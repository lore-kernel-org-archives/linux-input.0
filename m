From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [2.6.36 regression] Under linux console gpm cursor now going to opposite direction of mouse
Date: Wed, 25 Aug 2010 20:19:01 +0200
Message-ID: <201008252019.02455.maciej.rutecki@gmail.com>
References: <20100820223316.4f6ac734@neptune.home>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab0HYSTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Aug 2010 14:19:08 -0400
In-Reply-To: <20100820223316.4f6ac734@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On pi=C4=85tek, 20 sierpnia 2010 o 22:33:16 Bruno Pr=C3=A9mont wrote:
> Somewhere between 2.6.35 and Linus's tree as of this writing gpm
> started moving its cursor to the opposite direction of mouse movement=
=2E
>=20
> e.g. moving mouse up causes cursor to move down, moving mouse left
>      causes cursor to go right
>=20
> Under 2.6.35 the cursor moved into the same direction as the mouse.
>=20
> Note, mouse is synaptics touchpad (Acer TravelMate660):
>   Synaptics Touchpad, model: 1, fw: 5.8, id: 0x9d48b1, caps:
> 0x904713/0x4006/0x0
>=20
>=20
> When I get around to it I will try to get more precise information as
> to when this regression got introduced, eventually bisecting.
>=20
> Bruno

I created a Bugzilla entry at=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D17031
for your bug report, please add your address to the CC list in there, t=
hanks!
--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
