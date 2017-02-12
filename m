From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: trackpoint: add new trackpoint firmware ID
Date: Sun, 12 Feb 2017 14:38:59 -0800
Message-ID: <20170212223859.GA15928@dtor-ws>
References: <1486695741-8969-1-git-send-email-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34409 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdBLWjN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 17:39:13 -0500
Content-Disposition: inline
In-Reply-To: <1486695741-8969-1-git-send-email-aaron.ma@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Fri, Feb 10, 2017 at 11:02:21AM +0800, Aaron Ma wrote:
> Synaptics add new TP firmware ID: 0x2 and 0x3, for now both lower 2 bits
> are indicated as TP. Change the constant to bitwise values.

Hmm, I thought IBM/Lenovo owned trackpoint support... Andrew, is it
yours now?

Aaron, what devices have these new trackpoints>?

Thanks.

> 
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/input/mouse/trackpoint.c | 3 ++-
>  drivers/input/mouse/trackpoint.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index 7331084..9ff0f38 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -265,7 +265,8 @@ static int trackpoint_start_protocol(struct psmouse *psmouse, unsigned char *fir
>  	if (ps2_command(&psmouse->ps2dev, param, MAKE_PS2_CMD(0, 2, TP_READ_ID)))
>  		return -1;
>  
> -	if (param[0] != TP_MAGIC_IDENT)
> +	/* add new TP ID. */
> +	if (!(param[0] & TP_MAGIC_IDENT))
>  		return -1;
>  
>  	if (firmware_id)
> diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
> index 5617ed3..8805575 100644
> --- a/drivers/input/mouse/trackpoint.h
> +++ b/drivers/input/mouse/trackpoint.h
> @@ -21,8 +21,9 @@
>  #define TP_COMMAND		0xE2	/* Commands start with this */
>  
>  #define TP_READ_ID		0xE1	/* Sent for device identification */
> -#define TP_MAGIC_IDENT		0x01	/* Sent after a TP_READ_ID followed */
> +#define TP_MAGIC_IDENT		0x03	/* Sent after a TP_READ_ID followed */
>  					/* by the firmware ID */
> +					/* Firmware ID includes 0x1, 0x2, 0x3 */
>  
>  
>  /*
> -- 
> 2.9.3
> 

-- 
Dmitry
