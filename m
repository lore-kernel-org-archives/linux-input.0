From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Add antoher Lenovo ACPI ID for
 upcoming Lenovo NB Add 2 ACPI IC ELAN0609, ELAN060B in the ACPI mapping
 table Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Date: Mon, 14 Aug 2017 20:18:15 -0700
Message-ID: <20170815031815.GA31856@dtor-ws>
References: <1502435404-20549-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36312 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbdHODSS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Aug 2017 23:18:18 -0400
Content-Disposition: inline
In-Reply-To: <1502435404-20549-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: KT Liao <kt.liao@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw

On Fri, Aug 11, 2017 at 03:10:04PM +0800, KT Liao wrote:

Applied, however please make sure that there is a blank line in your
commit messages between the first line (subject) and the subsequent
lines comprising the patch description: it will allow the tools work
properly and not create emails with subjects consisting of your entire
commit message.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 3b616cb..0d111322 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1248,6 +1248,8 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0100", 0 },
>  	{ "ELAN0600", 0 },
>  	{ "ELAN0605", 0 },
> +	{ "ELAN0609", 0 },
> +	{ "ELAN060B", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
>  };
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
