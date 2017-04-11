From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: soc_button_array: Properly map usage-page 7 usage
 0xe3 to KEY_LEFTMETA
Date: Mon, 10 Apr 2017 20:36:41 -0700
Message-ID: <20170411033641.GB4346@dtor-ws>
References: <20170410193645.9797-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36219 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbdDKDgo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 23:36:44 -0400
Received: by mail-pg0-f68.google.com with SMTP id 81so28067940pgh.3
        for <linux-input@vger.kernel.org>; Mon, 10 Apr 2017 20:36:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170410193645.9797-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, russianneuromancer@ya.ru

On Mon, Apr 10, 2017 at 09:36:45PM +0200, Hans de Goede wrote:
> When submitting the support for the ACPI0011 windows tablet keys device
> I mapped the "windows" logo homekey to KEY_HOMEPAGE. But this is
> inconsistent with how it is done on windows tablets using the
> old PNP0C40 ACPI device and it does not match the Hut spec, which says
> that usage-page 7 usage 0xe3 is "Keyboard Left GUI".
> 
> This commit maps usage-page 7 usage 0xe3 to KEY_LEFTMETA fixing this.
> 
> Cc: russianneuromancer@ya.ru
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
>  drivers/input/misc/soc_button_array.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index d75a8a3..e1d42f1 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -187,7 +187,7 @@ static int soc_button_parse_btn_desc(struct device *dev,
>  		info->wakeup = true;
>  	} else if (upage == 0x07 && usage == 0xe3) {
>  		info->name = "home";
> -		info->event_code = KEY_HOMEPAGE;
> +		info->event_code = KEY_LEFTMETA;
>  		info->wakeup = true;
>  	} else if (upage == 0x0c && usage == 0xe9) {
>  		info->name = "volume_up";
> -- 
> 2.9.3
> 

-- 
Dmitry
