From: Roel Kluin <12o3l@tiscali.nl>
Subject: [PATCH] Fix incorrect usage of strncpy and strncat in i8042_pnp_kbd_probe();
 drivers/input/serio/i8042-x86ia64io.h
Date: Mon, 05 Nov 2007 21:24:34 +0100
Message-ID: <472F7C02.9040600@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

See http://www.gratisoft.us/todd/papers/strlcpy.html
--
Fix incorrect length argument for  strncpy and strncat by replacing them with
respectively strlcpy and strlcat

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index f8fe421..4e6bd5f 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -288,6 +288,8 @@ static char i8042_pnp_aux_name[32];
 
 static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
+	const unsigned int nsize = sizeof(i8042_pnp_kbd_name);
+
 	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
 		i8042_pnp_data_reg = pnp_port_start(dev,0);
 
@@ -297,10 +299,16 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	if (pnp_irq_valid(dev,0))
 		i8042_pnp_kbd_irq = pnp_irq(dev, 0);
 
-	strncpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
+	if (strlcpy(i8042_pnp_kbd_name, did->id, nsize) >= nsize)
+		return -ENAMETOOLONG;
+
 	if (strlen(pnp_dev_name(dev))) {
-		strncat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
-		strncat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
+		if (strlcat(i8042_pnp_kbd_name, ":", nsize) >= nsize)
+			return -ENAMETOOLONG;
+
+		if (strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), nsize) >= nsize)
+			return -ENAMETOOLONG;
+
 	}
 
 	i8042_pnp_kbd_devices++;
@@ -309,6 +317,8 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 
 static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
 {
+	const unsigned int nsize = sizeof(i8042_pnp_aux_name);
+
 	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
 		i8042_pnp_data_reg = pnp_port_start(dev,0);
 
@@ -318,10 +328,15 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	if (pnp_irq_valid(dev, 0))
 		i8042_pnp_aux_irq = pnp_irq(dev, 0);
 
-	strncpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
+	if (strlcpy(i8042_pnp_aux_name, did->id, nsize) >= nsize)
+		return -ENAMETOOLONG;
+
 	if (strlen(pnp_dev_name(dev))) {
-		strncat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
-		strncat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
+		if (strlcat(i8042_pnp_aux_name, ":", nsize) >= nsize)
+			return -ENAMETOOLONG;
+
+		if (strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), nsize) >= nsize)
+			return -ENAMETOOLONG;
 	}
 
 	i8042_pnp_aux_devices++;
