From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 10/10] HID: intel-ish-hid: Add interface function for PCI device pointer
Date: Mon, 18 Mar 2019 12:14:28 -0700
Message-ID: <20190318191428.6527-11-srinivas.pandruvada@linux.intel.com>
References: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Instead of directly accessing PCI device poitner via struct ishtp_cl,
create interface function for same. This is required for DMA transfer.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 13 +++++++++++++
 include/linux/intel-ish-client-if.h   |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 66a485a41481..fb8ca12955b4 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -855,6 +855,19 @@ struct device *ishtp_device(struct ishtp_cl_device *device)
 }
 EXPORT_SYMBOL(ishtp_device);
 
+/**
+ * ishtp_get_pci_device() - Return PCI device dev pointer
+ * This interface is used to return PCI device pointer
+ * from ishtp_cl_device instance.
+ *
+ * Return: device *.
+ */
+struct device *ishtp_get_pci_device(struct ishtp_cl_device *device)
+{
+	return device->ishtp_dev->devc;
+}
+EXPORT_SYMBOL(ishtp_get_pci_device);
+
 /**
  * ishtp_trace_callback() - Return trace callback
  *
diff --git a/include/linux/intel-ish-client-if.h b/include/linux/intel-ish-client-if.h
index e98bfbb1e07e..16255c2ca2f4 100644
--- a/include/linux/intel-ish-client-if.h
+++ b/include/linux/intel-ish-client-if.h
@@ -77,6 +77,8 @@ int ishtp_register_event_cb(struct ishtp_cl_device *device,
 struct device *ishtp_device(struct ishtp_cl_device *cl_device);
 /* Trace interface for clients */
 void *ishtp_trace_callback(struct ishtp_cl_device *cl_device);
+/* Get device pointer of PCI device for DMA acces */
+struct device *ishtp_get_pci_device(struct ishtp_cl_device *cl_device);
 
 struct ishtp_cl *ishtp_cl_allocate(struct ishtp_cl_device *cl_device);
 void ishtp_cl_free(struct ishtp_cl *cl);
-- 
2.17.2
