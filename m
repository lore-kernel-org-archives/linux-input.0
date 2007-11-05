From: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH] Fix incorrect usage of strncpy and strncat in i8042_pnp_kbd_probe();
 drivers/input/serio/i8042-x86ia64io.h
Date: Mon, 05 Nov 2007 23:30:58 +0100
Message-ID: <472F99A2.9080209@tiscali.nl>
References: <472F7C02.9040600@tiscali.nl> <d120d5000711051308p62094becnce4fdb57cb30687a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000711051308p62094becnce4fdb57cb30687a@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> Hi Roel,
> 
> On Nov 5, 2007 3:24 PM, Roel Kluin <12o3l@tiscali.nl> wrote:
>> See http://www.gratisoft.us/todd/papers/strlcpy.html
>> --
>> Fix incorrect length argument for  strncpy and strncat by replacing them with
> 
> What is incorrect about the argument?

As explained in the article, strncpy and strncat should not get sizeof(target) as a
third argument, but rather, for strncpy 'sizeof(target) -1' and for strncat
'sizeof(target) - strlen(target) - 1'.

for strlcpy and strlcat sizeof(target) should be used. Also strncpy and strncat
zero out the remainder of the characters - if source is shorter than target - which
makes it slower than the strl- variants.

> I will gladly take a patch replacing strncat with strlcat but don't
> error out if the buffer is too small - it is oK if PNP name is printed
> truncated, it does not affect KBC operations.

Ok, updated patch below.

--
Fix incorrect length argument for strncpy and strncat by replacing them with
strlcpy and strlcat

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index f8fe421..1a739cf 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -297,10 +297,10 @@ static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	if (pnp_irq_valid(dev,0))
 		i8042_pnp_kbd_irq = pnp_irq(dev, 0);
 
-	strncpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
+	strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
 	if (strlen(pnp_dev_name(dev))) {
-		strncat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
-		strncat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
+		strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
+		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
 	}
 
 	i8042_pnp_kbd_devices++;
@@ -318,10 +318,10 @@ static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *
 	if (pnp_irq_valid(dev, 0))
 		i8042_pnp_aux_irq = pnp_irq(dev, 0);
 
-	strncpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
+	strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
 	if (strlen(pnp_dev_name(dev))) {
-		strncat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
-		strncat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
+		strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
+		strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
 	}
 
 	i8042_pnp_aux_devices++;
