From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: input-evdev patch adding option to override XDevice type Atom,
 option to force EV_REL events being treated as absolute values.
Date: Fri, 14 Mar 2008 13:19:50 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803141317540.30831@jikos.suse.cz>
References: <200803110052.00181.wdraxinger@darkstargames.de>
 <200803111113.30161.wdraxinger@darkstargames.de> <20080311105437.GA6148@fooishbar.org>
 <200803111328.10670.wdraxinger@darkstargames.de>
 <54221.192.54.193.59.1205239967.squirrel@rousalka.dyndns.org>
 <20080311090537.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:41752 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751749AbYCNMTv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Mar 2008 08:19:51 -0400
In-Reply-To: <20080311090537.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nicolas Mailhot <nicolas.mailhot@laposte.net>, Wolfgang Draxinger <wdraxinger@darkstargames.de>, Daniel Stone <daniel@fooishbar.org>, Ville Syrj??l?? <syrjala@sci.fi>, xorg@lists.freedesktop.org, greg@kroah.com, linux-input@vger.kernel.org

On Tue, 11 Mar 2008, Dmitry Torokhov wrote:

> I think that if EV_ABS for a device is the one that really makes sense 
> and the device sends EV_REL in error we should just adjust the type of 
> events right in USBHID driver so incorrect events don't propagate any 
> further. If hovewer preference of EV_ABS vs EV_REL is just something 
> xf86-evdev wants just because of its internal architecture then the 
> quirk belongs to xf86-evdev itself.
> Jiri, apparently some 3Dconnexion devices send EV_REL which makes
> xf86-evdev not too happy. What do you think?

Exactly, I fully agree with Dmitry here.

We can easily fix up the device report descriptor in the kernel code, so 
that it would send EV_ABS instead of EV_REL events. We do similar fixups 
(not this particular one) for quite a few devices already.

The real question here is whether it is really buggy device, or just 
EV_REL interpretation makes more sense so X input driver, but the device 
itself doesn't send buggy data. Could you please elaborate a little bit 
more?

Thanks,

-- 
Jiri Kosina
SUSE Labs
