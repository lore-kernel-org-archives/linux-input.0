From: Even Xu <even.xu@intel.com>
Subject: [PATCH 5/7] hid: intel-ish-hid: ishtp: add helper function for client search
Date: Fri, 23 Dec 2016 09:22:27 +0800
Message-ID: <1482456149-4841-5-git-send-email-even.xu@intel.com>
References: <1482456149-4841-1-git-send-email-even.xu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1482456149-4841-1-git-send-email-even.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, srinivas.pandruvada@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, andriy.shevchenko@intel.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
List-Id: linux-input@vger.kernel.org

Add helper function ishtp_fw_cl_get_client() for client driver searching
client information to hide internal details from callers.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 25 +++++++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 40e13f1..f07af7a 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -149,6 +149,31 @@ int ishtp_fw_cl_by_uuid(struct ishtp_device *dev, const uuid_le *uuid)
 EXPORT_SYMBOL(ishtp_fw_cl_by_uuid);
 
 /**
+ * ishtp_fw_cl_get_client() - return client information to client
+ * @dev: the ishtp device structure
+ * @uuid: uuid of the client to search
+ *
+ * Search firmware client using UUID and reture related client information.
+ *
+ * Return: pointer of client information on success, NULL on failure.
+ */
+struct ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device *dev,
+						const uuid_le *uuid)
+{
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->fw_clients_lock, flags);
+	i = ishtp_fw_cl_by_uuid(dev, uuid);
+	spin_unlock_irqrestore(&dev->fw_clients_lock, flags);
+	if (i < 0 || dev->fw_clients[i].props.fixed_address)
+		return NULL;
+
+	return &dev->fw_clients[i];
+}
+EXPORT_SYMBOL(ishtp_fw_cl_get_client);
+
+/**
  * ishtp_fw_cl_by_id() - return index to fw_clients for client_id
  * @dev: the ishtp device structure
  * @client_id: fw client id to search
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.h b/drivers/hid/intel-ish-hid/ishtp/bus.h
index 8888331..b8a5bcc 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.h
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.h
@@ -113,5 +113,7 @@ void	ishtp_cl_driver_unregister(struct ishtp_cl_driver *driver);
 int	ishtp_register_event_cb(struct ishtp_cl_device *device,
 				void (*read_cb)(struct ishtp_cl_device *));
 int	ishtp_fw_cl_by_uuid(struct ishtp_device *dev, const uuid_le *cuuid);
+struct	ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device *dev,
+						const uuid_le *uuid);
 
 #endif /* _LINUX_ISHTP_CL_BUS_H */
-- 
2.7.4
