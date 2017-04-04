From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: sur40: fix bad endianness handling
 in sur40_poll
Date: Tue, 4 Apr 2017 10:07:11 -0700
Message-ID: <20170404170711.GA29558@dtor-ws>
References: <1491311177-16974-1-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34098 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbdDDRHP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 13:07:15 -0400
Content-Disposition: inline
In-Reply-To: <1491311177-16974-1-git-send-email-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: hverkuil@xs4all.nl, mchehab@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 04, 2017 at 03:06:17PM +0200, Martin Kepplinger wrote:
> sparse says:
> 
>   sur40.c:372:40: warning: restricted __le32 degrades to integer
> 
> the header's data is __le32 so we need to convert it before comparing.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/sur40.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index 4c0eeca..128e5bd 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -369,7 +369,7 @@ static void sur40_poll(struct input_polled_dev *polldev)
>  		 * packet ID will usually increase in the middle of a series
>  		 * instead of at the end.
>  		 */
> -		if (packet_id != header->packet_id)
> +		if (packet_id != le32_to_cpu(header->packet_id))
>  			dev_dbg(sur40->dev, "packet ID mismatch\n");
>  
>  		packet_blobs = result / sizeof(struct sur40_blob);
> -- 
> 2.1.4
> 

-- 
Dmitry
