From: Heiko =?utf-8?q?St=C3=BCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2] Input: add driver for Neonode zForce based touchscreens
Date: Mon, 23 Sep 2013 15:50:26 +0200
Message-ID: <201309231550.27313.heiko@sntech.de>
References: <201309070133.11671.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:59968 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418Ab3IWNub (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Sep 2013 09:50:31 -0400
In-Reply-To: <201309070133.11671.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Am Samstag, 7. September 2013, 01:33:11 schrieb Heiko St=C3=BCbner:
> This adds a driver for touchscreens using the zforce infrared
> technology from Neonode connected via i2c to the host system.
>=20
> It supports multitouch with up to two fingers and tracking of the
> contacts in hardware.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v1:
> - address comments from Dmitry Torokhov
>   but I kept the access_mutex due to the possible race I described in=
 the
> mail:
>   - touch -> interrupt
>   - isr reads first packet
>   - user closes device -> stop command sent
>   - isr reads payload
> - address comments from Henrik Rydberg, letting the input system coll=
ect
>   singletouch from the multitouch data using the appropriate function=
s

ping?


Thanks
Heiko
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
