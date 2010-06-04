From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH] Input: usbtouchscreen - reduce number fo be16_to_cpu conversions
Date: Fri, 4 Jun 2010 12:35:02 +0200
Message-ID: <201006041235.03153.linux@rainbow-software.org>
References: <20100604075057.15829.92443.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1-out1.atlantis.sk ([80.94.52.55]:44440 "EHLO
	mail.atlantis.sk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753810Ab0FDKfL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Jun 2010 06:35:11 -0400
In-Reply-To: <20100604075057.15829.92443.stgit@localhost.localdomain>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Friday 04 June 2010, Dmitry Torokhov wrote:
> Let's perform be16_to_cpu() conversions once for each received packet,
> and then use cached values. Makes code a little bit easier to follow.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> Ondrej,
>
> Any chance you could test the following patch?

Thanks for the patch, it works.


> Thanks,
> Dmitry
>
>
>  drivers/input/touchscreen/usbtouchscreen.c |   34
> +++++++++++++++------------- 1 files changed, 18 insertions(+), 16
> deletions(-)
>
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c
> b/drivers/input/touchscreen/usbtouchscreen.c index 567d572..5d6bf2a 100644
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -849,29 +849,32 @@ static void nexio_exit(struct usbtouch_usb *usbtouch)
>
>  static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char
> *pkt) {
> -	int x, y, begin_x, begin_y, end_x, end_y, w, h, ret;
>  	struct nexio_touch_packet *packet = (void *) pkt;
>  	struct nexio_priv *priv = usbtouch->priv;
> +	unsigned int data_len = be16_to_cpu(packet->data_len);
> +	unsigned int x_len = be16_to_cpu(packet->x_len);
> +	unsigned int y_len = be16_to_cpu(packet->y_len);
> +	int x, y, begin_x, begin_y, end_x, end_y, w, h, ret;
>
>  	/* got touch data? */
>  	if ((pkt[0] & 0xe0) != 0xe0)
>  		return 0;
>
> -	if (be16_to_cpu(packet->data_len) > 0xff)
> -		packet->data_len = cpu_to_be16(be16_to_cpu(packet->data_len) - 0x100);
> -	if (be16_to_cpu(packet->x_len) > 0xff)
> -		packet->x_len = cpu_to_be16(be16_to_cpu(packet->x_len) - 0x80);
> +	if (data_len > 0xff)
> +		data_len -= 0x100;
> +	if (x_len > 0xff)
> +		x_len -= 0x80;
>
>  	/* send ACK */
>  	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
>
>  	if (!usbtouch->type->max_xc) {
> -		usbtouch->type->max_xc = 2 * be16_to_cpu(packet->x_len);
> -		input_set_abs_params(usbtouch->input, ABS_X, 0,
> -				     2 * be16_to_cpu(packet->x_len), 0, 0);
> -		usbtouch->type->max_yc = 2 * be16_to_cpu(packet->y_len);
> -		input_set_abs_params(usbtouch->input, ABS_Y, 0,
> -				     2 * be16_to_cpu(packet->y_len), 0, 0);
> +		usbtouch->type->max_xc = 2 * x_len;
> +		input_set_abs_params(usbtouch->input, ABS_X,
> +				     0, usbtouch->type->max_xc, 0, 0);
> +		usbtouch->type->max_yc = 2 * y_len;
> +		input_set_abs_params(usbtouch->input, ABS_Y,
> +				     0, usbtouch->type->max_yc, 0, 0);
>  	}
>  	/*
>  	 * The device reports state of IR sensors on X and Y axes.
> @@ -881,22 +884,21 @@ static int nexio_read_data(struct usbtouch_usb
> *usbtouch, unsigned char *pkt) * it's disabled (and untested) here as
> there's no X driver for that. */
>  	begin_x = end_x = begin_y = end_y = -1;
> -	for (x = 0; x < be16_to_cpu(packet->x_len); x++) {
> +	for (x = 0; x < x_len; x++) {
>  		if (begin_x == -1 && packet->data[x] > NEXIO_THRESHOLD) {
>  			begin_x = x;
>  			continue;
>  		}
>  		if (end_x == -1 && begin_x != -1 && packet->data[x] < NEXIO_THRESHOLD) {
>  			end_x = x - 1;
> -			for (y = be16_to_cpu(packet->x_len);
> -			     y < be16_to_cpu(packet->data_len); y++) {
> +			for (y = x_len; y < data_len; y++) {
>  				if (begin_y == -1 && packet->data[y] > NEXIO_THRESHOLD) {
> -					begin_y = y - be16_to_cpu(packet->x_len);
> +					begin_y = y - x_len;
>  					continue;
>  				}
>  				if (end_y == -1 &&
>  				    begin_y != -1 && packet->data[y] < NEXIO_THRESHOLD) {
> -					end_y = y - 1 - be16_to_cpu(packet->x_len);
> +					end_y = y - 1 - x_len;
>  					w = end_x - begin_x;
>  					h = end_y - begin_y;
>  #if 0



-- 
Ondrej Zary
