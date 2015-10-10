From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 10/15] Input: xpad: use ida() for finding the pad_nr
Date: Sat, 10 Oct 2015 10:06:52 -0700
Message-ID: <20151010170652.GH39573@dtor-ws>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
 <1443733046-29610-11-git-send-email-rojtberg@gmail.com>
 <560DB966.8080602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35855 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbbJJRGz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Oct 2015 13:06:55 -0400
Received: by pablk4 with SMTP id lk4so115241804pab.3
        for <linux-input@vger.kernel.org>; Sat, 10 Oct 2015 10:06:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <560DB966.8080602@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Fri, Oct 02, 2015 at 12:53:26AM +0200, Pavel Rojtberg wrote:
> sorry, I messed up this one. This would be the correct patch.
> Should I re-spin the whole series or would it be too much noise?
> 
> Subject: [PATCH 10/15] Input: xpad: use ida() for finding the pad_nr
> 
> The pad_nr corresponds to the lit up LED on the controller. Therefore
> there should be no gaps when enumerating. Currently a LED is only
> re-assigned after a controller is re-connected 4 times.
> 
> This patch uses ida to track connected pads - this way we can re-assign
> freed up pad number immediately.
> 
> Consider the following case:
> 1. pad A is connected and gets pad_nr = 0
> 2. pad B is connected and gets pad_nr = 1
> 3. pad A is disconnected
> 4. pad A is connected again
> 
> using ida_simple_get() controller A now correctly gets pad_nr = 0 again.
> 
> Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 31bcd78..b83ea3c 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -342,11 +342,13 @@ struct usb_xpad {
> 
>      int mapping;            /* map d-pad to buttons or to axes */
>      int xtype;            /* type of xbox device */
> -    unsigned long pad_nr;        /* the order x360 pads were attached */
> +    int pad_nr;            /* the order x360 pads were attached */
>      const char *name;        /* name of the device */
>      struct work_struct work;    /* init/remove device from callback */
>  };
> 
> +static DEFINE_IDA(xpad_pad_seq);
> +
>  static int xpad_init_input(struct usb_xpad *xpad);
>  static void xpad_deinit_input(struct usb_xpad *xpad);
> 
> @@ -946,6 +948,16 @@ static void xpad_send_led_command(struct
> usb_xpad *xpad, int command)
>   */
>  static void xpad_identify_controller(struct usb_xpad *xpad)
>  {
> +    if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
> +        return;
> +
> +    xpad->pad_nr = ida_simple_get(&xpad_pad_seq, 0, 0, GFP_KERNEL);
> +
> +    if(xpad->pad_nr < 0) {
> +        dev_dbg(&xpad->dev->dev, "%s - ida_get failed\n", __func__);
> +        return;
> +    }
> +
>      xpad_send_led_command(xpad, (xpad->pad_nr % 4) + 2);
>  }
> 
> @@ -960,7 +972,6 @@ static void xpad_led_set(struct led_classdev *led_cdev,
> 
>  static int xpad_led_probe(struct usb_xpad *xpad)
>  {
> -    static atomic_t led_seq = ATOMIC_INIT(-1);
>      struct xpad_led *led;
>      struct led_classdev *led_cdev;
>      int error;
> @@ -972,9 +983,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
>      if (!led)
>          return -ENOMEM;
> 
> -    xpad->pad_nr = atomic_inc_return(&led_seq);
> -
> -    snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->pad_nr);
> +    snprintf(led->name, sizeof(led->name), "xpad%d", xpad->pad_nr);

So the name is always "xpad0"? Have you tested with more than 1 pad?

I'll fix it all up. The place where you get the new ID us the wrong
place, you needed to do it right here.

>      led->xpad = xpad;
> 
>      led_cdev = &led->led_cdev;
> @@ -1132,6 +1141,8 @@ static int xpad_init_input(struct usb_xpad *xpad)
>              xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
>      }
> 
> +    xpad_identify_controller(xpad);
> +
>      error = xpad_init_ff(xpad);
>      if (error)
>          goto fail_init_ff;
> @@ -1144,8 +1155,6 @@ static int xpad_init_input(struct usb_xpad *xpad)
>      if (error)
>          goto fail_input_register;
> 
> -    xpad_identify_controller(xpad);
> -
>      return 0;
> 
>  fail_input_register:
> @@ -1305,6 +1314,13 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
>  {
>      xpad_led_disconnect(xpad);
>      input_unregister_device(xpad->dev);
> +
> +    if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
> +        return;
> +
> +    if(xpad->pad_nr > -1) {
> +        ida_simple_remove(&xpad_pad_seq, xpad->pad_nr);
> +    }
>  }
> 
>  static void xpad_disconnect(struct usb_interface *intf)
> -- 
> 1.9.1
> 

-- 
Dmitry
