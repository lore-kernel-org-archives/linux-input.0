From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] Input: sentelic - filter on-pad clicks in absolute mode
Date: Mon, 02 Apr 2012 07:22:24 -0700
Message-ID: <4F79B620.7030800@canonical.com>
References: <20120401183037.GA23849@timantti.taisia.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41751 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755Ab2DBOVt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 10:21:49 -0400
In-Reply-To: <20120401183037.GA23849@timantti.taisia.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oskari Saarenmaa <os@ohmu.fi>
Cc: Tai-hwa Liang <avatar@sentelic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 04/01/2012 11:30 AM, Oskari Saarenmaa wrote:
> On-pad clicks in absolute positioning single-finger mode are reported
> without the PHY_BTN bit set, the on-pad clicks are handled by userspace
> so the kernel shouldn't report them as real clicks.

What is the definition of an "on-pad" click?

> Signed-off-by: Oskari Saarenmaa <os@ohmu.fi>
> ---
>  Applies to v3.4-rc1
> 
>  drivers/input/mouse/sentelic.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
> index a977bfa..d4df8cd 100644
> --- a/drivers/input/mouse/sentelic.c
> +++ b/drivers/input/mouse/sentelic.c
> @@ -741,6 +741,14 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
>  			}
>  		} else {
>  			/* SFAC packet */
> +			if ((packet[0] & FSP_PB0_LBTN|FSP_PB0_PHY_BTN) ==
> +				FSP_PB0_LBTN) {
> +				/* On-pad click in SFAC mode should be handled
> +				 * by userspace.  On-pad clicks in MFMC mode
> +				 * are real clickpad clicks, and not ignored.
> +				 */
> +				packet[0] &= ~FSP_PB0_LBTN;
> +			}
>  
>  			/* no multi-finger information */
>  			ad->last_mt_fgr = 0;

