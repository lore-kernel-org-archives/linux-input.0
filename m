From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 1/3] Input: Add new property INPUT_PROP_COMPOSITE
Date: Fri, 18 Aug 2017 13:24:54 +1000
Message-ID: <20170818032454.GA1254@jelly>
References: <20170818020156.23390-1-roderick@gaikai.com>
 <20170818020156.23390-2-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:41333 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753775AbdHRDZF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 23:25:05 -0400
Content-Disposition: inline
In-Reply-To: <20170818020156.23390-2-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, Aug 17, 2017 at 07:01:54PM -0700, Roderick Colenbrander wrote:
> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> This new property can be set on subdevices part of a composite
> input device. The purpose of the constant is to notify other
> kernel components (e.g. joydev) and user space that a device is
> a composite device.
> 
> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> ---
>  Documentation/input/event-codes.rst    | 12 ++++++++++++
>  include/uapi/linux/input-event-codes.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> index a8c0873..d56a32e 100644
> --- a/Documentation/input/event-codes.rst
> +++ b/Documentation/input/event-codes.rst
> @@ -356,6 +356,18 @@ can report through the rotational axes (absolute and/or relative rx, ry, rz).
>  All other axes retain their meaning. A device must not mix
>  regular directional axes and accelerometer axes on the same event node.
>  
> +INPUT_PROP_COMPOSITE
> +--------------------
> +
> +The functionality of some advanced input devices is exposed through several
> +event devices. For example a gamepad with motion sensors could be exposed as
> +a gamepad device with axes / buttons and a separate motion sensor device.
> +
> +The INPUT_PROP_COMPOSITE flag is set on all sub devices making up a larger
> +composite device. This flag allows user space applications in addition to
> +other kernel drivers (e.g. joydev) to easily determine whether a device
> +is part of a composite device.

honestly, I would love for this to be paired with an ioctl that can give me
the sysnames of the other devices. Or (probably safer) just a unique
number/string that all composite devices share.

That way I can reassemble this in userspace. We already do something like
this for the libinput device groups and I think just having the input
property isn't quite enough. We can already guess a lot of this from the
PHYS attributes but there are several devices where having this filled by
the kernel is going to be useful. Wacom devices for example where the pen
and touch device don't share the same pid.

Right now, it's a bit too simple - all this flag gives me is the
notification that I have to start looking for other devices. Works fine with
one composited device connected, but once you look at more than that it
doesn't seem to be overly useful.

Cheers,
   Peter


> +
>  Guidelines
>  ==========
>  
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 1798910..da3fa83 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -26,6 +26,7 @@
>  #define INPUT_PROP_TOPBUTTONPAD		0x04	/* softbuttons at top of pad */
>  #define INPUT_PROP_POINTING_STICK	0x05	/* is a pointing stick */
>  #define INPUT_PROP_ACCELEROMETER	0x06	/* has accelerometer */
> +#define INPUT_PROP_COMPOSITE		0x07	/* is part of a composite device */
>  
>  #define INPUT_PROP_MAX			0x1f
>  #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
> -- 
> 2.9.4
