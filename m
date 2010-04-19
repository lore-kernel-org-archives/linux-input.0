From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Mon, 19 Apr 2010 00:28:47 -0700
Message-ID: <20100419072847.GA26102@core.coreip.homeip.net>
References: <1271434792.2045.5.camel@localhost.localdomain>
 <20100418194328.GA17565@core.coreip.homeip.net>
 <1271620177.19833.3471.camel@localhost.localdomain>
 <201004181319.25318.dmitry.torokhov@gmail.com>
 <1271637109.19833.3767.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:47173 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab0DSH2y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Apr 2010 03:28:54 -0400
Received: by yxe29 with SMTP id 29so2371423yxe.4
        for <linux-input@vger.kernel.org>; Mon, 19 Apr 2010 00:28:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271637109.19833.3767.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, Apr 19, 2010 at 01:31:49AM +0100, Bastien Nocera wrote:
> On Sun, 2010-04-18 at 13:19 -0700, Dmitry Torokhov wrote:
> <snip>
> > > > Hmm, I am curious why suspend and resume is not necessary for this
> > > > device... Are you relying on the USB core to tear down and re-create the
> > > > device? Then you may lose user-applied settings (like changed keymap).
> > > 
> > > How could I test that?
> > 
> > Change the keymap (with keyfuzz or something similar), suspend. resume and see 
> > if the mapping persisted.
> 
> Tried using udev's keymap tool on it, but the default get function
> doesn't give me any output.
> 
> Am I supposed to implement get/setkeycode myself for this to work, or
> should the default input functions work? If the latter, is there
> anything missing in the driver for me to call to enable that?
> 
> Trying to set a keycode says that the "EVIOCSKEYCODE" ioctl returns
> EINVAL.
> 

As I said in an earlier e-mail:

> ... also set up input_dev->keycode, keycodemax and keycodesize so that
> keymap can be adjusted from userspace on per-device basis.

Thanks.

-- 
Dmitry
