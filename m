From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: logitech-dj: prevent false errors to be shown
Date: Mon, 25 Aug 2014 03:00:18 -0500 (CDT)
Message-ID: <alpine.LNX.2.00.1408250300030.23162@pobox.suse.cz>
References: <1408738566-6805-1-git-send-email-benjamin.tissoires@redhat.com> <alpine.LNX.2.00.1408250249150.23162@pobox.suse.cz> <20140825075552.GA298@x4>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140825075552.GA298@x4>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Hawkes <hawkes@google.com>
List-Id: linux-input@vger.kernel.org

On Mon, 25 Aug 2014, Markus Trippelsdorf wrote:

> > > Commit "HID: logitech: perform bounds checking on device_id early
> > > enough" unfortunately leaks some errors to dmesg which are not real
> > > ones:
> > > - if the report is not a DJ one, then there is not point in checking
> > >   the device_id
> > > - the receiver (index 0) can also receive some notifications which
> > >   can be safely ignored given the current implementation
> > > 
> > > Move out the test regarding the report_id and also discards
> > > printing errors when the receiver got notified.
> > > 
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > 
> > I have now queued this one for 3.17. Adding Markus to CC -- Markus, this 
> > should make the spurious error messages you have reported go away.
> 
> Indeed it does. Feel free to add:
> 
> Reported-and-tested-by: Markus Trippelsdorf <markus@trippelsdorf.de>

Excellent, thanks. Will be pushing it to Linus this week.

-- 
Jiri Kosina
SUSE Labs
