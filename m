From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Driver for AUO In-Cell touchscreens using pixcir ICs
Date: Sat, 31 Dec 2011 15:29:43 -0800
Message-ID: <20111231232943.GA8078@core.coreip.homeip.net>
References: <201112072348.04578.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39907 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab1LaX3w (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Dec 2011 18:29:52 -0500
Received: by iaeh11 with SMTP id h11so27346780iae.19
        for <linux-input@vger.kernel.org>; Sat, 31 Dec 2011 15:29:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201112072348.04578.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: linux-input@vger.kernel.org

On Wed, Dec 07, 2011 at 11:48:04PM +0100, Heiko St=FCbner wrote:
> Some displays from AUO have a so called in-cell touchscreen, meaning =
it
> is built directly into the display unit.
>=20
> Touchdata is gathered through PIXCIR Tango-ICs and processed in an
> Atmel ATmega168P with custom firmware. Communication between the host
> system and ATmega is done via I2C.
>=20
> Devices using this touch solution include the Dell Streak5 and the fa=
mily
> of Qisda ebook readers.
>=20
> The driver reports single- and multi-touch events including touch are=
a
> values.
>=20

Applied, thank you Heiko.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
