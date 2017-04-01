From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 15/33] docs: input/gpio-tilt: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:58 -0300
Message-ID: <d02fc4145bff1d73e28317d1bfadeab9394a59cf.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
 <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
 <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
 <c1c2d69dddb0f6281452ee3a4db7023c5adbe9a0.1491069870.git.mchehab@s-opensource.com>
 <d3aeee7338003eb50db47a510e4f523d800bcf8c.1491069870.git.mchehab@s-opensource.com>
 <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
 <ccecd15f5c80b96476fd41c046b19efc9cba28d5.1491069870.git.mchehab@s-opensource.com>
 <0b3e07c981ca9c1e5ac466704bbc96a4bb91b136.1491069870.git.mchehab@s-opensource.com>
 <6af7af2b604dc23c6a1000ec7619f4428622fc7a.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <6af7af2b604dc23c6a1000ec7619f4428622fc7a.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/gpio-tilt.txt | 124 +++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/Documentation/input/gpio-tilt.txt b/Documentation/input/gpio-tilt.txt
index 2cdfd9bcb1af..23de9eff6a34 100644
--- a/Documentation/input/gpio-tilt.txt
+++ b/Documentation/input/gpio-tilt.txt
@@ -28,76 +28,76 @@ Example:
 --------
 
 Example configuration for a single TS1003 tilt switch that rotates around
-one axis in 4 steps and emits the current tilt via two GPIOs.
+one axis in 4 steps and emits the current tilt via two GPIOs::
 
-static int sg060_tilt_enable(struct device *dev) {
-	/* code to enable the sensors */
-};
+    static int sg060_tilt_enable(struct device *dev) {
+	    /* code to enable the sensors */
+    };
 
-static void sg060_tilt_disable(struct device *dev) {
-	/* code to disable the sensors */
-};
+    static void sg060_tilt_disable(struct device *dev) {
+	    /* code to disable the sensors */
+    };
 
-static struct gpio sg060_tilt_gpios[] = {
-	{ SG060_TILT_GPIO_SENSOR1, GPIOF_IN, "tilt_sensor1" },
-	{ SG060_TILT_GPIO_SENSOR2, GPIOF_IN, "tilt_sensor2" },
-};
+    static struct gpio sg060_tilt_gpios[] = {
+	    { SG060_TILT_GPIO_SENSOR1, GPIOF_IN, "tilt_sensor1" },
+	    { SG060_TILT_GPIO_SENSOR2, GPIOF_IN, "tilt_sensor2" },
+    };
 
-static struct gpio_tilt_state sg060_tilt_states[] = {
-	{
-		.gpios = (0 << 1) | (0 << 0),
-		.axes = (int[]) {
-			0,
-		},
-	}, {
-		.gpios = (0 << 1) | (1 << 0),
-		.axes = (int[]) {
-			1, /* 90 degrees */
-		},
-	}, {
-		.gpios = (1 << 1) | (1 << 0),
-		.axes = (int[]) {
-			2, /* 180 degrees */
-		},
-	}, {
-		.gpios = (1 << 1) | (0 << 0),
-		.axes = (int[]) {
-			3, /* 270 degrees */
-		},
-	},
-};
+    static struct gpio_tilt_state sg060_tilt_states[] = {
+	    {
+		    .gpios = (0 << 1) | (0 << 0),
+		    .axes = (int[]) {
+			    0,
+		    },
+	    }, {
+		    .gpios = (0 << 1) | (1 << 0),
+		    .axes = (int[]) {
+			    1, /* 90 degrees */
+		    },
+	    }, {
+		    .gpios = (1 << 1) | (1 << 0),
+		    .axes = (int[]) {
+			    2, /* 180 degrees */
+		    },
+	    }, {
+		    .gpios = (1 << 1) | (0 << 0),
+		    .axes = (int[]) {
+			    3, /* 270 degrees */
+		    },
+	    },
+    };
 
-static struct gpio_tilt_axis sg060_tilt_axes[] = {
-	{
-		.axis = ABS_RY,
-		.min = 0,
-		.max = 3,
-		.fuzz = 0,
-		.flat = 0,
-	},
-};
+    static struct gpio_tilt_axis sg060_tilt_axes[] = {
+	    {
+		    .axis = ABS_RY,
+		    .min = 0,
+		    .max = 3,
+		    .fuzz = 0,
+		    .flat = 0,
+	    },
+    };
 
-static struct gpio_tilt_platform_data sg060_tilt_pdata= {
-	.gpios = sg060_tilt_gpios,
-	.nr_gpios = ARRAY_SIZE(sg060_tilt_gpios),
+    static struct gpio_tilt_platform_data sg060_tilt_pdata= {
+	    .gpios = sg060_tilt_gpios,
+	    .nr_gpios = ARRAY_SIZE(sg060_tilt_gpios),
 
-	.axes = sg060_tilt_axes,
-	.nr_axes = ARRAY_SIZE(sg060_tilt_axes),
+	    .axes = sg060_tilt_axes,
+	    .nr_axes = ARRAY_SIZE(sg060_tilt_axes),
 
-	.states = sg060_tilt_states,
-	.nr_states = ARRAY_SIZE(sg060_tilt_states),
+	    .states = sg060_tilt_states,
+	    .nr_states = ARRAY_SIZE(sg060_tilt_states),
 
-	.debounce_interval = 100,
+	    .debounce_interval = 100,
 
-	.poll_interval = 1000,
-	.enable = sg060_tilt_enable,
-	.disable = sg060_tilt_disable,
-};
+	    .poll_interval = 1000,
+	    .enable = sg060_tilt_enable,
+	    .disable = sg060_tilt_disable,
+    };
 
-static struct platform_device sg060_device_tilt = {
-	.name = "gpio-tilt-polled",
-	.id = -1,
-	.dev = {
-		.platform_data = &sg060_tilt_pdata,
-	},
-};
+    static struct platform_device sg060_device_tilt = {
+	    .name = "gpio-tilt-polled",
+	    .id = -1,
+	    .dev = {
+		    .platform_data = &sg060_tilt_pdata,
+	    },
+    };
-- 
2.9.3


