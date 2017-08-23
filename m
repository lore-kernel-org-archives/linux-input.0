From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 3/3] Input: joydev - ignore accelerometer devices
Date: Wed, 23 Aug 2017 10:45:37 +0200
Message-ID: <1503477937.24498.8.camel@hadess.net>
References: <20170818020156.23390-1-roderick@gaikai.com>
         <20170818020156.23390-4-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42087 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753601AbdHWIpk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Aug 2017 04:45:40 -0400
In-Reply-To: <20170818020156.23390-4-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, 2017-08-17 at 19:01 -0700, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Gamepads like DualShock 3 / 4 as of 4.12 started reporting motion
> sensors on a separate evdev node. Joydev is picking these devices
> up as well, but they don't make sense for the joydev interface.
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> ---
>  drivers/input/joydev.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 29d677c..9b70fe0 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -819,6 +819,11 @@ static bool joydev_match(struct input_handler
> *handler, struct input_dev *dev)
>  	if (joydev_dev_is_absolute_mouse(dev))
>  		return false;
>  
> +	/* Avoid accelerometers on composite devices. */
> +	if (test_bit(INPUT_PROP_ACCELEROMETER, dev->propbit) &&
> +	    test_bit(INPUT_PROP_COMPOSITE, dev->propbit))
> +		return false;

I don't understand how making a laptop's builtin hard-drive drop sensor
into a joystick device is acceptable, but the same device inside an
external joypad isn't.

Either all accelerometers are blocked through this interface, or none
are.
