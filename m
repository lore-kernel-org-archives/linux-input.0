From: Sebastian Schmidt <yath@yath.de>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Mon, 8 Jan 2018 16:11:01 +0100
Message-ID: <20180108151101.GA2220@marax.lan.yath.de>
References: <20171230152213.GA2099@marax.lan.yath.de>
 <dcfb84c8-4ad8-8276-5451-ee91fc84f742@canonical.com>
 <20171231082646.GC25965@kroah.com>
 <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com>
 <20180102070811.p7gfaq3vr55sdbd3@dtor-ws>
 <ac087ae7-54d4-d038-daa7-048c87368d17@canonical.com>
 <20180105005659.j2x56opkq74wm7v2@dtor-ws>
 <598ac534-ed9b-1377-70c5-eec7b7521755@canonical.com>
 <20180105162313.higyrbd6unumgtjb@dtor-ws>
 <20180107065201.q2xck62unijt3avr@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from karr.yath.de ([144.76.4.50]:38028 "EHLO karr.yath.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755993AbeAHPLJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 8 Jan 2018 10:11:09 -0500
Content-Disposition: inline
In-Reply-To: <20180107065201.q2xck62unijt3avr@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Aaron Ma <aaron.ma@canonical.com>, Greg KH <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org

Hi Dmitry,

On Sat, Jan 06, 2018 at 10:52:01PM -0800, Dmitry Torokhov wrote:
> Guys, could you please try the patch below? It will not solve the
> "speed" issue on 0x01 devices, but hopefully we won't be exposing
> non-existing controls on others.

Thanks for looking into this. Which speed issue on 0x01 devices? I
thought those were the legacy ones that used to work and still do as
ever.

I've tried your (slightly modified, see below) patch and the trackpoint
now gets apparently[1] correctly detected as "psmouse serio2:
trackpoint: Elan TrackPoint firmware: 0x04, buttons: 3/3". However, I
still have the feeling that it's a lot more sensitive (or faster?) than
with the regular PS/2 driver - even with libinput accel speed turned to
-1. I don't know how I could measure this objectively, but there must be
some difference between the trackpoint driver and the regular one. Is it
maybe an init sequence that causes it to report more sensitively, or a
different resolution, or ...? I really have no idea how mice work. :)

Also, I'm wondering, since my trackpoint works just fine as "Generic
PS/2 Mouse", including the third button. The driver even says:
| /*
|  * Bare PS/2 protocol "detection". Always succeeds.
|  */
| static int ps2bare_detect(struct psmouse *psmouse, bool set_properties)
| {
| [...]
|         /*
|          * We have no way of figuring true number of buttons so let's
|          * assume that the device has 3.
|          */
|         __set_bit(BTN_MIDDLE, psmouse->dev->keybit);
|     }
| 
|     return 0;
| }

So I wonder what driver Aaron was using that didn't report a third
button. What vendor/firmwares did you (get reports of) have that middle
mouse button problem on, Aaron?

Thanks,

Sebastian


1: If it's actually Elan. I've taken out my battery but could only
find FRU numbers on the back of the keyboard, no signs of a vendor.
<https://photos.app.goo.gl/iafpfzvRY042dOBo2> or
<https://t.yath.de/IMG_20180108_143205.jpg>

In trackpoint_start_protocol:
> +   switch (param[0]) {
> +   case TP_VARIANT_IBM:
> +   case TP_VARIANT_ALPS:
> +   case TP_VARIANT_ELAN:
> +   case TP_VARIANT_NXP:
> +       if (variant_id)
> +           *variant_id = param[0];
> +       if (firmware_id)
> +           *firmware_id = param[1];
> +       break;
          ^^^^^
          That should be a return 0.
> +   }
> 
> -   return 0;
> +   return -ENODEV;
>  }
