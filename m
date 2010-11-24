From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] Adding BTN_TOOL_TOUCH to input.h
Date: Tue, 23 Nov 2010 18:52:48 -0800
Message-ID: <20101124025248.GD27368@core.coreip.homeip.net>
References: <AANLkTinw2pyZOPuVsG6ovBTFKstozamfWX=6EcjyYTfX@mail.gmail.com>
 <20101123223018.GC20283@core.coreip.homeip.net>
 <AANLkTi=sEJC9r=ZL7rJH9ojOjadmriNFbN97t+=HpTwy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37787 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab0KXCw5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Nov 2010 21:52:57 -0500
Received: by ywl5 with SMTP id 5so841832ywl.19
        for <linux-input@vger.kernel.org>; Tue, 23 Nov 2010 18:52:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=sEJC9r=ZL7rJH9ojOjadmriNFbN97t+=HpTwy@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Tue, Nov 23, 2010 at 02:40:00PM -0800, Ping Cheng wrote:
> On Tue, Nov 23, 2010 at 2:30 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Nov 23, 2010 at 12:48:07PM -0800, Ping Cheng wrote:
> >> Hi all,
> >>
> >> I am not going to write a patch for this request before I get the
> >> permission for the new tool type. It affects all touch screen devi=
ces
> >> (under drivers/input/touchscreen) that support both pen and touch.
> >>
> >> Right now, in the user land, BTN_TOUCH is used to indicate a singl=
e
> >> touch events. BTN_TOUCH and !BTN_TOOL_PEN
> >> (http://udev.sourcearchive.com/documentation/161-1/input__id_8c-so=
urce.html)
> >> are used to determine if the device is a touch screen device or no=
t a
> >> pen. With both pen and touch on the same logical port (serial touc=
h
> >> screen with pen and touch enabled, refer to wacom_w8001.c), BTN_TO=
UCH
> >> and !BTN_TOOL_PEN will always be false, which indicates a
> >> non-touchscreen device. That is wrong.
> >>
> >> Unless we have other means to tell the user land a device is a
> >> touchscreen, BTN_TOUCH with !BTN_TOOL_PEN won't do the job for us.
> >>
> >> I've already had a value for the new type:
> >>
> >> +#define BTN_TOOL_TOUCH =A0 =A0 =A0 0x149
> >>
> >> This new type resolves the confusion we had for the existing seria=
l
> >> pen and touch enabled touchscreen devices. Considering we are merg=
ing
> >> the two logical ports for USB devices, the new type is required fo=
r
> >> the future USB touchscreen support as well.
> >
> > How is BTN_TOOL_TOUCH is different from BTN_TOOL_FINGER?
>=20
> Good question.
>=20
> BTN_TOOL_FINGER is used for touchpad or trackpad, or whichever term
> that works for you. It indicates a relative cursor movement. The touc=
h
> screen needs to translate the (x,y) events into absolute movement.
> That's why none of those touchscreen drivers use BTN_TOOL_FINGER so
> far.
>=20

BTN_TOOL_FINGER and the new BTN_TOOL_TOUCH convey the same data to the
userspace, namely that there is a finger on the owrking surface, as
oopsed to pen, mouse, lens or something else. It does not dictate how
exactly the data should be used, although right now we have heuristic t=
o
decide the class of the device we are dealing with.

It looks like that we getting into fuzzy area where it is hard to
classify the device solely by its capabilities. Maybe it is time we
revisited the topic of adding "flags" or "hint" to the device to
describe it's main purpose(s).

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
