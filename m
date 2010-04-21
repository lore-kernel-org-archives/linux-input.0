From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: add appleir USB driver
Date: Wed, 21 Apr 2010 15:06:51 +0100
Message-ID: <1271858811.17421.3572.camel@localhost.localdomain>
References: <1271434792.2045.5.camel@localhost.localdomain>
	 <20100418194328.GA17565@core.coreip.homeip.net>
	 <1271620177.19833.3471.camel@localhost.localdomain>
	 <201004181319.25318.dmitry.torokhov@gmail.com>
	 <1271637109.19833.3767.camel@localhost.localdomain>
	 <20100419072847.GA26102@core.coreip.homeip.net>
	 <1271671690.17421.80.camel@localhost.localdomain>
	 <20100421063142.GI4364@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:37796 "EHLO
	relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab0DUOG4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 10:06:56 -0400
In-Reply-To: <20100421063142.GI4364@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Tue, 2010-04-20 at 23:31 -0700, Dmitry Torokhov wrote:
<snip>
> > I tested udev's keymap, and the keymap isn't being saved across
> > suspend/resume cycles. I re-added the _suspend() and _resume() calls
> > (and their definitions in the usb_driver struct), but the keymap still
> > disappears.
> 
> Do you see another instance of the device appearing in dmesg?

The device was disappearing when a reset_resume wasn't present. I now
use resume for both reset_resume and resume, and force a URB on resume,
which should fix some cases of the device being dead on resume.

That also fixes the keymap disappearing on suspend.

Updated patch is now on the list

Cheers

