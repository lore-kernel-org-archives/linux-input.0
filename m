From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 6/8] Input: psmouse - add support for SMBus companions
Date: Fri, 10 Mar 2017 18:55:09 +0100
Message-ID: <20170310175509.GA1221@mail.corp.redhat.com>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
 <20170309235308.GI20077@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755276AbdCJRzR (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 12:55:17 -0500
Content-Disposition: inline
In-Reply-To: <20170309235308.GI20077@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On Mar 09 2017 or thereabouts, Dmitry Torokhov wrote:
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> This provides glue between PS/2 devices that enumerate the RMI4 devices
> and Elan touchpads to the RMI4 (or Elan) SMBus driver.
> 
> The SMBus devices keep their PS/2 connection alive. If the initialization
> process goes too far (psmouse_activate called), the device disconnects
> from the I2C bus and stays on the PS/2 bus, that is why we explicitly
> disable PS/2 device reporting (by calling psmouse_deactivate) before
> trying to register SMBus companion device.
> 
> The HID over I2C devices are enumerated through the ACPI DSDT, and
> their PS/2 device also exports the InterTouch bit in the extended
> capability 0x0C. However, the firmware keeps its I2C connection open
> even after going further in the PS/2 initialization. We don't need
> to take extra precautions with those device, especially because they
> block their PS/2 communication when HID over I2C is used.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>

Hi Dmitry,

There is an issue with this patch. The platform_data provided by the
caller of psmouse_smbus_init() may be dereference, leading to a dangling
pointer on the stack in rmi4.

There is no guarantees rmi-smbus will get probed directly and even if it
does, a later rmmod/modprobe might happen and won't have access to the
platform data.

See below for a patch that solves this. Feel free to squash it, change it
and remove the terrible commit message.

>From a86f766de9c544a8d61da520719287c68a5f1bea Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 10 Mar 2017 18:31:01 +0100
Subject: [PATCH] Input: smbus companion - store the platform data for later
 use

The platform data should be available as long as the i2c_device exists.
In the current implementation, the platform data is allocated on the
stack, which gives a dangling pointer to the i2c_client once
psmouse_smbus_init() ends.

Duplicate the provided platform data in psmouse_smbus_init() so that
the allocation/free of pdata is handled by psmouse-smbus.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/psmouse-smbus.c | 18 ++++++++++++++++--
 drivers/input/mouse/psmouse.h       |  2 +-
 drivers/input/mouse/synaptics.c     |  5 ++---
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index 5bda551..6f603ec 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -20,6 +20,7 @@
 struct psmouse_smbus_dev {
 	struct psmouse *psmouse;
 	struct i2c_client *client;
+	void *pdata;
 	struct list_head node;
 	unsigned short addr;
 	bool dead;
@@ -166,6 +167,7 @@ static void psmouse_smbus_disconnect(struct psmouse *psmouse)
 		psmouse_smbus_schedule_remove(smbdev->client);
 	}
 
+	kfree(smbdev->pdata);
 	kfree(smbdev);
 	psmouse->private = NULL;
 }
@@ -205,6 +207,7 @@ void psmouse_smbus_cleanup(struct psmouse *psmouse)
 	list_for_each_entry_safe(smbdev, tmp, &psmouse_smbus_list, node) {
 		if (psmouse == smbdev->psmouse) {
 			list_del(&smbdev->node);
+			kfree(smbdev->pdata);
 			kfree(smbdev);
 		}
 	}
@@ -213,16 +216,26 @@ void psmouse_smbus_cleanup(struct psmouse *psmouse)
 }
 
 int psmouse_smbus_init(struct psmouse *psmouse, struct i2c_board_info *board,
-		       bool leave_breadcrumbs)
+		       void *pdata, size_t pdata_size, bool leave_breadcrumbs)
 {
 	struct psmouse_smbus_companion_req req;
 	struct psmouse_smbus_dev *smbdev;
+	struct i2c_board_info _board;
 	int error;
 
 	smbdev = kzalloc(sizeof(*smbdev), GFP_KERNEL);
 	if (!smbdev)
 		return -ENOMEM;
 
+	smbdev->pdata = kmemdup(pdata, pdata_size, GFP_KERNEL);
+	if (!smbdev->pdata) {
+		kfree(smbdev);
+		return -ENOMEM;
+	}
+
+	_board = *board;
+	_board.platform_data = smbdev->pdata;
+
 	smbdev->psmouse = psmouse;
 	smbdev->addr = board->addr;
 
@@ -240,7 +253,7 @@ int psmouse_smbus_init(struct psmouse *psmouse, struct i2c_board_info *board,
 	mutex_unlock(&psmouse_smbus_mutex);
 
 	/* Bind to already existing adapters right away */
-	req.board = board;
+	req.board = &_board;
 	req.client = &smbdev->client;
 	error = i2c_for_each_dev(&req, psmouse_smbus_create_companion);
 
@@ -254,6 +267,7 @@ int psmouse_smbus_init(struct psmouse *psmouse, struct i2c_board_info *board,
 		list_del(&smbdev->node);
 		mutex_unlock(&psmouse_smbus_mutex);
 
+		kfree(smbdev->pdata);
 		kfree(smbdev);
 	}
 
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 60e5e8d..a572e66 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -219,7 +219,7 @@ void psmouse_smbus_module_exit(void);
 struct i2c_board_info;
 
 int psmouse_smbus_init(struct psmouse *psmouse, struct i2c_board_info *board,
-		       bool leave_breadcrumbs);
+		       void *pdata, size_t pdata_size, bool leave_breadcrumbs);
 void psmouse_smbus_cleanup(struct psmouse *psmouse);
 
 #else /* !CONFIG_MOUSE_PS2_SMBUS */
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 5807504..95cdf21 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1708,12 +1708,11 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 	};
 	struct i2c_board_info intertouch_board = {
 		I2C_BOARD_INFO("rmi4_smbus", 0x2c),
-		.platform_data = &pdata,
 		.flags = I2C_CLIENT_HOST_NOTIFY,
 	};
 
-	return psmouse_smbus_init(psmouse, &intertouch_board,
-				  leave_breadcrumbs);
+	return psmouse_smbus_init(psmouse, &intertouch_board, &pdata,
+				  sizeof(pdata), leave_breadcrumbs);
 }
 
 /**
-- 
2.9.3

Cheers,
Benjamin
