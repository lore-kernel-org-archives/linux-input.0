Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193979;
	b=keOQHDZzu4QC6AAU8st3Qp6+u71MBjUfrkTNiR5nnlxgI+KlvWn34eXEshSyw5Frd/X1
	 FLUBcYc5mMml7d38FKE+rCIANsQEcWulcnApmmoPEECqzd819lca2CvNOAhjueyzmKuAl
	 3X/UA8+dxsqbnbD6kIwEIACe+2Tm+k20lMkJ33ffZioA+h8jeJgktb10WaTTYhIkVDa18
	 cJgGuXvExUGAbiNJ+HwS27W4TQ7yiyOJMR9ybDkLRL67A6NXrj44WiqB7qyZhl1W2onIG
	 3X+9ihaJMI3wAKnO7GIxkfgpZo286K8Nj2f74ncAysTWw6eNSGjE55AltBJVXlXjXPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193979;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Jxi3KDN9XQT6jQufc10RGkZ8/tK7dfXOzgQAMF2fqcY=;
	b=BGoBAY96TDZqJzALuGYjvvui3g54iR8+vakCh/ewg/D1MxIyyaV3WCxnTHAZ+2U27rSl
	 0IrJaBYMEmvVksr9WTUXAtMamie/eRv5+i0MqvtZR9H0KRpUtITX0GFewgcsAV+JXbwVA
	 jFm34zaJqFaNMmeU2Ugjprky9U7+03+BBjFtiH4Suf1W1MfGrTmlz2PZJebt/8EbdGNlZ
	 WKycCpaZ4Gcq7LAivhRW87Ya1y8Spuvfq02DHPpO8mYK2y+s4+I9nTb5vm90JD6uGPkqb
	 1/znooklYG3rHgEjLQM+QQWhsj8twNte1qtNiV7aLQYNveuhfyTVtae0DcYdQBxhxFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f972YPor;
	arc=none smtp.remote-ip=74.125.229.132
Received: from mail-dl2-f4.google.com (mail-dl2-f4.google.com [74.125.229.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3734606A31A
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 13:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3734606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f972YPor
Received: by mail-dl2-f4.google.com with SMTP id a92af1059eb24-1949fbcbe6cso40449c88.1
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 06:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793193978; x=1793798778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jxi3KDN9XQT6jQufc10RGkZ8/tK7dfXOzgQAMF2fqcY=;
        b=f972YPoragQaUQZRGk6nVtnXeSeGRRZfar2NZTos4ajrcgwj+ZZleKAUVRsFtprtGS
         Z0bd94LfyFcvkOxy79oBBAgU0tWuPCskc0wnIHVETZ1/t0kbTe3MDDCorogiIwdZr9cF
         kCYSXht91hW/adOwBSGwwX62/CJnBne4/V6QC/pIcH9jGYQn8Cu3DTHNHarED3vfGy+M
         ZkaFQ/GCq7eTsFPt4wxgQju+NrjW+D/an/l8v1aB/yYGH0M+oN5CVWCtXWF9oSA/UJra
         eIv48q/ptld5J20S7HLNAUAJkvJJ4eq79agCnTMHQdSnz8fzzkegMOIWOnx/ol/ASdu0
         AziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793193978; x=1793798778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jxi3KDN9XQT6jQufc10RGkZ8/tK7dfXOzgQAMF2fqcY=;
        b=VVrNvpYztRKymcZ6A67xIJXTSmgvnG7ml59LzSJUO5sika5jJTi7srgw0E/369NWX9
         HcTN1ckaTejtnvkdB/kmg1wrzQDg3HpFjmnierdMe4EPnUrfxJop2UvX85ON8Gl6cZ8C
         7oMQDssXAqxd8Ik168eEF3dwEgSa6ObOzOt1MIo44Mc+1VVYLDoKbvJ539FYYGi4eBUT
         g3iM4Mhg3kMRkJWIx6QrP2OVSWTqjl0fuLhKQRnbbNnvlOpA3j8ZpV69oitFclOQ2CK3
         w+tpgoeQfh1tqQ1K0SOO2nh2iBzjOF+HNpkB8xQ39QY0A07kD9WYoPNydZ8uAVpyOaZr
         XYwQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxxFsoJswh22vo7+pPmCcWQuUAVLe/WmGwL8gsAkyi3QWTTGNcXZ4WVBr5V0mnj1rorVitDC/OcYkBWQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIg3YmcM2b5cP1ZcZ6YONsglusx96za8pjJDxcbx0pw5/JFoLtc
	gOT8fwOdXR4gORGy9e10pCwIQFNyuXcS4fjb18dAJ3srnThymnZ9UWQCGhGcWsbjbb+Qvg==
X-Gm-Gg: AYBFou3pVGhUM+vSxntf4qVNew9GynWQgTgCk2Y9lWaH8NW6LLfCdmuUGjgxsI7c+9t
	y61rpP3xOZ/92esZpPj4H7/Ts5dxrFaUQ5cXjUn55+sBZMq4DMla0vE1QsxWs3ce5vSMffjHsIy
	DJzJ7Jz1KX1MesqbpqGtz+raACCC9Fwy6hT1S4KoEjWiz4RXo5tiqKJg7F1eNzMtYF+/CC/uOFv
	hwC+RXA25Oc+ZLLA8/TOWVNm32HU2Pww10pocXxkqc+04TGB9ECWhKOTLgucX/PBobFpy5WRR8z
	6H6+WnA3vLpHYdohCBfllGqy/CYNjf1O0Ois2eHmRv8/B1JzEB/gOeRZFd/9b2vt5VG7JLJZ0C5
	TxnCdQ/aW/w9drRd/4FXhkTmpJANLMEVHB9vAea0ar0Jegwq2R/rdjmcIh6DMYZWlEziGY+9pdr
	YWRTdhs+8r6HsCwi+/UXqy37nDu7I+tlfEFEAAhM2jkc2HUmm6bK76xwGzP/FR/SvqJ5DVhCv7j
	c0QMtp8F2M3ceiQkchZzKhIqvEhYJ+qnoCbPb3sJmyIWzklsOPM3kp98qT/V5IQPA5POpHstn4w
	Y7EvO+aJ430GJXBmVr4XfTf49DbkrNlU4stT2NmTIANv7yW8wAAp26aqfchCoR2mgOfZ
X-Received: by 2002:a05:7022:3b8d:b0:144:c128:4c4b with SMTP id a92af1059eb24-1a6cfde6ed5mr3356925c88.36.1793193977380;
        Wed, 28 Oct 2026 06:26:17 -0700 (PDT)
Received: from toolbx (2607-8700-5500-3d9a-0000-0000-0000-0003.16clouds.com. [2607:8700:5500:3d9a::3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c814aa1sm10708639c88.7.2026.10.28.06.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:26:16 -0700 (PDT)
From: ZiAo Wang <ziaowang2007@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>,
	ZiAo Wang <ziaowang2007@gmail.com>
Subject: [PATCH 3/3] drm/tiny: add driver for Valkyrie USB LCD displays
Date: Wed, 28 Oct 2026 21:25:36 +0800
Message-ID: <20261028132536.375927-4-ziaowang2007@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028132536.375927-1-ziaowang2007@gmail.com>
References: <20261028132536.375927-1-ziaowang2007@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Valkyrie USB LCD displays rely on vendor-specific Windows software
to display images and do not expose a standard display interface,
preventing them from being used as regular displays on Linux.

Add a DRM/KMS driver developed from scratch by reverse-engineering
the vendor's software and USB protocol. The driver exposes these
devices as standard DRM display outputs with fixed native modes,
initially supporting the 320x240 and 360x960 variants.

The driver initializes and controls the displays through USB
control transfers, and converts and streams framebuffer contents
as UYVY data over a USB bulk OUT endpoint in chunks of up to
65536 bytes.

Use GEM shmem buffers and atomic modesetting to integrate with
the DRM subsystem, and provide fbdev emulation for compatibility
with legacy framebuffer applications.

Signed-off-by: ZiAo Wang <ziaowang2007@gmail.com>
---
 MAINTAINERS                         |    7 +
 drivers/gpu/drm/tiny/Kconfig        |   15 +
 drivers/gpu/drm/tiny/Makefile       |    1 +
 drivers/gpu/drm/tiny/valkyrie-lcd.c | 1413 +++++++++++++++++++++++++++
 4 files changed, 1436 insertions(+)
 create mode 100644 drivers/gpu/drm/tiny/valkyrie-lcd.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 365bec8eb7..1b91f813bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8815,6 +8815,13 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/udl/
 
+DRM DRIVER FOR VALKYRIE USB LCD DISPLAYS
+M:	ZiAo Wang <ziaowang2007@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	drivers/gpu/drm/tiny/valkyrie-lcd.c
+
 DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
 M:	Louis Chauvet <louis.chauvet@bootlin.com>
 R:	Haneen Mohammed <hamohammed.sa@gmail.com>
diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index f0e72d4b6a..1e4be6d72c 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -98,6 +98,21 @@ config DRM_PIXPAPER
 
 	  If M is selected, the module will be built as pixpaper.ko.
 
+config DRM_VALKYRIE_LCD
+	tristate "DRM support for Valkyrie USB LCDs"
+	depends on DRM && USB && MMU
+	select DRM_CLIENT_SELECTION
+	select DRM_KMS_HELPER
+	select DRM_GEM_SHMEM_HELPER
+	help
+	  Enable support for Valkyrie USB LCD displays with USB ID 345f:9132.
+	  The driver provides DRM/KMS output for the 320x240 and 360x960
+	  display variants. It supports native UYVY and software-converted
+	  XRGB8888 framebuffers.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called valkyrie-lcd.
+
 config TINYDRM_HX8357D
 	tristate "DRM support for HX8357D display panels"
 	depends on DRM && SPI
diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
index 48d30bf615..e768abb4dc 100644
--- a/drivers/gpu/drm/tiny/Makefile
+++ b/drivers/gpu/drm/tiny/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_DRM_CIRRUS_QEMU)		+= cirrus-qemu.o
 obj-$(CONFIG_DRM_GM12U320)		+= gm12u320.o
 obj-$(CONFIG_DRM_PANEL_MIPI_DBI)	+= panel-mipi-dbi.o
 obj-$(CONFIG_DRM_PIXPAPER)              += pixpaper.o
+obj-$(CONFIG_DRM_VALKYRIE_LCD)		+= valkyrie-lcd.o
 obj-$(CONFIG_TINYDRM_HX8357D)		+= hx8357d.o
 obj-$(CONFIG_TINYDRM_ILI9163)		+= ili9163.o
 obj-$(CONFIG_TINYDRM_ILI9225)		+= ili9225.o
diff --git a/drivers/gpu/drm/tiny/valkyrie-lcd.c b/drivers/gpu/drm/tiny/valkyrie-lcd.c
new file mode 100644
index 0000000000..6478e92462
--- /dev/null
+++ b/drivers/gpu/drm/tiny/valkyrie-lcd.c
@@ -0,0 +1,1413 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/mutex.h>
+#include <linux/stddef.h>
+#include <linux/math.h>
+#include <linux/gfp_types.h>
+#include <linux/minmax.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/jiffies.h>
+#include <linux/unaligned.h>
+#include <linux/container_of.h>
+#include <linux/array_size.h>
+#include <linux/delay.h>
+#include <linux/completion.h>
+#include <linux/types.h>
+#include <linux/err.h>
+#include <linux/atomic.h>
+#include <linux/lockdep.h>
+
+#include <linux/usb.h>
+#include <linux/usb/ch9.h>
+#include <linux/hid.h>
+#include <linux/hiddev.h>
+
+#include <drm/drm_drv.h>
+#include <drm/drm_device.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_print.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_probe_helper.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_framebuffer.h>
+#include <drm/drm_format_helper.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_fbdev_shmem.h>
+#include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_vblank.h>
+#include <drm/drm_vblank_helper.h>
+#include <drm/clients/drm_client_setup.h>
+#include <drm/drm_plane.h>
+#include <drm/drm_crtc.h>
+
+#define VK_VENDOR_ID 0x345f
+#define VK_PRODUCT_ID 0x9132
+
+#define VK_FRAME_EP_NUMBER 0x04
+#define VK_SERIAL_ADDR 0x001fe0
+
+#define VK_A6_POLL_INTERVAL_US 1000
+#define VK_A6_POLL_MAX 100
+
+#define VK_SEND_CHUNK_TIMEOUT 1000
+#define VK_SEND_BUF_SIZE 65536
+
+#define VK_FRAME_FORMAT DRM_FORMAT_UYVY
+
+#define VK_TIMEOUT_FLUSH_INTERVAL_MS 3000
+
+MODULE_AUTHOR("ZiAo Wang");
+MODULE_DESCRIPTION("Valkyrie USB LCD DRM driver");
+MODULE_LICENSE("GPL");
+
+struct vk_lcd_device_info {
+	/* Identification data */
+	u8 serial[32] __nonstring;
+	u8 label_0030[2];
+	u8 label_f000[3];
+
+	/* Panel parameters */
+	u32 width, height, fps;
+	u32 width_mm, height_mm;
+	u16 video_code;
+	u16 complex_switch_addr;
+	u8 complex_switch_mask;
+	bool complex_switch_active_high;
+	u8 frame_header[8], frame_trailer[8];
+};
+
+static const struct vk_lcd_device_info vk_lcd_devices[];
+
+struct vk_driver {
+	struct usb_interface *intf;
+	struct usb_device *dev;
+	struct usb_endpoint_descriptor *frame_epd;
+	const struct vk_lcd_device_info *device_info;
+
+	/* Serializes all USB I/O and protects io_blocking and device_state. */
+	struct mutex io_lock;
+	bool io_blocking;
+	bool device_state;
+
+	struct drm_device drm;
+	bool drm_suspended;
+	struct drm_plane plane;
+	struct drm_encoder encoder;
+	struct vk_crtc_driver *crtc;
+	struct vk_connector_driver *connector;
+};
+
+/* On success, return with io_lock held; on failure, release it. */
+static inline bool vk_io_start(struct vk_driver *drv)
+{
+	mutex_lock(&drv->io_lock);
+	if (drv->io_blocking) {
+		mutex_unlock(&drv->io_lock);
+		return false;
+	}
+	return true;
+}
+
+static inline void vk_io_end(struct vk_driver *drv)
+{
+	lockdep_assert_held(&drv->io_lock);
+	mutex_unlock(&drv->io_lock);
+}
+
+static int vk_probe(struct usb_interface *intf, const struct usb_device_id *id);
+static void vk_disconnect(struct usb_interface *intf);
+static int vk_suspend(struct usb_interface *intf, pm_message_t message);
+static int vk_resume(struct usb_interface *intf);
+static int vk_reset_resume(struct usb_interface *intf);
+static int vk_pre_reset(struct usb_interface *intf);
+static int vk_post_reset(struct usb_interface *intf);
+static const struct usb_device_id vk_usb_ids[] = {
+	{ USB_DEVICE_INTERFACE_NUMBER(VK_VENDOR_ID, VK_PRODUCT_ID, 3) },
+	{}
+};
+MODULE_DEVICE_TABLE(usb, vk_usb_ids);
+
+static struct usb_driver vk_usb_driver = {
+	.name = "valkyrie_lcd",
+	.id_table = vk_usb_ids,
+	.probe = vk_probe,
+	.disconnect = vk_disconnect,
+	.supports_autosuspend = 0,
+	.suspend = vk_suspend,
+	.resume = vk_resume,
+	.reset_resume = vk_reset_resume,
+	.pre_reset = vk_pre_reset,
+	.post_reset = vk_post_reset,
+};
+module_usb_driver(vk_usb_driver);
+
+DEFINE_DRM_GEM_FOPS(vk_drm_fops);
+static struct drm_driver vk_drm_driver = {
+	.name = "valkyrie_lcd",
+	.desc = "Valkyrie LCD DRM driver",
+	.major = 1,
+	.minor = 0,
+	.patchlevel = 0,
+	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
+	DRM_GEM_SHMEM_DRIVER_OPS,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
+	.fops = &vk_drm_fops,
+};
+
+static const u32 vk_plane_formats[] = {
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_UYVY,
+};
+
+static const struct drm_mode_config_funcs vk_mode_config_funcs = {
+	.fb_create = drm_gem_fb_create_with_dirty,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit
+};
+
+static const struct drm_plane_funcs vk_plane_funcs = {
+	.update_plane = drm_atomic_helper_update_plane,
+	.disable_plane = drm_atomic_helper_disable_plane,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+	.destroy = drm_plane_cleanup
+};
+
+static int vk_plane_atomic_check(struct drm_plane *plane,
+				 struct drm_atomic_commit *state);
+static void vk_plane_atomic_update(struct drm_plane *plane,
+				   struct drm_atomic_commit *state)
+{
+	// All work is done in vk_crtc_atomic_flush
+}
+
+static const struct drm_plane_helper_funcs vk_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check = vk_plane_atomic_check,
+	.atomic_update = vk_plane_atomic_update
+};
+
+struct vk_send_chunk {
+	struct urb urb;
+	void *buf;
+	int errno;
+	struct completion flight;
+};
+
+static int vk_send_chunk_init(struct drm_device *drm,
+			      struct vk_send_chunk *chunk)
+{
+	init_completion(&chunk->flight);
+	usb_init_urb(&chunk->urb);
+	chunk->buf = drmm_kzalloc(drm, VK_SEND_BUF_SIZE, GFP_KERNEL);
+	if (!chunk->buf)
+		return -ENOMEM;
+	return 0;
+}
+
+struct vk_crtc_driver {
+	struct drm_crtc crtc;
+	struct delayed_work timeout_flush;
+
+	struct vk_send_chunk send_chunk[2];
+};
+
+static const struct drm_crtc_funcs vk_crtc_funcs = {
+	.set_config = drm_atomic_helper_set_config,
+	.page_flip = drm_atomic_helper_page_flip,
+	.atomic_create_state = drm_atomic_helper_crtc_create_state,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
+	DRM_CRTC_VBLANK_TIMER_FUNCS
+};
+
+static enum drm_mode_status
+vk_crtc_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode *mode);
+static int vk_crtc_atomic_check(struct drm_crtc *crtc,
+				struct drm_atomic_commit *state);
+static void vk_crtc_atomic_flush(struct drm_crtc *crtc,
+				 struct drm_atomic_commit *state);
+static void vk_crtc_atomic_enable(struct drm_crtc *crtc,
+				  struct drm_atomic_commit *state)
+{
+	drm_crtc_vblank_on(crtc);
+}
+
+static void vk_crtc_atomic_disable(struct drm_crtc *crtc,
+				   struct drm_atomic_commit *state)
+{
+	drm_crtc_vblank_off(crtc);
+}
+
+static const struct drm_crtc_helper_funcs vk_crtc_helper_funcs = {
+	.mode_valid = vk_crtc_mode_valid,
+	.atomic_check = vk_crtc_atomic_check,
+	.atomic_flush = vk_crtc_atomic_flush,
+	.atomic_enable = vk_crtc_atomic_enable,
+	.atomic_disable = vk_crtc_atomic_disable,
+};
+
+struct vk_connector_driver {
+	struct drm_connector connector;
+
+	struct usb_device *usb_dev;
+	unsigned int data_pipe;
+	const struct vk_lcd_device_info *device_info;
+};
+
+static const struct drm_connector_funcs vk_connector_funcs = {
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state
+};
+
+static int vk_connector_get_modes(struct drm_connector *connector);
+static const struct drm_connector_helper_funcs vk_connector_helper_funcs = {
+	.get_modes = vk_connector_get_modes,
+};
+
+static const struct drm_encoder_funcs vk_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
+static int vk_device_info_find_or_verify(struct vk_driver *drv);
+static int vk_device_bootstrap(struct vk_driver *drv);
+static int vk_device_enable_pre(struct vk_driver *drv);
+static int vk_device_enable_post(struct vk_driver *drv);
+static int vk_device_disable(struct vk_driver *drv);
+static int vk_device_reset(struct vk_driver *drv);
+
+static int vk_plane_atomic_check(struct drm_plane *plane,
+				 struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *new_crtc_state;
+	int ret;
+
+	if (!new_plane_state->fb)
+		return 0;
+
+	if (!new_plane_state->crtc)
+		return -EINVAL;
+	new_crtc_state =
+		drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
+	if (!new_crtc_state)
+		return -EINVAL;
+
+	ret = drm_atomic_helper_check_plane_state(new_plane_state,
+						  new_crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING, false,
+						  false);
+	if (ret)
+		return ret;
+
+	if (new_plane_state->rotation != DRM_MODE_ROTATE_0) {
+		drm_dbg_kms(plane->dev, "Unsupported plane rotation %#x\n",
+			    new_plane_state->rotation);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum drm_mode_status
+vk_crtc_mode_valid(struct drm_crtc *crtc, const struct drm_display_mode *mode)
+{
+	struct vk_driver *drv = container_of(crtc->dev, struct vk_driver, drm);
+	struct drm_display_mode preferred = {
+		DRM_MODE_INIT(drv->device_info->fps,
+			      drv->device_info->width,
+			      drv->device_info->height,
+			      drv->device_info->width_mm,
+			      drv->device_info->height_mm)
+	};
+
+	return drm_crtc_helper_mode_valid_fixed(crtc, mode, &preferred);
+}
+
+static int vk_crtc_atomic_check(struct drm_crtc *crtc,
+				struct drm_atomic_commit *state)
+{
+	struct vk_driver *drv = container_of(crtc->dev, struct vk_driver, drm);
+	struct drm_crtc_state *new_crtc_state =
+		drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_plane *plane = &drv->plane;
+	struct vk_connector_driver *connector_drv = drv->connector;
+	struct drm_plane_state *new_plane_state;
+
+	if (!new_crtc_state->enable || !new_crtc_state->active)
+		return 0;
+
+	if (new_crtc_state->plane_mask != drm_plane_mask(plane) ||
+	    new_crtc_state->connector_mask !=
+		    drm_connector_mask(&connector_drv->connector)) {
+		drm_dbg_kms(crtc->dev,
+			    "Active CRTC requires the primary plane and USB connector\n");
+		return -EINVAL;
+	}
+
+	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	if (!new_plane_state)
+		new_plane_state = plane->state;
+	if (!new_plane_state || new_plane_state->crtc != crtc ||
+	    !new_plane_state->fb) {
+		drm_dbg_kms(crtc->dev,
+			    "Active CRTC has no framebuffer on its primary plane\n");
+		return -EINVAL;
+	}
+
+	if (new_plane_state->crtc_w != connector_drv->device_info->width ||
+	    new_plane_state->crtc_h != connector_drv->device_info->height) {
+		drm_dbg_kms(crtc->dev,
+			    "Unsupported scanout size %ux%u (expected %ux%u)\n",
+			    new_plane_state->crtc_w, new_plane_state->crtc_h,
+			    connector_drv->device_info->width,
+			    connector_drv->device_info->height);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vk_connector_get_modes(struct drm_connector *connector)
+{
+	struct vk_connector_driver *drv =
+		container_of(connector, struct vk_connector_driver, connector);
+	struct drm_display_mode mode = {
+		DRM_MODE_INIT(drv->device_info->fps,
+			      drv->device_info->width,
+			      drv->device_info->height,
+			      drv->device_info->width_mm,
+			      drv->device_info->height_mm)
+	};
+	return drm_connector_helper_get_modes_fixed(connector, &mode);
+}
+
+static void vk_timeout_atomic_submit(struct work_struct *work)
+{
+	struct vk_crtc_driver *crtc_drv =
+		container_of(to_delayed_work(work), struct vk_crtc_driver,
+			     timeout_flush);
+	struct drm_crtc *crtc = &crtc_drv->crtc;
+	struct drm_device *drm = crtc->dev;
+	struct drm_modeset_acquire_ctx ctx;
+	struct drm_atomic_commit *state;
+	struct drm_crtc_state *crtc_state;
+	int ret = 0;
+
+	drm_modeset_acquire_init(&ctx, 0);
+
+	state = drm_atomic_commit_alloc(drm);
+	if (!state) {
+		ret = -ENOMEM;
+		goto fail_alloc;
+	}
+
+	state->acquire_ctx = &ctx;
+	state->allow_modeset = false;
+
+	do {
+		crtc_state = drm_atomic_get_crtc_state(state, crtc);
+		if (IS_ERR(crtc_state))
+			ret = PTR_ERR(crtc_state);
+		else if (crtc_state->active)
+			ret = drm_atomic_nonblocking_commit(state);
+		else
+			break;
+
+		if (ret != -EDEADLK)
+			break;
+		drm_atomic_commit_clear(state);
+		ret = drm_modeset_backoff(&ctx);
+	} while (!ret);
+	drm_atomic_commit_put(state);
+
+fail_alloc:
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
+
+	if (ret == -EBUSY)
+		return;
+
+	if (ret)
+		drm_warn_ratelimited(crtc->dev, "Timeout refresh commit failed: %d\n", ret);
+}
+
+static int vk_scan_frame(struct vk_crtc_driver *crtc_drv,
+			 struct vk_connector_driver *connector_drv,
+			 struct drm_shadow_plane_state *plane);
+static void vk_crtc_atomic_flush(struct drm_crtc *crtc,
+				 struct drm_atomic_commit *state)
+{
+	struct vk_driver *drv = container_of(crtc->dev, struct vk_driver, drm);
+	struct vk_crtc_driver *crtc_drv = drv->crtc;
+	struct drm_crtc_state *old_crtc_state =
+		drm_atomic_get_old_crtc_state(state, crtc);
+	struct drm_crtc_state *new_crtc_state =
+		drm_atomic_get_new_crtc_state(state, crtc);
+	struct drm_plane *plane = &drv->plane;
+	struct vk_connector_driver *connector_drv = drv->connector;
+	struct drm_plane_state *new_plane_state =
+		drm_atomic_get_new_plane_state(state, plane);
+	int ret = 0, ret2;
+	int enter_idx;
+	bool new_enable = new_crtc_state->enable && new_crtc_state->active,
+	     old_enable = old_crtc_state->enable && old_crtc_state->active;
+	unsigned long irqflags;
+
+	if (!new_plane_state)
+		new_plane_state = plane->state;
+
+	if (!drm_dev_enter(crtc->dev, &enter_idx))
+		goto drm_fail;
+	if (!vk_io_start(drv)) {
+		drm_dbg_ratelimited(crtc->dev,
+				    "Skipping CRTC update while display I/O is blocked\n");
+		goto vkio_fail;
+	}
+
+	if (new_enable != old_enable)
+		drm_dbg_kms(crtc->dev, "CRTC active state: %d -> %d\n",
+			    old_enable, new_enable);
+
+	if (!new_enable) {
+		if (drv->device_state)
+			ret = vk_device_disable(drv);
+	} else {
+		bool enabling = !drv->device_state;
+
+		/* Testing found a ~10-second timeout; refresh every 3 seconds. */
+		mod_delayed_work(system_dfl_wq, &crtc_drv->timeout_flush,
+				 msecs_to_jiffies(VK_TIMEOUT_FLUSH_INTERVAL_MS));
+		if (enabling)
+			ret = vk_device_enable_pre(drv);
+		ret2 = vk_scan_frame(crtc_drv, connector_drv,
+				     to_drm_shadow_plane_state(new_plane_state));
+		ret = ret ? ret : ret2;
+		if (enabling) {
+			ret2 = vk_device_enable_post(drv);
+			ret = ret ? ret : ret2;
+		}
+	}
+	if (ret && ret != -ENODEV && ret != -ESHUTDOWN)
+		drm_err_ratelimited(crtc->dev,
+				    "Display update failed (active=%d): %d\n",
+				    new_enable, ret);
+	vk_io_end(drv);
+vkio_fail:
+	drm_dev_exit(enter_idx);
+drm_fail:
+	if (new_crtc_state->event) {
+		spin_lock_irqsave(&crtc->dev->event_lock, irqflags);
+		drm_crtc_send_vblank_event(crtc, new_crtc_state->event);
+		new_crtc_state->event = NULL;
+		spin_unlock_irqrestore(&crtc->dev->event_lock, irqflags);
+	}
+}
+
+static int vk_init_drm(struct vk_driver *drv)
+{
+	int ret;
+	struct drm_device *drm = &drv->drm;
+	struct drm_mode_config *mode_config = &drm->mode_config;
+	struct vk_connector_driver *connector;
+	struct vk_crtc_driver *crtc;
+
+	drm_dbg_driver(drm, "Initializing DRM resources\n");
+
+	ret = drmm_mode_config_init(drm);
+	if (ret)
+		return ret;
+
+	mode_config->funcs = &vk_mode_config_funcs;
+	mode_config->max_height = drv->device_info->height;
+	mode_config->min_height = drv->device_info->height;
+	mode_config->max_width = drv->device_info->width;
+	mode_config->min_width = drv->device_info->width;
+	mode_config->preferred_depth = 24;
+	mode_config->prefer_shadow = true;
+
+	ret = drm_universal_plane_init(drm, &drv->plane, BIT(0),
+				       &vk_plane_funcs, vk_plane_formats,
+				       ARRAY_SIZE(vk_plane_formats), NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(&drv->plane, &vk_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(&drv->plane);
+
+	crtc = drmm_crtc_alloc_with_planes(drm, struct vk_crtc_driver, crtc,
+					   &drv->plane, NULL, &vk_crtc_funcs,
+					   NULL);
+	if (IS_ERR(crtc))
+		return PTR_ERR(crtc);
+	drm_crtc_helper_add(&crtc->crtc, &vk_crtc_helper_funcs);
+	INIT_DELAYED_WORK(&crtc->timeout_flush, vk_timeout_atomic_submit);
+	drv->crtc = crtc;
+	for (size_t i = 0; i < ARRAY_SIZE(crtc->send_chunk); i++) {
+		ret = vk_send_chunk_init(drm, &crtc->send_chunk[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = drm_encoder_init(drm, &drv->encoder, &vk_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	drv->encoder.possible_crtcs = drm_crtc_mask(&crtc->crtc);
+
+	connector = drmm_kzalloc(drm, sizeof(struct vk_connector_driver),
+				 GFP_KERNEL);
+	if (!connector)
+		return -ENOMEM;
+	ret = drmm_connector_init(drm, &connector->connector,
+				  &vk_connector_funcs, DRM_MODE_CONNECTOR_USB,
+				  NULL);
+	if (ret)
+		return ret;
+	drm_connector_helper_add(&connector->connector,
+				 &vk_connector_helper_funcs);
+	connector->usb_dev = drv->dev;
+	connector->data_pipe =
+		usb_sndbulkpipe(drv->dev, drv->frame_epd->bEndpointAddress);
+	connector->device_info = drv->device_info;
+	ret = drm_connector_attach_encoder(&connector->connector,
+					   &drv->encoder);
+	if (ret)
+		return ret;
+	drv->connector = connector;
+
+	ret = drm_vblank_init(drm, 1);
+	if (ret)
+		return ret;
+
+	return drm_mode_config_create_initial_state(drm);
+}
+
+static int vk_init_usb(struct vk_driver *drv, struct usb_interface *intf)
+{
+	struct usb_host_interface *altsetting = intf->cur_altsetting;
+
+	drv->intf = intf;
+	usb_set_intfdata(intf, drv);
+
+	drv->dev = interface_to_usbdev(intf);
+
+	for (size_t i = 0; i < altsetting->desc.bNumEndpoints; i++) {
+		struct usb_endpoint_descriptor *epd =
+			&altsetting->endpoint[i].desc;
+		if (usb_endpoint_num(epd) == VK_FRAME_EP_NUMBER &&
+		    usb_endpoint_is_bulk_out(epd)) {
+			drv->frame_epd = epd;
+			break;
+		}
+	}
+	if (!drv->frame_epd) {
+		drm_err(&drv->drm, "Bulk OUT endpoint %u not found\n",
+			VK_FRAME_EP_NUMBER);
+		return -ENODEV;
+	}
+
+	drm_dbg_driver(&drv->drm,
+		       "Using bulk OUT endpoint %#x (max packet %u)\n",
+		       drv->frame_epd->bEndpointAddress,
+		       usb_endpoint_maxp(drv->frame_epd));
+
+	return 0;
+}
+
+static void vk_deinit_usb(struct vk_driver *drv)
+{
+	usb_set_intfdata(drv->intf, NULL);
+}
+
+static int vk_probe(struct usb_interface *intf, const struct usb_device_id *id)
+{
+	struct vk_driver *drv = devm_drm_dev_alloc(&intf->dev, &vk_drm_driver,
+						   struct vk_driver, drm);
+	int ret;
+
+	if (IS_ERR(drv))
+		return dev_err_probe(&intf->dev, PTR_ERR(drv),
+				     "Failed to allocate DRM device\n");
+	mutex_init(&drv->io_lock);
+
+	ret = vk_init_usb(drv, intf);
+	if (ret)
+		goto fail;
+
+	mutex_lock(&drv->io_lock);
+
+	ret = vk_device_info_find_or_verify(drv);
+	if (ret) {
+		drm_err(&drv->drm, "Failed to identify display: %d\n", ret);
+		goto fail_io;
+	}
+	drm_info(&drv->drm, "Detected %ux%u Valkyrie USB LCD (%u Hz)\n",
+		 drv->device_info->width, drv->device_info->height,
+		 drv->device_info->fps);
+
+	ret = vk_device_bootstrap(drv);
+	if (ret) {
+		drm_err(&drv->drm, "Failed to initialize display: %d\n", ret);
+		goto fail_io;
+	}
+
+	drv->io_blocking = false;
+	mutex_unlock(&drv->io_lock);
+
+	ret = vk_init_drm(drv);
+	if (ret) {
+		drm_err(&drv->drm, "Failed to initialize DRM resources: %d\n",
+			ret);
+		goto fail;
+	}
+	ret = drm_dev_register(&drv->drm, 0);
+	if (ret) {
+		drm_err(&drv->drm, "Failed to register DRM device: %d\n", ret);
+		goto fail;
+	}
+	drm_client_setup(&drv->drm, NULL);
+
+	return 0;
+fail_io:
+	drv->io_blocking = true;
+	mutex_unlock(&drv->io_lock);
+fail:
+	vk_deinit_usb(drv);
+	return ret;
+}
+
+static void vk_disconnect(struct usb_interface *intf)
+{
+	struct vk_driver *drv = usb_get_intfdata(intf);
+	int ret;
+
+	drm_dbg_driver(&drv->drm, "Disconnecting display\n");
+
+	drm_dev_get(&drv->drm);
+	drm_dev_unplug(&drv->drm);
+
+	mutex_lock(&drv->io_lock);
+	drv->io_blocking = true;
+	mutex_unlock(&drv->io_lock);
+
+	cancel_delayed_work_sync(&drv->crtc->timeout_flush);
+
+	if (drv->drm.mode_config.suspend_state) {
+		drm_atomic_commit_put(drv->drm.mode_config.suspend_state);
+		drv->drm.mode_config.suspend_state = NULL;
+	}
+
+	drm_dev_put(&drv->drm);
+
+	mutex_lock(&drv->io_lock);
+	drv->io_blocking = true;
+	/* Re-enable the display so its observed ~10-second timeout resets it. */
+	ret = vk_device_reset(drv);
+	if (ret)
+		drm_dbg_driver(&drv->drm,
+			       "Display reset during disconnect failed: %d\n",
+			       ret);
+	mutex_unlock(&drv->io_lock);
+	vk_deinit_usb(drv);
+}
+
+static int __vk_resume_device(struct usb_interface *intf, bool rebootstrap,
+			      bool reidentify)
+{
+	struct vk_driver *drv = usb_get_intfdata(intf);
+	int ret = 0;
+
+	drm_dbg_driver(&drv->drm,
+		       "Resuming display (reinitialize=%d, reidentify=%d, DRM suspended=%d)\n",
+		       rebootstrap, reidentify, drv->drm_suspended);
+
+	mutex_lock(&drv->io_lock);
+
+	if (reidentify) {
+		ret = vk_device_info_find_or_verify(drv);
+		if (ret) {
+			drm_err(&drv->drm,
+				"Failed to verify display after USB reset: %d\n",
+				ret);
+			goto fail;
+		}
+	}
+
+	if (rebootstrap) {
+		ret = vk_device_bootstrap(drv);
+		if (ret) {
+			drm_err(&drv->drm,
+				"Failed to initialize display after USB reset: %d\n",
+				ret);
+			goto fail;
+		}
+	}
+
+	drv->io_blocking = false;
+	mutex_unlock(&drv->io_lock);
+
+	if (drv->drm_suspended) {
+		ret = drm_mode_config_helper_resume(&drv->drm);
+		drv->drm_suspended = false;
+		if (ret)
+			drm_err(&drv->drm, "Failed to restore DRM state: %d\n",
+				ret);
+	} else {
+		drm_dbg_driver(&drv->drm,
+			       "No saved DRM state; scheduling an immediate refresh\n");
+		schedule_delayed_work(&drv->crtc->timeout_flush, 0);
+	}
+
+	if (!ret)
+		drm_dbg_driver(&drv->drm, "Display I/O resumed\n");
+
+	return ret;
+
+fail:
+	drv->io_blocking = true;
+	mutex_unlock(&drv->io_lock);
+	return ret;
+}
+
+static int __vk_suspend_device(struct usb_interface *intf, bool force)
+{
+	struct vk_driver *drv = usb_get_intfdata(intf);
+	int ret = 0;
+
+	drm_dbg_driver(&drv->drm,
+		       "Suspending display (force=%d, DRM suspended=%d)\n",
+		       force, drv->drm_suspended);
+
+	if (!drv->drm_suspended) {
+		ret = drm_mode_config_helper_suspend(&drv->drm);
+		if (ret)
+			drm_err(&drv->drm, "Failed to suspend DRM state: %d\n",
+				ret);
+		if (ret && !force)
+			return ret;
+		if (!ret)
+			drv->drm_suspended = true;
+	}
+
+	mutex_lock(&drv->io_lock);
+	drv->io_blocking = true;
+	mutex_unlock(&drv->io_lock);
+	cancel_delayed_work_sync(&drv->crtc->timeout_flush);
+	drm_dbg_driver(&drv->drm, "Display I/O suspended\n");
+	return ret;
+}
+
+static int vk_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	return __vk_suspend_device(intf, true);
+}
+
+static int vk_resume(struct usb_interface *intf)
+{
+	return __vk_resume_device(intf, false, false);
+}
+
+static int vk_reset_resume(struct usb_interface *intf)
+{
+	return __vk_resume_device(intf, true, true);
+}
+
+static int vk_pre_reset(struct usb_interface *intf)
+{
+	return __vk_suspend_device(intf, false);
+}
+
+static int vk_post_reset(struct usb_interface *intf)
+{
+	return __vk_resume_device(intf, true, false);
+}
+
+static void
+__vk_conv_to_buf(struct vk_send_chunk *curr,
+		 struct drm_shadow_plane_state *plane_state, size_t *i,
+		 unsigned long *x, unsigned long *y,
+		 const struct vk_lcd_device_info *device_info,
+		 const struct drm_format_info *src_format_info,
+		 const struct drm_format_info *dst_format_info)
+{
+	struct drm_rect clip;
+	struct iosys_map dst;
+	unsigned int dst_pitch = device_info->width * dst_format_info->cpp[0];
+
+	while (*y < device_info->height && *i < VK_SEND_BUF_SIZE) {
+		size_t line_avail = device_info->width - *x,
+		       buf_avail = DIV_ROUND_DOWN_ULL(VK_SEND_BUF_SIZE - *i,
+						      dst_format_info->cpp[0]);
+		/* UYVY encodes pixels in pairs, so round down to an even count. */
+		size_t pixs_to_send = ALIGN_DOWN(min(line_avail, buf_avail),
+						 2);
+		size_t bytes_to_send = pixs_to_send * dst_format_info->cpp[0];
+
+		if (!bytes_to_send)
+			return;
+
+		clip.y1 = *y;
+		clip.y2 = *y + 1;
+		clip.x1 = *x;
+		clip.x2 = *x + pixs_to_send;
+		iosys_map_set_vaddr(&dst, curr->buf + *i);
+
+		switch (src_format_info->format) {
+		case DRM_FORMAT_XRGB8888:
+			drm_fb_xrgb8888_to_uyvy(&dst, &dst_pitch,
+						&plane_state->data[0],
+						plane_state->base.fb, &clip,
+						&plane_state->fmtcnv_state);
+			break;
+		case DRM_FORMAT_UYVY:
+			drm_fb_memcpy(&dst, &dst_pitch, &plane_state->data[0],
+				      plane_state->base.fb, &clip);
+			break;
+		}
+		*i += bytes_to_send;
+		if (clip.x2 != device_info->width) {
+			*x = clip.x2;
+		} else {
+			*x = 0;
+			(*y)++;
+		}
+	}
+}
+
+static void __vk_urb_finish_callback(struct urb *urb)
+{
+	struct vk_send_chunk *curr =
+		container_of(urb, struct vk_send_chunk, urb);
+	curr->errno = 0;
+	if (urb->transfer_buffer_length != urb->actual_length)
+		curr->errno = -EIO;
+	if (urb->status)
+		curr->errno = urb->status;
+	complete_all(&curr->flight);
+}
+
+static int __vk_wait_chunk_complete(struct vk_send_chunk *chunk,
+				    unsigned long timeout)
+{
+	int ret = 0;
+
+	if (!wait_for_completion_timeout(&chunk->flight, timeout)) {
+		ret = ret ? ret : -ETIMEDOUT;
+		usb_kill_urb(&chunk->urb);
+		complete_all(&chunk->flight);
+	}
+	if (chunk->errno)
+		ret = ret ? ret : chunk->errno;
+	return ret;
+}
+
+static int vk_scan_frame(struct vk_crtc_driver *crtc_drv,
+			 struct vk_connector_driver *connector_drv,
+			 struct drm_shadow_plane_state *plane_state)
+{
+	const struct vk_lcd_device_info *device_info =
+		connector_drv->device_info;
+	struct vk_send_chunk *curr = &crtc_drv->send_chunk[0],
+			     *next = &crtc_drv->send_chunk[1];
+	struct drm_device *drm = crtc_drv->crtc.dev;
+	struct drm_framebuffer *fb = plane_state->base.fb;
+	const struct drm_format_info *src_format_info = fb->format;
+	const struct drm_format_info *dst_format_info =
+		drm_get_format_info(drm, VK_FRAME_FORMAT,
+				    DRM_FORMAT_MOD_LINEAR);
+	unsigned long x = 0, y = 0;
+	const unsigned long wait_timeout =
+		msecs_to_jiffies(VK_SEND_CHUNK_TIMEOUT);
+	size_t i;
+	bool adding_header = true;
+	size_t trailer_i = 0;
+	int ret = 0;
+	int ret2 = 0;
+
+	lockdep_assert_held(&container_of(drm, struct vk_driver, drm)->io_lock);
+	curr->errno = 0;
+	next->errno = 0;
+	complete_all(&curr->flight);
+	complete_all(&next->flight);
+
+	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
+	if (ret) {
+		drm_dbg_ratelimited(drm,
+				    "Failed to begin CPU access to framebuffer %u: %d\n",
+				    fb->base.id, ret);
+		return ret;
+	}
+
+	while (trailer_i < ARRAY_SIZE(device_info->frame_trailer)) {
+		swap(curr, next);
+		i = 0;
+
+		if (adding_header) {
+			memcpy(curr->buf, device_info->frame_header,
+			       sizeof(device_info->frame_header));
+			i += sizeof(device_info->frame_header);
+			adding_header = false;
+		}
+		__vk_conv_to_buf(curr, plane_state, &i, &x, &y, device_info,
+				 src_format_info, dst_format_info);
+
+		if (y == device_info->height) {
+			size_t append_trailer_len =
+				min(ARRAY_SIZE(device_info->frame_trailer) -
+					    trailer_i,
+				    VK_SEND_BUF_SIZE - i);
+			memcpy(curr->buf + i,
+			       &device_info->frame_trailer[trailer_i],
+			       append_trailer_len);
+			i += append_trailer_len;
+			trailer_i += append_trailer_len;
+		}
+
+		usb_fill_bulk_urb(&curr->urb, connector_drv->usb_dev,
+				  connector_drv->data_pipe, curr->buf, i,
+				  __vk_urb_finish_callback, NULL);
+		ret = __vk_wait_chunk_complete(next, wait_timeout);
+		if (ret) {
+			drm_dbg_ratelimited(drm,
+					    "Bulk OUT transfer failed (%d/%d bytes): %d\n",
+					    next->urb.actual_length,
+					    next->urb.transfer_buffer_length, ret);
+			break;
+		}
+		reinit_completion(&curr->flight);
+		ret = usb_submit_urb(&curr->urb, GFP_KERNEL);
+		if (ret) {
+			drm_dbg_ratelimited(drm,
+					    "Failed to submit bulk OUT transfer (%zu bytes): %d\n",
+					    i, ret);
+			curr->errno = ret;
+			complete_all(&curr->flight);
+			break;
+		}
+	}
+	ret2 = __vk_wait_chunk_complete(curr, wait_timeout);
+	if (ret2)
+		drm_dbg_ratelimited(drm, "Last frame chunk failed (%d/%d bytes): %d\n",
+				    curr->urb.actual_length,
+				    curr->urb.transfer_buffer_length, ret2);
+	ret = ret ? ret : ret2;
+
+	/* The device expects a zero-length bulk transfer to terminate each frame. */
+	reinit_completion(&curr->flight);
+	usb_fill_bulk_urb(&curr->urb, connector_drv->usb_dev,
+			  connector_drv->data_pipe, NULL, 0,
+			  __vk_urb_finish_callback, NULL);
+	ret2 = usb_submit_urb(&curr->urb, GFP_KERNEL);
+	if (ret2) {
+		drm_dbg_ratelimited(drm, "Failed to submit frame terminator: %d\n", ret2);
+		curr->errno = ret2;
+		complete_all(&curr->flight);
+	}
+	ret2 = __vk_wait_chunk_complete(curr, wait_timeout);
+	if (ret2)
+		drm_dbg_ratelimited(drm, "Frame terminator failed: %d\n", ret2);
+	ret = ret ? ret : ret2;
+
+	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+	return ret;
+}
+
+/*
+ * Feature reports carry 8-byte commands. The helpers below encode observed
+ * register reads/writes and command-completion polling, including the
+ * big-endian address fields. The meaning of several command fields remains
+ * unknown.
+ */
+static int vk_feature_report(struct vk_driver *drv, const u8 request[8],
+			     u8 response[8])
+{
+	int ret;
+
+	lockdep_assert_held(&drv->io_lock);
+
+	ret = usb_control_msg_send(drv->dev, 0, HID_REQ_SET_REPORT,
+				   USB_DIR_OUT | USB_TYPE_CLASS |
+					   USB_RECIP_INTERFACE,
+				   HID_REPORT_TYPE_FEATURE << 8, 0, request, 8,
+				   USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+	if (ret) {
+		drm_dbg_ratelimited(&drv->drm, "SET_REPORT %8ph failed: %d\n",
+				    request, ret);
+		return ret;
+	}
+
+	if (response) {
+		ret = usb_control_msg_recv(drv->dev, 0, HID_REQ_GET_REPORT,
+					   USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
+					   HID_REPORT_TYPE_FEATURE << 8, 0, response, 8,
+					   USB_CTRL_GET_TIMEOUT, GFP_KERNEL);
+		if (ret)
+			drm_dbg_ratelimited(&drv->drm,
+					    "GET_REPORT for %8ph failed: %d\n",
+					    request, ret);
+	}
+
+	return ret;
+}
+
+static inline int vk_b5_read(struct vk_driver *drv, u16 addr, u8 *val)
+{
+	u8 buf[8] = { 0xB5, 0 };
+	u8 ans[8];
+	int ret;
+
+	put_unaligned_be16(addr, buf + 1);
+
+	ret = vk_feature_report(drv, buf, ans);
+	if (ret)
+		return ret;
+
+	if (memcmp(buf, ans, 3)) {
+		drm_dbg_ratelimited(&drv->drm,
+				    "Unexpected response reading register %#06x: %8ph\n",
+				    addr, ans);
+		return -EIO;
+	}
+
+	if (val)
+		*val = ans[3];
+	return 0;
+}
+
+static inline int vk_b6_write(struct vk_driver *drv, u16 addr, u8 val)
+{
+	u8 buf[8] = { 0xB6, 0 };
+
+	put_unaligned_be16(addr, buf + 1);
+	buf[3] = val;
+
+	return vk_feature_report(drv, buf, NULL);
+}
+
+static inline int vk_f5_read(struct vk_driver *drv, u32 addr, u8 val[8])
+{
+	u8 buf[8] = { 0xF5, 0 };
+
+	if (addr > 0xFFFFFF)
+		return -EINVAL;
+	put_unaligned_be32(addr, buf);
+	buf[0] = 0xF5;
+
+	return vk_feature_report(drv, buf, val);
+}
+
+static inline int vk_a6_command(struct vk_driver *drv, u8 cmd[8], u16 poll,
+				unsigned long poll_delay_us)
+{
+	int ret;
+
+	ret = vk_feature_report(drv, cmd, NULL);
+	if (ret)
+		return ret;
+
+	fsleep(poll_delay_us);
+
+	for (uint i = 0; i < VK_A6_POLL_MAX; i++) {
+		u8 val;
+
+		ret = vk_b5_read(drv, poll, &val);
+		if (ret)
+			return ret;
+		if (!val)
+			return 0;
+		fsleep(VK_A6_POLL_INTERVAL_US);
+	}
+
+	drm_dbg_ratelimited(&drv->drm,
+			    "Command %#04x timed out polling register %#06x\n",
+			    cmd[1], poll);
+	return -ETIMEDOUT;
+}
+
+static inline int vk_a601_set_screen(struct vk_driver *drv)
+{
+	u8 buf[8] = { 0xa6, 0x01, 0, 0, 0, 0, 0x22, 0x00 };
+
+	put_unaligned_be16(drv->device_info->width, buf + 2);
+	put_unaligned_be16(drv->device_info->height, buf + 4);
+
+	return vk_a6_command(drv, buf, 0xc555, 10 * 1000);
+}
+
+static inline int vk_a602_set_screen(struct vk_driver *drv)
+{
+	u8 buf[8] = { 0xa6, 0x02, 0 };
+
+	put_unaligned_be16(drv->device_info->video_code, buf + 2);
+	put_unaligned_be16(drv->device_info->width, buf + 4);
+	put_unaligned_be16(drv->device_info->height, buf + 6);
+
+	return vk_a6_command(drv, buf, 0xc557, 20 * 1000);
+}
+
+static inline int vk_a603_command(struct vk_driver *drv)
+{
+	u8 buf[8] = { 0xa6, 0x03, 0x03, 0 };
+
+	return vk_a6_command(drv, buf, 0xc558, 10 * 1000);
+}
+
+static inline int vk_a604_switch(struct vk_driver *drv, bool on)
+{
+	u8 buf[8] = { 0xa6, 0x04, on ? 1 : 0, 0 };
+	int ret;
+
+	ret = vk_a6_command(drv, buf, 0xc555, 10 * 1000);
+	if (ret)
+		return ret;
+
+	if (on) {
+		u8 f242;
+
+		ret = vk_b6_write(drv, 0xf24e, 0);
+		if (ret)
+			return ret;
+
+		ret = vk_b5_read(drv, 0xf242, &f242);
+		if (ret)
+			return ret;
+		if (f242 & BIT(3)) {
+			drm_dbg_ratelimited(&drv->drm,
+					    "Unexpected status %#04x in register 0xf242\n",
+					    f242);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static inline int vk_a605_switch(struct vk_driver *drv, bool on)
+{
+	u8 buf[8] = { 0xa6, 0x05, on ? 1 : 0, 0 };
+
+	return vk_a6_command(drv, buf, 0xc555, 10 * 1000);
+}
+
+static inline int vk_a607_switch(struct vk_driver *drv, bool on)
+{
+	u8 buf[8] = { 0xa6, 0x07, on ? 1 : 0, 0x02, 0 };
+	int ret;
+
+	if (on) {
+		ret = vk_b6_write(drv, 0xdeee, 1);
+		if (ret)
+			return ret;
+	}
+
+	return vk_a6_command(drv, buf, 0xc454, 100 * 1000);
+}
+
+static int vk_complex_switch(struct vk_driver *drv, bool on)
+{
+	int ret;
+	u8 val;
+
+	ret = vk_b5_read(drv, drv->device_info->complex_switch_addr, &val);
+	if (ret)
+		return ret;
+
+	if (drv->device_info->complex_switch_active_high ^ on)
+		val &= ~drv->device_info->complex_switch_mask;
+	else
+		val |= drv->device_info->complex_switch_mask;
+
+	return vk_b6_write(drv, drv->device_info->complex_switch_addr, val);
+}
+
+/*
+ * The sequence and ordering here follow the observed initialization and
+ * enable protocol. The purpose of some device-specific commands is unknown.
+ */
+static int vk_device_bootstrap(struct vk_driver *drv)
+{
+	int ret;
+
+	drm_dbg_driver(&drv->drm, "Initializing %ux%u display\n",
+		       drv->device_info->width, drv->device_info->height);
+
+	drv->device_state = false;
+
+	ret = vk_a603_command(drv);
+	if (ret)
+		return ret;
+
+	ret = vk_a607_switch(drv, true);
+	if (ret)
+		return ret;
+
+	ret = vk_a605_switch(drv, false);
+	if (ret)
+		return ret;
+
+	ret = vk_complex_switch(drv, false);
+	if (ret)
+		return ret;
+
+	ret = vk_a604_switch(drv, false);
+	if (ret)
+		return ret;
+
+	ret = vk_a603_command(drv);
+	if (ret)
+		return ret;
+
+	ret = vk_a601_set_screen(drv);
+	if (ret)
+		return ret;
+
+	return vk_a602_set_screen(drv);
+}
+
+static int vk_device_enable_pre(struct vk_driver *drv)
+{
+	drm_dbg_driver(&drv->drm, "Enabling display\n");
+	drv->device_state = true;
+	return vk_a604_switch(drv, true);
+}
+
+static int vk_device_enable_post(struct vk_driver *drv)
+{
+	int ret;
+
+	ret = vk_complex_switch(drv, true);
+	if (ret)
+		return ret;
+
+	return vk_a605_switch(drv, true);
+}
+
+static int vk_device_disable(struct vk_driver *drv)
+{
+	int ret;
+
+	drm_dbg_driver(&drv->drm, "Disabling display\n");
+
+	drv->device_state = false;
+
+	ret = vk_a605_switch(drv, false);
+	if (ret)
+		return ret;
+
+	ret = vk_complex_switch(drv, false);
+	if (ret)
+		return ret;
+
+	return vk_a604_switch(drv, false);
+}
+
+static int vk_device_reset(struct vk_driver *drv)
+{
+	int ret = 0;
+	int ret2;
+
+	/*
+	 * The device has no observed shutdown command. Enable it and let its
+	 * timeout reset it later; this function does not wait for that reset.
+	 */
+	ret = vk_device_bootstrap(drv);
+	ret2 = vk_device_enable_pre(drv);
+	ret = ret ? ret : ret2;
+	if (!ret2)
+		ret2 = vk_device_enable_post(drv);
+	return ret ? ret : ret2;
+}
+
+/* Known panel identification data and observed frame markers. */
+static const struct vk_lcd_device_info vk_lcd_devices[] = {
+	{ .serial = "\x5a\xa5\x1aMCVKA080320*0240S244613682\xff\xff\xff",
+	  .label_0030 = { 0x02, 0x05 },
+	  .label_f000 = { 0xb7, 0x16, 0x0a },
+
+	  .width = 320,
+	  .height = 240,
+	  .fps = 30,
+	  .width_mm = 39,
+	  .height_mm = 28,
+	  .video_code = 0x9400,
+	  .complex_switch_addr = 0xf507,
+	  .complex_switch_mask = BIT(1),
+	  .complex_switch_active_high = false,
+	  .frame_header = { 0xff, 0x00, 0x00, 0x00, 0x00, 0x14, 0x00, 0xf0 },
+	  .frame_trailer = { 0xff, 0xc0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 } },
+	{ .serial = "\x5a\xa5\x1aMCVKC030360*0960S252309025\xff\xff\xff",
+	  .label_0030 = { 0x02, 0x06 },
+	  .label_f000 = { 0xb7, 0x16, 0x0a },
+
+	  .width = 360,
+	  .height = 960,
+	  .fps = 30,
+	  .width_mm = 54,
+	  .height_mm = 144,
+	  .video_code = 0xa000,
+	  .complex_switch_addr = 0xf005,
+	  .complex_switch_mask = BIT(4),
+	  .complex_switch_active_high = true,
+	  .frame_header = { 0xff, 0x00, 0x00, 0x00, 0x00, 0x16, 0x83, 0xc0 },
+	  .frame_trailer = { 0xff, 0xc0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 } },
+};
+
+static int vk_device_info_find_or_verify(struct vk_driver *drv)
+{
+	u8 serial[32] __nonstring;
+	u8 label_0030[2];
+	u8 label_f000[3];
+	int ret;
+
+	for (size_t i = 0; i < 2; i++) {
+		ret = vk_b5_read(drv, 0x0030 + i, &label_0030[i]);
+		if (ret)
+			return ret;
+	}
+	for (size_t i = 0; i < 3; i++) {
+		ret = vk_b5_read(drv, 0xf000 + i, &label_f000[i]);
+		if (ret)
+			return ret;
+	}
+	for (size_t i = 0; i < 4; i++) {
+		ret = vk_f5_read(drv, VK_SERIAL_ADDR + (i * 8),
+				 serial + (i * 8));
+		if (ret)
+			return ret;
+	}
+
+	drm_dbg_driver(&drv->drm,
+		       "Panel ID: 0030=%2ph f000=%3ph identification=%32ph\n",
+		       label_0030, label_f000, serial);
+
+	for (size_t i = drv->device_info ? drv->device_info - vk_lcd_devices :
+					   0;
+	     i < ARRAY_SIZE(vk_lcd_devices); i++) {
+		if (memcmp(vk_lcd_devices[i].label_0030, label_0030,
+			   sizeof(label_0030)) ||
+		    memcmp(vk_lcd_devices[i].label_f000, label_f000,
+			   sizeof(label_f000)) ||
+		    memcmp(vk_lcd_devices[i].serial, serial, sizeof(serial))) {
+			if (drv->device_info) {
+				drm_dbg_driver(&drv->drm,
+					       "Panel identification changed after USB reset\n");
+				return -ENODEV;
+			}
+		} else {
+			drv->device_info = &vk_lcd_devices[i];
+			return 0;
+		}
+	}
+	drm_dbg_driver(&drv->drm, "Unsupported panel identification\n");
+	return -ENODEV;
+}
-- 
2.56.0

