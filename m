From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH 2/5] qt602240_ts: move clearing of pending interrupt closer
 to	request_threaded_irq
Date: Thu, 18 Nov 2010 21:53:13 +0900
Message-ID: <4CE521B9.9070509@samsung.com>
References: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
 <20101116204155.28796.6682.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49264 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087Ab0KRMxP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Nov 2010 07:53:15 -0500
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LC200FY5ZSPPOB0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 21:53:13 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LC200C36ZSPLJ@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Thu, 18 Nov 2010 21:53:13 +0900 (KST)
In-reply-to: <20101116204155.28796.6682.stgit@localhost6.localdomain6>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Leech <christopher.leech@linux.intel.com>
Cc: linux-input@vger.kernel.org

Hi, Chris.

On 2010-11-17 =EC=98=A4=EC=A0=84 5:41, Chris Leech wrote:
> I've seen interrupts asserted on the CHG pin between the call to make=
_highcgh()
> during initialization and registering the interrupt handler, leaving =
CHG low
> and no events get passed up.
>

The CHG pin can be affected by control of gpios connected to touch
chip. Could you check it? I think it doesn't matter where
make_highchg() exists actually.

Thanks.

> This moves the clearing of pending messages to right before the call =
to
> request_threaded_irq().  I still think there's a race here that could=
 leave CHG
> stuck low, but worry about clearing the message queue while the inter=
rupt
> handler is registered without some sort of additional locking.
>
> Signed-off-by: Chris Leech<christopher.leech@linux.intel.com>
> ---
>   drivers/input/touchscreen/qt602240_ts.c |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/=
touchscreen/qt602240_ts.c
> index 0b92c9d..95496ec 100644
> --- a/drivers/input/touchscreen/qt602240_ts.c
> +++ b/drivers/input/touchscreen/qt602240_ts.c
> @@ -991,10 +991,6 @@ static int qt602240_initialize(struct qt602240_d=
ata *data)
>   	if (error)
>   		return error;
>
> -	error =3D qt602240_make_highchg(data);
> -	if (error)
> -		return error;
> -
>   	qt602240_handle_pdata(data);
>
>   	/* Backup to memory */
> @@ -1280,6 +1276,10 @@ static int __devinit qt602240_probe(struct i2c=
_client *client,
>   	if (error)
>   		goto err_free_object;
>
> +	error =3D qt602240_make_highchg(data);
> +	if (error)
> +		goto err_free_object;
> +
>   	error =3D request_threaded_irq(client->irq, NULL, qt602240_interru=
pt,
>   			IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
>   	if (error) {
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
