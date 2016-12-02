From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH] Input: elantech - Add a special mode for a specific FW
 The touchapd which sample ver is 0x74 and hw_version is 0x03 have a fw bug
 which will cause crush sometimes, I add some work-around for it and our
 customer ask us to upstream the patch Signed-off-by: KT Liao
 <kt.liao@emc.com.tw>
Date: Fri, 2 Dec 2016 23:05:29 +0100
Message-ID: <20161202220529.jkdzy3trss2syb7x@lantern>
References: <1480658357-18320-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480658357-18320-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

Hi,

Thank you for the patch, see below my feedback on your patch.
Can you provide the contents of fw_verison, capabilities and samples ?

It this fw bug present on multiple laptops ?

 

On Fri, Dec 02, 2016 at 01:59:17PM +0800, KT Liao wrote:
> Date:   Fri,  2 Dec 2016 13:59:17 +0800
> From: KT Liao <kt.liao@emc.com.tw>
> To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
>  dmitry.torokhov@gmail.com
> Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw
> Subject: [PATCH] Input: elantech - Add a special mode for a specific FW The
>  touchapd which sample ver is 0x74 and hw_version is 0x03 have a fw bug
>  which will cause crush sometimes, I add some work-around for it and our
>  customer ask us to upstream the patch Signed-off-by: KT Liao
>  <kt.liao@emc.com.tw>

It seems that the newlines got lost when you used git-send-email. The 
subject should be a oneliner, the remaining part should go to the mail body.

> X-Mailer: git-send-email 2.7.4
> X-Mailing-List: linux-input@vger.kernel.org
> 
> ---
>  drivers/input/mouse/elantech.c | 152 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 131 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index db7d1d6..acfe7f2 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -539,6 +539,30 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
>  	input_sync(dev);
>  }
>  
> +static psmouse_ret_t elantech_report_relative_v3(struct psmouse *psmouse)
> +{
> +	struct input_dev *dev = psmouse->dev;
> +	unsigned char *packet = psmouse->packet;
> +	int rel_x = 0, rel_y = 0;
> +
> +	if (psmouse->pktcnt < psmouse->pktsize)
> +		return PSMOUSE_GOOD_DATA;

This is a duplicate of elantech_process_byte and you skipped the
elantech_packet_dump feature of elantech_process_byte. I think it would be
better to let elantech_process_byte call this elantech_report_relative_v3
just like all the other reportings.
Is it required to also disable the elantech_packet_check_v3 ? 

Can you document the typical packet format for 
elantech_report_relative_v3 ? Something similar to elantech_report_trackpoint ?


> +
> +	input_report_rel(dev, REL_WHEEL, -(signed char)packet[3]);
> +
> +	rel_x = (int) packet[1] - (int) ((packet[0] << 4) & 0x100);
> +	rel_y = (int) ((packet[0] << 3) & 0x100) - (int) packet[2];
> +
> +	input_report_key(dev, BTN_LEFT,    packet[0]       & 1);
> +	input_report_key(dev, BTN_RIGHT,  (packet[0] >> 1) & 1);
> +	input_report_rel(dev, REL_X, rel_x);
> +	input_report_rel(dev, REL_Y, rel_y);
> +
> +	input_sync(dev);
> +
> +	return PSMOUSE_FULL_PACKET;
> +}
> +
>  static void elantech_input_sync_v4(struct psmouse *psmouse)
>  {
>  	struct input_dev *dev = psmouse->dev;
> @@ -696,14 +720,14 @@ static int elantech_packet_check_v1(struct psmouse *psmouse)
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
> +	 * When we encounter packet that matches this exactly, it means the
> +	 * hardware is in debounce status. Just ignore the whole packet.
> +	 */
> +	const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
> +	unsigned char *packet = psmouse->packet;
> +
> +	return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
>  }

Confirmed, the lines of elantech_debounce_check_v2 do not start with tab 
but spaces, but preferably this will be part of a separate commit.

>  
>  static int elantech_packet_check_v2(struct psmouse *psmouse)
> @@ -995,6 +1019,29 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
>  	return rc;
>  }
>  
> +/* it's the work around mode for some touchpad which has FW bug, but dont' support IAP funciton */

This line is too long, split it across multiple lines.

> +static int elantech_set_special_mode(struct psmouse *psmouse)
> +{
> +	unsigned char param[3];
> +	int rc = 0;

Knowing Dmitry, he would prefer to have error as name instead of rc.

> +
> +	param[0] = 0xc8;
> +	param[1] = 0x64;
> +	param[2] = 0x50;
> +
> +	if (elantech_ps2_command(psmouse, &param[0], PSMOUSE_CMD_SETRATE) ||
> +	   elantech_ps2_command(psmouse, &param[1], PSMOUSE_CMD_SETRATE) ||
> +	   elantech_ps2_command(psmouse, &param[2], PSMOUSE_CMD_SETRATE) ||
> +	   elantech_ps2_command(psmouse, param, PSMOUSE_CMD_GETID)) {
> +		rc = -1;
> +	}

Hm, these do look very similar to intellimouse_detect. Is that a coincidence ?

> +
> +	psmouse->set_rate(psmouse, 0x64);
> +	psmouse->set_resolution(psmouse, 200);

Why hardcode set_rate and set_resolution when they are already module
parameters with the defaults exactly the ones selected here.

> +
> +	return rc;
> +}
> +
>  static int elantech_set_range(struct psmouse *psmouse,
>  			      unsigned int *x_min, unsigned int *y_min,
>  			      unsigned int *x_max, unsigned int *y_max,
> @@ -1279,6 +1326,32 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>  	return 0;
>  }
>  
> +static int elantech_set_input_params_special(struct psmouse *psmouse)
> +{
> +	struct input_dev *dev = psmouse->dev;
> +	struct elantech_data *etd = psmouse->private;
> +	unsigned int x_min = 0, y_min = 0, x_max = 0, y_max = 0, width = 0;
> +
> +	if (elantech_set_range(psmouse, &x_min, &y_min, &x_max, &y_max, &width))
> +		return -1;
> +
> +	__set_bit(INPUT_PROP_POINTER, dev->propbit);
> +	__set_bit(EV_KEY, dev->evbit);
> +
> +	__set_bit(BTN_LEFT, dev->keybit);
> +	__set_bit(BTN_RIGHT, dev->keybit);
> +
> +	__set_bit(EV_REL, dev->evbit);
> +	__set_bit(REL_X, dev->relbit);
> +	__set_bit(REL_Y, dev->relbit);
> +	__set_bit(REL_WHEEL, dev->relbit);
> +
> +	etd->y_max = y_max;
> +	etd->width = width;
> +
> +	return 0;
> +}
> +
>  struct elantech_attr_data {
>  	size_t		field_offset;
>  	unsigned char	reg;
> @@ -1483,15 +1556,28 @@ static void elantech_disconnect(struct psmouse *psmouse)
>   */
>  static int elantech_reconnect(struct psmouse *psmouse)
>  {
> +
> +	struct elantech_data *etd = psmouse->private;
> +
>  	psmouse_reset(psmouse);
>  
>  	if (elantech_detect(psmouse, 0))
>  		return -1;
>  
> -	if (elantech_set_absolute_mode(psmouse)) {
> -		psmouse_err(psmouse,
> -			    "failed to put touchpad back into absolute mode.\n");
> -		return -1;
> +	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {

Is this the appropriate way to detect only the devices that have this
special OTP FW ? Any chance that other elantech devices will also be
falsely detected for this special mode ?

> +		/* handle specail FW issue */

Typo .. special instead of specail.

> +		psmouse_info(psmouse, "ELANTECH special OTP FW detected and call special handle\n");
> +		if (elantech_set_special_mode(psmouse)) {
> +			psmouse_err(psmouse,
> +				    "failed to put touchpad back into special mode.\n");
> +			return -1;
> +		}
> +	} else {
> +		if (elantech_set_absolute_mode(psmouse)) {
> +			psmouse_err(psmouse,
> +				    "failed to put touchpad back into absolute mode.\n");
> +			return -1;
> +		}
>  	}
>  
>  	return 0;
> @@ -1687,10 +1773,20 @@ int elantech_init(struct psmouse *psmouse)
>  			     etd->samples[0], etd->samples[1], etd->samples[2]);
>  	}
>  
> -	if (elantech_set_absolute_mode(psmouse)) {
> -		psmouse_err(psmouse,
> -			    "failed to put touchpad into absolute mode.\n");
> -		goto init_fail;
> +	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {

See above in elantech_reconnect for same line.

> +		/* handle specail FW issue */

Typo .. special instead of specail.

> +		psmouse_info(psmouse, "ELANTECH special OTP FW detected and call special handle\n");
> +		if (elantech_set_special_mode(psmouse)) {
> +			psmouse_err(psmouse,
> +				    "failed to put touchpad back into special mode.\n");
> +			return -1;
> +		}
> +	} else {
> +		if (elantech_set_absolute_mode(psmouse)) {
> +			psmouse_err(psmouse,
> +				    "failed to put touchpad back into absolute mode.\n");
> +			return -1;
> +		}
>  	}
>  
>  	if (etd->fw_version == 0x381f17) {
> @@ -1698,9 +1794,17 @@ int elantech_init(struct psmouse *psmouse)
>  		psmouse->set_rate = elantech_set_rate_restore_reg_07;
>  	}
>  
> -	if (elantech_set_input_params(psmouse)) {
> -		psmouse_err(psmouse, "failed to query touchpad range.\n");
> -		goto init_fail;
> +
> +	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
> +		if (elantech_set_input_params_special(psmouse)) {
> +			psmouse_err(psmouse, "failed to query touchpad range for special FW.\n");
> +			goto init_fail;
> +		}
> +	} else {
> +		if (elantech_set_input_params(psmouse)) {
> +			psmouse_err(psmouse, "failed to query touchpad range.\n");
> +			goto init_fail;
> +		}
>  	}
>  
>  	error = sysfs_create_group(&psmouse->ps2dev.serio->dev.kobj,
> @@ -1746,10 +1850,16 @@ int elantech_init(struct psmouse *psmouse)
>  			goto init_fail_tp_reg;
>  	}
>  
> -	psmouse->protocol_handler = elantech_process_byte;
>  	psmouse->disconnect = elantech_disconnect;
>  	psmouse->reconnect = elantech_reconnect;
> -	psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
> +
> +	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
> +		psmouse->protocol_handler = elantech_report_relative_v3;
> +		psmouse->pktsize = 4;
> +	} else {
> +		psmouse->protocol_handler = elantech_process_byte;
> +		psmouse->pktsize = etd->hw_version > 1 ? 6 : 4;
> +	}

Preferably do the split between elantech_report_relative_v3 and elantech_report_absolute_v3 in elantech_process_byte and not here.

>  
>  	return 0;
>   init_fail_tp_reg:
> -- 
> 2.7.4

Thank you,
Kind regards,
Ulrik De Bie
