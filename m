From: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH 2/3] Input: tsc2007 - correctly report pressure and not resistance to user space
Date: Mon, 20 Feb 2017 17:56:35 +0100
Message-ID: <9e249276be9e20aab1a74617373bf6587f1acd4b.1487609795.git.hns@goldelico.com>
References: <cover.1487609795.git.hns@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1487609795.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
In-Reply-To: <cover.1487609795.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
References: <cover.1487609795.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

previously, tsc2007 will report as ABS_PRESSURE:
0              for no pressure (resistance infinite)
high value     for soft pressure (high resistance)
low value      for firm pressure (lower resistance)

This does not matter for most applications (e.g. GUI, Menu, Scrolling
etc.) where the ABS_PRESSURE is ignored and only BTN_TOUCH is processed
to detect screen taps.

Only some special graphics applications read the pressure channel and
they will be mixed up by this non-monotonic relation.

So we fix it to become:
0              for no pressure (resistance infinite)
low value      for soft pressure (high resistance)
high value     for firm pressure (lower resistance)

While this patch changes the values reported to userspace,
ABS_PRESSURE is used rarely by userspace. Most software only
relies on BTN_TOUCH (boolean), which is not affected by this
patch. Some graphics software makes use of the interface and
does not work correctly with the currently used inverted
behaviour.

Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---
 drivers/input/touchscreen/tsc2007_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index 30b53ca..fc73849 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -141,6 +141,8 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 				"DOWN point(%4d,%4d), resistance (%4u)\n",
 				tc.x, tc.y, rt);
 
+			rt = ts->max_rt - rt;
+
 			input_report_key(input, BTN_TOUCH, 1);
 			input_report_abs(input, ABS_X, tc.x);
 			input_report_abs(input, ABS_Y, tc.y);
-- 
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
