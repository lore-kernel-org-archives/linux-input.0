From: Hn Chen <hn.chen@weidahitech.com>
Subject: RE: [PATCH] HID: i2c-hid: add retry in set power for fixing weida's
 issue
Date: Mon, 7 Nov 2016 11:02:47 +0000
Message-ID: <22498D53301C4D4A8FFA8F02C7C3C7C06DDE5462@mail02.WHT.local>
References: <1478515138-1922-1-git-send-email-hn.chen@weidahitech.com>
 <alpine.LNX.2.00.1611071147580.29400@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:1148 "EHLO
        ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbcKGLDU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Nov 2016 06:03:20 -0500
In-Reply-To: <alpine.LNX.2.00.1611071147580.29400@cbobk.fhfr.pm>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Jiri,

Thanks for the tip.

Since I don't have any experience to add a quirk, may I have a sample code for reference ?
It should be a HID quirk, right ?

Hn.chen.

-----Original Message-----
From: Jiri Kosina [mailto:jikos@kernel.org] 
Sent: Monday, November 07, 2016 6:49 PM
To: Hn Chen
Cc: benjamin.tissoires@redhat.com; dmitry.torokhov@gmail.com; linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid: add retry in set power for fixing weida's issue

On Mon, 7 Nov 2016, hn.chen@weidahitech.com wrote:

> From: HungNien Chen <hn.chen@weidahitech.com>
> 
> Just modify the set_power function to send the command twice.
> It should be ok for other contorllers since it will jump out the loop 
> after the first command send out. If this is not a proper 
> modification, please tell me a proper way to fix this kind of issue.
> 
> Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c 
> b/drivers/hid/i2c-hid/i2c-hid.c index b3ec4f2..d7423d9 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -49,6 +49,8 @@
>  #define I2C_HID_PWR_ON		0x00
>  #define I2C_HID_PWR_SLEEP	0x01
>  
> +#define	SET_PWR_RETRIES		2
> +
>  /* debug option */
>  static bool debug;
>  module_param(debug, bool, 0444);
> @@ -343,14 +345,26 @@ static int i2c_hid_set_power(struct i2c_client 
> *client, int power_state)  {
>  	struct i2c_hid *ihid = i2c_get_clientdata(client);
>  	int ret;
> +	int retry;
>  
>  	i2c_hid_dbg(ihid, "%s\n", __func__);
>  
> -	ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
> -		0, NULL, 0, NULL, 0);
> -	if (ret)
> -		dev_err(&client->dev, "failed to change power setting.\n");
> +       /*
> +	* Some Weida's controllers require Set_Power twice on resume.
> +	* The 1st cmd wakeup the controller and the 2nd cmd will be executed.
> +	* It should be safe to controllers of other vendors.
> +	*/
> +	for (retry = 0; retry < SET_PWR_RETRIES; retry++) {
> +		ret = __i2c_hid_command(client, &hid_set_power_cmd,
> +			power_state, 0, NULL, 0, NULL, 0);
> +
> +		if (!ret)
> +			goto set_power_exit;

This is ugly, and we have no idea what this might do to any other
(potential) devices. Can't you make this a quirk that'd be applied only to this specific device?

--
Jiri Kosina
SUSE Labs

