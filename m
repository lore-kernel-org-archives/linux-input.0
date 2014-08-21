From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH 4/7] mfd: cros_ec: move locking into
 cros_ec_cmd_xfer
Date: Thu, 21 Aug 2014 15:09:53 +0100
Message-ID: <20140821140953.GL4266@lee--X1>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408536812-7836-5-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:59014 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbaHUOKA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Aug 2014 10:10:00 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so13361838igb.2
        for <linux-input@vger.kernel.org>; Thu, 21 Aug 2014 07:10:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408536812-7836-5-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On Wed, 20 Aug 2014, Javier Martinez Canillas wrote:

> From: Andrew Bresticker <abrestic@chromium.org>
>=20
> Now that there's a central cros_ec_cmd_xfer(), move the locking
> out of the SPI and LPC drivers.
>=20
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co=
=2Euk>
> ---
>  drivers/mfd/cros_ec.c     | 10 +++++++++-
>  drivers/mfd/cros_ec_spi.c | 11 -----------
>  2 files changed, 9 insertions(+), 12 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
