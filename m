From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/4] input: touchscreen: Add generic touchscreen softbutton support
Date: Sun, 31 Jul 2016 17:23:06 +0200
Message-ID: <1469978590-14081-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Some touchscreens extend over the display they cover and have a number
of capacative softbuttons outside of the display the cover.

With some hardware these softbuttons simply report touches with
coordinates outside of the normal coordinate space for touches on the
display.

This patch-series adds some generic helper code for supporting such
setups, including support for triggering a led as visual feedback that
a softbutton has been touched.

It also uses the generic helpers to add softbutton support to the
edt-ft5x06 driver.

Can you please review patches 1-3 and if they are to your liking merge
them ?

Note patch 4 is included mostly as illustration how this all can be used,
I will submit that to the sunxi dt maintainers once the input bits have
been merged.

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
