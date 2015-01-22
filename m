From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: cyapa: fix variable dereferenced before check
 'gen5_pip->resp_len' issue
Date: Thu, 22 Jan 2015 08:22:01 -0800
Message-ID: <20150122162201.GC18153@dtor-ws>
References: <1421909406-1240-1-git-send-email-dudl@cypress.com>
 <1421909406-1240-2-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:59730 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbbAVQWG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2015 11:22:06 -0500
Content-Disposition: inline
In-Reply-To: <1421909406-1240-2-git-send-email-dudl@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dudley Du <dudl@cypress.com>
Cc: jmmahler@gmail.com, rydberg@euromail.se, bleung@google.com, dan.carpenter@oracle.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jan 22, 2015 at 02:50:06PM +0800, Dudley Du wrote:
> Fixes the warning issue of the variable dereferenced before check
> 'gen5_pip->resp_len' report by dan Carpenter.
> 
> Signed-off-by: Dudley Du <dudl@cypress.com>

Applied, thank you.

> ---
>  drivers/input/mouse/cyapa_gen5.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
> index 69d9059..ed1af74 100644
> --- a/drivers/input/mouse/cyapa_gen5.c
> +++ b/drivers/input/mouse/cyapa_gen5.c
> @@ -2558,7 +2558,9 @@ static bool cyapa_gen5_irq_cmd_handler(struct cyapa *cyapa)
>  			 * trackpad device when booting/rebooting
>  			 * their chrome book.
>  			 */
> -			length = *gen5_pip->resp_len;
> +			length = 0;
> +			if (gen5_pip->resp_len)
> +				length = *gen5_pip->resp_len;
>  			cyapa_empty_pip_output_data(cyapa,
>  					gen5_pip->resp_data,
>  					&length,
> -- 
> 1.9.1
> 

-- 
Dmitry
