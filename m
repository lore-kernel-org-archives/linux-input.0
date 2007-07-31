From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [patch] Refresh lid state on resume
Date: Tue, 31 Jul 2007 10:07:22 +0100
Message-ID: <1185872842.2652.11.camel@hughsie-laptop>
References: <1184670921.8890.2.camel@work>
	 <1185808891.18821.25.camel@queen.suse.de>
	 <1185809610.24649.3.camel@hughsie-laptop>  <200707311108.42947.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200707311108.42947.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: trenn@suse.de, Len Brown <lenb@kernel.org>, Dmitry Torokhov <dtor@insightbb.com>, linux-acpi <linux-acpi@vger.kernel.org>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Kay Sievers <kay.sievers@vrfy.org>
List-Id: linux-input@vger.kernel.org

On Tue, 2007-07-31 at 11:08 +0200, Rafael J. Wysocki wrote:
> On Monday, 30 July 2007 17:33, Richard Hughes wrote:
> > On Mon, 2007-07-30 at 17:21 +0200, Thomas Renninger wrote:
> > > On Tue, 2007-07-17 at 12:15 +0100, Richard Hughes wrote:
> > > > On resume we need to refresh the lid status as we will not get an event if
> > > > the lid opening was what triggered the suspend.
> > > > This manifests itself in users never getting a "lid open" event when a
> > > > suspend happens because of lid close on hardware that supports wake on
> > > > lid open. This makes userspace gets very confused indeed.
> > > > Patch inline (and also attached) forces a check of the lid status in the
> > > > resume handler.
> > > Is this a general problem on all machines?
> > 
> > I've only seen myself it on new ThinkPads such as the T61 and X60,
> > although I've been getting a few bug reports about other IBM laptops.
> > 
> > > Or does this only happen if "shutdown" suspend mode is used?
> > 
> > No, I don't believe so.
> > 
> > > I could imagine a lot machines let it up to OS to check for LID state
> > > change, then this one should be added.
> > 
> > I guess it's up to the BIOS, and I don't think this refresh hurts any
> > machines that implement a notify on resume, and fixes a fair few
> > machines that don't.
> 
> AFAICS, the notify doesn't seem to work very well on some machines.

Agree.

> Are there any downsides of the $subject patch?

Not that I've found. I've been testing it on ~6 IBM and non-IBM machines
with no bad effects so far.

Richard.


