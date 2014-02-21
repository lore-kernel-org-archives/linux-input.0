From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
Subject: RE: [patch] Input: remove a duplicative NULL test
Date: Fri, 21 Feb 2014 09:14:38 +0000
Message-ID: <e1cf3227a1484c3b931abb61b97391a6@BLUPR03MB373.namprd03.prod.outlook.com>
References: <20140221085506.GB13185@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20140221085506.GB13185@elgon.mountain>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Jingoo Han <jg1.han@samsung.com>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Data: Friday, February 21, 2014 4:55 PM

>To: Dmitry Torokhov
>Cc: Paul Gortmaker; Jingoo Han; Duan Fugang-B38611; Benson Leung; Daniel Kurtz;
>linux-input@vger.kernel.org; kernel-janitors@vger.kernel.org
>Subject: [patch] Input: remove a duplicative NULL test
>
>"pdata" is non-NULL here.  We verified that at the start of the function.
>
>Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
>diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
>b/drivers/input/touchscreen/atmel_mxt_ts.c
>index a70400754e92..40abe90cc924 100644
>--- a/drivers/input/touchscreen/atmel_mxt_ts.c
>+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>@@ -1146,7 +1146,7 @@ static int mxt_probe(struct i2c_client *client,
> 		goto err_free_mem;
> 	}
>
>-	data->is_tp = pdata && pdata->is_tp;
>+	data->is_tp = pdata->is_tp;
>
> 	input_dev->name = (data->is_tp) ? "Atmel maXTouch Touchpad" :
> 					  "Atmel maXTouch Touchscreen";
>
Agree, it is redundant. And if you have free time, you can convert the driver to support devicetree.

Acked-by: Fugang Duan <B38611@freescale.com>
