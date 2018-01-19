From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] Input: synaptics-rmi4 - log when we create a guest serio port
Date: Thu, 18 Jan 2018 16:49:55 -0800
Message-ID: <20180119004955.247190-4-dmitry.torokhov@gmail.com>
References: <20180119004955.247190-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180119004955.247190-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Lyude Paul <thatslyude@gmail.com>, Damjan Georgievski <gdamjan@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Duggan <aduggan@synaptics.com>
List-Id: linux-input@vger.kernel.org

To ease analyzing boot behavior from logs, let's log when we are about to
register the pass-through serio port.

Also, let's drop "Synaptics" prefix from the port name, as RMI4 is good
enough indicator already, and having the prefix means that the name does
not fit into serio->name field. While at it move from hard-coded seio->phys
to one mentioning the sensor ID (such as "rmi4-00.fn03/serio0").

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f03.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index 7ccbb370a9a81..88822196d6b72 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -184,14 +184,15 @@ static int rmi_f03_register_pt(struct f03_data *f03)
 	serio->close = rmi_f03_pt_close;
 	serio->port_data = f03;
 
-	strlcpy(serio->name, "Synaptics RMI4 PS/2 pass-through",
-		sizeof(serio->name));
-	strlcpy(serio->phys, "synaptics-rmi4-pt/serio1",
-		sizeof(serio->phys));
+	strlcpy(serio->name, "RMI4 PS/2 pass-through", sizeof(serio->name));
+	snprintf(serio->phys, sizeof(serio->phys), "%s/serio0",
+		 dev_name(&f03->fn->dev));
 	serio->dev.parent = &f03->fn->dev;
 
 	f03->serio = serio;
 
+	printk(KERN_INFO "serio: %s port at %s\n",
+		serio->name, dev_name(&f03->fn->dev));
 	serio_register_port(serio);
 
 	return 0;
-- 
2.16.0.rc1.238.g530d649a79-goog
