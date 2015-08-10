From: =?UTF-8?Q?Cl=c3=a9ment_Vuchener?= <clement.vuchener@gmail.com>
Subject: Writing a driver for the Corsair K90 keyboard
Date: Mon, 10 Aug 2015 12:26:22 +0200
Message-ID: <55C87C4E.4040601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34800 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933239AbbHJK0Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2015 06:26:25 -0400
Received: by wicne3 with SMTP id ne3so129895615wic.1
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2015 03:26:24 -0700 (PDT)
Received: from [192.168.1.13] (ARennes-658-1-98-8.w83-199.abo.wanadoo.fr. [83.199.49.8])
        by smtp.googlemail.com with ESMTPSA id lk16sm13066333wic.6.2015.08.10.03.26.23
        for <linux-input@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 10 Aug 2015 03:26:23 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello.

I wrote a driver for the Corsair K90 keyboard, it is my first kernel=20
development and I have a few questions about how to properly do a few=20
things (mainly interactions with the user space).

The Corsair Vengeance K90 is a mechanical keyboard with a backlight,=20
macro keys (G1 to G18) and some other special keys (macro recording,=20
profile switching, changing the light level or disabling the "windows=20
logo" keys). The macro playback can be switched between hardware or=20
software (from the driver not a key). Using the generic HID driver, the=
=20
macro keys and special keys send wrong key code or no key code at all=20
(because of the HID usage code used by the keyboard).

The source for my driver can be found at this address:=20
https://github.com/cvuchener/k90-linux-driver . It solves the problem o=
f=20
the generic driver and add some handling of the other features (see the=
=20
README for more details).

So, my questions are about:

- Macro keys
=46or handling the macro keys from a software, they need to send some=20
keycodes but I have no idea what to use. Currently I use F keys above 1=
2=20
and some MISC buttons and a parameter for changing that (at load time).=
=20
Are there 18 keycodes reserved for custom uses? It would also be=20
possible to send no keycode at all and use a specific software listenin=
g=20
to the hidraw or hiddev devices, but I think it would be better to be=20
able to use a generic software.

- Backlight
I chose to use a led class device to manage the backlight. It seems to=20
work fine but when unregistering the driver, the light is set to 0. The=
=20
keyboard remembers the previous light level and so nothing should be=20
done when registering or unregistering the driver. Is the led class the=
=20
right class for that? or am I using it wrong?

- Sending the macro profiles to the keyboard
I created a "profile" branch on my git repo for adding binary attribute=
s=20
used for sending macro data to the keyboard. But I am not sure it is a=20
good idea, it may be better to leave that to the user space. How are=20
programmable buttons/keys usually dealt with?

Any other comment is welcome.

Thanks,
Cl=C3=A9ment
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
