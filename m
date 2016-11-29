From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 02/13] Input: synaptics-rmi4 - remove unused fields in struct rmi_driver_data
Date: Tue, 29 Nov 2016 11:08:13 +0100
Message-ID: <1480414104-8524-3-git-send-email-benjamin.tissoires@redhat.com>
References: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

These fields are not used anywhere, there is no point in carrying them.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 include/linux/rmi.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 27dd9aa..0b118ab 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -340,7 +340,6 @@ struct rmi_driver_data {
 	struct rmi_function *f34_container;
 	bool f01_bootloader_mode;
 
-	u32 attn_count;
 	int num_of_irq_regs;
 	int irq_count;
 	void *irq_memory;
@@ -352,14 +351,11 @@ struct rmi_driver_data {
 	struct input_dev *input;
 
 	u8 pdt_props;
-	u8 bsr;
 
 	u8 num_rx_electrodes;
 	u8 num_tx_electrodes;
 
 	bool enabled;
-
-	void *data;
 };
 
 int rmi_register_transport_device(struct rmi_transport_dev *xport);
-- 
2.7.4
