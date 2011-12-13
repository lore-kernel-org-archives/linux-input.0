From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v3] Driver for AUO In-Cell touchscreens using pixcir ICs
Date: Tue, 13 Dec 2011 11:03:19 +0100
Message-ID: <201112131103.19427.heiko@sntech.de>
References: <201112072348.04578.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1778886.stratoserver.net ([85.214.133.74]:52600 "EHLO
	h1778886.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab1LMKDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Dec 2011 05:03:22 -0500
In-Reply-To: <201112072348.04578.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

Am Mittwoch, 7. Dezember 2011, 23:48:04 schrieb Heiko St=FCbner:
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
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v2: address comments from Dmitry Torokhov
> especially suspend/resume handling
>=20
> changes since v1: address comments from Christoph Fritz
> (wrong type for error checks, wrong call to input_free_device)

ping for this?

As I wrote in the other thread, the device is not capable of tracking t=
he=20
individual fingers, so this v3 should hopefully address all your commen=
ts.

Heiko
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
