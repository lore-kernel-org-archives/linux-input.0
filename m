From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] input: silead: add Chuwi Hi8 support
Date: Sat, 16 Dec 2017 16:15:40 +0100
Message-ID: <4a065f11-b453-93fa-9b4a-7400fcdd1e12@redhat.com>
References: <SLXP216MB0462B59087253DCEFF0811DB9B0B0@SLXP216MB0462.KORP216.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38905 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753278AbdLPPPm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 16 Dec 2017 10:15:42 -0500
Received: by mail-wm0-f68.google.com with SMTP id 64so22357864wme.3
        for <linux-input@vger.kernel.org>; Sat, 16 Dec 2017 07:15:42 -0800 (PST)
In-Reply-To: <SLXP216MB0462B59087253DCEFF0811DB9B0B0@SLXP216MB0462.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maruyama Shohei <cheat.sc.linux@outlook.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>

Hi,

On 15-12-17 21:02, Maruyama Shohei wrote:
> This commit add ACPI support for Chuwi Hi8 tablet. On the ACPI table of
> the tablet, GSL1680 is registered as MSSL0001, so the driver does not
> recognize the device. This commit resolve it.
> 
> Signed-off-by: Shohei Maruyama <cheat.sc.linux@outlook.com>

Looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   drivers/input/touchscreen/silead.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index 0dbcf105f7db..531f22891462 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -578,6 +578,7 @@ static const struct acpi_device_id silead_ts_acpi_match[] = {
>   	{ "GSL3675", 0 },
>   	{ "GSL3692", 0 },
>   	{ "MSSL1680", 0 },
> +	{ "MSSL0001", 0 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(acpi, silead_ts_acpi_match);
> 
