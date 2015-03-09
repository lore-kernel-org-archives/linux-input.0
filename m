From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 2/6] Input: synaptics - Log queried and quirked
 dimension values
Date: Sun, 8 Mar 2015 23:43:12 -0700
Message-ID: <20150309064312.GB17331@dtor-ws>
References: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
 <1423237499-2930-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:41722 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbbCIGnR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 02:43:17 -0400
Content-Disposition: inline
In-Reply-To: <1423237499-2930-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Daniel Martin <consume.noise@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 06, 2015 at 10:44:55AM -0500, Benjamin Tissoires wrote:
> From: Daniel Martin <consume.noise@gmail.com>
> 
> Logging the dimension values we queried (info) and the values we use
> from a quirk to overwrite (warn) can be helpful for debugging.

Warnings should be sed when something goes wrong, not during normal
operations. Switched all to info and merged split strings.

Thanks.

> 
> This partly relates to bug:
>     https://bugzilla.kernel.org/show_bug.cgi?id=91541
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> ---
>  drivers/input/mouse/synaptics.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 8c2b343..0485e6b 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -365,6 +365,10 @@ static int synaptics_resolution(struct psmouse *psmouse)
>  		} else {
>  			priv->x_max = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
>  			priv->y_max = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
> +			psmouse_info(psmouse,
> +				     "queried max coordinates: "
> +				     "x [..%d], y [..%d]\n",
> +				     priv->x_max, priv->y_max);
>  		}
>  	}
>  
> @@ -376,6 +380,10 @@ static int synaptics_resolution(struct psmouse *psmouse)
>  		} else {
>  			priv->x_min = (resp[0] << 5) | ((resp[1] & 0x0f) << 1);
>  			priv->y_min = (resp[2] << 5) | ((resp[1] & 0xf0) >> 3);
> +			psmouse_info(psmouse,
> +				     "queried min coordinates: "
> +				     "x [%d..], y [%d..]\n",
> +				     priv->x_min, priv->y_min);
>  		}
>  	}
>  
> @@ -398,6 +406,11 @@ static int synaptics_quirks(struct psmouse *psmouse)
>  			priv->x_max = min_max_pnpid_table[i].x_max;
>  			priv->y_min = min_max_pnpid_table[i].y_min;
>  			priv->y_max = min_max_pnpid_table[i].y_max;
> +			psmouse_warn(psmouse,
> +				     "quirked min/max coordinates: "
> +				     "x [%d..%d], y [%d..%d]\n",
> +				     priv->x_min, priv->x_max,
> +				     priv->y_min, priv->y_max);
>  			break;
>  		}
>  	}
> -- 
> 2.1.0
> 

-- 
Dmitry
