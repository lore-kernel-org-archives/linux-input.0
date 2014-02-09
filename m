From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH v2 3/3] input: appletouch: fix jumps when additional fingers
 are detected
Date: Sun, 09 Feb 2014 13:16:55 +0100
Message-ID: <52F771B7.9090509@euromail.se>
References: <52D9DE7A.7040509@gmail.com> <52F42AEE.3040505@gmail.com> <52F42CDD.30703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:34724 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbaBIMPC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Feb 2014 07:15:02 -0500
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 726BBEB261
	for <linux-input@vger.kernel.org>; Sun,  9 Feb 2014 13:15:00 +0100 (CET)
In-Reply-To: <52F42CDD.30703@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Clinton Sprain <clintonsprain@gmail.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 02/07/2014 01:46 AM, Clinton Sprain wrote:
> Discard cursor movements if they directly coincide with a change in the number of fingers detected. This helps with two issues - a sudden jump of the cursor when a second finger enters or leaves the touchpad, and an unexpected jump in page scrolling under the same scenario. The fix doesn't completely eliminate the problem but does greatly reduce its frequency and severity.
> 
> Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
> ---
>  drivers/input/mouse/appletouch.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index edbdd95..370d0e9 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -212,6 +212,7 @@ struct atp {
>  	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
>  	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
>  	int			idlecount;	/* number of empty packets */
> +	int			fingers_old;	/* last reported finger count */
>  	struct work_struct	work;
>  };
>  
> @@ -505,6 +506,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
>  	int x, y, x_z, y_z, x_f, y_f;
>  	int retval, i, j;
>  	int key;
> +	int fingers;
>  	struct atp *dev = urb->context;
>  	int status = atp_status_check(urb);
>  
> @@ -587,7 +589,9 @@ static void atp_complete_geyser_1_2(struct urb *urb)
>  			      dev->info->yfact, &y_z, &y_f);
>  	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
>  
> -	if (x && y) {
> +	fingers = max(x_f, y_f);
> +
> +	if (x && y && (fingers == dev->fingers_old)) {
>  		if (dev->x_old != -1) {
>  			x = (dev->x_old * 7 + x) >> 3;
>  			y = (dev->y_old * 7 + y) >> 3;
> @@ -604,7 +608,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
>  			input_report_abs(dev->input, ABS_Y, y);
>  			input_report_abs(dev->input, ABS_PRESSURE,
>  					 min(ATP_PRESSURE, x_z + y_z));
> -			atp_report_fingers(dev->input, max(x_f, y_f));
> +			atp_report_fingers(dev->input, fingers);
>  		}
>  		dev->x_old = x;
>  		dev->y_old = y;
> @@ -620,6 +624,10 @@ static void atp_complete_geyser_1_2(struct urb *urb)
>  		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
>  	}
>  
> +	if (fingers != dev->fingers_old)
> +		dev->x_old = dev->y_old = -1;
> +	dev->fingers_old = fingers;
> +
>  	input_report_key(dev->input, BTN_LEFT, key);
>  	input_sync(dev->input);
>  
> @@ -638,6 +646,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
>  	int x, y, x_z, y_z, x_f, y_f;
>  	int retval, i, j;
>  	int key;
> +	int fingers;
>  	struct atp *dev = urb->context;
>  	int status = atp_status_check(urb);
>  
> @@ -699,7 +708,9 @@ static void atp_complete_geyser_3_4(struct urb *urb)
>  			      dev->info->yfact, &y_z, &y_f);
>  	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
>  
> -	if (x && y) {
> +	fingers = max(x_f, y_f);
> +
> +	if (x && y && (fingers == dev->fingers_old)) {
>  		if (dev->x_old != -1) {
>  			x = (dev->x_old * 7 + x) >> 3;
>  			y = (dev->y_old * 7 + y) >> 3;
> @@ -716,7 +727,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
>  			input_report_abs(dev->input, ABS_Y, y);
>  			input_report_abs(dev->input, ABS_PRESSURE,
>  					 min(ATP_PRESSURE, x_z + y_z));
> -			atp_report_fingers(dev->input, max(x_f, y_f));
> +			atp_report_fingers(dev->input, fingers);
>  		}
>  		dev->x_old = x;
>  		dev->y_old = y;
> @@ -732,6 +743,10 @@ static void atp_complete_geyser_3_4(struct urb *urb)
>  		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
>  	}
>  
> +	if (fingers != dev->fingers_old)
> +		dev->x_old = dev->y_old = -1;
> +	dev->fingers_old = fingers;
> +
>  	input_report_key(dev->input, BTN_LEFT, key);
>  	input_sync(dev->input);
>  
> 

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik

