From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input:Add clk api support for w90p910 touchscreen
Date: Tue, 7 Jul 2009 22:49:52 +0530
Message-ID: <5d5443650907071019w45474b2dhd0a175a0ffac4f3a@mail.gmail.com>
References: <4A535B97.4010700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:32014 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbZGGRTx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2009 13:19:53 -0400
Received: by qw-out-2122.google.com with SMTP id 9so2067965qwb.37
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2009 10:19:52 -0700 (PDT)
In-Reply-To: <4A535B97.4010700@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,

> + =A0 =A0 =A0 w90p910_ts->clk =3D clk_get(&pdev->dev, pdev->name);

Having clk_name coming from pdev->name looks strange to me. I feel it
should either  "NULL" or const string.

> + =A0 =A0 =A0 if (IS_ERR(w90p910_ts->clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(w90p910_ts->clk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail3;
> =A0 =A0 =A0 =A0}
>


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
