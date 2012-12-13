From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] input:stmpe-ts: Add support to report BTN_TOUCH event
Date: Thu, 13 Dec 2012 09:10:04 +0000
Message-ID: <20121213091004.GF27617@gmail.com>
References: <7c50ed5f531db8ab992ebeaf1a48853a6274faf2.1355376050.git.vipulkumar.samar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35253 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab2LMJKK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Dec 2012 04:10:10 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so865271bkw.19
        for <linux-input@vger.kernel.org>; Thu, 13 Dec 2012 01:10:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7c50ed5f531db8ab992ebeaf1a48853a6274faf2.1355376050.git.vipulkumar.samar@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vipul Kumar Samar <vipulkumar.samar@st.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com, viresh.kumar@linaro.org, shiraz.hashim@st.com

On Thu, 13 Dec 2012, Vipul Kumar Samar wrote:

> stmpe touchscreen supports BTN_TOUCH event but doesn't report it. Add
> BTN_TOUCH reporting capability to the stmpe touchscreen driver.
>=20
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> ---
>  drivers/input/touchscreen/stmpe-ts.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/tou=
chscreen/stmpe-ts.c
> index 076442a..c3399a1 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -121,6 +121,7 @@ static void stmpe_work(struct work_struct *work)
>  	__stmpe_reset_fifo(ts->stmpe);
> =20
>  	input_report_abs(ts->idev, ABS_PRESSURE, 0);
> +	input_report_key(ts->idev, BTN_TOUCH, 0);
>  	input_sync(ts->idev);
>  }
> =20
> @@ -154,6 +155,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void=
 *data)
>  	input_report_abs(ts->idev, ABS_X, x);
>  	input_report_abs(ts->idev, ABS_Y, y);
>  	input_report_abs(ts->idev, ABS_PRESSURE, z);
> +	input_report_key(ts->idev, BTN_TOUCH, 1);
>  	input_sync(ts->idev);
> =20
>         /* flush the FIFO after we have read out our values. */
> --=20
> 1.7.2.2

So long as it's tested/working, the code looks fine so:

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
