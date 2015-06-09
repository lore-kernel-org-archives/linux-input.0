From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 15:50:18 +0200
Message-ID: <20150609135018.GG31071@pali>
References: <1433799790-31873-4-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-3-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609134241.GB3045@type>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33205 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbbFINuW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 09:50:22 -0400
Content-Disposition: inline
In-Reply-To: <20150609134241.GB3045@type>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tuesday 09 June 2015 15:42:41 Samuel Thibault wrote:
> Dmitry Torokhov, le Mon 08 Jun 2015 14:43:07 -0700, a =C3=A9crit :
> > If user wants all keyboards to light up CapsLock LED when VT state =
locks
> > CtrlL modifier they need to write a udev rule or similar to set up
> > "kbd-ctrlllock" trigger for all appearing "input%::capslock" LED cl=
ass
> > devices.
>=20
> I guess console-setup's maintainer will not be happy about it.  I'd
> say it'd be good to at least give examples how to do it in the
> documentation.
>=20

What about CC relevant people who maintains those userspace packages?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
