From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 8/9] HID: intel-ish-hid: Move functions related to bus and device
Date: Sun,  3 Mar 2019 08:46:53 -0800
Message-ID: <20190303164654.29400-9-srinivas.pandruvada@linux.intel.com>
References: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Move function idefinitions related to bus and device to common header file.
Also create new function to get fw client id and move ish_hw_reset() from
inline to exported function.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c       | 26 +++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h       | 11 ---------
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h |  5 ----
 include/linux/intel-ish-client-if.h         | 12 ++++++++++
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 2ca65864192f..66a485a41481 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -170,6 +170,19 @@ struct ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device *dev,
 }
 EXPORT_SYMBOL(ishtp_fw_cl_get_client);
 
+/**
+ * ishtp_get_fw_client_id() - Get fw client id
+ *
+ * This interface is used to reset HW get FW client id.
+ *
+ * Return: firmware client id.
+ */
+int ishtp_get_fw_client_id(struct ishtp_fw_client *fw_client)
+{
+	return fw_client->client_id;
+}
+EXPORT_SYMBOL(ishtp_get_fw_client_id);
+
 /**
  * ishtp_fw_cl_by_id() - return index to fw_clients for client_id
  * @dev: the ishtp device structure
@@ -855,6 +868,19 @@ void *ishtp_trace_callback(struct ishtp_cl_device *cl_device)
 }
 EXPORT_SYMBOL(ishtp_trace_callback);
 
+/**
+ * ish_hw_reset() - Call HW reset IPC callback
+ *
+ * This interface is used to reset HW in case of error.
+ *
+ * Return: value from IPC hw_reset callback
+ */
+int ish_hw_reset(struct ishtp_device *dev)
+{
+	return dev->ops->hw_reset(dev);
+}
+EXPORT_SYMBOL(ish_hw_reset);
+
 /**
  * ishtp_bus_register() - Function to register bus
  *
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.h b/drivers/hid/intel-ish-hid/ishtp/bus.h
index 4aed195719de..93d516f5a853 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.h
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.h
@@ -80,16 +80,5 @@ void	ishtp_recv(struct ishtp_device *dev);
 void	ishtp_reset_handler(struct ishtp_device *dev);
 void	ishtp_reset_compl_handler(struct ishtp_device *dev);
 
-void	ishtp_put_device(struct ishtp_cl_device *);
-void	ishtp_get_device(struct ishtp_cl_device *);
-
-void	ishtp_set_drvdata(struct ishtp_cl_device *cl_device, void *data);
-void	*ishtp_get_drvdata(struct ishtp_cl_device *cl_device);
-
-int	ishtp_register_event_cb(struct ishtp_cl_device *device,
-				void (*read_cb)(struct ishtp_cl_device *));
 int	ishtp_fw_cl_by_uuid(struct ishtp_device *dev, const guid_t *cuuid);
-struct	ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device *dev,
-						const guid_t *uuid);
-
 #endif /* _LINUX_ISHTP_CL_BUS_H */
diff --git a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
index e0a320e67a41..3cfef084b9fc 100644
--- a/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
+++ b/drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
@@ -238,11 +238,6 @@ static inline int ish_ipc_reset(struct ishtp_device *dev)
 	return dev->ops->ipc_reset(dev);
 }
 
-static inline int ish_hw_reset(struct ishtp_device *dev)
-{
-	return dev->ops->hw_reset(dev);
-}
-
 /* Exported function */
 void	ishtp_device_init(struct ishtp_device *dev);
 int	ishtp_start(struct ishtp_device *dev);
diff --git a/include/linux/intel-ish-client-if.h b/include/linux/intel-ish-client-if.h
index 526e3048e09f..e98bfbb1e07e 100644
--- a/include/linux/intel-ish-client-if.h
+++ b/include/linux/intel-ish-client-if.h
@@ -9,7 +9,9 @@
 #define _INTEL_ISH_CLIENT_IF_H_
 
 struct ishtp_cl_device;
+struct ishtp_device;
 struct ishtp_cl;
+struct ishtp_fw_client;
 
 /* Client state */
 enum cl_state {
@@ -95,4 +97,14 @@ void ishtp_set_rx_ring_size(struct ishtp_cl *cl, int size);
 void ishtp_set_connection_state(struct ishtp_cl *cl, int state);
 void ishtp_cl_set_fw_client_id(struct ishtp_cl *cl, int fw_client_id);
 
+void ishtp_put_device(struct ishtp_cl_device *cl_dev);
+void ishtp_get_device(struct ishtp_cl_device *cl_dev);
+void ishtp_set_drvdata(struct ishtp_cl_device *cl_device, void *data);
+void *ishtp_get_drvdata(struct ishtp_cl_device *cl_device);
+int ishtp_register_event_cb(struct ishtp_cl_device *device,
+				void (*read_cb)(struct ishtp_cl_device *));
+struct	ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device *dev,
+						const guid_t *uuid);
+int ishtp_get_fw_client_id(struct ishtp_fw_client *fw_client);
+int ish_hw_reset(struct ishtp_device *dev);
 #endif /* _INTEL_ISH_CLIENT_IF_H_ */
-- 
2.17.2
