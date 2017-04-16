From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/8] Input: rotary-encoder - remove references to platform data from docs
Date: Sat, 15 Apr 2017 22:11:39 -0700
Message-ID: <20170416051145.13618-2-dmitry.torokhov@gmail.com>
References: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-input@vger.kernel.org

The driver has been converted to use generic device properties, so
stop referring to platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/input/rotary-encoder.rst | 85 ++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/Documentation/input/rotary-encoder.rst b/Documentation/input/rotary-encoder.rst
index 4695bea67f9b..b07b20a295ac 100644
--- a/Documentation/input/rotary-encoder.rst
+++ b/Documentation/input/rotary-encoder.rst
@@ -81,48 +81,51 @@ Board integration
 
 To use this driver in your system, register a platform_device with the
 name 'rotary-encoder' and associate the IRQs and some specific platform
-data with it.
+data with it. Because the driver uses generic device properties, this can
+be done either via device tree, ACPI, or using static board files, like in
+example below:
 
-struct rotary_encoder_platform_data is declared in
-include/linux/rotary-encoder.h and needs to be filled with the number of
-steps the encoder has and can carry information about externally inverted
-signals (because of an inverting buffer or other reasons). The encoder
-can be set up to deliver input information as either an absolute or relative
-axes. For relative axes the input event returns +/-1 for each step. For
-absolute axes the position of the encoder can either roll over between zero
-and the number of steps or will clamp at the maximum and zero depending on
-the configuration.
+::
 
-Because GPIO to IRQ mapping is platform specific, this information must
-be given in separately to the driver. See the example below.
+	/* board support file example */
 
-::
+	#include <linux/input.h>
+	#include <linux/gpio/machine.h>
+	#include <linux/property.h>
+
+	#define GPIO_ROTARY_A 1
+	#define GPIO_ROTARY_B 2
+
+	static struct gpiod_lookup_table rotary_encoder_gpios = {
+		.dev_id = "rotary-encoder.0",
+		.table = {
+			GPIO_LOOKUP_IDX("gpio-0",
+					GPIO_ROTARY_A, NULL, 0, GPIO_ACTIVE_LOW),
+			GPIO_LOOKUP_IDX("gpio-0",
+					GPIO_ROTARY_B, NULL, 1, GPIO_ACTIVE_HIGH),
+			{ },
+		},
+	};
+
+	static const struct property_entry rotary_encoder_properties[] __initconst = {
+		PROPERTY_ENTRY_INTEGER("rotary-encoder,steps-per-period", u32, 24),
+		PROPERTY_ENTRY_INTEGER("linux,axis",			  u32, ABS_X),
+		PROPERTY_ENTRY_INTEGER("rotary-encoder,relative_axis",	  u32, 0),
+		{ },
+	};
+
+	static struct platform_device rotary_encoder_device = {
+		.name		= "rotary-encoder",
+		.id		= 0,
+	};
+
+	...
+
+	gpiod_add_lookup_table(&rotary_encoder_gpios);
+	device_add_properties(&rotary_encoder_device, rotary_encoder_properties);
+	platform_device_register(&rotary_encoder_device);
+
+	...
 
-    /* board support file example */
-
-    #include <linux/input.h>
-    #include <linux/rotary_encoder.h>
-
-    #define GPIO_ROTARY_A 1
-    #define GPIO_ROTARY_B 2
-
-    static struct rotary_encoder_platform_data my_rotary_encoder_info = {
-	    .steps		= 24,
-	    .axis		= ABS_X,
-	    .relative_axis	= false,
-	    .rollover	= false,
-	    .gpio_a		= GPIO_ROTARY_A,
-	    .gpio_b		= GPIO_ROTARY_B,
-	    .inverted_a	= 0,
-	    .inverted_b	= 0,
-	    .half_period	= false,
-	    .wakeup_source	= false,
-    };
-
-    static struct platform_device rotary_encoder_device = {
-	    .name		= "rotary-encoder",
-	    .id		= 0,
-	    .dev		= {
-		    .platform_data = &my_rotary_encoder_info,
-	    }
-    };
+Please consult device tree binding documentation to see all properties
+supported by the driver.
-- 
2.12.2.762.g0e3151a226-goog
