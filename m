From: Andres Salomon <dilinger@queued.net>
Subject: Re: [PATCH 2/2] Recover from failed recalibration for OLPC touchpad
Date: Tue, 16 Dec 2008 14:53:32 -0500
Message-ID: <20081216145332.614b847a@ephemeral>
References: <20081216194509.GB15380@trantor.hsd1.or.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.queued.net ([207.210.101.209]:3288 "EHLO mail.queued.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbYLPTxh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2008 14:53:37 -0500
In-Reply-To: <20081216194509.GB15380@trantor.hsd1.or.comcast.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dsaxena@laptop.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, pgf@laptop.org

On Tue, 16 Dec 2008 11:45:09 -0800
Deepak Saxena <dsaxena@laptop.org> wrote:

> Sometimes the the HPGK touchpad will fail to properly respond
> to a ps2_command() during recalibration. This patch works around
> that issue be scheduling another recalibration if this happens.
> 
> This solves http://dev.laptop.org/ticket/9008
> 

The bug lacks details regarding testing, see below.


> Signed-off-by: Paul Fox <pgf@laptop.org>
> Signed-off-by: Deepak Saxena <dsaxena@laptop.org>
> ---
>  drivers/input/mouse/hgpk.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
> index 39cce65..9548e1c 100644
> --- a/drivers/input/mouse/hgpk.c
> +++ b/drivers/input/mouse/hgpk.c
> @@ -233,6 +233,9 @@ static int hgpk_force_recalibrate(struct psmouse
> *psmouse) ps2_command(ps2dev, NULL, 0xf5) ||
>  	    ps2_command(ps2dev, NULL, 0xe6) ||
>  	    ps2_command(ps2dev, NULL, 0xf5)) {
> + 		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
> + 		psmouse_queue_work(psmouse, &priv->recalib_wq,
> +				   msecs_to_jiffies(500));
>  		return -1;
>  	}
>  

Do we know why the ps2 commands are failing?  Do we really want to keep
trying to recalibrate if something's screwy with ps2, rather than (say)
completely reinitializing the driver?

Paul, did you manage to reproduce the problem with this patch applied?


> @@ -245,8 +248,12 @@ static int hgpk_force_recalibrate(struct psmouse
> *psmouse)
>  	 * (below) is our best option for now.
>  	 */
>  
> -	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE))
> +	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE)) {
> +		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
> +		psmouse_queue_work(psmouse, &priv->recalib_wq,
> +				   msecs_to_jiffies(500));
>  		return -1;
> +	}
>  
>  	psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
>  
