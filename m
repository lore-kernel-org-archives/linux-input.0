From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Support TrackStick of Thinkpad L570
Date: Fri, 1 Dec 2017 22:07:49 +0100
Message-ID: <20171201210749.el6q62sc22jshwc5@pali>
References: <20171129083358.5063-1-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171129083358.5063-1-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: dmitry.torokhov@gmail.com, benjamin.tissoires@redhat.com, aaron.ma@canonical.com, jaak@ristioja.ee, masaki.ota@jp.alps.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wednesday 29 November 2017 17:33:58 Masaki Ota wrote:
> From: Masaki Ota <masaki.ota@jp.alps.com>
> - The issue is that Thinkpad L570 TrackStick does not work. Because the main interface of Thinkpad L570 device is SMBus, so ALPS overlooked PS2 interface Firmware setting of TrackStick. The detail is that TrackStick otp bit is disabled.
> - Add the code that checks 0xD7 address value. This value is device number information, so we can identify the device by checking this value.
> - If we check 0xD7 value, we need to enable Command mode and after check the value we need to disable Command mode, then we have to enable the device(0xF4 command).
> - Thinkpad L570 device number is 0x0C or 0x1D. If it is TRUE, enable ALPS_DUALPOINT flag.
> 
> Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> ---
>  drivers/input/mouse/alps.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 850b00e3ad8e..6f092bdd9fc5 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2541,13 +2541,31 @@ static int alps_update_btn_info_ss4_v2(unsigned char otp[][4],
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
> +		if (!is_dual) {
> +			/* For support TrackStick of Thinkpad L/E series */
> +			if (alps_exit_command_mode(psmouse) == 0 &&
> +				alps_enter_command_mode(psmouse) == 0) {
> +				reg_val = alps_command_mode_read_reg(psmouse,
> +									0xD7);
> +			}
> +			alps_exit_command_mode(psmouse);
> +			ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> +
> +			if (reg_val == 0x0C || reg_val == 0x1D)
> +				is_dual = true;
> +		}
> +	}
> +
>  	if (is_dual)
>  		priv->flags |= ALPS_DUALPOINT |
>  					ALPS_DUALPOINT_WITH_PRESSURE;
> @@ -2570,7 +2588,7 @@ static int alps_set_defaults_ss4_v2(struct psmouse *psmouse,
>  
>  	alps_update_btn_info_ss4_v2(otp, priv);
>  
> -	alps_update_dual_info_ss4_v2(otp, priv);
> +	alps_update_dual_info_ss4_v2(otp, priv, psmouse);

Now looking at this change... Is there reason why you are passing
psmouse parameter there? Because struct alps_data contains psmouse
member.

>  
>  	return 0;
>  }

-- 
Pali Rohár
pali.rohar@gmail.com
