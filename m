From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Synaptics Multi touch capabilities
Date: Wed, 23 Dec 2009 10:32:32 -0800
Message-ID: <200912231032.32526.dmitry.torokhov@gmail.com>
References: <62e5edd40912230313r65593b0cmea9541ea7a246cfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:62198 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZLWSkW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2009 13:40:22 -0500
Received: by fxm25 with SMTP id 25so2255281fxm.21
        for <linux-input@vger.kernel.org>; Wed, 23 Dec 2009 10:40:19 -0800 (PST)
In-Reply-To: <62e5edd40912230313r65593b0cmea9541ea7a246cfc@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Erik =?iso-8859-1?q?Andr=E9n?= <erik.andren@gmail.com>
Cc: linux-input@vger.kernel.org

On Wednesday 23 December 2009 03:13:04 am Erik Andr=E9n wrote:
> Hi,
> I have a ASUS 1005HA netbook equipped with a Synaptics touch pad:
> [   18.341491] Synaptics Touchpad, model: 1, fw: 7.2, id: 0x1a0b1,
> caps: 0xd04731/0xa40000
>=20
> In Linux, no multitouch capabilities are detected (Zoom, two and thre=
e
> finger button presses etc.).
> This all works with the same hardware in windows 7.
> Is there a bug in the linux driver preventing multitouch to work?
>=20

Linux Synaptics driver does not have full multitouch support (yet?). Th=
e 2-=20
and 3- finger taps should work (provided that they are enabled in SYnap=
tics X=20
driver) but there is no multiple finger tracking...

BTW, the capability 0xd04731 indicates that your hardware does not repo=
rt=20
multi-finger taps.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
