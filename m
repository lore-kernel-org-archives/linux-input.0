From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 05/10] drivers/input/mouse/appletouch.c: Remove
 KERN_DEBUG use from dprintk
Date: Tue, 26 Oct 2010 08:52:06 -0700
Message-ID: <20101026155206.GB13097@core.coreip.homeip.net>
References: <cover.1288059486.git.joe@perches.com>
 <0f8723f18ce30ef726043555baee90d47ee995ca.1288059486.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54997 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab0JZPwQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Oct 2010 11:52:16 -0400
Content-Disposition: inline
In-Reply-To: <0f8723f18ce30ef726043555baee90d47ee995ca.1288059486.git.joe@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Jiri Kosina <trivial@kernel.org>, Alessandro Rubini <rubini@ipvvis.unipv.it>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Oct 25, 2010 at 07:44:23PM -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>

Applied, thanks Joe.

> ---
>  drivers/input/mouse/appletouch.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index a9cf768..b77f999 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -630,7 +630,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
>  	/* Just update the base values (i.e. touchpad in untouched state) */
>  	if (dev->data[dev->info->datalen - 1] & ATP_STATUS_BASE_UPDATE) {
>  
> -		dprintk(KERN_DEBUG "appletouch: updated base values\n");
> +		dprintk("appletouch: updated base values\n");
>  
>  		memcpy(dev->xy_old, dev->xy_cur, sizeof(dev->xy_old));
>  		goto exit;
> -- 
> 1.7.3.dirty
> 

-- 
Dmitry
