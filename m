From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] Input: wacom_w8001 - split the touch and pen devices
 into two devices
Date: Tue, 1 Dec 2015 14:06:51 -0800
Message-ID: <20151201220651.GG3740@dtor-ws>
References: <1448854696-32625-1-git-send-email-peter.hutterer@who-t.net>
 <1448854696-32625-5-git-send-email-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36505 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757118AbbLAWGy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2015 17:06:54 -0500
Received: by pacdm15 with SMTP id dm15so17988117pac.3
        for <linux-input@vger.kernel.org>; Tue, 01 Dec 2015 14:06:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1448854696-32625-5-git-send-email-peter.hutterer@who-t.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>

On Mon, Nov 30, 2015 at 01:38:16PM +1000, Peter Hutterer wrote:
> These devices have a pen device and a touch device through the same serial
> protocol, split it up into two separate devices like we do for USB Wacom
> tablets too.
> 
> Userspace already matches on the device name so we can't drop it
> completely. Compose the same basename based on capabilities and append the
> tool type, leading to a name like "Wacom Serial Penabled 2FG Touchscreen
> Pen".
> 
> Note that this drops BTN_TOOL_FINGER, it is not needed once the tools are
> split out (and a touch device with BTN_TOOL_FINGER is interpreted as
> touchpad by most of userspace).
> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/input/touchscreen/wacom_w8001.c | 163 ++++++++++++++++++++++----------
>  1 file changed, 112 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index 363e510..9efc7ec 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -80,7 +80,8 @@ struct w8001_touch_query {
>   */
>  
>  struct w8001 {
> -	struct input_dev *dev;
> +	struct input_dev *pen_dev;
> +	struct input_dev *touch_dev;
>  	struct serio *serio;
>  	struct completion cmd_done;
>  	int id;
> @@ -95,7 +96,10 @@ struct w8001 {
>  	u16 max_touch_y;
>  	u16 max_pen_x;
>  	u16 max_pen_y;
> -	char name[64];
> +	char pen_name[64];
> +	char touch_name[64];
> +	int open_count;
> +	struct mutex mutex;
>  };
>  
>  static void parse_pen_data(u8 *data, struct w8001_coord *coord)
> @@ -141,7 +145,7 @@ static void scale_touch_coordinates(struct w8001 *w8001,
>  
>  static void parse_multi_touch(struct w8001 *w8001)
>  {
> -	struct input_dev *dev = w8001->dev;
> +	struct input_dev *dev = w8001->touch_dev;
>  	unsigned char *data = w8001->data;
>  	unsigned int x, y;
>  	int i;
> @@ -207,7 +211,7 @@ static void parse_touchquery(u8 *data, struct w8001_touch_query *query)
>  
>  static void report_pen_events(struct w8001 *w8001, struct w8001_coord *coord)
>  {
> -	struct input_dev *dev = w8001->dev;
> +	struct input_dev *dev = w8001->pen_dev;
>  
>  	/*
>  	 * We have 1 bit for proximity (rdy) and 3 bits for tip, side,
> @@ -233,11 +237,6 @@ static void report_pen_events(struct w8001 *w8001, struct w8001_coord *coord)
>  		break;
>  
>  	case BTN_TOOL_FINGER:
> -		input_report_key(dev, BTN_TOUCH, 0);
> -		input_report_key(dev, BTN_TOOL_FINGER, 0);
> -		input_sync(dev);
> -		/* fall through */
> -
>  	case KEY_RESERVED:
>  		w8001->type = coord->f2 ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
>  		break;
> @@ -261,7 +260,7 @@ static void report_pen_events(struct w8001 *w8001, struct w8001_coord *coord)
>  
>  static void report_single_touch(struct w8001 *w8001, struct w8001_coord *coord)
>  {
> -	struct input_dev *dev = w8001->dev;
> +	struct input_dev *dev = w8001->touch_dev;
>  	unsigned int x = coord->x;
>  	unsigned int y = coord->y;
>  
> @@ -271,7 +270,6 @@ static void report_single_touch(struct w8001 *w8001, struct w8001_coord *coord)
>  	input_report_abs(dev, ABS_X, x);
>  	input_report_abs(dev, ABS_Y, y);
>  	input_report_key(dev, BTN_TOUCH, coord->tsw);
> -	input_report_key(dev, BTN_TOOL_FINGER, coord->tsw);
>  
>  	input_sync(dev);
>  
> @@ -369,20 +367,33 @@ static int w8001_command(struct w8001 *w8001, unsigned char command,
>  static int w8001_open(struct input_dev *dev)
>  {
>  	struct w8001 *w8001 = input_get_drvdata(dev);
> +	int err;
>  
> -	return w8001_command(w8001, W8001_CMD_START, false);
> +	err = mutex_lock_interruptible(&w8001->mutex);
> +	if (err)
> +		return err;
> +
> +	if (w8001->open_count++ == 0)
> +		err = w8001_command(w8001, W8001_CMD_START, false);

We leak the count in case of error here. You need something like:

static int w8001_open(struct input_dev *dev)
{
	struct w8001 *w8001 = input_get_drvdata(dev);
	int retval;

	retval = mutex_lock_interruptible(&w8001->mutex);
	if (retval)
		return retval;

	if (w8001->open_count++ == 0) {
		retval = w8001_command(w8001, W8001_CMD_START, false);
		if (retval)
			w8001->open_count--;
	}

	mutex_unlock(&w8001->mutex);
	return retval;
}

Thanks.

-- 
Dmitry
