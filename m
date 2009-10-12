From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not work
	anymore
Date: Mon, 12 Oct 2009 11:33:13 -0700
Message-ID: <20091012183313.GC8345@core.coreip.homeip.net>
References: <4AD120F2.3020606@tremplin-utc.net> <20091011030029.GA6526@suse.de> <200910112135.29384.dmitry.torokhov@gmail.com> <4AD31709.4000103@tremplin-utc.net> <20091012154846.GB7996@core.coreip.homeip.net> <20091012173551.GC10557@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757663AbZJLSeC@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091012173551.GC10557@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <eric.piel@tremplin-utc.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 12, 2009 at 10:35:51AM -0700, Greg KH wrote:
> On Mon, Oct 12, 2009 at 08:48:46AM -0700, Dmitry Torokhov wrote:
> > > So at least, unbind should fail as well as bind.
> > >
> > 
> > That would be Greg's domain s it is driver core decision whether to
> > allow unbinding platform devices registered with
> > platform_driver_probe().
> 
> No, I do not see why that should not be allowed.
> 

Because once you did unbind the device you are stuck (unless the driver
is compiled as a module, but then you could just unload the module
instead of unbinding). Disallowing unbind would allow discarding not
only __devinit but __devexit sections when driver is built in which
would make ebedded people happy[^Hier].

-- 
Dmitry
