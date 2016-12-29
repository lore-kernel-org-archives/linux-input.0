From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: synaptics-rmi4: remove redundant null check on
 rmi_dev
Date: Thu, 29 Dec 2016 10:20:56 -0800
Message-ID: <20161229182056.GA5256@dtor-ws>
References: <20161221144104.25794-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35590 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbcL2SU7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Dec 2016 13:20:59 -0500
Content-Disposition: inline
In-Reply-To: <20161221144104.25794-1-colin.king@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Lyude Paul <thatslyude@gmail.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Dec 21, 2016 at 02:41:04PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> rmi_dev is currently being dereferenced before it null checked,
> however, after deeper inspecting, rmi_dev can never be null,
> so just remove this redundant check. Thanks to Dmitry Torokhov for
> noticing that we can remove the null check.
> 
> Fixes CoverityScan CID 1391218 ("Dereference before null check")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/rmi4/rmi_f03.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
> index 8a7ca3e..9a1b099 100644
> --- a/drivers/input/rmi4/rmi_f03.c
> +++ b/drivers/input/rmi4/rmi_f03.c
> @@ -175,9 +175,6 @@ static int rmi_f03_attention(struct rmi_function *fn, unsigned long *irq_bits)
>  	int i;
>  	int error;
>  
> -	if (!rmi_dev)
> -		return -ENODEV;
> -
>  	if (drvdata->attn_data.data) {
>  		/* First grab the data passed by the transport device */
>  		if (drvdata->attn_data.size < ob_len) {
> -- 
> 2.10.2
> 

-- 
Dmitry
