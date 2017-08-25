From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 4/4] Input: joydev - ignore devices which don't want
 joydev
Date: Fri, 25 Aug 2017 10:48:28 +0200
Message-ID: <1503650908.12938.8.camel@hadess.net>
References: <20170824231153.8809-1-roderick@gaikai.com>
         <20170824231153.8809-5-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52575 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755009AbdHYIsb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Aug 2017 04:48:31 -0400
In-Reply-To: <20170824231153.8809-5-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, 2017-08-24 at 16:11 -0700, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> Gamepads like DualShock 3 / 4 as of 4.12 started reporting motion
> sensors on a separate evdev node. Joydev is picking these devices
> up as well, but they don't make sense for the joydev interface.

Again, they do make sense, but programs using joydev are unlikely to
see updates any time soon. See the comment for patch 1, this needs to
be reworded.

> This patch leverages INPUT_PROP_JOYDEV_IGNORE to not create joydev
> devices for devices, which don't want them.

"to not create joydev device nodes for devices which don't want it".

> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> ---
>  drivers/input/joydev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 29d677c..a60cfb3 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -819,6 +819,10 @@ static bool joydev_match(struct input_handler
> *handler, struct input_dev *dev)
>  	if (joydev_dev_is_absolute_mouse(dev))
>  		return false;
>  
> +	/* Avoid devices, which don't want to be reported by joydev.
> */
> +	if (test_bit(INPUT_PROP_JOYDEV_IGNORE, dev->propbit))
> +		return false;
> +
>  	return true;
>  }
>  
