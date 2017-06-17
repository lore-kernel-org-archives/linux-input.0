From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: goodix: Add support for capacitive home button
 found on some x86 tablets
Date: Sat, 17 Jun 2017 21:34:51 +0200
Message-ID: <7cfbb358-3905-5b32-3677-e217e04d9e73@redhat.com>
References: <1725443.Vzhj3lzWjD@z12>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751594AbdFQTez (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 17 Jun 2017 15:34:55 -0400
In-Reply-To: <1725443.Vzhj3lzWjD@z12>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Sergei A. Trusov" <sergei.a.trusov@ya.ru>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: russianneuromancer@ya.ru, linux-input@vger.kernel.org

Hi,

On 17-06-17 11:42, Sergei A. Trusov wrote:
> On some x86 tablets with a goodix touchscreen the windows logo on the
> front is a capacitive home button. Touching this button results in a touch
> with bit 4 of the 0th byte set, while normally only the lower 4 bits
> are used to indicate the number of touches.
> 
> Detect this and report a KEY_LEFTMETA press when this happens. Note the
> hardware might support more than one button, the number of a button is
> reported by the 'id' byte of coor_data. Now we ignore button id.
> 
> Signed-off-by: Sergei A. Trusov <sergei.a.trusov@ya.ru>

The changes look good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Also this makes the capacitive home button on my HP stream 7 work, so:

Tested-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   drivers/input/touchscreen/goodix.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 240b16f3ee97..a4c17c461792 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -76,6 +76,10 @@ struct goodix_ts_data {
>   #define MAX_CONTACTS_LOC	5
>   #define TRIGGER_LOC		6
>   
> +#define GOODIX_TOUCH_NUM_MASK		0x0f
> +#define GOODIX_SOFTBUTTON_MASK		0x10
> +#define GOODIX_SOFTBUTTON1		KEY_LEFTMETA
> +
>   static const unsigned long goodix_irq_flags[] = {
>   	IRQ_TYPE_EDGE_RISING,
>   	IRQ_TYPE_EDGE_FALLING,
> @@ -208,7 +212,7 @@ static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
>   	if (!(data[0] & 0x80))
>   		return -EAGAIN;
>   
> -	touch_num = data[0] & 0x0f;
> +	touch_num = data[0] & GOODIX_TOUCH_NUM_MASK;
>   	if (touch_num > ts->max_touch_num)
>   		return -EPROTO;
>   
> @@ -223,7 +227,7 @@ static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
>   			return error;
>   	}
>   
> -	return touch_num;
> +	return data[0];
>   }
>   
>   static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
> @@ -260,13 +264,17 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
>   static void goodix_process_events(struct goodix_ts_data *ts)
>   {
>   	u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
> -	int touch_num;
> +	int touch_num, status;
>   	int i;
>   
> -	touch_num = goodix_ts_read_input_report(ts, point_data);
> -	if (touch_num < 0)
> +	status = goodix_ts_read_input_report(ts, point_data);
> +	if (status < 0)
>   		return;
>   
> +	input_report_key(ts->input_dev, GOODIX_SOFTBUTTON1,
> +			!!(status & GOODIX_SOFTBUTTON_MASK));
> +
> +	touch_num = status & GOODIX_TOUCH_NUM_MASK;
>   	for (i = 0; i < touch_num; i++)
>   		goodix_ts_report_touch(ts,
>   				&point_data[1 + GOODIX_CONTACT_SIZE * i]);
> @@ -612,6 +620,8 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
>   	ts->input_dev->id.product = ts->id;
>   	ts->input_dev->id.version = ts->version;
>   
> +	input_set_capability(ts->input_dev, EV_KEY, GOODIX_SOFTBUTTON1);
> +
>   	error = input_register_device(ts->input_dev);
>   	if (error) {
>   		dev_err(&ts->client->dev,
> 
