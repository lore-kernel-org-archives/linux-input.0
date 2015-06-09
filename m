From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 13:22:21 +0200
Message-ID: <20150609112221.GB31071@pali>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609105421.GA15814@amd>
 <20150609111242.GA21235@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38615 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533AbbFILW0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 07:22:26 -0400
Content-Disposition: inline
In-Reply-To: <20150609111242.GA21235@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tuesday 09 June 2015 13:12:42 Pavel Machek wrote:
> On Tue 2015-06-09 12:54:21, Pavel Machek wrote:
> > I did echo kbd-capslock > trigger, but still no luck. (That might b=
e
> > bug in Debian, IIRC?)
>=20
> I tried rebooting with stock Debian kernel, and the bug is there, too=
=2E
>=20
> Best regards,
> 									Pavel

Is not trigger only kernel part? If yes, then replacing kernel should
not cause any Debian related bug, right?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
