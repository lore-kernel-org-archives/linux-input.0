From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i8042: Add noloop quirk for Asus X750LN
Date: Sat, 11 Oct 2014 11:35:23 -0700
Message-ID: <20141011183523.GA20881@dtor-ws>
References: <1413032946-19748-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:39113 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbaJKSf2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Oct 2014 14:35:28 -0400
Received: by mail-pd0-f181.google.com with SMTP id z10so3465284pdj.12
        for <linux-input@vger.kernel.org>; Sat, 11 Oct 2014 11:35:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413032946-19748-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

On Sat, Oct 11, 2014 at 03:09:06PM +0200, Hans de Goede wrote:
> Without this the aux port does not get detected, and consequently the touchpad
> will not work.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1110011
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
>  drivers/input/serio/i8042-x86ia64io.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 40b7d6c..4a6d05d 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -101,6 +101,12 @@ static const struct dmi_system_id __initconst i8042_dmi_noloop_table[] = {
>  	},
>  	{
>  		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "X750LN"),
> +		},
> +	},
> +	{
> +		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
>  			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
>  			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
> -- 
> 2.1.0
> 

-- 
Dmitry
