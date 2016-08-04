From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atkbd - filter buggy codes on ASUS Q500A
Date: Wed, 3 Aug 2016 17:50:52 -0700
Message-ID: <20160804005052.GC36266@dtor-ws>
References: <1469821304-30255-1-git-send-email-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:32930 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933331AbcHDAvE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2016 20:51:04 -0400
Received: by mail-pa0-f67.google.com with SMTP id q2so15054415pap.0
        for <linux-input@vger.kernel.org>; Wed, 03 Aug 2016 17:51:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1469821304-30255-1-git-send-email-linux@rempel-privat.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: linux-input@vger.kernel.org

Hi Oleksij,

On Fri, Jul 29, 2016 at 09:41:44PM +0200, Oleksij Rempel wrote:
> Some revision of ASUS Q500A series have keyboard related
> issue which is reproducible only if Windows with installed ASUS
> tools was ever started.
> In this case the Linux side will have blocked keyboard or
> report wrong or incomplete hotkey events.
> To make Linux work properly again complete power down
> (unplug power supply and remove battery) should be made.
> 
> Linux/atkbd after clean start will get fallowing code on VOLUME_UP
> key: {0xe0, 0x30, 0xe0, 0xb0}. After Windows, same key will generate this
> codes: {0xe1, 0x23, 0xe0, 0x30, 0xe0, 0xb0}. As result atkdb will
> be confused by buggy codes.
> 
> This patch is filtering this buggy code out.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=119391
> 
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> Sponsored-by: Alex Henrie <alexhenrie24@gmail.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I'd prefer it was done as a i8042_filter() installed in a platform
driver (asus-laptop.c?). I a filter you'd need to note the fact that you
received e1 and when you receive next character you either swallo both
or re-inject e1 and the new character. See filter implementation in
./drivers/input/misc/ideapad_slidebar.c.

The scancode fixup method is quite old and is better suited when you
actually want to use the scancode, just a different one. Here you are
forced to user ATKBD_RET_ERR which causes debug messages and increment
error counter.

Thanks.

> ---
>  drivers/input/keyboard/atkbd.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index ec876b5..949c199 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -996,6 +996,17 @@ static unsigned int atkbd_oqo_01plus_scancode_fixup(struct atkbd *atkbd,
>  	return code;
>  }
>  
> +static unsigned int atkbd_asus_q500a_scancode_fixup(struct atkbd *atkbd,
> +						    unsigned int code)
> +{
> +	if (atkbd->translated && atkbd->emul == 2 && code == 0x23) {
> +		atkbd->emul = 0;
> +		return ATKBD_RET_ERR;
> +	}
> +
> +	return code;
> +}
> +
>  /*
>   * atkbd_set_keycode_table() initializes keyboard's keycode table
>   * according to the selected scancode set
> @@ -1802,6 +1813,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
>  		},
>  		.callback = atkbd_deactivate_fixup,
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Q500A"),
> +		},
> +		.callback = atkbd_setup_scancode_fixup,
> +		.driver_data = atkbd_asus_q500a_scancode_fixup,
> +	},
>  	{ }
>  };
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
