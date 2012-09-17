From: Florian Echtler <floe@butterbrot.org>
Subject: Re: [PATCH 1/2] HID: wiimote: Add Nintendo Balance-Board support
Date: Mon, 17 Sep 2012 17:05:30 +0200
Message-ID: <50573C3A.4000209@butterbrot.org>
References: <1347877896-23939-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from butterbrot.org ([176.9.106.16]:36079 "EHLO butterbrot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751837Ab2IQPMn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 11:12:43 -0400
In-Reply-To: <1347877896-23939-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Tested-by: Florian Echtler <floe@butterbrot.org>

On 17.09.2012 12:31, David Herrmann wrote:
> The Nintendo Balance-Board is a controller which behaves exactly like the
> Wii Remote but reports all its data through a special extension device.
> Hence, we can simply add the Balance-Board as extension device and we get
> full support for it.
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> Hi Jiri
>
> This has been tested by Florian Echtler (see CC) and user-space BlueZ patches to
> support Balance-Board connections are already sent upstream.
>
> Maybe Florian can provide a "Tested-by: Florian Echtler <floe@butterbrot.org>"
> line.
>
> Thanks!
> David
>
>   drivers/hid/hid-wiimote-ext.c | 59 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)
>
> diff --git a/drivers/hid/hid-wiimote-ext.c b/drivers/hid/hid-wiimote-ext.c
> index 0a1805c..ae022b8 100644
> --- a/drivers/hid/hid-wiimote-ext.c
> +++ b/drivers/hid/hid-wiimote-ext.c
> @@ -34,6 +34,7 @@ enum wiiext_type {
>   	WIIEXT_NONE,		/* placeholder */
>   	WIIEXT_CLASSIC,		/* Nintendo classic controller */
>   	WIIEXT_NUNCHUCK,	/* Nintendo nunchuck controller */
> +	WIIEXT_BALANCE_BOARD,	/* Nintendo balance board controller */
>   };
>
>   enum wiiext_keys {
> @@ -151,6 +152,8 @@ static __u8 ext_read(struct wiimote_ext *ext)
>   			type = WIIEXT_NUNCHUCK;
>   		else if (rmem[0] == 0x01 && rmem[1] == 0x01)
>   			type = WIIEXT_CLASSIC;
> +		else if (rmem[0] == 0x04 && rmem[1] == 0x02)
> +			type = WIIEXT_BALANCE_BOARD;
>   	}
>
>   	wiimote_cmd_release(ext->wdata);
> @@ -509,6 +512,55 @@ static void handler_classic(struct wiimote_ext *ext, const __u8 *payload)
>   	input_sync(ext->input);
>   }
>
> +static void handler_balance_board(struct wiimote_ext *ext, const __u8 *payload)
> +{
> +	__s32 val[4];
> +
> +	/*   Byte |  8  7  6  5  4  3  2  1  |
> +	 *   -----+--------------------------+
> +	 *    1   |    Top Right <15:8>      |
> +	 *    2   |    Top Right  <7:0>      |
> +	 *   -----+--------------------------+
> +	 *    3   | Bottom Right <15:8>      |
> +	 *    4   | Bottom Right  <7:0>      |
> +	 *   -----+--------------------------+
> +	 *    5   |     Top Left <15:8>      |
> +	 *    6   |     Top Left  <7:0>      |
> +	 *   -----+--------------------------+
> +	 *    7   |  Bottom Left <15:8>      |
> +	 *    8   |  Bottom Left  <7:0>      |
> +	 *   -----+--------------------------+
> +	 *
> +	 * These values represent the weight-measurements of the Wii-balance
> +	 * board with 16bit precision.
> +	 *
> +	 * The balance-board is never reported interleaved with motionp.
> +	 */
> +
> +	val[0] = payload[0];
> +	val[0] <<= 8;
> +	val[0] |= payload[1];
> +
> +	val[1] = payload[2];
> +	val[1] <<= 8;
> +	val[1] |= payload[3];
> +
> +	val[2] = payload[4];
> +	val[2] <<= 8;
> +	val[2] |= payload[5];
> +
> +	val[3] = payload[6];
> +	val[3] <<= 8;
> +	val[3] |= payload[7];
> +
> +	input_report_abs(ext->input, ABS_HAT0X, val[0]);
> +	input_report_abs(ext->input, ABS_HAT0Y, val[1]);
> +	input_report_abs(ext->input, ABS_HAT1X, val[2]);
> +	input_report_abs(ext->input, ABS_HAT1Y, val[3]);
> +
> +	input_sync(ext->input);
> +}
> +
>   /* call this with state.lock spinlock held */
>   void wiiext_handle(struct wiimote_data *wdata, const __u8 *payload)
>   {
> @@ -523,6 +575,8 @@ void wiiext_handle(struct wiimote_data *wdata, const __u8 *payload)
>   		handler_nunchuck(ext, payload);
>   	} else if (ext->ext_type == WIIEXT_CLASSIC) {
>   		handler_classic(ext, payload);
> +	} else if (ext->ext_type == WIIEXT_BALANCE_BOARD) {
> +		handler_balance_board(ext, payload);
>   	}
>   }
>
> @@ -551,6 +605,11 @@ static ssize_t wiiext_show(struct device *dev, struct device_attribute *attr,
>   			return sprintf(buf, "motionp+classic\n");
>   		else
>   			return sprintf(buf, "classic\n");
> +	} else if (type == WIIEXT_BALANCE_BOARD) {
> +		if (motionp)
> +			return sprintf(buf, "motionp+balanceboard\n");
> +		else
> +			return sprintf(buf, "balanceboard\n");
>   	} else {
>   		if (motionp)
>   			return sprintf(buf, "motionp\n");
>


-- 
SENT FROM MY PDP-11
