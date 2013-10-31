From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: remove a redundant max() call.
Date: Thu, 31 Oct 2013 00:48:08 -0700
Message-ID: <20131031074808.GA1886@core.coreip.homeip.net>
References: <1383204394-15399-1-git-send-email-hukangustc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:57575 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab3JaHsK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Oct 2013 03:48:10 -0400
Content-Disposition: inline
In-Reply-To: <1383204394-15399-1-git-send-email-hukangustc@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kang Hu <hukangustc@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Oct 31, 2013 at 03:26:34PM +0800, Kang Hu wrote:
> dev->hint_events_per_packet is guaranteed to be >= packet_size.
> so an extra max() call is not needed.


Applied, thank you.

> 
> Signed-off-by: Kang Hu <hukangustc@gmail.com>
> ---
>  drivers/input/input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index c044699..fb513da 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2048,7 +2048,7 @@ int input_register_device(struct input_dev *dev)
>  	if (dev->hint_events_per_packet < packet_size)
>  		dev->hint_events_per_packet = packet_size;
>  
> -	dev->max_vals = max(dev->hint_events_per_packet, packet_size) + 2;
> +	dev->max_vals = dev->hint_events_per_packet + 2;
>  	dev->vals = kcalloc(dev->max_vals, sizeof(*dev->vals), GFP_KERNEL);
>  	if (!dev->vals) {
>  		error = -ENOMEM;
> -- 
> 1.8.3.1
> 

-- 
Dmitry
