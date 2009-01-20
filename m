From: Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: [PATCH 3/3] ati_remote2: Check module params
Date: Tue, 20 Jan 2009 21:00:35 +0200
Message-ID: <1232478035-20172-3-git-send-email-syrjala@sci.fi>
References: <1232478035-20172-1-git-send-email-syrjala@sci.fi>
 <1232478035-20172-2-git-send-email-syrjala@sci.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1232478035-20172-2-git-send-email-syrjala-ORSVBvAovxo@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Validate that the values of the module parameters are within the
supported range. Also print the values in hex since that seems like
a better match for bitmasks than decimal.

Signed-off-by: Ville Syrjala <syrjala-ORSVBvAovxo@public.gmane.org>
---
 drivers/input/misc/ati_remote2.c |   64 +++++++++++++++++++++++++++++++++++--
 1 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 39e0ecd..efb0c5b 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -36,12 +36,68 @@ enum {
 	ATI_REMOTE2_MAX_MODE_MASK = 0x1F,
 };
 
+static int ati_remote2_set_mask(const char *val,
+				struct kernel_param *kp, unsigned int max)
+{
+	unsigned long mask;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = strict_strtoul(val, 0, &mask);
+	if (ret)
+		return ret;
+
+	if (mask & ~max)
+		return -EINVAL;
+
+	*(unsigned int *)kp->arg = mask;
+
+	return 0;
+}
+
+static int ati_remote2_set_channel_mask(const char *val,
+					struct kernel_param *kp)
+{
+	pr_debug("%s()\n", __func__);
+
+	return ati_remote2_set_mask(val, kp, ATI_REMOTE2_MAX_CHANNEL_MASK);
+}
+
+static int ati_remote2_get_channel_mask(char *buffer, struct kernel_param *kp)
+{
+	pr_debug("%s()\n", __func__);
+
+	return sprintf(buffer, "0x%04x", *(unsigned int *)kp->arg);
+}
+
+static int ati_remote2_set_mode_mask(const char *val, struct kernel_param *kp)
+{
+	pr_debug("%s()\n", __func__);
+
+	return ati_remote2_set_mask(val, kp, ATI_REMOTE2_MAX_MODE_MASK);
+}
+
+static int ati_remote2_get_mode_mask(char *buffer, struct kernel_param *kp)
+{
+	pr_debug("%s()\n", __func__);
+
+	return sprintf(buffer, "0x%02x", *(unsigned int *)kp->arg);
+}
+
 static unsigned int channel_mask = ATI_REMOTE2_MAX_CHANNEL_MASK;
-module_param(channel_mask, uint, 0644);
+#define param_check_channel_mask(name, p) __param_check(name, p, unsigned int)
+#define param_set_channel_mask ati_remote2_set_channel_mask
+#define param_get_channel_mask ati_remote2_get_channel_mask
+module_param(channel_mask, channel_mask, 0644);
 MODULE_PARM_DESC(channel_mask, "Bitmask of channels to accept <15:Channel16>...<1:Channel2><0:Channel1>");
 
 static unsigned int mode_mask = ATI_REMOTE2_MAX_MODE_MASK;
-module_param(mode_mask, uint, 0644);
+#define param_check_mode_mask(name, p) __param_check(name, p, unsigned int)
+#define param_set_mode_mask ati_remote2_set_mode_mask
+#define param_get_mode_mask ati_remote2_get_mode_mask
+module_param(mode_mask, mode_mask, 0644);
 MODULE_PARM_DESC(mode_mask, "Bitmask of modes to accept <4:PC><3:AUX4><2:AUX3><1:AUX2><0:AUX1>");
 
 static struct usb_device_id ati_remote2_id_table[] = {
@@ -722,8 +778,8 @@ static int ati_remote2_probe(struct usb_interface *interface, const struct usb_d
 	if (r)
 		goto fail2;
 
-	ar2->channel_mask = channel_mask & ATI_REMOTE2_MAX_CHANNEL_MASK;
-	ar2->mode_mask = mode_mask & ATI_REMOTE2_MAX_MODE_MASK;
+	ar2->channel_mask = channel_mask;
+	ar2->mode_mask = mode_mask;
 
 	r = ati_remote2_setup(ar2, ar2->channel_mask);
 	if (r)
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
