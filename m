From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 2/2] Support-Alps-Touchpad-SS4-device
Date: Fri, 27 Mar 2015 09:25:09 +0100
Message-ID: <551513E5.10101@redhat.com>
References: <1427488186-10046-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34449 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753113AbbC0IZL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Mar 2015 04:25:11 -0400
In-Reply-To: <1427488186-10046-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, masaki.ota@jp.alps.com

Hi,

On 27-03-15 21:29, Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> -Support SS4 device
> -SS4 device supports 4Finger and real multi-touch.
>
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>

Thanks looks good now:

Acked-by: Hans de Goede <hdegoede@redhat.com>

One remark though, you enable: BTN_TOOL_QUINTTAP for v7 touchpads
in the alps_set_abs_params_v7_v8 changes. This is the right thing
to do as v7 can indeed report 5 fingers being down, something which I
missed when I added support for it. But it would be good to have
a small note about this in the commit message.

Dmitry, can you amend the commit message for this when merging this?

Regards,

Hans


> ---
>   drivers/input/mouse/alps.c | 322 ++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/input/mouse/alps.h |  76 ++++++++++-
>   2 files changed, 391 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index e36d4da..f0a661c 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -153,11 +153,15 @@ static const struct alps_protocol_info alps_v7_protocol_data = {
>   	ALPS_PROTO_V7, 0x48, 0x48, ALPS_DUALPOINT
>   };
>
> +static const struct alps_protocol_info alps_v8_protocol_data = {
> +	ALPS_PROTO_V8, 0x18, 0x18, 0
> +};
> +
>   static void alps_set_abs_params_st(struct alps_data *priv,
>   				   struct input_dev *dev1);
>   static void alps_set_abs_params_mt(struct alps_data *priv,
>   				   struct input_dev *dev1);
> -static void alps_set_abs_params_v7(struct alps_data *priv,
> +static void alps_set_abs_params_v7_v8(struct alps_data *priv,
>   					struct input_dev *dev1);
>
>   /* Packet formats are described in Documentation/input/alps.txt */
> @@ -1087,6 +1091,178 @@ static void alps_process_packet_v7(struct psmouse *psmouse)
>   		alps_process_touchpad_packet_v7(psmouse);
>   }
>
> +unsigned char alps_get_pkt_id_ss4_v2(char *byte)
> +{
> +	unsigned char pkt_id = SS4_PACKET_ID_IDLE;
> +
> +	if (((byte[0] & 0xFF) == 0x18) && ((byte[1] & 0xFF) == 0x10) &&
> +	     ((byte[2] & 0xFF) == 0x00) && ((byte[3] & 0x88) == 0x08) &&
> +	     ((byte[4] & 0xFF) == 0x10) && ((byte[5] & 0xFF) == 0x00)) {
> +		pkt_id = SS4_PACKET_ID_IDLE;
> +	} else if (!(byte[3] & 0x10)) {
> +		pkt_id = SS4_PACKET_ID_ONE;
> +	} else {
> +		if (!(byte[3] & 0x20))
> +			pkt_id = SS4_PACKET_ID_TWO;
> +		else
> +			pkt_id = SS4_PACKET_ID_MULTI;
> +	}
> +
> +	return pkt_id;
> +}
> +
> +static int alps_decode_ss4_v2(struct alps_fields *f,
> +			unsigned char *p, struct psmouse *psmouse)
> +{
> +	struct alps_data *priv = psmouse->private;
> +	unsigned char pkt_id;
> +	unsigned int no_data_x, no_data_y;
> +
> +	pkt_id = alps_get_pkt_id_ss4_v2(p);
> +
> +	/* Current packet is 1Finger coordinate packet */
> +	switch (pkt_id) {
> +	case SS4_PACKET_ID_ONE:
> +		f->mt[0].x = SS4_1F_X_V2(p);
> +		f->mt[0].y = SS4_1F_Y_V2(p);
> +		f->pressure = ((SS4_1F_Z_V2(p)) * 2) & 0x7f;
> +		f->fingers = 1;
> +		f->first_mp = 0;
> +		f->is_mp = 0;
> +		break;
> +
> +	case SS4_PACKET_ID_TWO:
> +		if (priv->flags & ALPS_BUTTONPAD) {
> +			f->mt[0].x = SS4_BTL_MF_X_V2(p, 0);
> +			f->mt[0].y = SS4_BTL_MF_Y_V2(p, 0);
> +			f->mt[1].x = SS4_BTL_MF_X_V2(p, 1);
> +			f->mt[1].y = SS4_BTL_MF_Y_V2(p, 1);
> +		} else {
> +			f->mt[0].x = SS4_STD_MF_X_V2(p, 0);
> +			f->mt[0].y = SS4_STD_MF_Y_V2(p, 0);
> +			f->mt[1].x = SS4_STD_MF_X_V2(p, 1);
> +			f->mt[1].y = SS4_STD_MF_Y_V2(p, 1);
> +		}
> +		f->pressure = SS4_MF_Z_V2(p, 0) ? 0x30 : 0;
> +
> +		if (SS4_IS_MF_CONTINUE(p)) {
> +			f->first_mp = 1;
> +		} else {
> +			f->fingers = 2;
> +			f->first_mp = 0;
> +		}
> +		f->is_mp = 0;
> +
> +		break;
> +
> +	case SS4_PACKET_ID_MULTI:
> +		if (priv->flags & ALPS_BUTTONPAD) {
> +			f->mt[2].x = SS4_BTL_MF_X_V2(p, 0);
> +			f->mt[2].y = SS4_BTL_MF_Y_V2(p, 0);
> +			f->mt[3].x = SS4_BTL_MF_X_V2(p, 1);
> +			f->mt[3].y = SS4_BTL_MF_Y_V2(p, 1);
> +			no_data_x = SS4_MFPACKET_NO_AX_BL;
> +			no_data_y = SS4_MFPACKET_NO_AY_BL;
> +		} else {
> +			f->mt[2].x = SS4_STD_MF_X_V2(p, 0);
> +			f->mt[2].y = SS4_STD_MF_Y_V2(p, 0);
> +			f->mt[3].x = SS4_STD_MF_X_V2(p, 1);
> +			f->mt[3].y = SS4_STD_MF_Y_V2(p, 1);
> +			no_data_x = SS4_MFPACKET_NO_AX;
> +			no_data_y = SS4_MFPACKET_NO_AY;
> +		}
> +
> +		f->first_mp = 0;
> +		f->is_mp = 1;
> +
> +		if (SS4_IS_5F_DETECTED(p)) {
> +			f->fingers = 5;
> +		} else if (f->mt[3].x == no_data_x &&
> +			     f->mt[3].y == no_data_y) {
> +			f->mt[3].x = 0;
> +			f->mt[3].y = 0;
> +			f->fingers = 3;
> +		} else {
> +			f->fingers = 4;
> +		}
> +		break;
> +
> +	case SS4_PACKET_ID_IDLE:
> +	default:
> +		memset(f, 0, sizeof(struct alps_fields));
> +		break;
> +	}
> +
> +	f->left = !!(SS4_BTN_V2(p) & 0x01);
> +	if (!(priv->flags & ALPS_BUTTONPAD)) {
> +		f->right = !!(SS4_BTN_V2(p) & 0x02);
> +		f->middle = !!(SS4_BTN_V2(p) & 0x04);
> +	}
> +
> +	return 0;
> +}
> +
> +static void alps_process_packet_ss4_v2(struct psmouse *psmouse)
> +{
> +	struct alps_data *priv = psmouse->private;
> +	unsigned char *packet = psmouse->packet;
> +	struct input_dev *dev = psmouse->dev;
> +	struct alps_fields *f = &priv->f;
> +
> +	memset(f, 0, sizeof(struct alps_fields));
> +	priv->decode_fields(f, packet, psmouse);
> +	if (priv->multi_packet) {
> +		/*
> +		 * Sometimes the first packet will indicate a multi-packet
> +		 * sequence, but sometimes the next multi-packet would not come.
> +		 * Check for this, and when it happens process the
> +		 * position packet as usual.
> +		 */
> +		if (f->is_mp) {
> +			/* Now process the 1st packet */
> +			priv->decode_fields(f, priv->multi_data, psmouse);
> +		} else {
> +			priv->multi_packet = 0;
> +		}
> +	}
> +
> +	/*
> +	 * "f.is_mp" would always be '0' after merging the 1st and 2nd packet.
> +	 * When it is set, it means 2nd packet comes without 1st packet come.
> +	 */
> +	if (f->is_mp)
> +		return;
> +
> +	/* Save the first packet */
> +	if (!priv->multi_packet && f->first_mp) {
> +		priv->multi_packet = 1;
> +		memcpy(priv->multi_data, packet, sizeof(priv->multi_data));
> +		return;
> +	}
> +
> +	priv->multi_packet = 0;
> +
> +	alps_report_mt_data(psmouse, (f->fingers <= 4) ? f->fingers : 4);
> +
> +	input_mt_report_finger_count(dev, f->fingers);
> +
> +	input_report_key(dev, BTN_LEFT, f->left);
> +	input_report_key(dev, BTN_RIGHT, f->right);
> +	input_report_key(dev, BTN_MIDDLE, f->middle);
> +
> +	input_report_abs(dev, ABS_PRESSURE, f->pressure);
> +	input_sync(dev);
> +}
> +
> +static bool alps_is_valid_package_ss4_v2(struct psmouse *psmouse)
> +{
> +	if (psmouse->pktcnt == 4 && ((psmouse->packet[3] & 0x08) != 0x08))
> +		return false;
> +	if (psmouse->pktcnt == 6 && ((psmouse->packet[5] & 0x10) != 0x0))
> +		return false;
> +	return true;
> +}
> +
>   static DEFINE_MUTEX(alps_mutex);
>
>   static void alps_register_bare_ps2_mouse(struct work_struct *work)
> @@ -1289,8 +1465,10 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
>   	 * a device connected to the external PS/2 port. Because bare PS/2
>   	 * protocol does not have enough constant bits to self-synchronize
>   	 * properly we only do this if the device is fully synchronized.
> +	 * Can not distinguish V8's first byte from PS/2 packet's
>   	 */
> -	if (!psmouse->out_of_sync_cnt && (psmouse->packet[0] & 0xc8) == 0x08) {
> +	if (!psmouse->out_of_sync_cnt && (psmouse->packet[0] & 0xc8) == 0x08 &&
> +		priv->proto_version != ALPS_PROTO_V8) {
>
>   		/* Register dev3 mouse if we received PS/2 packet first time */
>   		if (unlikely(!priv->dev3))
> @@ -1347,8 +1525,10 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
>   		return PSMOUSE_BAD_DATA;
>   	}
>
> -	if (priv->proto_version == ALPS_PROTO_V7 &&
> -	    !alps_is_valid_package_v7(psmouse)) {
> +	if ((priv->proto_version == ALPS_PROTO_V7 &&
> +		!alps_is_valid_package_v7(psmouse)) ||
> +	    (priv->proto_version == ALPS_PROTO_V8 &&
> +		!alps_is_valid_package_ss4_v2(psmouse))) {
>   		psmouse_dbg(psmouse, "refusing packet[%i] = %x\n",
>   			    psmouse->pktcnt - 1,
>   			    psmouse->packet[psmouse->pktcnt - 1]);
> @@ -2123,6 +2303,88 @@ error:
>   	return -1;
>   }
>
> +static int alps_get_otp_values_ss4_v2(struct psmouse *psmouse,
> +			unsigned char index, unsigned char otp[])
> +{
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> +
> +	switch (index) {
> +	case 0:
> +		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM)  ||
> +		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM)  ||
> +		    ps2_command(ps2dev, otp, PSMOUSE_CMD_GETINFO))
> +			return -1;
> +
> +		break;
> +
> +	case 1:
> +		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL)  ||
> +		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL)  ||
> +		    ps2_command(ps2dev, otp, PSMOUSE_CMD_GETINFO))
> +			return -1;
> +
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +int alps_update_device_area_ss4_v2(unsigned char otp[][4],
> +			struct alps_data *priv)
> +{
> +	int	num_x_electrode;
> +	int	num_y_electrode;
> +	int x_pitch, y_pitch, x_phys, y_phys;
> +
> +	num_x_electrode = SS4_NUMSENSOR_XOFFSET + (otp[1][0]		& 0x0F);
> +	num_y_electrode = SS4_NUMSENSOR_YOFFSET + ((otp[1][0] >> 4) & 0x0F);
> +
> +	priv->x_max = (num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
> +	priv->y_max = (num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
> +
> +	x_pitch = ((otp[1][2] >> 2) & 0x07) + SS4_MIN_PITCH_MM;
> +	y_pitch = ((otp[1][2] >> 5) & 0x07) + SS4_MIN_PITCH_MM;
> +
> +	x_phys = x_pitch * (num_x_electrode - 1); /* In 0.1 mm units */
> +	y_phys = y_pitch * (num_y_electrode - 1); /* In 0.1 mm units */
> +
> +	priv->x_res = priv->x_max * 10 / x_phys; /* units / mm */
> +	priv->y_res = priv->y_max * 10 / y_phys; /* units / mm */
> +
> +	return 0;
> +}
> +
> +int alps_update_btn_info_ss4_v2(unsigned char otp[][4], struct alps_data *priv)
> +{
> +
> +	unsigned char is_btnless = 0;
> +
> +	is_btnless = (otp[1][1] >> 3) &  0x01;
> +
> +	if (is_btnless)
> +		priv->flags |= ALPS_BUTTONPAD;
> +
> +	return 0;
> +}
> +
> +static int alps_set_defaults_ss4_v2(struct psmouse *psmouse,
> +			struct alps_data *priv)
> +{
> +	unsigned char otp[2][4];
> +
> +	memset(otp, 0, sizeof(otp));
> +
> +	if (alps_get_otp_values_ss4_v2(psmouse, 0, &otp[0][0]) ||
> +	    alps_get_otp_values_ss4_v2(psmouse, 1, &otp[1][0]))
> +		return -1;
> +
> +	alps_update_device_area_ss4_v2(otp, priv);
> +
> +	alps_update_btn_info_ss4_v2(otp, priv);
> +
> +	return 0;
> +}
> +
>   static int alps_dolphin_get_device_area(struct psmouse *psmouse,
>   					struct alps_data *priv)
>   {
> @@ -2215,6 +2477,35 @@ error:
>   	return ret;
>   }
>
> +static int alps_hw_init_ss4_v2(struct psmouse *psmouse)
> +{
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> +	char param[2] = {0x64, 0x28};
> +	int ret = -1;
> +
> +	/* enter absolute mode */
> +	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
> +	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
> +	    ps2_command(ps2dev, &param[0], PSMOUSE_CMD_SETRATE) ||
> +	    ps2_command(ps2dev, &param[1], PSMOUSE_CMD_SETRATE)) {
> +		goto error;
> +	}
> +
> +	/* T.B.D. Decread noise packet number, delete in the future */
> +	if (alps_exit_command_mode(psmouse) ||
> +	    alps_enter_command_mode(psmouse) ||
> +	    alps_command_mode_write_reg(psmouse, 0x001D, 0x20)) {
> +		goto error;
> +	}
> +	alps_exit_command_mode(psmouse);
> +
> +	return ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> +
> +error:
> +	alps_exit_command_mode(psmouse);
> +	return ret;
> +}
> +
>   static int alps_set_protocol(struct psmouse *psmouse,
>   			     struct alps_data *priv,
>   			     const struct alps_protocol_info *protocol)
> @@ -2302,7 +2593,7 @@ static int alps_set_protocol(struct psmouse *psmouse,
>   		priv->hw_init = alps_hw_init_v7;
>   		priv->process_packet = alps_process_packet_v7;
>   		priv->decode_fields = alps_decode_packet_v7;
> -		priv->set_abs_params = alps_set_abs_params_v7;
> +		priv->set_abs_params = alps_set_abs_params_v7_v8;
>   		priv->nibble_commands = alps_v3_nibble_commands;
>   		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
>
> @@ -2313,6 +2604,20 @@ static int alps_set_protocol(struct psmouse *psmouse,
>   			priv->flags |= ALPS_BUTTONPAD;
>
>   		break;
> +
> +	case ALPS_PROTO_V8:
> +		priv->hw_init = alps_hw_init_ss4_v2;
> +		priv->process_packet = alps_process_packet_ss4_v2;
> +		priv->decode_fields = alps_decode_ss4_v2;
> +		priv->set_abs_params = alps_set_abs_params_v7_v8;
> +		priv->nibble_commands = alps_v3_nibble_commands;
> +		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
> +		priv->x_max = 0xfff;
> +		priv->y_max = 0x7ff;
> +		if (alps_set_defaults_ss4_v2(psmouse, priv))
> +			return -EIO;
> +
> +		break;
>   	}
>
>   	return 0;
> @@ -2381,6 +2686,9 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
>   		} else if (ec[0] == 0x88 && ec[1] == 0x07 &&
>   			   ec[2] >= 0x90 && ec[2] <= 0x9d) {
>   			protocol = &alps_v3_protocol_data;
> +		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
> +				e7[2] == 0x14 && ec[1] == 0x02) {
> +					protocol = &alps_v8_protocol_data;
>   		} else {
>   			psmouse_dbg(psmouse,
>   				    "Likely not an ALPS touchpad: E7=%3ph, EC=%3ph\n", e7, ec);
> @@ -2453,13 +2761,15 @@ static void alps_set_abs_params_mt(struct alps_data *priv,
>   		INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK | INPUT_MT_SEMI_MT);
>   }
>
> -static void alps_set_abs_params_v7(struct alps_data *priv,
> +static void alps_set_abs_params_v7_v8(struct alps_data *priv,
>   				   struct input_dev *dev1)
>   {
>   	alps_set_abs_params_mt_common(priv, dev1);
>
>   	input_mt_init_slots(dev1, MAX_TOUCHES, INPUT_MT_POINTER |
>   		INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK);
> +
> +	set_bit(BTN_TOOL_QUINTTAP, dev1->keybit);
>   }
>
>   int alps_init(struct psmouse *psmouse)
> diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
> index 02513c0..6f310d1 100644
> --- a/drivers/input/mouse/alps.h
> +++ b/drivers/input/mouse/alps.h
> @@ -22,14 +22,88 @@
>   #define ALPS_PROTO_V5		0x500
>   #define ALPS_PROTO_V6		0x600
>   #define ALPS_PROTO_V7		0x700	/* t3btl t4s */
> +#define ALPS_PROTO_V8		0x800	/* SS4btl SS4s */
>
> -#define MAX_TOUCHES	2
> +#define MAX_TOUCHES	4
>
>   #define DOLPHIN_COUNT_PER_ELECTRODE	64
>   #define DOLPHIN_PROFILE_XOFFSET		8	/* x-electrode offset */
>   #define DOLPHIN_PROFILE_YOFFSET		1	/* y-electrode offset */
>
>   /*
> + * enum SS4_PACKET_ID - defines the packet type for V8
> + * SS4_PACKET_ID_IDLE: There's no finger and no button activity.
> + * SS4_PACKET_ID_ONE: There's one finger on touchpad
> + *  or there's button activities.
> + * SS4_PACKET_ID_TWO: There's two or more fingers on touchpad
> + * SS4_PACKET_ID_MULTI: There's three or more fingers on touchpad
> +*/
> +enum SS4_PACKET_ID {
> +	SS4_PACKET_ID_IDLE = 0,
> +	SS4_PACKET_ID_ONE,
> +	SS4_PACKET_ID_TWO,
> +	SS4_PACKET_ID_MULTI,
> +};
> +
> +#define SS4_COUNT_PER_ELECTRODE			256
> +#define SS4_NUMSENSOR_XOFFSET			7
> +#define SS4_NUMSENSOR_YOFFSET			7
> +#define SS4_MIN_PITCH_MM				50
> +
> +#define SS4_MASK_NORMAL_BUTTONS	0x07
> +
> +#define SS4_1F_X_V2(_b)	((_b[0] & 0x0007) | \
> +		((_b[1] << 3) & 0x0078) | \
> +		((_b[1] << 2) & 0x0380) | \
> +		((_b[2] << 5) & 0x1C00) \
> +		)
> +
> +#define SS4_1F_Y_V2(_b)	(((_b[2]) & 0x000F) | \
> +		((_b[3] >> 2) & 0x0030) | \
> +		((_b[4] << 6) & 0x03C0) | \
> +		((_b[4] << 5) & 0x0C00) \
> +		)
> +
> +#define SS4_1F_Z_V2(_b)	(((_b[5]) & 0x0F) | \
> +		((_b[5] >> 1) & 0x70) | \
> +		((_b[4]) & 0x80) \
> +		)
> +
> +#define	SS4_1F_LFB_V2(_b)	(((_b[2] >> 4) & 0x01) == 0x01)
> +
> +#define	SS4_MF_LF_V2(_b, _i)	((_b[1 + _i * 3] & 0x0004) == 0x0004)
> +
> +#define SS4_BTN_V2(_b)		((_b[0] >> 5) & SS4_MASK_NORMAL_BUTTONS)
> +
> +#define SS4_STD_MF_X_V2(_b, _i)	(((_b[0 + _i * 3]  << 5) & 0x00E0) | \
> +		((_b[1 + _i * 3]  << 5) & 0x1F00) \
> +		)
> +
> +#define SS4_STD_MF_Y_V2(_b, _i)	(((_b[1 + _i * 3] << 3) & 0x0010) | \
> +		((_b[2 + _i * 3] << 5) & 0x01E0) | \
> +		((_b[2 + _i * 3] << 4) & 0x0E00) \
> +		)
> +
> +#define SS4_BTL_MF_X_V2(_b, _i)	(SS4_STD_MF_X_V2(_b, _i) | \
> +		((_b[0 + _i * 3] >> 3) & 0x0010))
> +
> +#define SS4_BTL_MF_Y_V2(_b, _i)	(SS4_STD_MF_Y_V2(_b, _i) | \
> +		((_b[0 + _i * 3] >> 3) & 0x0008))
> +
> +#define SS4_MF_Z_V2(_b, _i)	(((_b[1 + _i * 3]) & 0x0001) | \
> +		((_b[1 + _i * 3] >> 1) & 0x0002) \
> +		)
> +
> +#define SS4_IS_MF_CONTINUE(_b)	((_b[2] & 0x10) == 0x10)
> +#define SS4_IS_5F_DETECTED(_b)	((_b[2] & 0x10) == 0x10)
> +
> +
> +#define SS4_MFPACKET_NO_AX		8160	/* X-Coordinate value */
> +#define SS4_MFPACKET_NO_AY		4080	/* Y-Coordinate value */
> +#define SS4_MFPACKET_NO_AX_BL	8176	/* Buttonless X-Coordinate value */
> +#define SS4_MFPACKET_NO_AY_BL	4088	/* Buttonless Y-Coordinate value */
> +
> +/*
>    * enum V7_PACKET_ID - defines the packet type for V7
>    * V7_PACKET_ID_IDLE: There's no finger and no button activity.
>    * V7_PACKET_ID_TWO: There's one or two non-resting fingers on touchpad
>
