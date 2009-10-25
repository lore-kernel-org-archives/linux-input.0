From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not  work
	anymore
Date: Sun, 25 Oct 2009 12:07:26 -0700
Message-ID: <20091025190726.GA20932@core.coreip.homeip.net>
References: <200910211320.16339.dmitry.torokhov@gmail.com> <4AE0840C.8070801@tremplin-utc.net> <20091022162202.GA18031@core.coreip.homeip.net> <4AE09AFF.805@tremplin-utc.net> <20091022181915.GB18031@core.coreip.homeip.net> <4AE16489.4030008@tremplin-utc.net> <20091023085824.GA7199@core.coreip.homeip.net> <4AE17586.9020009@tremplin-utc.net> <20091023163113.GA7707@core.coreip.homeip.net> <4AE43AB7.8070601@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:62282 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444AbZJYTH1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Oct 2009 15:07:27 -0400
Content-Disposition: inline
In-Reply-To: <4AE43AB7.8070601@tremplin-utc.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, Oct 25, 2009 at 12:47:03PM +0100, =C9ric Piel wrote:
> Op 23-10-09 18:31, Dmitry Torokhov schreef:
>>
>> Right, your init scripts/UDEV/HAL whatever adjust keymap to match yo=
ur
>> laptop.
> :
>> Now, all depends on when this adjustment happens... In your case it
>> looks like X server starts before the keymap is adjusted, so on firs=
t
>> resume the keymaps are different and it disables the device.
> Ok, now I catch it. It's actually my own written script, which is =20
> executed at init a bit after X starts. It does a couple of =20
> "setkeycodes". So now the scenario is very clear: X starts, init scri=
pt =20
> do setkeycodes, resume/suspend, X detect a difference in keymaps and =
=20
> disable the device.

Yep.

OK, so X's evdev is still too paranoid but now we know the whole pictur=
e
and for my part I declare kernel is free from blame ;)

>
> BTW, I haven't really found info about this: what does setkeycodes? I=
t =20
> does not work on a specific device, but still it changes keymap of so=
me =20
> specific devices. Does it change only the current devices which have =
=20
> keys?

setkeycodes issues KDSETKEYCODE which goes through all devices bound to
the "kbd" input handler and sets keycode for the specified scan code fo=
r
all devices that support that scancode.

> Whenever a new input device appears, all the setkeycodes should be =20
> re-executed?
>

It is recommended to adjust individual devices and HAL has facilities t=
o
do that (although now that they deprecating HAL I am not sure what the
replacement is). Anyway, for HAL look into:

	/usr/share/hal/fdi/information/10freedesktop/*-keymap-*.fdi

The nice thing here is that keymaps are re-applied if device gets
disconnected and rediscovered for one reason or another.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
