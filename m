From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: psmouse - when comparing PNP IDs ignore case
Date: Sat, 28 Feb 2015 11:15:19 +0100
Message-ID: <54F19537.3050401@redhat.com>
References: <20150228001852.GA18983@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36067 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751029AbbB1KPY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2015 05:15:24 -0500
In-Reply-To: <20150228001852.GA18983@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org

Hi,

On 28-02-15 01:18, Dmitry Torokhov wrote:
> PNP IDs are supposed to be case-insensitive and so we should compare
> them as such.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Looks good:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   drivers/input/mouse/psmouse-base.c | 39 +++++++++++++++++++++++++++++++-------
>   1 file changed, 32 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index 4ccd01d..a175496 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -463,19 +463,44 @@ static int psmouse_poll(struct psmouse *psmouse)
>   			   PSMOUSE_CMD_POLL | (psmouse->pktsize << 8));
>   }
>
> +static bool psmouse_check_pnp_id(const char *id, const char * const ids[])
> +{
> +	int i;
> +
> +	for (i = 0; ids[i]; i++)
> +		if (!strcasecmp(id, ids[i]))
> +			return true;
> +
> +	return false;
> +}
> +
>   /*
>    * psmouse_matches_pnp_id - check if psmouse matches one of the passed in ids.
>    */
>   bool psmouse_matches_pnp_id(struct psmouse *psmouse, const char * const ids[])
>   {
> -	int i;
> -
> -	if (!strncmp(psmouse->ps2dev.serio->firmware_id, "PNP:", 4))
> -		for (i = 0; ids[i]; i++)
> -			if (strstr(psmouse->ps2dev.serio->firmware_id, ids[i]))
> -				return true;
> +	struct serio *serio = psmouse->ps2dev.serio;
> +	char *p, *fw_id_copy, *save_ptr;
> +	bool found = false;
> +
> +	if (!strncmp(serio->firmware_id, "PNP:", 4))
> +		return false;
> +
> +	fw_id_copy = kstrndup(&serio->firmware_id[4],
> +			      sizeof(serio->firmware_id) - 4,
> +			      GFP_KERNEL);
> +	if (!fw_id_copy)
> +		return false;
> +
> +	save_ptr = fw_id_copy;
> +	while ((p = strsep(&fw_id_copy, " ")) != NULL) {
> +		if (psmouse_check_pnp_id(p, ids))
> +			found = true;
> +			break;
> +	}
>
> -	return false;
> +	kfree(save_ptr);
> +	return found;
>   }
>
>   /*
>
