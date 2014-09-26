From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/6] mfd: core: add helper function to register hotplug devices
Date: Fri, 26 Sep 2014 12:55:30 +0200
Message-ID: <1411728933-13351-4-git-send-email-johan@kernel.org>
References: <1411728933-13351-1-git-send-email-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411728933-13351-1-git-send-email-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-input@vger.kernel.org

Hot-pluggable multi-function devices should always be registered with
PLATFORM_DEVID_AUTO to avoid name collisions on the platform bus. This
helper also hides the memory map and irq parameters, which aren't used
by hot-pluggable (e.g. USB-based) devices.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 include/linux/mfd/core.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index f543de91ce19..1e47262a1c63 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -108,6 +108,13 @@ extern int mfd_add_devices(struct device *parent, int id,
 			   struct resource *mem_base,
 			   int irq_base, struct irq_domain *irq_domain);
 
+static inline int mfd_add_hotplug_devices(struct device *parent,
+		const struct mfd_cell *cells, int n_devs)
+{
+	return mfd_add_devices(parent, PLATFORM_DEVID_AUTO, cells, n_devs,
+			NULL, 0, NULL);
+}
+
 extern void mfd_remove_devices(struct device *parent);
 
 #endif
-- 
1.8.5.5
