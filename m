From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] Input: xpad - fix stuck mode button on Xbox One S pad
Date: Mon, 6 Feb 2017 14:03:13 -0800
Message-ID: <20170206220313.GD17441@dtor-ws>
References: <20170205003002.28160-1-aicommander@gmail.com>
 <20170205003002.28160-6-aicommander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34242 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbdBFWDW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2017 17:03:22 -0500
Content-Disposition: inline
In-Reply-To: <20170205003002.28160-6-aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: rojtberg@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Feb 04, 2017 at 04:30:02PM -0800, Cameron Gutman wrote:
> The Xbox One S requires an ack to its mode button report
> otherwise it continuously retransmits the report. This
> makes the mode button appear to be stuck down after it
> is pressed for the first time.
> 
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>

Applied, thank you.

> ---
>  drivers/input/joystick/xpad.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 1179266..eb01c54 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -414,6 +414,7 @@ struct usb_xpad {
>  
>  static int xpad_init_input(struct usb_xpad *xpad);
>  static void xpad_deinit_input(struct usb_xpad *xpad);
> +static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
>  
>  /*
>   *	xpad_process_packet
> @@ -647,6 +648,14 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
>  
>  	/* the xbox button has its own special report */
>  	if (data[0] == 0X07) {
> +		/*
> +		 * The Xbox One S controller requires these reports to be
> +		 * acked otherwise it continues sending them forever and
> +		 * won't report further mode button events.
> +		 */
> +		if (data[1] == 0x30)
> +			xpadone_ack_mode_report(xpad, data[2]);
> +
>  		input_report_key(dev, BTN_MODE, data[4] & 0x01);
>  		input_sync(dev);
>  		return;
> @@ -983,6 +992,30 @@ static int xpad_start_xbox_one(struct usb_xpad *xpad)
>  	return retval;
>  }
>  
> +static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num)
> +{
> +	unsigned long flags;
> +	struct xpad_output_packet *packet =
> +			&xpad->out_packets[XPAD_OUT_CMD_IDX];
> +	static const u8 mode_report_ack[] = {
> +		0x01, 0x20, 0x00, 0x09, 0x00, 0x07, 0x20, 0x02,
> +		0x00, 0x00, 0x00, 0x00, 0x00
> +	};
> +
> +	spin_lock_irqsave(&xpad->odata_lock, flags);
> +
> +	packet->len = sizeof(mode_report_ack);
> +	memcpy(packet->data, mode_report_ack, packet->len);
> +	packet->data[2] = seq_num;
> +	packet->pending = true;
> +
> +	/* Reset the sequence so we send out the ack now */
> +	xpad->last_out_packet = -1;
> +	xpad_try_sending_next_out_packet(xpad);
> +
> +	spin_unlock_irqrestore(&xpad->odata_lock, flags);
> +}
> +
>  #ifdef CONFIG_JOYSTICK_XPAD_FF
>  static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
>  {
> -- 
> 2.9.3
> 

-- 
Dmitry
