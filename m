From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] [ADD] 1.support new ic type for version 4.
Date: Tue, 6 Jan 2015 23:21:36 -0800
Message-ID: <20150107072136.GA5256@dtor-ws>
References: <1420531816-4744-1-git-send-email-sam.hung@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:48759 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbbAGHVl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Jan 2015 02:21:41 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so889447igj.4
        for <linux-input@vger.kernel.org>; Tue, 06 Jan 2015 23:21:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1420531816-4744-1-git-send-email-sam.hung@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sam hung <sam.hung@emc.com.tw>
Cc: linux-input@vger.kernel.org, dusonlin@emc.com.tw

Hi Sam,

On Tue, Jan 06, 2015 at 04:10:16PM +0800, Sam hung wrote:
> ---
>  drivers/input/mouse/elantech.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index f2b9780..4891d07 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -700,14 +700,14 @@ static int elantech_packet_check_v1(struct psmouse *psmouse)
>  
>  static int elantech_debounce_check_v2(struct psmouse *psmouse)
>  {
> -        /*
> -         * When we encounter packet that matches this exactly, it means the
> -         * hardware is in debounce status. Just ignore the whole packet.
> -         */
> -        const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
> -        unsigned char *packet = psmouse->packet;
> -
> -        return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
> +	/*
> +	* When we encounter packet that matches this exactly, it means the
> +	* hardware is in debounce status. Just ignore the whole packet.
> +	*/
> +	const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
> +	unsigned char *packet = psmouse->packet;
> +
> +	return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
>  }

Hmm, this chunk seems to be replacing spaces with tabs... I'd rather had
it separate from the hardware version changes.

I'll pick up the chunk below though.

>  
>  static int elantech_packet_check_v2(struct psmouse *psmouse)
> @@ -1499,7 +1499,7 @@ static const struct dmi_system_id no_hw_res_dmi_table[] = {
>  /*
>   * determine hardware version and set some properties according to it.
>   */
> -static int elantech_set_properties(struct elantech_data *etd)
> +static int elantech_set_properties(struct psmouse *psmouse, struct elantech_data *etd)
>  {
>  	/* This represents the version of IC body. */
>  	int ver = (etd->fw_version & 0x0f0000) >> 16;
> @@ -1520,9 +1520,12 @@ static int elantech_set_properties(struct elantech_data *etd)
>  		case 7:
>  		case 8:
>  		case 9:
> +		case 10:
> +		case 13:
>  			etd->hw_version = 4;
>  			break;
>  		default:
> +			psmouse_err(psmouse, "failed to setting hw version.\n");
>  			return -1;
>  		}
>  	}
> @@ -1593,7 +1596,7 @@ int elantech_init(struct psmouse *psmouse)
>  	}
>  	etd->fw_version = (param[0] << 16) | (param[1] << 8) | param[2];
>  
> -	if (elantech_set_properties(etd)) {
> +	if (elantech_set_properties(psmouse, etd)) {
>  		psmouse_err(psmouse, "unknown hardware version, aborting...\n");
>  		goto init_fail;
>  	}
> -- 
> 1.8.3.2
> 

Thanks.

-- 
Dmitry
