From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics - handle spurious release of trackstick
 buttons, again
Date: Thu, 17 Mar 2016 17:14:19 -0700
Message-ID: <20160318001419.GD21461@dtor-ws>
References: <1458037097-6444-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35642 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966832AbcCRAOX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Mar 2016 20:14:23 -0400
Content-Disposition: inline
In-Reply-To: <1458037097-6444-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 15, 2016 at 11:18:17AM +0100, Benjamin Tissoires wrote:
> Looks like the fimware 8.2 stall has the extra buttons spurious release
> bug.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=114321
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> ---
>  drivers/input/mouse/synaptics.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 6025eb4..9f3b83f 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -862,8 +862,9 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
>  	if (!SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
>  		return;
>  
> -	/* Bug in FW 8.1, buttons are reported only when ExtBit is 1 */
> -	if (SYN_ID_FULL(priv->identity) == 0x801 &&
> +	/* Bug in FW 8.1 & 8.2, buttons are reported only when ExtBit is 1 */
> +	if (((SYN_ID_FULL(priv->identity) == 0x801) ||
> +	     (SYN_ID_FULL(priv->identity) == 0x802)) &&

but dropped extra parenthesis...

>  	    !((psmouse->packet[0] ^ psmouse->packet[3]) & 0x02))
>  		return;
>  
> -- 
> 2.5.0
> 

-- 
Dmitry
