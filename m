From: Andrew Duggan <andrew@duggan.us>
Subject: [PATCH] Input: synaptics-rmi4: Fix register descriptor subpacket map construction
Date: Thu, 18 Aug 2016 12:05:33 -0700
Message-ID: <1471547133-26819-1-git-send-email-andrew@duggan.us>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Nitin Chaudhary <nitinchaudhary1289@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Andrew Duggan <aduggan@synaptics.com>

The map_offset variable is specific to the register and needs to be reset
in the loop. Otherwise, subsequent register's subpacket maps will have
their bits set at the wrong index. This results in the max X and Y and
the resolution to not be set on some devices which use F12.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Tested-by: Nitin Chaudhary <nitinchaudhary1289@gmail.com>
Cc: stable@vger.kernel.org
---
In rmi_f12_read_sensor_tuning() we call rmi_register_desc_has_subpacket()
to check the subpacket map to make sure a subpacket exists to ensure that
the buffer contains the correct data. It happened that on my the test
devices the register we were checking was also the first register. This
issues showed up on newer devices where F12 CTRL 8 is not teh first control
register.

Thanks,
Andrew

 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 2b6b97e..19843f1 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -553,10 +553,10 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
 		goto free_struct_buff;
 
 	reg = find_first_bit(rdesc->presense_map, RMI_REG_DESC_PRESENSE_BITS);
-	map_offset = 0;
 	for (i = 0; i < rdesc->num_registers; i++) {
 		struct rmi_register_desc_item *item = &rdesc->registers[i];
 		int reg_size = struct_buf[offset];
+		map_offset = 0;
 
 		++offset;
 		if (reg_size == 0) {
-- 
2.7.4
