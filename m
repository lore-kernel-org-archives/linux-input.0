From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Fri, 16 May 2008 09:13:41 -0400
Message-ID: <20080516090351.ZZRA012@mailhub.coreip.homeip.net>
References: <20080514221519.GA6575@kroah.com> <20080515132108.GA9327@dose.home.local> <20080515094212.ZZRA012@mailhub.coreip.homeip.net> <20080515174939.GA10881@dose.home.local> <20080515142845.ZZRA012@mailhub.coreip.homeip.net> <20080515205950.GA11794@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.183]:14852 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYEPNNq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 May 2008 09:13:46 -0400
Received: by py-out-1112.google.com with SMTP id u52so843712pyb.10
        for <linux-input@vger.kernel.org>; Fri, 16 May 2008 06:13:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080515205950.GA11794@dose.home.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>, jkosina@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 15, 2008 at 10:59:50PM +0200, Tino Keitel wrote:
> On Thu, May 15, 2008 at 14:35:54 -0400, Dmitry Torokhov wrote:
> > On Thu, May 15, 2008 at 07:49:39PM +0200, Tino Keitel wrote:
> > 
> > > From the user's point of view: There are no official kernel release
> > > notes about what devices are added/removed to/from the various
> > > ignore lists and blacklists. The kernel doesn't produce any output
> > > about devices that are ignored or blacklisted in may cases (and
> > > also this one). The user has no indication why his LIRC setup stops
> > > working with the new kernel.
> > >
> > 
> > Not sure what we can do here... The only thing I guess is better
> > commit message mentioning LIRC setup concerns.
> 
> Who reads commit messages? I think it should be easy to add some
> printk()s saying something like "skipping device foo, because it is on
> the ignore list".

Then every user of Wacom tablet will be alarmed and ask "why my tablet
is ignored". The only thing that I can think of is making that quirk
compiled in depending on whether CONFIG_APPLEIR is selected.

> 
> > > Even if all LIRC users switch to the appleir driver, what about
> > > people who use a learning remote to have more than 6 keys that the
> > > Apple remote has? Does this work at all? After a quick look at the
> > > key handling it seems to me that the codes of the 6 keys are
> > > hardcoded in the driver. So a learning remote with more keys
> > > wouldn't work anymore.
> > >
> > 
> > We'll have to adjust the driver to allow changing keymap on a
> > per-device base from userspace. That's pretty easy actually.
> 
> I'm not talking about the keymap that is visible in userspace, but
> about the keys on the remote that are detected by the kernel. The Apple
> remote has only 6 keys, and they are mapped in a static array:
> 
> #define MAX_KEYS       8
> static int keymap[MAX_KEYS] = ...
> 
> With the LIRC driver, I can use a learning remote with much more keys,
> and then just use irrecord to create a LIRC config file.
> 

Does the learning remote have the same VID/PID as AppleIr? If not I am
not sure why you are btringing it here.

-- 
Dmitry
