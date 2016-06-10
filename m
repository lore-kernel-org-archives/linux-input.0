From: Tobita Tatsunosuke <tobita.tatsunosuke@wacom.co.jp>
Subject: RE: [PATCH] Input: Adding 2 bytes ahead of the input report which
 describes the length of the packet meeting HID-over-I2C spec
Date: Fri, 10 Jun 2016 01:40:32 +0000
Message-ID: <AMSPR07MB3590B7DA57F6D9A7142C68BDE500@AMSPR07MB359.eurprd07.prod.outlook.com>
References: <1465458818-14104-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
 <e0a1b792-de63-f687-b08b-1f1ea2dc425d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db3on0083.outbound.protection.outlook.com ([157.55.234.83]:59936
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751017AbcFJDPz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jun 2016 23:15:55 -0400
In-Reply-To: <e0a1b792-de63-f687-b08b-1f1ea2dc425d@gmail.com>
Content-Language: ja-JP
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>, Tatsunosuke Tobita <junkpainting@gmail.com>, Linux Input <linux-input@vger.kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pinglinux@gmail.com>

Thank you for taking a look at it and replying.
I'll make it sure again.

All,

Please hold this patch...

Tats

-----Original Message-----
From: Jason Gerecke [mailto:killertofu@gmail.com] 
Sent: Friday, June 10, 2016 6:45 AM
To: Tatsunosuke Tobita; Linux Input
Cc: Tobita Tatsunosuke; Benjamin Tissoires; Ping Cheng
Subject: Re: [PATCH] Input: Adding 2 bytes ahead of the input report which describes the length of the packet meeting HID-over-I2C spec

On 06/09/2016 12:53 AM, Tatsunosuke Tobita wrote:
> HID-over-I2C requires data at the first two bytes for describing the 
> input report length, but the current wacom.ko doesn't have such space 
> and this makes the input outcome messed.
> Also, another report ID for Wacom AES type device is defined.
> 
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> ---

I must admit I'm confused by this patch...

Firstly, I2C devices should be using the HID_GENERIC codepath, but none of the changes here are to that codepath, so I don't see how this would fix anything. Secondly, the HID subsystem itself should already be taking into account the two byte header for I2C devices (see the i2c_hid_get_input function in  drivers/hid/i2c-hid/i2c-hid.c); at least, I haven't seen any strange behavior with the I2C devices I've used with wacom.ko...

Jason
---
Now instead of four in the eights place / you've got three, 'Cause you added one / (That is to say, eight) to the two, / But you can't take seven from three, / So you look at the sixty-fours....


>  drivers/hid/wacom_sys.c |  6 +++++-
>  drivers/hid/wacom_wac.c | 28 ++++++++++++++++------------  
> drivers/hid/wacom_wac.h |  2 ++
>  3 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c index 
> 499cc82..95be318 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1886,7 +1886,11 @@ static int wacom_probe(struct hid_device *hdev,
>  			hid_warn(hdev,
>  				 "can't create sysfs speed attribute err: %d\n",
>  				 error);
> -	}
> +
> +	/*HID Over I2C spec requires 2 bytes at the head of*/
> +	/*Input report for length description*/
> +	} else if (hdev->bus == BUS_I2C)
> +		wacom_wac->data_head = 2;
>  
>  	return 0;
>  
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c index 
> 1eae13c..c352d40 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1229,8 +1229,9 @@ static int wacom_mt_touch(struct wacom_wac 
> *wacom)  {
>  	struct input_dev *input = wacom->touch_input;
>  	unsigned char *data = wacom->data;
> +	unsigned char data_head = wacom->data_head;
>  	int i;
> -	int current_num_contacts = data[2];
> +	int current_num_contacts = data[data_head + 2];
>  	int contacts_to_send = 0;
>  	int x_offset = 0;
>  
> @@ -1249,7 +1250,8 @@ static int wacom_mt_touch(struct wacom_wac *wacom)
>  	contacts_to_send = min(5, wacom->num_contacts_left);
>  
>  	for (i = 0; i < contacts_to_send; i++) {
> -		int offset = (WACOM_BYTES_PER_MT_PACKET + x_offset) * i + 3;
> +		int offset = (WACOM_BYTES_PER_MT_PACKET
> +				+ x_offset) * (data_head + i) + 3;
>  		bool touch = (data[offset] & 0x1) && !wacom->shared->stylus_in_proximity;
>  		int id = get_unaligned_le16(&data[offset + 1]);
>  		int slot = input_mt_get_slot_by_key(input, id); @@ -1343,25 
> +1344,31 @@ static int wacom_tpc_single_touch(struct wacom_wac *wacom, 
> size_t len)  static int wacom_tpc_pen(struct wacom_wac *wacom)  {
>  	unsigned char *data = wacom->data;
> +	unsigned char data_head = wacom->data_head;
>  	struct input_dev *input = wacom->pen_input;
> -	bool prox = data[1] & 0x20;
> +	bool prox = data[data_head + 1] & 0x20;
>  
>  	if (!wacom->shared->stylus_in_proximity) /* first in prox */
>  		/* Going into proximity select tool */
> -		wacom->tool[0] = (data[1] & 0x0c) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
> +		wacom->tool[data_head]
> +		= (data[data_head + 1] & 0x0c) ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
>  
>  	/* keep pen state for touch events */
>  	wacom->shared->stylus_in_proximity = prox;
>  
>  	/* send pen events only when touch is up or forced out */
>  	if (!wacom->shared->touch_down) {
> -		input_report_key(input, BTN_STYLUS, data[1] & 0x02);
> -		input_report_key(input, BTN_STYLUS2, data[1] & 0x10);
> -		input_report_abs(input, ABS_X, le16_to_cpup((__le16 *)&data[2]));
> -		input_report_abs(input, ABS_Y, le16_to_cpup((__le16 *)&data[4]));
> -		input_report_abs(input, ABS_PRESSURE, ((data[7] & 0x07) << 8) | data[6]);
> -		input_report_key(input, BTN_TOUCH, data[1] & 0x05);
> -		input_report_key(input, wacom->tool[0], prox);
> +		input_report_key(input, BTN_STYLUS, data[data_head + 1] & 0x02);
> +		input_report_key(input, BTN_STYLUS2,
> +					data[data_head + 1] & 0x10);
> +		input_report_abs(input, ABS_X,
> +					le16_to_cpup((__le16 *)&data[data_head + 2]));
> +		input_report_abs(input, ABS_Y,
> +					le16_to_cpup((__le16 *)&data[data_head + 4]));
> +		input_report_abs(input, ABS_PRESSURE, ((data[data_head + 7]
> +					& 0x07) << 8) | data[data_head + 6]);
> +		input_report_key(input, BTN_TOUCH, data[data_head + 1] & 0x05);
> +		input_report_key(input, wacom->tool[data_head], prox);
>  		return 1;
>  	}
>  
> @@ -1371,6 +1373,7 @@ static int wacom_tpc_pen(struct wacom_wac 
> *wacom)  static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)  
> {
>  	unsigned char *data = wacom->data;
> +	unsigned char data_head = wacom->data_head;
>  
>  	if (wacom->pen_input)
>  		dev_dbg(wacom->pen_input->dev.parent,
> @@ -1390,7 +1393,7 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
>  		return wacom_tpc_pen(wacom);
>  
>  	default:
> -		switch (data[0]) {
> +		switch (data[data_head]) {
>  		case WACOM_REPORT_TPC1FG:
>  		case WACOM_REPORT_TPCHID:
>  		case WACOM_REPORT_TPCST:
> @@ -1399,6 +1402,7 @@ static int wacom_tpc_irq(struct wacom_wac 
> *wacom, size_t len)
>  
>  		case WACOM_REPORT_TPCMT:
>  		case WACOM_REPORT_TPCMT2:
> +		case WACOM_REPORT_TPCMTHID:
>  			return wacom_mt_touch(wacom);
>  
>  		case WACOM_REPORT_PENABLED:
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h index 
> 53d1653..c992c2c 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -71,6 +71,7 @@
>  #define WACOM_REPORT_INTUOS_PEN		16
>  #define WACOM_REPORT_REMOTE		17
>  #define WACOM_REPORT_INTUOSHT2_ID	8
> +#define WACOM_REPORT_TPCMTHID           12
>  
>  /* device quirks */
>  #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0001
> @@ -248,6 +249,7 @@ struct wacom_wac {
>  	int mode_report;
>  	int mode_value;
>  	struct hid_data hid_data;
> +	unsigned char data_head;
>  };
>  
>  #endif
> 
