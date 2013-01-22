From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PROBLEM: 3.8.0-rc4 keyboard failure at boot
Date: Tue, 22 Jan 2013 13:42:54 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301221341550.20374@pobox.suse.cz>
References: <20130121213604.GA31225@16s.us> <20130122001346.GD16638@core.coreip.homeip.net> <alpine.LNX.2.00.1301221122380.20374@pobox.suse.cz> <20130122121947.GB27072@16s.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130122121947.GB27072@16s.us>
Sender: linux-kernel-owner@vger.kernel.org
To: Brad Tilley <brad@16s.us>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 22 Jan 2013, Brad Tilley wrote:

> > > > Here is info from a computer where the keyboard works occasionally at
> > > > boot (about 50% of the time). Users reboot until the keyboard works.
> > > > 
> > > 
> > > Hmm, this is a USB keyboard so let's CC Jiri in addition to
> > > linux-input...
> > 
> > Thanks for the report.
> > 
> > First question before we start any further analysis -- what is the latest 
> > known-good version of the kernel, where this problem didn't happen on this 
> > particular computer?
> 
> Kernels 3.7.3 and 3.7.4 do not have this issue. It began with the 3.8 rcs.

Could you please provide dmesg output from both working and non-working 
case?

Also /proc/bus/input/devices content would be interesting (in case you are 
able to log remotely into the machine).

Does replugging the keyboard fix the problem with 50% probability?

Are other USB devices (such as mice) affected by this as well?

Thanks,

-- 
Jiri Kosina
SUSE Labs
