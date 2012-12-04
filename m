From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 01/14] HID: i2c-hid: change I2C name
Date: Tue, 4 Dec 2012 17:07:12 +0100
Message-ID: <20121204170712.1bcdcddb@endymion.delvare>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
	<1354634875-5182-2-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:9250 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754335Ab2LDQHZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 11:07:25 -0500
In-Reply-To: <1354634875-5182-2-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue,  4 Dec 2012 16:27:42 +0100, Benjamin Tissoires wrote:
> no I2C driver has "i2c" in its name. It makes more sense to call this
> i2c driver "hid".
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 67ab5b7..0fbb229 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -949,7 +949,7 @@ static int i2c_hid_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(i2c_hid_pm, i2c_hid_suspend, i2c_hid_resume);
>  
>  static const struct i2c_device_id i2c_hid_id_table[] = {
> -	{ "i2c_hid", 0 },
> +	{ "hid", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(i2c, i2c_hid_id_table);

Reviewed-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare
