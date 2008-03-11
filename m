From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input-evdev patch adding option to override XDevice type Atom,
	option to force EV_REL events being treated as absolute values.
Date: Tue, 11 Mar 2008 09:12:17 -0400
Message-ID: <20080311090537.ZZRA012@mailhub.coreip.homeip.net>
References: <200803110052.00181.wdraxinger@darkstargames.de> <200803111113.30161.wdraxinger@darkstargames.de> <20080311105437.GA6148@fooishbar.org> <200803111328.10670.wdraxinger@darkstargames.de> <54221.192.54.193.59.1205239967.squirrel@rousalka.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.187]:45154 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbYCKNMd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Mar 2008 09:12:33 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1458454rvb.1
        for <linux-input@vger.kernel.org>; Tue, 11 Mar 2008 06:12:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <54221.192.54.193.59.1205239967.squirrel@rousalka.dyndns.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>, Jiri Kosina <jkosina@suse.cz>
Cc: Wolfgang Draxinger <wdraxinger@darkstargames.de>, Daniel Stone <daniel@fooishbar.org>, Ville Syrj??l?? <syrjala@sci.fi>, xorg@lists.freedesktop.org, greg@kroah.com, linux-input@vger.kernel.org

[Adding linux-input and specifucally Jiri Kosina]

On Tue, Mar 11, 2008 at 01:52:47PM +0100, Nicolas Mailhot wrote:
> 
> Le Mar 11 mars 2008 13:28, Wolfgang Draxinger a ??crit :
> > Am Dienstag, 11. M??rz 2008 schrieb Daniel Stone:
> >
> >> Quirk tables are all through the USB code[0], IDE, etc, already, so
> >> this would be the accepted practice.
> >
> > I can understand it for single chipsets, or other specific HW. But
> > USBHID is generic to the bone, and it's device neutral. Having the
> > quirks table in the kernel would mean, that for every awkward device
> > you'd have to get the latest kernel, or if it's not in there yet
> > patch it.
> 
> I'd be very careful not to assume what can or can not be done at
> kernel level, and what should and should not belong in the kernel.
> 
> The kernel HID people are the ones who see all the hardware diversity
> and what people need. They're the ones you should consult first before
> adding a quirks table somewhere else. Because if they have to
> implement a quirks table in the kernel anyway (for some need you've
> not envisionned today) having two layers of quirks that fight each
> other for device control is going to make life miserable for everyone.
> 

I think that if EV_ABS for a device is the one that really makes sense
and the device sends EV_REL in error we should just adjust the type
of events right in USBHID driver so incorrect events don't propagate
any further. If hovewer preference of EV_ABS vs EV_REL is just something
xf86-evdev wants just because of its internal architecture then the
quirk belongs to xf86-evdev itself.

Jiri, apparently some 3Dconnexion devices send EV_REL which makes
xf86-evdev not too happy. What do you think?

-- 
Dmitry
