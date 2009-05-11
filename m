From: Alessandro Di Marco <dmr@c0nc3pt.com>
Subject: [PATCH 2.6.28] input: activity counters (Perl trigger)
Date: Mon, 11 May 2009 11:27:12 +0200
Message-ID: <87fxfcj7s6.fsf@c0nc3pt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bin.disi.unige.it ([130.251.61.176]:56048 "EHLO c0nc3pt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284AbZEKJse (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 05:48:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru

#!/usr/bin/perl -w

# Copyright (C) 2009 Alessandro Di Marco <dmr@c0nc3pt.com>

# This file is part of SIN.

# SIN is free software: you can redistribute it and/or modify it under the
# terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.

# SIN is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

# You should have received a copy of the GNU General Public License along with
# SIN.  If not, see <http://www.gnu.org/licenses/>.

use strict;

use IO::File;
use IO::Select;
use Getopt::Long;
use Pod::Usage;

use Storable;

use constant CONFIG => 'SIN.conf';
use constant ENROLL_TIMEOUT => 5;

my @script = ( { timeout => 5, action => 'echo "dim screen"' },
	       { timeout => 10, action => 'echo "blank screen"' },
	       { timeout => 20, action => 'echo "system suspend"' } );

use constant RESUME => 'echo "restore screen"';

sub devices {
    open my $devices, "/proc/bus/input/devices"
	or die "uhm, no input devices?!?";

    my $name;
    my $devs;

    while (<$devices>) {
	$name = $1 if $_ =~ /^N: Name=\"(.*)\"\n$/;
	$devs->{$1} = $name if $_ =~ /S: Sysfs=(.*)\n$/;
    }

    $devs;
}

sub activity {
    my ($enrolled) = @_;

    $enrolled = $_ unless defined $enrolled;

    my $activities;

    foreach (keys %$enrolled) {
	open my $handle, "/sys$_/activity"
	    or die "missing activity on $_; please apply the patch!";

	my @data = <$handle>;

	$data[0] =~ /A: (0|[1-9][0-9]*)\n$/;
	my $last = $1;

	$data[1] =~ /D: (0|[1-9][0-9]*)\n$/;
	my $delta = $1;

	$activities->{$handle} = {
	    'path' => $_,
	    'handle' => $handle,
	    'last' => $last,
	    'delta' => $delta,
	};
    }

    $activities;
}

sub latest {
    my ($activities) = @_;

    $activities = $_ unless defined $activities;

    foreach (values %$activities) {
	my $handle = $_->{'handle'};

	seek $handle, 0, SEEK_SET;

	my @data = <$handle>;

	$data[0] =~ /A: (0|[1-9][0-9]*)\n$/;
	$_->{'last'} = $1;

	$data[1] =~ /D: (0|[1-9][0-9]*)\n$/;
	$_->{'delta'} = $1;
    }

    $activities;
}

sub configure {
    my ($devs) = @_;

    select(undef, undef, undef, 0.1);

    print "Input device enrolling:\n";
    print "  please interact with the desired input devices;\n";
    print "  the process will terminate after " . ENROLL_TIMEOUT
	. " seconds from the last enrollment.\n";

    my $activities = activity($devs);

    my $select = new IO::Select(map { $_->{'handle'} } values %$activities);

    while ($select->handles) {
	last unless my @picked = $select->can_read(ENROLL_TIMEOUT);

    	foreach (@picked) {
    	    print "Enrolled $devs->{$activities->{$_}->{'path'}}\n";
    	}

    	$select->remove(@picked);
    }

    delete $activities->{$_} foreach ($select->handles);

    my $enrolled;

    foreach (map { $_->{'path'} } values %$activities) {
	$enrolled->{$_} = $devs->{$_};
    }

    $enrolled;
}

my %opts = ();

GetOptions('configure' => \$opts{'configure'},
	   'help|?' => \$opts{'help'},
	   'man' => \$opts{'man'})
    or pod2usage(2);

pod2usage(1) if $opts{'help'};
pod2usage('-exitstatus' => 0, '-verbose' => 2) if $opts{'man'};

my $enrolled;

if ($opts{'configure'}) {
    $enrolled = configure devices;
    store $enrolled, CONFIG;
    exit 0;
}

die "No usable configuration found" unless -e CONFIG;

$enrolled = retrieve(CONFIG)
    or die "uhm, invalid configuration?!?\n";

my $devs = devices;

foreach (keys %$enrolled) {
    die "uhm, stored configuration doesn't match?!?\n"
	unless defined $devs->{$_};
}

sub latter_of {
    my ($activities) = @_;

    $activities = $_ unless defined $activities;

    my $last = 0;
    my $me;

    foreach (values %$activities) {
	if ($_->{'last'} > $last) {
	    $last = $_->{'last'};
	    $me = $_;
	}
    }

    $me;
}

sub warp {
    (($_[0]->{'timeout'} * 1000000) - $_[1]->{'delta'}) / 1000000;
}

my $activities = activity $enrolled;
my $select = new IO::Select(map { $_->{'handle'} } values %$activities);

start:
    while (1) {
	my $last = latter_of latest $activities;
	my $trig = 0;

	for (my $i = 0; $i < @script; $i++) {
	    if ($trig) {
		if ($select->can_read(warp($script[$i], $last))) {
		    system RESUME;
		    next start;
		}

		$last = latter_of latest $activities;
	    } else {
		while ((my $timeout = warp($script[$i], $last)) > 0) {
		    select(undef, undef, undef, $timeout);
		    $last = latter_of latest $activities;
		}

		$trig = 1;
	    }

	    system $script[$i]->{'action'};
	}

	$select->can_read;

	system RESUME;
}

__END__

=pod

=head1 NAME

SIN - System Inactivity Notifier

=head1 SYNOPSIS

B<SIN> [B<--configure>] [B<--help>] [B<--man>]

=head1 OPTIONS

=over 8

=item B<--configure>

Let the user configure SIN.

=item B<--help>

Print a brief help message and exits.

=item B<--man>

Prints the manual page and exits.

=back

=head1 DESCRIPTION

B<SIN> is an inactivity notifier. This means that you can instruct SIN to
perform different actions depending on the user's activity degree.

=cut

