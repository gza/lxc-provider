#!/usr/bin/perl -w

#get_scripts.sh
#This script parses directories corresponding to a query string (like debian/ubuntu/hardy) to produce an sorted list of scripts.
#Usage : get_scripts.sh path_to_script_home query/string

use strict;

use File::Basename;
use Data::Dumper;

my $debug=1;

#Checks args
die "usage: $0 path_to_script_home query/string" if $#ARGV<1;
die "$ARGV[0] is not a dir" unless -d $ARGV[0];
my @query=split(/\//,$ARGV[1]);
die "$ARGV[1] doesn't seems to be a good query string because $ARGV[0]/$query[0] is not a dir" unless -d "$ARGV[0]/$query[0]";

my $result={};

foreach my $dir ( get_tree({root=>$ARGV[0], query=>\@query}) ) {
	print STDERR "Loading scripts from $dir\n" if $debug;
	load_scripts_from_dir($dir);
}

display();

print STDERR Dumper($result) if $debug;

sub get_tree {
	#This lists dirs by reverse order of depth
	my ($arg) = @_;
	my @list;
	my $CurrentDir=$arg->{root};
	
	unshift @list,$CurrentDir;
	foreach my $step ( @{$arg->{query}} ) {
		$CurrentDir=$CurrentDir.'/'.$step;
		last unless -d $CurrentDir;
		unshift @list,$CurrentDir;
	}

	return @list;
}

sub load_scripts_from_dir {
	#This lists executables on a dir and call store() for each one
	my ($dir) = @_;
	print STDERR "Loading scripts in dir $dir\n" if $debug;
	opendir ( DIR, $dir ) || die "Error in opening dir $dir\n";
	foreach my $file (readdir(DIR)){
		if ( -f "$dir/$file" && -x "$dir/$file" ) { 
			print STDERR "file $dir $file\n" if $debug;
			store($dir,$file);
		}
	}
	closedir(DIR);
}


sub store {
	#store full path and basename of scripts in 3 category pre, main, post
	#deepest one overwrites last found, even if extensions are different 
	#example : /toto/tata/myscript.pl will overwrite /toto/myscript.py

	my ($dir,$file) = @_;
	print STDERR "get_scripts.pl::basename($file)\n";
	my @fileparts=split(/\./,$file);
	if ($#fileparts == 0) {
		print STDERR "found 1 part filename : $file\n";
		$result->{main}->{$fileparts[0]}="$dir/$file";
	} elsif ($#fileparts == 1) {
		print STDERR "found 2 part filename : $file\n";
		if ($fileparts[0] =~ /^(pre|post)/) {
			print STDERR "found 2 part filename with post or pre : $file\n";
			$result->{$fileparts[0]}->{$fileparts[1]}="$dir/$file";
		} else {
			print STDERR "found 2 part filename without post or pre : $file\n";
			$result->{main}->{$fileparts[0]}="$dir/$file";
		}
	} elsif ($#fileparts == 2) {
		print STDERR "found 3 part filename : $file\n";
		$result->{$fileparts[0]}->{$fileparts[1]}="$dir/$file";
	} else {
		die "$file as more than 3 parts, remember filename format : (pre.|post.)?filename(.ext)?";
	}
}

sub display {
	#Prints path of scripts in main category (sorted by basename)
	#pre prefixed are displayed just before there main equivalent
	#post are after
	foreach my $filename ( sort keys %{$result->{main}} ) {
		print $result->{pre}->{$filename}."\n" if $result->{pre}->{$filename};
		print $result->{main}->{$filename}."\n";
		print $result->{post}->{$filename}."\n" if $result->{post}->{$filename};
	}
}
