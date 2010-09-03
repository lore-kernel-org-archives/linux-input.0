From: Luotao Fu <devtty0@gmail.com>
Subject: Re: [PATCH 1/2] Input: stmpe-ts - remove input_free_device() in stmpe_ts_remove()
Date: Fri, 3 Sep 2010 09:13:30 +0200
Message-ID: <AANLkTinE4G0TYSn=hmqVxXVAbTZ1cpOAXmhqg6QGY5dP@mail.gmail.com>
References: <1283477451.5439.6.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49966 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab0ICHNb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 03:13:31 -0400
In-Reply-To: <1283477451.5439.6.camel@mola>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Luotao Fu <l.fu@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi,

On Fri, Sep 3, 2010 at 3:30 AM, Axel Lin <axel.lin@gmail.com> wrote:
> No need to call input_free_device() after input_unregister_device().
>

yeah right. The device is input_unregister_device unregisters the
device already. Thx for fixing this.

Acked-by: Luotao Fu <devtty0@gmail.com>

> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =A0drivers/input/touchscreen/stmpe-ts.c | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/tou=
chscreen/stmpe-ts.c
> index 656148e..0339d1d 100644
> --- a/drivers/input/touchscreen/stmpe-ts.c
> +++ b/drivers/input/touchscreen/stmpe-ts.c
> @@ -361,7 +361,6 @@ static int __devexit stmpe_ts_remove(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, NULL);
>
> =A0 =A0 =A0 =A0input_unregister_device(ts->idev);
> - =A0 =A0 =A0 input_free_device(ts->idev);
>
> =A0 =A0 =A0 =A0kfree(ts);
>
> --
> 1.7.2
>
>
>
>

cheers
Luotao Fu
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
