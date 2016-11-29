From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 05/13] Input: synaptics-rmi4 - remove EXPORT_SYMBOL_GPL for internal functions
Date: Tue, 29 Nov 2016 11:08:16 +0100
Message-ID: <1480414104-8524-6-git-send-email-benjamin.tissoires@redhat.com>
References: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

those functions should not be used outside of rmi_core.ko.
There is no point in exporting them to the world.

It looks like rmi_read_pdt_entry() should be static too.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_driver.c | 15 ++-------------
 drivers/input/rmi4/rmi_driver.h |  3 ---
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 27c731a..a718e51 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -59,7 +59,6 @@ void rmi_free_function_list(struct rmi_device *rmi_dev)
 		rmi_unregister_function(fn);
 	}
 }
-EXPORT_SYMBOL_GPL(rmi_free_function_list);
 
 static int reset_one_function(struct rmi_function *fn)
 {
@@ -309,7 +308,6 @@ int rmi_enable_sensor(struct rmi_device *rmi_dev)
 
 	return rmi_process_interrupt_requests(rmi_dev);
 }
-EXPORT_SYMBOL_GPL(rmi_enable_sensor);
 
 /**
  * rmi_driver_set_input_params - set input device id and other data.
@@ -431,8 +429,8 @@ static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
 	return 0;
 }
 
-int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
-			u16 pdt_address)
+static int rmi_read_pdt_entry(struct rmi_device *rmi_dev,
+			      struct pdt_entry *entry, u16 pdt_address)
 {
 	u8 buf[RMI_PDT_ENTRY_SIZE];
 	int error;
@@ -455,7 +453,6 @@ int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rmi_read_pdt_entry);
 
 static void rmi_driver_copy_pdt_to_fd(const struct pdt_entry *pdt,
 				      struct rmi_function_descriptor *fd)
@@ -532,7 +529,6 @@ int rmi_scan_pdt(struct rmi_device *rmi_dev, void *ctx,
 
 	return retval < 0 ? retval : 0;
 }
-EXPORT_SYMBOL_GPL(rmi_scan_pdt);
 
 int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 				struct rmi_register_descriptor *rdesc)
@@ -664,7 +660,6 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 	kfree(struct_buf);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(rmi_read_register_desc);
 
 const struct rmi_register_desc_item *rmi_get_register_desc_item(
 				struct rmi_register_descriptor *rdesc, u16 reg)
@@ -680,7 +675,6 @@ const struct rmi_register_desc_item *rmi_get_register_desc_item(
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(rmi_get_register_desc_item);
 
 size_t rmi_register_desc_calc_size(struct rmi_register_descriptor *rdesc)
 {
@@ -694,7 +688,6 @@ size_t rmi_register_desc_calc_size(struct rmi_register_descriptor *rdesc)
 	}
 	return size;
 }
-EXPORT_SYMBOL_GPL(rmi_register_desc_calc_size);
 
 /* Compute the register offset relative to the base address */
 int rmi_register_desc_calc_reg_offset(
@@ -712,7 +705,6 @@ int rmi_register_desc_calc_reg_offset(
 	}
 	return -1;
 }
-EXPORT_SYMBOL_GPL(rmi_register_desc_calc_reg_offset);
 
 bool rmi_register_desc_has_subpacket(const struct rmi_register_desc_item *item,
 	u8 subpacket)
@@ -796,7 +788,6 @@ int rmi_initial_reset(struct rmi_device *rmi_dev, void *ctx,
 	/* F01 should always be on page 0. If we don't find it there, fail. */
 	return pdt->page_start == 0 ? RMI_SCAN_CONTINUE : -ENODEV;
 }
-EXPORT_SYMBOL_GPL(rmi_initial_reset);
 
 static int rmi_create_function(struct rmi_device *rmi_dev,
 			       void *ctx, const struct pdt_entry *pdt)
@@ -1015,7 +1006,6 @@ int rmi_probe_interrupts(struct rmi_driver_data *data)
 
 	return retval;
 }
-EXPORT_SYMBOL_GPL(rmi_probe_interrupts);
 
 int rmi_init_functions(struct rmi_driver_data *data)
 {
@@ -1054,7 +1044,6 @@ int rmi_init_functions(struct rmi_driver_data *data)
 	rmi_free_function_list(rmi_dev);
 	return retval;
 }
-EXPORT_SYMBOL_GPL(rmi_init_functions);
 
 static int rmi_driver_probe(struct device *dev)
 {
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index c9fe3d3..cc94585 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -51,9 +51,6 @@ struct pdt_entry {
 	u8 function_number;
 };
 
-int rmi_read_pdt_entry(struct rmi_device *rmi_dev, struct pdt_entry *entry,
-			u16 pdt_address);
-
 #define RMI_REG_DESC_PRESENSE_BITS	(32 * BITS_PER_BYTE)
 #define RMI_REG_DESC_SUBPACKET_BITS	(37 * BITS_PER_BYTE)
 
-- 
2.7.4
