From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Tue, 20 Apr 2010 23:31:42 -0700
Message-ID: <20100421063142.GI4364@core.coreip.homeip.net>
References: <1271434792.2045.5.camel@localhost.localdomain>
 <20100418194328.GA17565@core.coreip.homeip.net>
 <1271620177.19833.3471.camel@localhost.localdomain>
 <201004181319.25318.dmitry.torokhov@gmail.com>
 <1271637109.19833.3767.camel@localhost.localdomain>
 <20100419072847.GA26102@core.coreip.homeip.net>
 <1271671690.17421.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53201 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab0DUGbv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 02:31:51 -0400
Received: by gwj19 with SMTP id 19so1258105gwj.19
        for <linux-input@vger.kernel.org>; Tue, 20 Apr 2010 23:31:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271671690.17421.80.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, Apr 19, 2010 at 11:08:10AM +0100, Bastien Nocera wrote:
> On Mon, 2010-04-19 at 00:28 -0700, Dmitry Torokhov wrote:
> > On Mon, Apr 19, 2010 at 01:31:49AM +0100, Bastien Nocera wrote:
> > > On Sun, 2010-04-18 at 13:19 -0700, Dmitry Torokhov wrote:
> > > <snip>
> > > > > > Hmm, I am curious why suspend and resume is not necessary for this
> > > > > > device... Are you relying on the USB core to tear down and re-create the
> > > > > > device? Then you may lose user-applied settings (like changed keymap).
> > > > > 
> > > > > How could I test that?
> > > > 
> > > > Change the keymap (with keyfuzz or something similar), suspend. resume and see 
> > > > if the mapping persisted.
> > > 
> > > Tried using udev's keymap tool on it, but the default get function
> > > doesn't give me any output.
> > > 
> > > Am I supposed to implement get/setkeycode myself for this to work, or
> > > should the default input functions work? If the latter, is there
> > > anything missing in the driver for me to call to enable that?
> > > 
> > > Trying to set a keycode says that the "EVIOCSKEYCODE" ioctl returns
> > > EINVAL.
> > > 
> > 
> > As I said in an earlier e-mail:
> > 
> > > ... also set up input_dev->keycode, keycodemax and keycodesize so that
> > > keymap can be adjusted from userspace on per-device basis.
> 
> I missed that bit, sorry.
> 
> I tested udev's keymap, and the keymap isn't being saved across
> suspend/resume cycles. I re-added the _suspend() and _resume() calls
> (and their definitions in the usb_driver struct), but the keymap still
> disappears.

Do you see another instance of the device appearing in dmesg?

> 
> Is there anything else I would need to do in this case to keep the
> device (and its keymap) around during suspend?
> 
> I'm guessing that this problem wouldn't matter too much because udev
> would re-apply any keymaps it had for the device when it reappears, and
> in the lirc case, the keymap is in user-space.

That assumes that user does use udev. Extremely likely, but still not certain.

-- 
Dmitry
