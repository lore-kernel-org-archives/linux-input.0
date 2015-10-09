From: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Subject: [PATCH 1/3] input: rotary-encoder: Use of_property_read_bool
Date: Fri,  9 Oct 2015 10:46:54 -0300
Message-ID: <1444398416-3073-2-git-send-email-ezequiel@vanguardiasur.com.ar>
References: <1444398416-3073-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444398416-3073-1-git-send-email-ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ariel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This commit makes uses of_property_read_bool() to read
boolean properties. This is just cosmetic cleanup.

Signed-off-by: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/input/misc/rotary_encoder.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index f27f81ee84ed..15a4cc670a3f 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -174,12 +174,9 @@ static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(struct devic
 	pdata->gpio_b = of_get_gpio_flags(np, 1, &flags);
 	pdata->inverted_b = flags & OF_GPIO_ACTIVE_LOW;
 
-	pdata->relative_axis = !!of_get_property(np,
-					"rotary-encoder,relative-axis", NULL);
-	pdata->rollover = !!of_get_property(np,
-					"rotary-encoder,rollover", NULL);
-	pdata->half_period = !!of_get_property(np,
-					"rotary-encoder,half-period", NULL);
+	pdata->relative_axis = of_property_read_bool(np, "rotary-encoder,relative-axis");
+	pdata->rollover = of_property_read_bool(np, "rotary-encoder,rollover");
+	pdata->half_period = of_property_read_bool(np, "rotary-encoder,half-period");
 
 	return pdata;
 }
-- 
2.5.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
