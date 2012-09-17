From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH Resend] HID: Fix return values in hid-core.c
Date: Mon, 17 Sep 2012 13:16:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209171316230.31149@pobox.suse.cz>
References: <1347880316-24604-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44111 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755668Ab2IQLQh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 07:16:37 -0400
In-Reply-To: <1347880316-24604-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-input@vger.kernel.org, patches@linaro.org

On Mon, 17 Sep 2012, Sachin Kamat wrote:

> Return -ENOMEM instead of -1 if memory allocation fails.
> Return -EINVAL instead of -1 for stack overflow and
> underflow errors.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/hid/hid-core.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 16d6454..80b0218 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -126,7 +126,7 @@ static int open_collection(struct hid_parser *parser, unsigned type)
>  
>  	if (parser->collection_stack_ptr == HID_COLLECTION_STACK_SIZE) {
>  		hid_err(parser->device, "collection stack overflow\n");
> -		return -1;
> +		return -EINVAL;
>  	}
>  
>  	if (parser->device->maxcollection == parser->device->collection_size) {
> @@ -134,7 +134,7 @@ static int open_collection(struct hid_parser *parser, unsigned type)
>  				parser->device->collection_size * 2, GFP_KERNEL);
>  		if (collection == NULL) {
>  			hid_err(parser->device, "failed to reallocate collection array\n");
> -			return -1;
> +			return -ENOMEM;
>  		}
>  		memcpy(collection, parser->device->collection,
>  			sizeof(struct hid_collection) *
> @@ -170,7 +170,7 @@ static int close_collection(struct hid_parser *parser)
>  {
>  	if (!parser->collection_stack_ptr) {
>  		hid_err(parser->device, "collection stack underflow\n");
> -		return -1;
> +		return -EINVAL;
>  	}
>  	parser->collection_stack_ptr--;
>  	return 0;

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
