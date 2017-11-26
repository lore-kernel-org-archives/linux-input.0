From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Support TrackStick of Thinkpad L570
Date: Sat, 25 Nov 2017 16:15:59 -0800
Message-ID: <20171126001559.uqeud7wxgjhkldgd@dtor-ws>
References: <20171120075530.4880-1-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:45866 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751415AbdKZAQE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 25 Nov 2017 19:16:04 -0500
Content-Disposition: inline
In-Reply-To: <20171120075530.4880-1-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: benjamin.tissoires@redhat.com, pali.rohar@gmail.com, aaron.ma@canonical.com, jaak@ristioja.ee, masaki.ota@jp.alps.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 20, 2017 at 04:55:30PM +0900, Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> - The issue is that Thinkpad L570 TrackStick does not work. Because the main interface of Thinkpad L570 device is SMBus, so ALPS overlooked PS2 interface Firmware setting of TrackStick. The detail is that TrackStick otp bit is disabled.

Is it custom protocol over SMBus/I2C or HID (via i2c-hid)? If it is
custom protocol, can we add the proper driver to the kernel for it so we
can get away from the PS/2 emulation in firmware?

Thanks!

> - Add the code that checks 0xD7 address value. This value is device number information, so we can identify the device by checking this value.
> - If we check 0xD7 value, we need to enable Command mode and after check the value we need to disable Command mode, then we have to enable the device(0xF4 command).
> - Thinkpad L570 device number is 0x0C or 0x1D. If it is TRUE, enable ALPS_DUALPOINT flag.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> ---
>  drivers/input/mouse/alps.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 850b00e3ad8e..cce52104ed5a 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2541,13 +2541,28 @@ static int alps_update_btn_info_ss4_v2(unsigned char otp[][4],
>  }
>  
>  static int alps_update_dual_info_ss4_v2(unsigned char otp[][4],
> -				       struct alps_data *priv)
> +				       struct alps_data *priv,
> +					struct psmouse *psmouse)
>  {
>  	bool is_dual = false;
> +	int reg_val = 0;
> +	struct ps2dev *ps2dev = &psmouse->ps2dev;
>  
> -	if (IS_SS4PLUS_DEV(priv->dev_id))
> +	if (IS_SS4PLUS_DEV(priv->dev_id)) {
>  		is_dual = (otp[0][0] >> 4) & 0x01;
>  
> +		/* For support TrackStick of Thinkpad L570 device */
> +		if (alps_exit_command_mode(psmouse) == 0 &&
> +			alps_enter_command_mode(psmouse) == 0) {
> +			reg_val = alps_command_mode_read_reg(psmouse, 0xD7);
> +		}
> +		alps_exit_command_mode(psmouse);
> +		ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> +
> +		if (reg_val == 0x0C || reg_val == 0x1D)
> +			is_dual = true;
> +	}
> +
>  	if (is_dual)
>  		priv->flags |= ALPS_DUALPOINT |
>  					ALPS_DUALPOINT_WITH_PRESSURE;
> @@ -2570,7 +2585,7 @@ static int alps_set_defaults_ss4_v2(struct psmouse *psmouse,
>  
>  	alps_update_btn_info_ss4_v2(otp, priv);
>  
> -	alps_update_dual_info_ss4_v2(otp, priv);
> +	alps_update_dual_info_ss4_v2(otp, priv, psmouse);
>  
>  	return 0;
>  }
> -- 
> 2.14.1
> 

-- 
Dmitry
