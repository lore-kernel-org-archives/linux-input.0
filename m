From: Rafael Brune <mail@rbrune.de>
Subject: Re: [PATCH] HID: wiimote: fix inverted pro-controller axes
Date: Wed, 30 Oct 2013 00:20:18 +0100
Message-ID: <1530A042-4C08-422E-A162-2057D250D325@rbrune.de>
References: <1382978873-802-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tyrell.rbrune.de ([83.169.16.173]:57016 "EHLO tyrell.rbrune.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab3J2XUX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Oct 2013 19:20:23 -0400
In-Reply-To: <1382978873-802-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, stable@vger.kernel.org


On Oct 28, 2013, at 5:47 PM, David Herrmann <dh.herrmann@gmail.com> wrote:

> The analog-stick vertical axes are inverted. Fix that! Otherwise, games
> and other gamepad applications need to carry their own fixups (which they
> thankfully haven't done, yet).
> 
> Cc: <stable@vger.kernel.org> # 3.11+
> Reported-by: Rafael Brune <mail@rbrune.de>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Tested-by: Rafael Brune <mail@rbrune.de>


> ---
> drivers/hid/hid-wiimote-modules.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
> index 71adf9e..e30567a 100644
> --- a/drivers/hid/hid-wiimote-modules.c
> +++ b/drivers/hid/hid-wiimote-modules.c
> @@ -1656,9 +1656,9 @@ static void wiimod_pro_in_ext(struct wiimote_data *wdata, const __u8 *ext)
> 	ry = (ext[6] & 0xff) | ((ext[7] & 0x0f) << 8);
> 
> 	input_report_abs(wdata->extension.input, ABS_X, lx - 0x800);
> -	input_report_abs(wdata->extension.input, ABS_Y, ly - 0x800);
> +	input_report_abs(wdata->extension.input, ABS_Y, 0x800 - ly);
> 	input_report_abs(wdata->extension.input, ABS_RX, rx - 0x800);
> -	input_report_abs(wdata->extension.input, ABS_RY, ry - 0x800);
> +	input_report_abs(wdata->extension.input, ABS_RY, 0x800 - ry);
> 
> 	input_report_key(wdata->extension.input,
> 			 wiimod_pro_map[WIIMOD_PRO_KEY_RIGHT],
> -- 
> 1.8.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

