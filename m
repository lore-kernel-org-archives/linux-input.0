From: Even Xu <even.xu@intel.com>
Subject: [PATCH 1/7] hid: intel-ish-hid: ishtp: add helper function for driver data get/set
Date: Fri, 23 Dec 2016 09:22:23 +0800
Message-ID: <1482456149-4841-1-git-send-email-even.xu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, srinivas.pandruvada@linux.intel.com, arnd@arndb.de, gregkh@linuxfoundation.org, andriy.shevchenko@intel.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
List-Id: linux-input@vger.kernel.org

Add helper function ishtp_set_drvdata() and ishtp_get_drvdata() for
different ISH client drivers to set/get private driver data.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 27 +++++++++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 2565215..40e13f1 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -562,6 +562,33 @@ void ishtp_put_device(struct ishtp_cl_device *cl_device)
 EXPORT_SYMBOL(ishtp_put_device);
 
 /**
+ * ishtp_set_drvdata() - set client driver data
+ * @cl_device:	client device instance
+ * @data:	driver data need to be set
+ *
+ * Set client driver data to cl_device->driver_data.
+ */
+void ishtp_set_drvdata(struct ishtp_cl_device *cl_device, void *data)
+{
+	cl_device->driver_data = data;
+}
+EXPORT_SYMBOL(ishtp_set_drvdata);
+
+/**
+ * ishtp_get_drvdata() - get client driver data
+ * @cl_device:	client device instance
+ *
+ * Get client driver data from cl_device->driver_data.
+ *
+ * Return: pointer of driver data
+ */
+void *ishtp_get_drvdata(struct ishtp_cl_device *cl_device)
+{
+	return cl_device->driver_data;
+}
+EXPORT_SYMBOL(ishtp_get_drvdata);
+
+/**
  * ishtp_bus_new_client() - Create a new client
  * @dev:	ISHTP device instance
  *
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.h b/drivers/hid/intel-ish-hid/ishtp/bus.h
index a1ffae7..8888331 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.h
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.h
@@ -101,6 +101,9 @@ void	ishtp_reset_compl_handler(struct ishtp_device *dev);
 void	ishtp_put_device(struct ishtp_cl_device *);
 void	ishtp_get_device(struct ishtp_cl_device *);
 
+void	ishtp_set_drvdata(struct ishtp_cl_device *cl_device, void *data);
+void	*ishtp_get_drvdata(struct ishtp_cl_device *cl_device);
+
 int	__ishtp_cl_driver_register(struct ishtp_cl_driver *driver,
 				   struct module *owner);
 #define ishtp_cl_driver_register(driver)		\
-- 
2.7.4
