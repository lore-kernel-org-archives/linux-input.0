From: Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
Subject: [PATCH v2 1/5] i8042: intel-8042 DT documentation
Date: Fri, 13 Feb 2015 22:52:49 +0300
Message-ID: <1423857173-16432-2-git-send-email-v1ron@v1ros.org>
References: <20150203011051.11999a16@v1ron-s7>
 <1423857173-16432-1-git-send-email-v1ron@v1ros.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423857173-16432-1-git-send-email-v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Documentation for 'intel,8042' DT compatible node.

Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
Signed-off-by: Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
---
 .../devicetree/bindings/input/intel-8042.txt       | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/intel-8042.txt

diff --git a/Documentation/devicetree/bindings/input/intel-8042.txt b/Documentation/devicetree/bindings/input/intel-8042.txt
new file mode 100644
index 0000000..ab8a3e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/intel-8042.txt
@@ -0,0 +1,26 @@
+Intel 8042 Keyboard Controller
+
+Required properties:
+- compatible: should be "intel,8042"
+- regs: memory for keyboard controller
+- interrupts: usually, two interrupts should be specified (keyboard and aux).
+	However, only one interrupt is also allowed in case of absence of the
+	physical port in the controller. The i8042 driver must be loaded with
+	nokbd/noaux option in this case.
+- interrupt-names: interrupt names corresponding to numbers in the list.
+	"kbd" is the keyboard interrupt and "aux" is the auxiliary (mouse)
+	interrupt.
+- command-reg: offset in memory for command register
+- status-reg: offset in memory for status register
+- data-reg: offset in memory for data register
+
+Example:
+	i8042@d8008800 {
+		compatible = "intel,8042";
+		regs = <0xd8008800 0x100>;
+		interrupts = <23>, <4>;
+		interrupt-names = "kbd", "aux";
+		command-reg = <0x04>;
+		status-reg = <0x04>;
+		data-reg = <0x00>;
+	};
-- 
2.3.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
