From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 2/2] HID: wacom: rely on actual touch down count to decide
 touch_down
Date: Wed, 04 Mar 2015 16:28:00 -0800
Message-ID: <54F7A310.8030300@gmail.com>
References: <1424471250-4708-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33351 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbbCEA2F (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 19:28:05 -0500
Received: by pdev10 with SMTP id v10so15133669pde.0
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2015 16:28:04 -0800 (PST)
In-Reply-To: <1424471250-4708-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On 2/20/2015 2:27 PM, Ping Cheng wrote:
> touch_down is a flag to indicate if there are touches on tablet
> or not. Since one set of touch events may be posted over more
> than one data packet/touch frame, and pen may come in proximity
> while touch events are partially sent, counting all touch events
> for the set reflects the actual status of touch_down.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>

Its a little ugly, but does the job. It seems like you could update=20
touch_down once at the end of wacom_wac_irq by inspecting the slots, bu=
t=20
I need to toy around with adapting wacom_wac_finger_count_touches some=20
more...

Acked-by: Jason Gerecke <killertofu@gmail.com>

--=20
Jason
---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....

> ---
>   drivers/hid/wacom_wac.c | 75 ++++++++++++++++++++++++++++----------=
-----------
>   1 file changed, 43 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 69827c9..cf76741 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1046,27 +1046,28 @@ static int wacom_24hdt_irq(struct wacom_wac *=
wacom)
>   	struct input_dev *input =3D wacom->input;
>   	unsigned char *data =3D wacom->data;
>   	int i;
> -	int current_num_contacts =3D 0;
> +	int current_num_contacts =3D data[61];
>   	int contacts_to_send =3D 0;
>   	int num_contacts_left =3D 4; /* maximum contacts per packet */
>   	int byte_per_packet =3D WACOM_BYTES_PER_24HDT_PACKET;
>   	int y_offset =3D 2;
> +	static int contact_with_no_pen_down_count =3D 0;
>
>   	if (wacom->features.type =3D=3D WACOM_27QHDT) {
>   		current_num_contacts =3D data[63];
>   		num_contacts_left =3D 10;
>   		byte_per_packet =3D WACOM_BYTES_PER_QHDTHID_PACKET;
>   		y_offset =3D 0;
> -	} else {
> -		current_num_contacts =3D data[61];
>   	}
>
>   	/*
>   	 * First packet resets the counter since only the first
>   	 * packet in series will have non-zero current_num_contacts.
>   	 */
> -	if (current_num_contacts)
> +	if (current_num_contacts) {
>   		wacom->num_contacts_left =3D current_num_contacts;
> +		contact_with_no_pen_down_count =3D 0;
> +	}
>
>   	contacts_to_send =3D min(num_contacts_left, wacom->num_contacts_le=
ft);
>
> @@ -1099,15 +1100,16 @@ static int wacom_24hdt_irq(struct wacom_wac *=
wacom)
>   				input_report_abs(input, ABS_MT_WIDTH_MINOR, min(w, h));
>   				input_report_abs(input, ABS_MT_ORIENTATION, w > h);
>   			}
> +			contact_with_no_pen_down_count++;
>   		}
>   	}
>   	input_mt_report_pointer_emulation(input, true);
>
>   	wacom->num_contacts_left -=3D contacts_to_send;
> -	if (wacom->num_contacts_left <=3D 0)
> +	if (wacom->num_contacts_left <=3D 0) {
>   		wacom->num_contacts_left =3D 0;
> -
> -	wacom->shared->touch_down =3D (wacom->num_contacts_left > 0);
> +		wacom->shared->touch_down =3D (contact_with_no_pen_down_count > 0)=
;
> +	}
>   	return 1;
>   }
>
> @@ -1119,6 +1121,7 @@ static int wacom_mt_touch(struct wacom_wac *wac=
om)
>   	int current_num_contacts =3D data[2];
>   	int contacts_to_send =3D 0;
>   	int x_offset =3D 0;
> +	static int contact_with_no_pen_down_count =3D 0;
>
>   	/* MTTPC does not support Height and Width */
>   	if (wacom->features.type =3D=3D MTTPC || wacom->features.type =3D=3D=
 MTTPC_B)
> @@ -1128,8 +1131,10 @@ static int wacom_mt_touch(struct wacom_wac *wa=
com)
>   	 * First packet resets the counter since only the first
>   	 * packet in series will have non-zero current_num_contacts.
>   	 */
> -	if (current_num_contacts)
> +	if (current_num_contacts) {
>   		wacom->num_contacts_left =3D current_num_contacts;
> +		contact_with_no_pen_down_count =3D 0;
> +	}
>
>   	/* There are at most 5 contacts per packet */
>   	contacts_to_send =3D min(5, wacom->num_contacts_left);
> @@ -1150,15 +1155,16 @@ static int wacom_mt_touch(struct wacom_wac *w=
acom)
>   			int y =3D get_unaligned_le16(&data[offset + x_offset + 9]);
>   			input_report_abs(input, ABS_MT_POSITION_X, x);
>   			input_report_abs(input, ABS_MT_POSITION_Y, y);
> +			contact_with_no_pen_down_count++;
>   		}
>   	}
>   	input_mt_report_pointer_emulation(input, true);
>
>   	wacom->num_contacts_left -=3D contacts_to_send;
> -	if (wacom->num_contacts_left < 0)
> +	if (wacom->num_contacts_left <=3D 0) {
>   		wacom->num_contacts_left =3D 0;
> -
> -	wacom->shared->touch_down =3D (wacom->num_contacts_left > 0);
> +		wacom->shared->touch_down =3D (contact_with_no_pen_down_count > 0)=
;
> +	}
>   	return 1;
>   }
>
> @@ -1196,29 +1202,25 @@ static int wacom_tpc_single_touch(struct waco=
m_wac *wacom, size_t len)
>   {
>   	unsigned char *data =3D wacom->data;
>   	struct input_dev *input =3D wacom->input;
> -	bool prox;
> +	bool prox =3D !wacom->shared->stylus_in_proximity;
>   	int x =3D 0, y =3D 0;
>
>   	if (wacom->features.touch_max > 1 || len > WACOM_PKGLEN_TPC2FG)
>   		return 0;
>
> -	if (!wacom->shared->stylus_in_proximity) {
> -		if (len =3D=3D WACOM_PKGLEN_TPC1FG) {
> -			prox =3D data[0] & 0x01;
> -			x =3D get_unaligned_le16(&data[1]);
> -			y =3D get_unaligned_le16(&data[3]);
> -		} else if (len =3D=3D WACOM_PKGLEN_TPC1FG_B) {
> -			prox =3D data[2] & 0x01;
> -			x =3D get_unaligned_le16(&data[3]);
> -			y =3D get_unaligned_le16(&data[5]);
> -		} else {
> -			prox =3D data[1] & 0x01;
> -			x =3D le16_to_cpup((__le16 *)&data[2]);
> -			y =3D le16_to_cpup((__le16 *)&data[4]);
> -		}
> -	} else
> -		/* force touch out when pen is in prox */
> -		prox =3D 0;
> +	if (len =3D=3D WACOM_PKGLEN_TPC1FG) {
> +		prox =3D prox && (data[0] & 0x01);
> +		x =3D get_unaligned_le16(&data[1]);
> +		y =3D get_unaligned_le16(&data[3]);
> +	} else if (len =3D=3D WACOM_PKGLEN_TPC1FG_B) {
> +		prox =3D prox && (data[2] & 0x01);
> +		x =3D get_unaligned_le16(&data[3]);
> +		y =3D get_unaligned_le16(&data[5]);
> +	} else {
> +		prox =3D prox && (data[1] & 0x01);
> +		x =3D le16_to_cpup((__le16 *)&data[2]);
> +		y =3D le16_to_cpup((__le16 *)&data[4]);
> +	}
>
>   	if (prox) {
>   		input_report_abs(input, ABS_X, x);
> @@ -1616,6 +1618,7 @@ static int wacom_bpt_touch(struct wacom_wac *wa=
com)
>   	struct input_dev *pad_input =3D wacom->pad_input;
>   	unsigned char *data =3D wacom->data;
>   	int i;
> +	int contact_with_no_pen_down_count =3D 0;
>
>   	if (data[0] !=3D 0x02)
>   	    return 0;
> @@ -1643,6 +1646,7 @@ static int wacom_bpt_touch(struct wacom_wac *wa=
com)
>   			}
>   			input_report_abs(input, ABS_MT_POSITION_X, x);
>   			input_report_abs(input, ABS_MT_POSITION_Y, y);
> +			contact_with_no_pen_down_count++;
>   		}
>   	}
>
> @@ -1652,11 +1656,12 @@ static int wacom_bpt_touch(struct wacom_wac *=
wacom)
>   	input_report_key(pad_input, BTN_FORWARD, (data[1] & 0x04) !=3D 0);
>   	input_report_key(pad_input, BTN_BACK, (data[1] & 0x02) !=3D 0);
>   	input_report_key(pad_input, BTN_RIGHT, (data[1] & 0x01) !=3D 0);
> +	wacom->shared->touch_down =3D (contact_with_no_pen_down_count > 0);
>
>   	return 1;
>   }
>
> -static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned c=
har *data)
> +static int wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned ch=
ar *data, int last_touch_count)
>   {
>   	struct wacom_features *features =3D &wacom->features;
>   	struct input_dev *input =3D wacom->input;
> @@ -1664,7 +1669,7 @@ static void wacom_bpt3_touch_msg(struct wacom_w=
ac *wacom, unsigned char *data)
>   	int slot =3D input_mt_get_slot_by_key(input, data[0]);
>
>   	if (slot < 0)
> -		return;
> +		return 0;
>
>   	touch =3D touch && !wacom->shared->stylus_in_proximity;
>
> @@ -1696,7 +1701,9 @@ static void wacom_bpt3_touch_msg(struct wacom_w=
ac *wacom, unsigned char *data)
>   		input_report_abs(input, ABS_MT_POSITION_Y, y);
>   		input_report_abs(input, ABS_MT_TOUCH_MAJOR, width);
>   		input_report_abs(input, ABS_MT_TOUCH_MINOR, height);
> +		last_touch_count++;
>   	}
> +	return last_touch_count;
>   }
>
>   static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned=
 char *data)
> @@ -1721,6 +1728,7 @@ static int wacom_bpt3_touch(struct wacom_wac *w=
acom)
>   	unsigned char *data =3D wacom->data;
>   	int count =3D data[1] & 0x07;
>   	int i;
> +	int contact_with_no_pen_down_count =3D 0;
>
>   	if (data[0] !=3D 0x02)
>   	    return 0;
> @@ -1731,12 +1739,15 @@ static int wacom_bpt3_touch(struct wacom_wac =
*wacom)
>   		int msg_id =3D data[offset];
>
>   		if (msg_id >=3D 2 && msg_id <=3D 17)
> -			wacom_bpt3_touch_msg(wacom, data + offset);
> +			contact_with_no_pen_down_count =3D
> +			    wacom_bpt3_touch_msg(wacom, data + offset,
> +						 contact_with_no_pen_down_count);
>   		else if (msg_id =3D=3D 128)
>   			wacom_bpt3_button_msg(wacom, data + offset);
>
>   	}
>   	input_mt_report_pointer_emulation(input, true);
> +	wacom->shared->touch_down =3D (contact_with_no_pen_down_count > 0);
>
>   	return 1;
>   }
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
