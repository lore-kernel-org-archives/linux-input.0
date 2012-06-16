From: "weixing" <weixing@hanwang.com.cn>
Subject: Re: Re: [PATCH] Input: hanwang - add support for Art Master II tablet
Date: Sat, 16 Jun 2012 21:59:34 +0800
Message-ID: <201206162159340106339@hanwang.com.cn>
References: <1339423839-9716-1-git-send-email-weixing@hanwang.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hanwang.com.cn ([221.122.51.51]:52588 "EHLO mail.hanwang.com.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756660Ab2FPOAL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jun 2012 10:00:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Dmitry Torokhov,

On 2012-06-13 14:38:19,you wrote:
>
>Hi,
>
>On Mon, Jun 11, 2012 at 10:10:39PM +0800, weixing wrote:
>> this adds support for old hanwang Art master II tablet
>> 
>> Signed-off-by: weixing <weixing@hanwang.com.cn>
>> ---
>>  drivers/input/tablet/hanwang.c |   63 ++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 61 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
>> index b2db3cf..4154c1d 100644
>> --- a/drivers/input/tablet/hanwang.c
>> +++ b/drivers/input/tablet/hanwang.c
>> @@ -63,6 +63,7 @@ MODULE_LICENSE(DRIVER_LICENSE);
>>  enum hanwang_tablet_type {
>>  	HANWANG_ART_MASTER_III,
>>  	HANWANG_ART_MASTER_HD,
>> +	HANWANG_ART_MASTER_II,
>>  };
>>  
>>  struct hanwang {
>> @@ -99,6 +100,8 @@ static const struct hanwang_features features_array[] = {
>>  	  ART_MASTER_PKGLEN_MAX, 0x7f00, 0x4f60, 0x3f, 0x7f, 2048 },
>>  	{ 0x8401, "Hanwang Art Master HD 5012", HANWANG_ART_MASTER_HD,
>>  	  ART_MASTER_PKGLEN_MAX, 0x678e, 0x4150, 0x3f, 0x7f, 1024 },
>> +	{ 0x8503, "Hanwang Art Master II", HANWANG_ART_MASTER_II,
>> +	  ART_MASTER_PKGLEN_MAX, 0x27de, 0x1cfe, 0x3f, 0x7f, 1024 },
>>  };
>>  
>>  static const int hw_eventtypes[] = {
>> @@ -120,6 +123,55 @@ static const int hw_mscevents[] = {
>>  	MSC_SERIAL,
>>  };
>>  
>> +static void hanwang_parse_ArtmasterII_packet(struct hanwang *hanwang)
>
>Caps are disliked. Why don't you call it
>hanwang_parse_artmaster2_packet()?
>

Ok,I'll fix it.

>> +{
>> +	unsigned char *data = hanwang->data;
>> +	struct input_dev *input_dev = hanwang->dev;
>> +	struct usb_device *dev = hanwang->usbdev;
>> +	u16 x, y, p;
>> +
>> +	hanwang->current_tool = BTN_TOOL_PEN;
>> +
>i> +	switch (data[0]) {
>> +	case 0x02:	/* correct report id */
>> +		switch (data[1]) {
>> +		case 0x00:	/* pen leave */
>> +			hanwang->current_id = 0;
>> +			input_report_key(input_dev, hanwang->current_tool, 0);
>> +			break;
>> +		default:
>> +			hanwang->current_id = STYLUS_DEVICE_ID;
>> +			x = (data[2] << 8) | data[3];
>> +			y = (data[4] << 8) | data[5];
>> +			p = (data[7] >> 6) | (data[6] << 2);
>> +
>> +			input_report_key(input_dev, BTN_TOOL_PEN, 1);
>> +			input_report_abs(input_dev, ABS_X,
>> +						le16_to_cpup((__le16 *)&x));
>> +			input_report_abs(input_dev, ABS_Y,
>> +						le16_to_cpup((__le16 *)&y));
>> +			input_report_abs(input_dev, ABS_PRESSURE,
>> +						le16_to_cpup((__le16 *)&p));
>
>This does not make any sense. You first manually conver BE data to CPU
>format and then you do "le16_to_cpup((__le16 *)&x" for no reason...
>
>It looks what you need is:
>
>			input_report_abs(input_dev, ABS_X,
>					 be16_to_cpup((__be16 *)&data[2]);
>			input_report_abs(input_dev, ABS_Y,
>					 be16_to_cpup((__be16 *)&data[3]);
>			input_report_abs(input_dev, ABS_PRESSURE,
>					 (data[7] >> 6) | (data[6] << 2));
>
>I see that the original driver has the same issue.. My bad, we need to
>fix it as well.
>

Sorry,I'll fix it.A little formalism here,my bad.Really appreciate ur advice and comment. 

>> +			input_report_abs(input_dev, ABS_TILT_X, data[7] & 0x3f);
>> +			input_report_abs(input_dev, ABS_TILT_Y, data[8] & 0x7f);
>> +			input_report_key(input_dev, BTN_STYLUS2,
>> +						data[1] & 0x02);
>> +			break;
>> +		}
>> +
>> +		input_report_abs(input_dev, ABS_MISC, hanwang->current_id);
>> +		input_event(input_dev, EV_MSC, MSC_SERIAL,
>> +				hanwang->features->pid);
>
>Hmm, so the difference between ArtmasterII and others is that you it
>does not have BTN_STYLUS, only BTN_STYLUS2 (why, BTW? I'd expect if a
>device had only one button on a stylus it woudl report BTN_STYLUS, not
>BTN_STYLUS2); and it sends hanwang->features->pid instead of 0xffffffff
>in MSC_SERIAL. Does it have to be a separate fucntion that is 99% the
>same as the original one?
>
ok, i'll fix that.

>Thanks.
>
>-- 
>Dmitry
>--
>To unsubscribe from this list: send the line "unsubscribe linux-input" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



Thanks.

