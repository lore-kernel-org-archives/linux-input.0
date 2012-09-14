From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH 3/6] HID: picoLCD: Add support for CIR
Date: Fri, 14 Sep 2012 11:15:37 -0300
Message-ID: <50533C09.1020809@redhat.com>
References: <20120819192859.74136bb0@neptune.home> <20120819193254.6a48348d@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41740 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756634Ab2INOPu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 10:15:50 -0400
In-Reply-To: <20120819193254.6a48348d@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?QnJ1bm8gUHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org

Em 19-08-2012 14:32, Bruno Pr=C3=A9mont escreveu:
> Implement support for picoLCD's CIR header using RC_CORE for decoding
> the IR event stream.
>=20
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

Sorry for a late answer. I'm with a huge backlog due to KS/2012 worksho=
p.

Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

> ---
>  drivers/hid/hid-picolcd.h      |    5 ++-
>  drivers/hid/hid-picolcd_cir.c  |   95 ++++++++++++++++++++++++++++++=
+++++++++-
>  drivers/hid/hid-picolcd_core.c |    3 +-
>  3 files changed, 98 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
> index dc4c795..240eb1c 100644
> --- a/drivers/hid/hid-picolcd.h
> +++ b/drivers/hid/hid-picolcd.h
> @@ -85,7 +85,9 @@ struct picolcd_data {
>  	/* input stuff */
>  	u8 pressed_keys[2];
>  	struct input_dev *input_keys;
> -	struct input_dev *input_cir;
> +#ifdef CONFIG_HID_PICOLCD_CIR
> +	struct rc_dev *rc_dev;
> +#endif
>  	unsigned short keycode[PICOLCD_KEYS];
> =20
>  #ifdef CONFIG_HID_PICOLCD_FB
> @@ -114,6 +116,7 @@ struct picolcd_data {
>  	int status;
>  #define PICOLCD_BOOTLOADER 1
>  #define PICOLCD_FAILED 2
> +#define PICOLCD_CIR_SHUN 4
>  };
> =20
>  #ifdef CONFIG_HID_PICOLCD_FB
> diff --git a/drivers/hid/hid-picolcd_cir.c b/drivers/hid/hid-picolcd_=
cir.c
> index dc632c3..f38af30 100644
> --- a/drivers/hid/hid-picolcd_cir.c
> +++ b/drivers/hid/hid-picolcd_cir.c
> @@ -37,6 +37,7 @@
>  #include <linux/completion.h>
>  #include <linux/uaccess.h>
>  #include <linux/module.h>
> +#include <media/rc-core.h>
> =20
>  #include "hid-picolcd.h"
> =20
> @@ -44,18 +45,108 @@
>  int picolcd_raw_cir(struct picolcd_data *data,
>  		struct hid_report *report, u8 *raw_data, int size)
>  {
> -	/* Need understanding of CIR data format to implement ... */
> +	unsigned long flags;
> +	int i, w, sz;
> +	DEFINE_IR_RAW_EVENT(rawir);
> +
> +	/* ignore if rc_dev is NULL or status is shunned */
> +	spin_lock_irqsave(&data->lock, flags);
> +	if (data->rc_dev && (data->status & PICOLCD_CIR_SHUN)) {
> +		spin_unlock_irqrestore(&data->lock, flags);
> +		return 1;
> +	}
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	/* PicoLCD USB packets contain 16-bit intervals in network order,
> +	 * with value negated for pulse. Intervals are in microseconds.
> +	 *
> +	 * Note: some userspace LIRC code for PicoLCD says negated values
> +	 * for space - is it a matter of IR chip? (pulse for my TSOP2236)
> +	 *
> +	 * In addition, the first interval seems to be around 15000 + base
> +	 * interval for non-first report of IR data - thus the quirk below
> +	 * to get RC_CODE to understand Sony and JVC remotes I have at hand
> +	 */
> +	sz =3D size > 0 ? min((int)raw_data[0], size-1) : 0;
> +	for (i =3D 0; i+1 < sz; i +=3D 2) {
> +		init_ir_raw_event(&rawir);
> +		w =3D (raw_data[i] << 8) | (raw_data[i+1]);
> +		rawir.pulse =3D !!(w & 0x8000);
> +		rawir.duration =3D US_TO_NS(rawir.pulse ? (65536 - w) : w);
> +		/* Quirk!! - see above */
> +		if (i =3D=3D 0 && rawir.duration > 15000000)
> +			rawir.duration -=3D 15000000;
> +		ir_raw_event_store(data->rc_dev, &rawir);
> +	}
> +	ir_raw_event_handle(data->rc_dev);
> +
>  	return 1;
>  }
> =20
> +static int picolcd_cir_open(struct rc_dev *dev)
> +{
> +	struct picolcd_data *data =3D dev->priv;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	data->status &=3D ~PICOLCD_CIR_SHUN;
> +	spin_unlock_irqrestore(&data->lock, flags);
> +	return 0;
> +}
> +
> +static void picolcd_cir_close(struct rc_dev *dev)
> +{
> +	struct picolcd_data *data =3D dev->priv;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +	data->status |=3D PICOLCD_CIR_SHUN;
> +	spin_unlock_irqrestore(&data->lock, flags);
> +}
> +
>  /* initialize CIR input device */
>  int picolcd_init_cir(struct picolcd_data *data, struct hid_report *r=
eport)
>  {
> -	/* support not implemented yet */
> +	struct rc_dev *rdev;
> +	int ret =3D 0;
> +
> +	rdev =3D rc_allocate_device();
> +	if (!rdev)
> +		return -ENOMEM;
> +
> +	rdev->priv             =3D data;
> +	rdev->driver_type      =3D RC_DRIVER_IR_RAW;
> +	rdev->allowed_protos   =3D RC_TYPE_ALL;
> +	rdev->open             =3D picolcd_cir_open;
> +	rdev->close            =3D picolcd_cir_close;
> +	rdev->input_name       =3D data->hdev->name;
> +	rdev->input_phys       =3D data->hdev->phys;
> +	rdev->input_id.bustype =3D data->hdev->bus;
> +	rdev->input_id.vendor  =3D data->hdev->vendor;
> +	rdev->input_id.product =3D data->hdev->product;
> +	rdev->input_id.version =3D data->hdev->version;
> +	rdev->dev.parent       =3D &data->hdev->dev;
> +	rdev->driver_name      =3D PICOLCD_NAME;
> +	rdev->map_name         =3D RC_MAP_RC6_MCE;
> +	rdev->timeout          =3D MS_TO_NS(100);
> +	rdev->rx_resolution    =3D US_TO_NS(1);
> +
> +	ret =3D rc_register_device(rdev);
> +	if (ret)
> +		goto err;
> +	data->rc_dev =3D rdev;
>  	return 0;
> +
> +err:
> +	rc_free_device(rdev);
> +	return ret;
>  }
> =20
>  void picolcd_exit_cir(struct picolcd_data *data)
>  {
> +	struct rc_dev *rdev =3D data->rc_dev;
> +
> +	data->rc_dev =3D NULL;
> +	rc_unregister_device(rdev);
>  }
> =20
> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd=
_core.c
> index 76ab173..580269b 100644
> --- a/drivers/hid/hid-picolcd_core.c
> +++ b/drivers/hid/hid-picolcd_core.c
> @@ -356,8 +356,7 @@ static int picolcd_raw_event(struct hid_device *h=
dev,
>  		if (data->input_keys)
>  			ret =3D picolcd_raw_keypad(data, report, raw_data+1, size-1);
>  	} else if (report->id =3D=3D REPORT_IR_DATA) {
> -		if (data->input_cir)
> -			ret =3D picolcd_raw_cir(data, report, raw_data+1, size-1);
> +		ret =3D picolcd_raw_cir(data, report, raw_data+1, size-1);
>  	} else {
>  		spin_lock_irqsave(&data->lock, flags);
>  		/*
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
