From: Samuel Thibault <sthibault@debian.org>
Subject: Re: Bug#514464: caps lock led does not show up
Date: Thu, 2 Jul 2015 18:50:48 +0200
Message-ID: <20150702165048.GE3985@type.bordeaux.inria.fr>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20090205113908.GA14224@const.inria.fr>
 <20150609141723.GE3045@type>
 <20150609160339.GB26687@logic.fmi.uni-sofia.bg>
 <20150611080809.GD3184@type.bordeaux.inria.fr>
 <20150611142803.GA3056@type.access.network>
 <20150611153755.GA2247@type>
 <20150625154112.GF3093@type.bordeaux.inria.fr>
 <20150702163905.GA7518@logic.fmi.uni-sofia.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:34075
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754022AbbGBQvJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jul 2015 12:51:09 -0400
Content-Disposition: inline
In-Reply-To: <20150702163905.GA7518@logic.fmi.uni-sofia.bg>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anton Zinoviev <anton@lml.bas.bg>, 514464@bugs.debian.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Anton Zinoviev, le Thu 02 Jul 2015 19:39:06 +0300, a =E9crit :
> > Anton, do you have all the informations you need to match that with=
 the
> > xkb data?
>=20
> But here, I don't understand what matching with xkb data you mean?

I mean matching the LED names from xkb with the LED names from Linux

> I have the following questions:
>=20
> 1. Is there a packaged Debian kernel with this functionality I can us=
e?

Not yet.

> 2. Suppose the new keyboard layout requires a trigger different from=20
> kbd-ctrlllock (because the user used KMAP in /etc/default/keyboard or=
=20
> installed console-setup-mini).  I can echo the new trigger for the=20
> existing keyboards, but what about the udev rules?  Can they change o=
n=20
> the fly?  Or maybe there is some way not to hardcode the trigger in t=
he=20
> udev rule but read it from a separate file each time the rule activat=
es?

You can just overwrite the udev rule with the new value.

> BTW, at the moment I think it will be best if I write a script kbd_le=
ds=20
> and propose it for inclusion in the console utilities package 'kbd'. =
=20
> Definitely, this is a functionality useful not only for console-setup=
=20
> users.  Then console-setup will be able to use the combination=20
> kbd_mode+loadkeys+kbd_leds in order to configure the keyboard.

Ah, yes, that can be useful indeed.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
