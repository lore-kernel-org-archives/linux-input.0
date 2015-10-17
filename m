From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: FocalTech touchpad stops working after suspend
Date: Sat, 17 Oct 2015 10:03:58 -0700
Message-ID: <20151017170358.GE13470@dtor-ws>
References: <56226B91.4070209@leprette.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35348 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbJQREC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Oct 2015 13:04:02 -0400
Received: by padfb7 with SMTP id fb7so6210961pad.2
        for <linux-input@vger.kernel.org>; Sat, 17 Oct 2015 10:04:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <56226B91.4070209@leprette.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Nathana=EBl=2FThatoo?= <thatoo@leprette.fr>
Cc: linux-input@vger.kernel.org

Hi,

On Sat, Oct 17, 2015 at 07:08:57PM +0330, Nathana=EBl/Thatoo wrote:
> [1.] FocalTech touchpad stops working after suspend
>=20
> [2.]
>=20
> I have an Asus V502LX the persian version of the Asus K501LX.
>=20
> I have Ubuntu 14.04 installed and the kernel 4.3-rc5 installed.
> The touchpad is recognised. whreas under kernel 3.19.30, the touchpad
> was recognised as a simple mouse (no two fingers scrolling...).
>=20
> However, the Focaltech touchpad is not working after suspending the
> computer.
> After I close the lid of my computer or click on the button to suspen=
d
> its activity, after awaking, everything seems to work except the
> touchpad. The keyboard works, the wifi reconnect but the touchpad is
> blocked. I have to restart to get it working again.
>=20
> Before suspending the computer, I can deactivate and activate again t=
he
> touchpad with the hotkey of my keyboard without problem. However, onc=
e
> the computer suspended, nothing work to re-activate the touchpad.

Hmm, it looks there was another report with Asus losing touchpad
function after suspend:

https://bbs.archlinux.org/viewtopic.php?id=3D194810

Can you try unloading and reloading i8042 module (make sure it is a
module and not compiled into kernel).

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
