From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH v3 3/4] driver core: add dev_print_hex_dump() logging function.
Date: Tue, 26 Mar 2019 18:48:06 -0700
Message-ID: <20190327014807.7472-4-ronald@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327014807.7472-1-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is the dev_xxx() analog to print_hex_dump(), using dev_printk()
instead of straight printk() to match other dev_xxx() logging functions.
---
 drivers/base/core.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h | 15 +++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 0073b09bb99f..eb260d482750 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3097,6 +3097,49 @@ define_dev_printk_level(_dev_warn, KERN_WARNING);
 define_dev_printk_level(_dev_notice, KERN_NOTICE);
 define_dev_printk_level(_dev_info, KERN_INFO);
 
+static void
+print_to_dev_printk(const char *level, void *arg, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+
+	vaf.fmt = fmt;
+	vaf.va = &args;
+
+	__dev_printk(level, (const struct device *)arg, &vaf);
+
+	va_end(args);
+}
+
+/**
+ * _dev_print_hex_dump - print a text hex dump to syslog for a binary blob of
+ * data
+ * @level: kernel log level (e.g. KERN_DEBUG)
+ * @dev: the device to which this log message pertains
+ * @prefix_str: string to prefix each line with;
+ *  caller supplies trailing spaces for alignment if desired
+ * @prefix_type: controls whether prefix of an offset, address, or none
+ *  is printed (%DUMP_PREFIX_OFFSET, %DUMP_PREFIX_ADDRESS, %DUMP_PREFIX_NONE)
+ * @rowsize: number of bytes to print per line; must be 16 or 32
+ * @groupsize: number of bytes to print at a time (1, 2, 4, 8; default = 1)
+ * @buf: data blob to dump
+ * @len: number of bytes in the @buf
+ * @ascii: include ASCII after the hex output
+ *
+ * See print_hex_dump() for additional details and examples.
+ */
+void _dev_print_hex_dump(const char *level, const struct device *dev,
+			 const char *prefix_str, int prefix_type,
+			 int rowsize, int groupsize,
+			 const void *buf, size_t len, bool ascii)
+{
+	print_hex_dump_to_cb(level, prefix_str, prefix_type, rowsize, groupsize,
+			     buf, len, ascii, print_to_dev_printk, (void *)dev);
+}
+EXPORT_SYMBOL(_dev_print_hex_dump);
+
 #endif
 
 static inline bool fwnode_is_primary(struct fwnode_handle *fwnode)
diff --git a/include/linux/device.h b/include/linux/device.h
index 6cb4640b6160..dc6fcae3002a 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1405,6 +1405,10 @@ __printf(2, 3)
 void _dev_notice(const struct device *dev, const char *fmt, ...);
 __printf(2, 3)
 void _dev_info(const struct device *dev, const char *fmt, ...);
+void _dev_print_hex_dump(const char *level, const struct device *dev,
+			 const char *prefix_str, int prefix_type,
+			 int rowsize, int groupsize,
+			 const void *buf, size_t len, bool ascii);
 
 #else
 
@@ -1445,6 +1449,12 @@ void _dev_notice(const struct device *dev, const char *fmt, ...)
 static inline __printf(2, 3)
 void _dev_info(const struct device *dev, const char *fmt, ...)
 {}
+static inline
+void _dev_print_hex_dump(const char *level, const struct device *dev,
+			 const char *prefix_str, int prefix_type,
+			 int rowsize, int groupsize,
+			 const void *buf, size_t len, bool ascii);
+{}
 
 #endif
 
@@ -1467,6 +1477,11 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 	_dev_notice(dev, dev_fmt(fmt), ##__VA_ARGS__)
 #define dev_info(dev, fmt, ...)						\
 	_dev_info(dev, dev_fmt(fmt), ##__VA_ARGS__)
+#define dev_print_hex_dump(level, dev, prefix_str, prefix_type,		\
+			   rowsize, groupsize, buf, len, ascii)		\
+	_dev_print_hex_dump(level, dev, dev_fmt(prefix_str),		\
+			    prefix_type, rowsize, groupsize, buf, len,	\
+			    ascii);
 
 #if defined(CONFIG_DYNAMIC_DEBUG)
 #define dev_dbg(dev, fmt, ...)						\
-- 
2.20.1
