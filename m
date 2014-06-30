From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Fixes kernel panic with Null pointer in hid-appleir.c
Date: Mon, 30 Jun 2014 16:38:04 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1406301636100.28307@pobox.suse.cz>
References: <1403281515-5508-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403281515-5508-1-git-send-email-xerofoify@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 20 Jun 2014, Nicholas Krause wrote:

> In for loop of function appleir_input_configured we hit
> a Null pointer after the for loop due to array_size not
> being correct needs to be changed to input_dev->keycodemax.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/hid/hid-appleir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
> index 0e6a42d..ab0a702 100644
> --- a/drivers/hid/hid-appleir.c
> +++ b/drivers/hid/hid-appleir.c
> @@ -272,7 +272,7 @@ static void appleir_input_configured(struct hid_device *hid,
>  	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
>  
>  	memcpy(appleir->keymap, appleir_key_table, sizeof(appleir->keymap));
> -	for (i = 0; i < ARRAY_SIZE(appleir_key_table); i++)
> +	for (i = 0; i < ARRAY_SIZE(input_dev->keycodemax); i++)

Ugh, how is this supposed to work? input_dev->keycodemax is int, not 
array. I think you actually want sizeof(appleir->keymap) there.

-- 
Jiri Kosina
SUSE Labs
