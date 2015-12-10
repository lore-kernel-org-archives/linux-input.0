From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] Input: don't push static constants on stack for %*ph
Date: Thu, 10 Dec 2015 15:46:57 +0200
Message-ID: <1449755217.30729.99.camel@linux.intel.com>
References: <1378291309-13869-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:51684 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173AbbLJNqo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2015 08:46:44 -0500
In-Reply-To: <1378291309-13869-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, 2013-09-04 at 13:41 +0300, Andy Shevchenko wrote:
> There is no need to pass constants via stack. The width may be
> explicitly
> specified in the format.

Dmitry, any comments on this?

>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/input/mouse/hgpk.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 7 +++----
> =C2=A0drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++--
> =C2=A02 files changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
> index 62be888..27909a1 100644
> --- a/drivers/input/mouse/hgpk.c
> +++ b/drivers/input/mouse/hgpk.c
> @@ -333,9 +333,8 @@ static bool hgpk_is_byte_valid(struct psmouse
> *psmouse, unsigned char *packet)
> =C2=A0	}
> =C2=A0
> =C2=A0	if (!valid)
> -		psmouse_dbg(psmouse,
> -			=C2=A0=C2=A0=C2=A0=C2=A0"bad data, mode %d (%d) %*ph\n",
> -			=C2=A0=C2=A0=C2=A0=C2=A0priv->mode, pktcnt, 6, psmouse->packet);
> +		psmouse_dbg(psmouse, "bad data, mode %d (%d)
> %6ph\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0priv->mode, pktcnt, psmouse->packet);
> =C2=A0
> =C2=A0	return valid;
> =C2=A0}
> @@ -1027,7 +1026,7 @@ static enum hgpk_model_t hgpk_get_model(struct
> psmouse *psmouse)
> =C2=A0		return -EIO;
> =C2=A0	}
> =C2=A0
> -	psmouse_dbg(psmouse, "ID: %*ph\n", 3, param);
> +	psmouse_dbg(psmouse, "ID: %3ph\n", param);
> =C2=A0
> =C2=A0	/* HGPK signature: 0x67, 0x00, 0x<model> */
> =C2=A0	if (param[0] !=3D 0x67 || param[1] !=3D 0x00)
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
> b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 59aa240..dd44ebf 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -331,8 +331,8 @@ static bool mxt_object_writable(unsigned int
> type)
> =C2=A0static void mxt_dump_message(struct device *dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mxt_message *message)
> =C2=A0{
> -	dev_dbg(dev, "reportid: %u\tmessage: %*ph\n",
> -		message->reportid, 7, message->message);
> +	dev_dbg(dev, "reportid: %u\tmessage: %7ph\n",
> +		message->reportid, message->message);
> =C2=A0}
> =C2=A0
> =C2=A0static int mxt_check_bootloader(struct i2c_client *client,

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
