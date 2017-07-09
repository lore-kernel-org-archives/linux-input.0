From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] skip all blobs that are not touches
Date: Sun, 9 Jul 2017 14:41:05 -0700
Message-ID: <20170709214105.GE21945@dtor-ws>
References: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
 <1499626491-22592-2-git-send-email-floe@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36456 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752622AbdGIVlJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 9 Jul 2017 17:41:09 -0400
Received: by mail-pf0-f194.google.com with SMTP id z6so11907009pfk.3
        for <linux-input@vger.kernel.org>; Sun, 09 Jul 2017 14:41:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1499626491-22592-2-git-send-email-floe@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-input@vger.kernel.org, Martin Kaltenbrunner <modin@yuri.at>

On Sun, Jul 09, 2017 at 08:54:51PM +0200, Florian Echtler wrote:
> The SUR40 labels all reported blobs as touch, token, or generic blob.
> Previously, all blobs were reported as touch regardless of type, causing
> lots of false positives. Present patch fixes this.
> 
> Signed-off-by: Martin Kaltenbrunner <modin@yuri.at>
> Signed-off-by: Florian Echtler <floe@butterbrot.org>
> ---
>  drivers/input/touchscreen/sur40.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index 12bdee9..fbd4010 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -309,6 +309,8 @@ static void sur40_report_blob(struct sur40_blob *blob, struct input_dev *input)
>  	int slotnum = input_mt_get_slot_by_key(input, blob->blob_id);
>  	if (slotnum < 0 || slotnum >= MAX_CONTACTS)
>  		return;
> +	if (blob->type != SUR40_TOUCH)
> +		return;

I think we should be checking blob type before trying to get slot
number.

>  
>  	input_mt_slot(input, slotnum);
>  	input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
