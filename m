From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH 2/2] HID: wiimote: Parse calibration data of balance boards
Date: Mon, 17 Sep 2012 17:04:56 +0200
Message-ID: <50573C18.1090500@butterbrot.org>
References: <1347877896-23939-1-git-send-email-dh.herrmann@googlemail.com> <1347877896-23939-2-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:36080 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab2IQPMo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 11:12:44 -0400
In-Reply-To: <1347877896-23939-2-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Signed-off-by: Florian Echtler <floe@butterbrot.org>

On 17.09.2012 12:31, David Herrmann wrote:
> From: Florian Echtler <floe@butterbrot.org>
>
> The raw pressure-data that is reported by balance-boards is pretty useless
> unless calibration data is applied. Therefore, we read the full
> calibration data on extension initialization and apply it to every
> reported data.
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> Hi Florian
>
> As this patch was written by you, I actually put you down as "Author" for this
> patch. However, we need a "Signed-off-by: Florian Echtler <floe@butterbrot.org>"
> line from you before we can apply it. So please respond to this mail with this
> line included.
> If you're not familiar with it, you can read it up in your kernel-tree
> documentation under: ./Documentation/SubmittingPatches
>
> Thanks!
> David
>
>   drivers/hid/hid-wiimote-ext.c | 39 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
> index ae022b8..fc98cc9 100644
> --- a/drivers/hid/hid-wiimote-ext.c
> +++ b/drivers/hid/hid-wiimote-ext.c
> @@ -28,6 +28,7 @@ struct wiimote_ext {
>   	bool mp_plugged;
>   	bool motionp;
>   	__u8 ext_type;
> +	__u16 calib[4][3];
>   };
>
>   enum wiiext_type {
> @@ -127,6 +128,7 @@ error:
>   static __u8 ext_read(struct wiimote_ext *ext)
>   {
>   	ssize_t ret;
> +	__u8 buf[24], i, j, offs = 0;
>   	__u8 rmem[2], wmem;
>   	__u8 type = WIIEXT_NONE;
>
> @@ -156,6 +158,26 @@ static __u8 ext_read(struct wiimote_ext *ext)
>   			type = WIIEXT_BALANCE_BOARD;
>   	}
>
> +	/* get balance board calibration data */
> +	if (type == WIIEXT_BALANCE_BOARD) {
> +		ret = wiimote_cmd_read(ext->wdata, 0xa40024, buf, 12);
> +		ret += wiimote_cmd_read(ext->wdata, 0xa40024 + 12,
> +					buf + 12, 12);
> +
> +		if (ret != 24) {
> +			type = WIIEXT_NONE;
> +		} else {
> +			for (i = 0; i < 3; i++) {
> +				for (j = 0; j < 4; j++) {
> +					ext->calib[j][i] = buf[offs];
> +					ext->calib[j][i] <<= 8;
> +					ext->calib[j][i] |= buf[offs + 1];
> +					offs += 2;
> +				}
> +			}
> +		}
> +	}
> +
>   	wiimote_cmd_release(ext->wdata);
>
>   	return type;
> @@ -514,7 +536,8 @@ static void handler_classic(struct wiimote_ext *ext, const __u8 *payload)
>
>   static void handler_balance_board(struct wiimote_ext *ext, const __u8 *payload)
>   {
> -	__s32 val[4];
> +	__s32 val[4], tmp;
> +	unsigned int i;
>
>   	/*   Byte |  8  7  6  5  4  3  2  1  |
>   	 *   -----+--------------------------+
> @@ -553,6 +576,20 @@ static void handler_balance_board(struct wiimote_ext *ext, const __u8 *payload)
>   	val[3] <<= 8;
>   	val[3] |= payload[7];
>
> +	/* apply calibration data */
> +	for (i = 0; i < 4; i++) {
> +		if (val[i] < ext->calib[i][1]) {
> +			tmp = val[i] - ext->calib[i][0];
> +			tmp *= 1700;
> +			tmp /= ext->calib[i][1] - ext->calib[i][0];
> +		} else {
> +			tmp = val[i] - ext->calib[i][1];
> +			tmp *= 1700;
> +			tmp /= ext->calib[i][2] - ext->calib[i][1] + 1700;
> +		}
> +		val[i] = tmp;
> +	}
> +
>   	input_report_abs(ext->input, ABS_HAT0X, val[0]);
>   	input_report_abs(ext->input, ABS_HAT0Y, val[1]);
>   	input_report_abs(ext->input, ABS_HAT1X, val[2]);
>


-- 
SENT FROM MY PDP-11
