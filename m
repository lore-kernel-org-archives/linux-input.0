From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] HID: core: Add hid printk_once macros
Date: Mon, 22 Jul 2019 10:11:28 -0700
Message-ID: <95b640fd89baacb0817126ddfb5a762d522eebea.camel@perches.com>
References: <20190722163642.10417-1-stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722163642.10417-1-stillcompiling@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: stillcompiling@gmail.com, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, 2019-07-22 at 10:36 -0600, stillcompiling@gmail.com wrote:
> From: Joshua Clayton <stillcompiling@gmail.com>
> 
> Make available printk_once variants to hid_warn() etc
> 
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>

This seems OK, but I suggest a slightly different style:

> diff --git a/include/linux/hid.h b/include/linux/hid.h
[]
> @@ -1179,4 +1179,23 @@ do {									\
>  #define hid_dbg(hid, fmt, arg...)			\
>  	dev_dbg(&(hid)->dev, fmt, ##arg)
>  
> +#define hid_level_once(level, hid, fmt, arg...)		\
> +	dev_level_once(level, &(hid)->dev, fmt, ##arg)

This one is probably not useful in actual code.

> +#define hid_emerg_once(hid, fmt, arg...)		\
> +	dev_emerg_once(&(hid)->dev, fmt, ##arg)

Even though I introduced those macros originally,
it's now a more common style to use:

#define hid_emerg_once(hid, fmt, ...)				\
	dev_emerg_once(&(hid)->dev, fmt, ##__VA_ARGS__)

etc...

And trivially:

hid_printk, hid_emerg, hid_crit, and hid_alert aren't
used at all and could all be removed.

I'm not sure there is a use case for any of them.

Perhaps:
---
 include/linux/hid.h | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index d770ab1a0479..5d2c4b63954f 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1160,23 +1160,26 @@ do {									\
 		printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);	\
 } while (0)
 
-#define hid_printk(level, hid, fmt, arg...)		\
-	dev_printk(level, &(hid)->dev, fmt, ##arg)
-#define hid_emerg(hid, fmt, arg...)			\
-	dev_emerg(&(hid)->dev, fmt, ##arg)
-#define hid_crit(hid, fmt, arg...)			\
-	dev_crit(&(hid)->dev, fmt, ##arg)
-#define hid_alert(hid, fmt, arg...)			\
-	dev_alert(&(hid)->dev, fmt, ##arg)
-#define hid_err(hid, fmt, arg...)			\
-	dev_err(&(hid)->dev, fmt, ##arg)
-#define hid_notice(hid, fmt, arg...)			\
-	dev_notice(&(hid)->dev, fmt, ##arg)
-#define hid_warn(hid, fmt, arg...)			\
-	dev_warn(&(hid)->dev, fmt, ##arg)
-#define hid_info(hid, fmt, arg...)			\
-	dev_info(&(hid)->dev, fmt, ##arg)
-#define hid_dbg(hid, fmt, arg...)			\
-	dev_dbg(&(hid)->dev, fmt, ##arg)
+#define hid_err(hid, fmt, ...)						\
+	dev_err(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_notice(hid, fmt, ...)					\
+	dev_notice(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_warn(hid, fmt, ...)						\
+	dev_warn(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_info(hid, fmt, ...)						\
+	dev_info(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_dbg(hid, fmt, ...)						\
+	dev_dbg(&(hid)->dev, fmt, ##__VA_ARGS__)
+
+#define hid_err_once(hid, fmt, ...)					\
+	dev_err_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_notice_once(hid, fmt, ...)					\
+	dev_notice_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_warn_once(hid, fmt, ...)					\
+	dev_warn_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_info_once(hid, fmt, ...)					\
+	dev_info_once(&(hid)->dev, fmt, ##__VA_ARGS__)
+#define hid_dbg_once(hid, fmt, ...)					\
+	dev_dbg_once(&(hid)->dev, fmt, ##__VA_ARGS__)
 
 #endif
