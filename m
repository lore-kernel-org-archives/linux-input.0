From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Subject: [PATCH v6 2/9] i2c: add helpers to ease DMA handling
Date: Sat,  4 Nov 2017 21:20:02 +0100
Message-ID: <20171104202009.3818-3-wsa+renesas@sang-engineering.com>
References: <20171104202009.3818-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171104202009.3818-1-wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

One helper checks if DMA is suitable and optionally creates a bounce
buffer, if not. The other function returns the bounce buffer and makes
sure the data is properly copied back to the message.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
---
 drivers/i2c/i2c-core-base.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/i2c.h         |  3 +++
 2 files changed, 49 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 706164b4c5be46..de1850bd440659 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2261,6 +2261,52 @@ void i2c_put_adapter(struct i2c_adapter *adap)
 }
 EXPORT_SYMBOL(i2c_put_adapter);
 
+/**
+ * i2c_get_dma_safe_msg_buf() - get a DMA safe buffer for the given i2c_msg
+ * @msg: the message to be checked
+ * @threshold: the minimum number of bytes for which using DMA makes sense
+ *
+ * Return: NULL if a DMA safe buffer was not obtained. Use msg->buf with PIO.
+ *	   Or a valid pointer to be used with DMA. After use, release it by
+ *	   calling i2c_release_dma_safe_msg_buf().
+ *
+ * This function must only be called from process context!
+ */
+u8 *i2c_get_dma_safe_msg_buf(struct i2c_msg *msg, unsigned int threshold)
+{
+	if (msg->len < threshold)
+		return NULL;
+
+	if (msg->flags & I2C_M_DMA_SAFE)
+		return msg->buf;
+
+	pr_debug("using bounce buffer for addr=0x%02x, len=%d\n",
+		 msg->addr, msg->len);
+
+	if (msg->flags & I2C_M_RD)
+		return kzalloc(msg->len, GFP_KERNEL);
+	else
+		return kmemdup(msg->buf, msg->len, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(i2c_get_dma_safe_msg_buf);
+
+/**
+ * i2c_release_dma_safe_msg_buf - release DMA safe buffer and sync with i2c_msg
+ * @msg: the message to be synced with
+ * @buf: the buffer obtained from i2c_get_dma_safe_msg_buf(). May be NULL.
+ */
+void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf)
+{
+	if (!buf || buf == msg->buf)
+		return;
+
+	if (msg->flags & I2C_M_RD)
+		memcpy(msg->buf, buf, msg->len);
+
+	kfree(buf);
+}
+EXPORT_SYMBOL_GPL(i2c_release_dma_safe_msg_buf);
+
 MODULE_AUTHOR("Simon G. Vogl <simon-nD9nYVNVf00W+b/DJNNodF6hYfS7NtTn@public.gmane.org>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 0f774406fad0e4..a0b57de91e21d3 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -769,6 +769,9 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
 	return (msg->addr << 1) | (msg->flags & I2C_M_RD ? 1 : 0);
 }
 
+u8 *i2c_get_dma_safe_msg_buf(struct i2c_msg *msg, unsigned int threshold);
+void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf);
+
 int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
 /**
  * module_i2c_driver() - Helper macro for registering a modular I2C driver
-- 
2.11.0
