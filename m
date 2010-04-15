From: David =?utf-8?b?SMOkcmRlbWFu?= <david@hardeman.nu>
Subject: [PATCH 5/8] ir-core: convert mantis from ir-functions.c
Date: Thu, 15 Apr 2010 23:46:20 +0200
Message-ID: <20100415214620.14142.19939.stgit@localhost.localdomain>
References: <20100415214520.14142.56114.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20100415214520.14142.56114.stgit@localhost.localdomain>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@redhat.com
Cc: linux-media@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Convert drivers/media/dvb/mantis/mantis_input.c to not use ir-functions=
=2Ec
(The driver is anyway not complete enough to actually use the subsystem=
 yet).

Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>
---
 0 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/drivers/media/dvb/mantis/mantis_input.c b/drivers/media/dv=
b/mantis/mantis_input.c
index 3d4e466..a99489b 100644
--- a/drivers/media/dvb/mantis/mantis_input.c
+++ b/drivers/media/dvb/mantis/mantis_input.c
@@ -19,7 +19,7 @@
 */
=20
 #include <linux/input.h>
-#include <media/ir-common.h>
+#include <media/ir-core.h>
 #include <linux/pci.h>
=20
 #include "dmxdev.h"
@@ -104,7 +104,6 @@ EXPORT_SYMBOL_GPL(ir_mantis);
 int mantis_input_init(struct mantis_pci *mantis)
 {
 	struct input_dev *rc;
-	struct ir_input_state rc_state;
 	char name[80], dev[80];
 	int err;
=20
@@ -120,8 +119,6 @@ int mantis_input_init(struct mantis_pci *mantis)
 	rc->name =3D name;
 	rc->phys =3D dev;
=20
-	ir_input_init(rc, &rc_state, IR_TYPE_OTHER);
-
 	rc->id.bustype	=3D BUS_PCI;
 	rc->id.vendor	=3D mantis->vendor_id;
 	rc->id.product	=3D mantis->device_id;
