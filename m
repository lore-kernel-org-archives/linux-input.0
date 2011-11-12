From: Jiejing Zhang <kzjeef@gmail.com>
Subject: Re: [PATCH V4] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Sat, 12 Nov 2011 16:45:32 +0800
Message-ID: <E5ED6E6E-90D2-4047-B246-F6BB85C572F1@gmail.com>
References: <20111110183819.GB18002@core.coreip.homeip.net> <1321078357-19317-1-git-send-email-jiejing.zhang@freescale.com> <20111112080206.GB20411@core.coreip.homeip.net>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60023 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858Ab1KLIps convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Nov 2011 03:45:48 -0500
Received: by iage36 with SMTP id e36so4991815iag.19
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2011 00:45:47 -0800 (PST)
In-Reply-To: <20111112080206.GB20411@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zhang Jiejing <jiejing.zhang@freescale.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Hi Dmitry,

On 2011-11-12=A3=ACPM4:02=A3=AC Dmitry Torokhov wrote=A3=BA

> On Sat, Nov 12, 2011 at 02:12:37PM +0800, Zhang Jiejing wrote
>>=20
>> V4 changes:
>> * fix some typo
>> * don't let i2c_master_recv spin indefinitely
>> * clean up the bit set of probe function
>> * clean up egalax_ts_remove  input_unregister_device order
>=20
> No, it is not the order I complained about, input_free_device() shoud=
l
> not be called at all after calling input_unregister_device().
>=20

I know the input_free_device call after input_unregister_device() maybe=
 cause NULL pointer reference, sorry for I don't tested rmmod this modu=
le, I always buildin this module in my test env.

I will pay attention to it.

Thanks for your review.

> Fixed up locally and applied.
>=20
Thanks.

Best Regards
Jiejing

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
