From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - add min/max quirk for Lenovo S540
Date: Mon, 8 Jun 2015 10:19:50 -0700
Message-ID: <20150608171950.GA14602@dtor-ws>
References: <20150528001055.GA15825@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36127 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbbFHRTy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 13:19:54 -0400
Content-Disposition: inline
In-Reply-To: <20150528001055.GA15825@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org, tommy.gagnes@gmail.com

On Thu, May 28, 2015 at 10:10:55AM +1000, Peter Hutterer wrote:
> https://bugzilla.redhat.com/show_bug.cgi?id=1223051#c2
> 
> Cc: stable@vger.kernel.org
> Tested-by: tommy.gagnes@gmail.com
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 3b06c8a..907ac9b 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -148,6 +148,11 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
>  		1024, 5112, 2024, 4832
>  	},
>  	{
> +		(const char * const []){"LEN2000", NULL},
> +		{ANY_BOARD_ID, ANY_BOARD_ID},
> +		1024, 5113, 2021, 4832
> +	},
> +	{
>  		(const char * const []){"LEN2001", NULL},
>  		{ANY_BOARD_ID, ANY_BOARD_ID},
>  		1024, 5022, 2508, 4832
> @@ -188,7 +193,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
>  	"LEN0045",
>  	"LEN0047",
>  	"LEN0049",
> -	"LEN2000",
> +	"LEN2000", /* S540 */
>  	"LEN2001", /* Edge E431 */
>  	"LEN2002", /* Edge E531 */
>  	"LEN2003",
> -- 
> 2.4.1
> 

-- 
Dmitry
