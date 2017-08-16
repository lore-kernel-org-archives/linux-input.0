From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] Input: i8042: constify pnp_device_id
Date: Wed, 16 Aug 2017 11:11:42 +0530
Message-ID: <5b0366a4ca5786168a4ef8e80e7125f7afbd51c6.1502861813.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33833 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbdHPFly (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Aug 2017 01:41:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, tglx@linutronix.de, marcos.souza.org@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

pnp_device_id are not supposed to change at runtime. All functions
working with pnp_device_id provided by <linux/pnp.h> work with
const pnp_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/serio/i8042-x86ia64io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index f932a83..ae81e57 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -927,7 +927,7 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	return 0;
 }
 
-static struct pnp_device_id pnp_kbd_devids[] = {
+static const struct pnp_device_id pnp_kbd_devids[] = {
 	{ .id = "PNP0300", .driver_data = 0 },
 	{ .id = "PNP0301", .driver_data = 0 },
 	{ .id = "PNP0302", .driver_data = 0 },
@@ -957,7 +957,7 @@ static struct pnp_driver i8042_pnp_kbd_driver = {
 	},
 };
 
-static struct pnp_device_id pnp_aux_devids[] = {
+static const struct pnp_device_id pnp_aux_devids[] = {
 	{ .id = "AUI0200", .driver_data = 0 },
 	{ .id = "FJC6000", .driver_data = 0 },
 	{ .id = "FJC6001", .driver_data = 0 },
-- 
2.7.4

