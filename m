From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: synaptics: fix min-max quirk value for E440
Date: Wed, 25 Mar 2015 15:53:35 -0700
Message-ID: <20150325225335.GB17427@dtor-ws>
References: <1427315624-6653-1-git-send-email-filipayazi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:32790 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbCYWxk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Mar 2015 18:53:40 -0400
Content-Disposition: inline
In-Reply-To: <1427315624-6653-1-git-send-email-filipayazi@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Filip Ayazi <filipayazi@gmail.com>
Cc: cramm0@gmail.com, linux-kernel@vger.kernel.org, consume.noise@gmail.com, linux-input@vger.kernel.org

On Wed, Mar 25, 2015 at 09:33:44PM +0100, Filip Ayazi wrote:
> Commit 98dc070373 ("Input: synaptics - add quirk for Thinkpad E440") had
> a typo in ymax, this changes the value to the one reported by
> touchpad-edge-detector and mentioned in the commit.
> 
> Signed-off-by: Filip Ayazi <filipayazi@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index f6a3a7b..3b06c8a 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -155,7 +155,7 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
>  	{
>  		(const char * const []){"LEN2006", NULL},
>  		{2691, 2691},
> -		1024, 5045, 2457, 4632
> +		1024, 5045, 2457, 4832
>  	},
>  	{
>  		(const char * const []){"LEN2006", NULL},
> -- 
> 1.9.1
> 

-- 
Dmitry
