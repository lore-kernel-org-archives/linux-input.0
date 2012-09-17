From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Fix return value in hid-core.c
Date: Mon, 17 Sep 2012 13:02:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209171301500.31149@pobox.suse.cz>
References: <1347623177-14221-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43356 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694Ab2IQLCf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 07:02:35 -0400
In-Reply-To: <1347623177-14221-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, patches@linaro.org

On Fri, 14 Sep 2012, Sachin Kamat wrote:

> Return -ENOMEM instead of -1 if memory allocation fails.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/hid/hid-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 16d6454..1011a22 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -134,7 +134,7 @@ static int open_collection(struct hid_parser *parser, unsigned type)
>  				parser->device->collection_size * 2, GFP_KERNEL);
>  		if (collection == NULL) {
>  			hid_err(parser->device, "failed to reallocate collection array\n");
> -			return -1;
> +			return -ENOMEM;

While you are at it, could you please update the return value in case the 
collection stack overflows? I'd go with EINVAL. Thanks.

>  		}
>  		memcpy(collection, parser->device->collection,
>  			sizeof(struct hid_collection) *
> -- 
> 1.7.4.1
> 

-- 
Jiri Kosina
SUSE Labs
