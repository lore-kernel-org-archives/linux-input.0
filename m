From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - correct x, y value range for v2
 hardware
Date: Wed, 17 Aug 2011 09:37:46 -0700
Message-ID: <20110817163746.GC4877@core.coreip.homeip.net>
References: <1313380295-26226-1-git-send-email-jj_ding@emc.com.tw>
 <87hb5hligi.fsf@emc.com.tw>
 <4E4AE637.1090000@tudelft.nl>
 <87aab86d3v.fsf@emc.com.tw>
 <20110817064336.GA29361@core.coreip.homeip.net>
 <4E4B8FB3.9090100@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53058 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab1HQQh4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 12:37:56 -0400
Received: by iye16 with SMTP id 16so2195723iye.1
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 09:37:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E4B8FB3.9090100@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>

On Wed, Aug 17, 2011 at 11:53:55AM +0200, =C9ric Piel wrote:
> Op 17-08-11 08:43, Dmitry Torokhov schreef:
> >Hi JJ,
> >
> >>As far as I know, this doesn't fix a bug. I just want to make sure =
the
> >>driver and what the firmware sends are consistent.
> >
> >As =C9ric mentioned, simply extending range to 12 bits is dangerous
> >because we might cause overflows. Blindly increasing ETP_YMAX_V2 is =
not
> >a good idea either as userspace would expect much larger device and
> >reports would only cover fraction of its surface. We need to separat=
e
> >ETP_YMAX_V2 as absolute maximum from reported coordinates range, lik=
e it
> >is done in synaptics driver.
> Hi Dmitry,
> Concerning this point, I was wondering if it'd be ok to only send
> negative values? Such as min/max are between -768 and 0. So that, if
> the hardware actually has a bigger resolution, it can go down to
> -4095 without any overflow?

Theoretically it should be possible, at least nothing in evdev protocol
says that absolute coordinates shoudl be positive. It is certainly not
true for joystick-like devvices. But I am concerned about users (as
in applications/drivers) getting negative coordinates for
touchpad/touchscreen like devices. I believe first reaction is to expec=
t
non-negative values.

> It sounds the simplest way to report the
> coordinate for a device which has an opposite axis. Or is it safer
> to stay in the positive numbers, with min/max between 3328 and 4095,
> and in case of bigger resolution the values go down to 0?

I think this is the best way. EVIOCGABS gives the "window" into the
expected range of coordinates emitted by the device, so as long as we
keep the scale (i.e. not reporting min/max as 0-4096 while actual
coordinates go only 0-768) it should work fine.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
