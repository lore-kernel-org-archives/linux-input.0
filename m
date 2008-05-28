From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH 2/3] ACPI: Send switch event on dock events
Date: Wed, 28 May 2008 14:21:52 +0100
Message-ID: <20080528132152.GB32646@srcf.ucam.org>
References: <20080523160955.GA19674@srcf.ucam.org> <20080528130621.GA32646@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751985AbYE1NWX@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080528130621.GA32646@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linu-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, kristen.c.accardi@intel.com
List-Id: linux-input@vger.kernel.org

Send a switch event on docking for consistency with docks that don't 
present as a separate device.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index fa44fb9..a67e74c 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/types.h>
 #include <linux/notifier.h>
 #include <linux/platform_device.h>
@@ -65,6 +66,7 @@ struct dock_station {
 	struct mutex hp_lock;
 	struct list_head dependent_devices;
 	struct list_head hotplug_devices;
+	struct input_dev *dock_input;
 };
 
 struct dock_dependent_device {
@@ -345,10 +347,13 @@ static void dock_event(struct dock_station *ds, u32 event, int num)
 	char event_string[13];
 	char *envp[] = { event_string, NULL };
 
-	if (num == UNDOCK_EVENT)
+	if (num == UNDOCK_EVENT) {
+		input_report_switch(dock_station->dock_input, SW_DOCK, 0);
 		sprintf(event_string, "EVENT=undock");
-	else
+	} else {
+		input_report_switch(dock_station->dock_input, SW_DOCK, 1);
 		sprintf(event_string, "EVENT=dock");
+	}
 
 	/*
 	 * Indicate that the status of the dock station has
@@ -834,6 +839,19 @@ static int dock_add(acpi_handle handle)
 		goto dock_add_err;
 	}
 
+	/* Set up input device */
+	dock_station->dock_input = input_allocate_device();
+	dock_station->dock_input->name = "ACPI dock";
+	dock_station->dock_input->phys = "dock/input0";
+	dock_station->dock_input->id.bustype = BUS_HOST;
+	dock_station->dock_input->dev.parent = &dock_device->dev;
+	set_bit(EV_SW, dock_station->dock_input->evbit);
+	set_bit(SW_DOCK, dock_station->dock_input->swbit);
+	ret = input_register_device(dock_station->dock_input);
+
+	if (ret)
+		input_free_device(dock_station->dock_input);
+
 	printk(KERN_INFO PREFIX "%s \n", ACPI_DOCK_DRIVER_DESCRIPTION);
 
 	return 0;
@@ -881,6 +899,8 @@ static int dock_remove(void)
 	device_remove_file(&dock_device->dev, &dev_attr_flags);
 	platform_device_unregister(dock_device);
 
+	input_unregister_device(dock_station->dock_input);
+
 	/* free dock station memory */
 	kfree(dock_station);
 	dock_station = NULL;

-- 
Matthew Garrett | mjg59@srcf.ucam.org
