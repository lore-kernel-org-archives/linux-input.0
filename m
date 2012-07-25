From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: sentelic - filtering out erratic movement
Date: Wed, 25 Jul 2012 00:08:37 -0700
Message-ID: <20120725070837.GA15997@core.coreip.homeip.net>
References: <1341553769-30324-1-git-send-email-avatar@sentelic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60750 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418Ab2GYHIm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 03:08:42 -0400
Received: by pbbrp8 with SMTP id rp8so954996pbb.19
        for <linux-input@vger.kernel.org>; Wed, 25 Jul 2012 00:08:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1341553769-30324-1-git-send-email-avatar@sentelic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tai-hwa Liang <avatar@sentelic.com>
Cc: linux-input@vger.kernel.org

Hi Tai-hwa,

On Fri, Jul 06, 2012 at 01:49:29PM +0800, Tai-hwa Liang wrote:
> It turns out that certain hardware sometime generates unexpected movement
> during normal operation. This patch tries to filter out these erratic
> movements which will cause unexpected cursor jumping to the top-left corner.
> 
> This patch also tries to fix jumpy(back and forth) scrolling in X11 by
> accumulating both fingers' coordinates before reporting to the input-mt layer.
> 
> Bugzilla:	https://bugzilla.kernel.org/show_bug.cgi?id=43197
> Reported-and-tested-by:	Aleksey Spiridonov <leks13@leks13.ru>
> Tested-by:	Eddie Dunn <eddie.dunn@gmail.com>
> Tested-by:	Olivier Goffart <olivier@woboq.com>
> ---
>  drivers/input/mouse/sentelic.c |  114 ++++++++++++++++++++++++++--------------
>  drivers/input/mouse/sentelic.h |   35 ++++++++++++
>  2 files changed, 110 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
> index 3f5649f..995b395 100644
> --- a/drivers/input/mouse/sentelic.c
> +++ b/drivers/input/mouse/sentelic.c
> @@ -707,7 +707,7 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>  	struct fsp_data *ad = psmouse->private;
>  	unsigned char *packet = psmouse->packet;
>  	unsigned char button_status = 0, lscroll = 0, rscroll = 0;
> -	unsigned short abs_x, abs_y, fgrs = 0;
> +	unsigned short abs_x, abs_y, fgrs;
>  	int rel_x, rel_y;
>  
>  	if (psmouse->pktcnt < 4)
> @@ -721,64 +721,100 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>  
>  	switch (psmouse->packet[0] >> FSP_PKT_TYPE_SHIFT) {
>  	case FSP_PKT_TYPE_ABS:
> +		if ((packet[0] == 0x48 || packet[0] == 0x49) &&
> +		    packet[1] == 0 && packet[2] == 0) {
> +			/*
> +			 * filtering out erratic movement which will cause
> +			 * unexpected cursor jumping to the top-left corner
> +			 */
> +			packet[3] &= 0xf0;
> +		}

I am not sure if I understand this patch. According to the documentation
the above values for the packet[0] have the 'valid' bit 0 which means
that the touch data should be completely ignored instead of massaging
data like you seem to be doing.

Overall I wonder if you want to increase the size of the buffer to hold
both packets (for both fingers) and analyze both of them together...

It also appears that the patch does too many things at one and should be
split into several addressing individual issues.

Thanks.

-- 
Dmitry
