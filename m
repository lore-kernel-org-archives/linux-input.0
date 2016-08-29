From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: input: touchscreen: silead_gsl1680: Document firmware-name, fix implementation
Date: Mon, 29 Aug 2016 21:29:35 +0200
Message-ID: <20160829192937.32129-1-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi All,

As discussed here is a patch to update the gsl1680 driver binding
doc to document the usage of firmware-name for specifying which
firmware to load.

Since the driver as merged in 4.8-rc1 uses touchscreen-fw-name,
this patch also updates the driver and moves the addition of the
"silead/" prefix to the driver instead of having to specify
the prefix in the dt.

I've also added a second patch to also prefix the default /
fallback firmware-names with "silead/".

Dmitry, since no kernel has been released with the old firmware names
yet, it would be good if we can get both of these merged as a fix
to 4.8, so that no one can end up depending on the old behavior.

Thanks & Regards,

Hans

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
