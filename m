From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 15/33] docs: input/gpio-tilt: convert it to ReST format
Date: Tue,  4 Apr 2017 07:52:25 -0300
Message-ID: <b46575603db084d1b32b83a4fc455551207f11ad.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491302719.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491302719.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491302719.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491302719.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491302719.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491302719.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491302719.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491302719.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491302719.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491302719.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491302719.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491302719.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491302719.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491302719.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <9b1b818d7cde485713aced6b077f0e276a24bddd.1491302719.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
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


