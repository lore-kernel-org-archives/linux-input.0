From: Jamie Lentin <jamie@lentin.co.uk>
Subject: [REPOST] [PATCH] Add support for OQO 01+ multimedia keys (fwd)
Date: Tue, 30 Jun 2009 23:06:49 +0100 (BST)
Message-ID: <alpine.DEB.1.10.0906302300290.9420@woodchuck.wormnet.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from woodchuck.wormnet.eu ([77.75.105.223]:56027 "EHLO
	woodchuck.wormnet.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020AbZF3WGr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jun 2009 18:06:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Apologies for reposting, but it'd be nice to get something along these 
lines merged.  If there's suggestions of other things I could try, or 
you'd prefer a patch to make the "up" and "down" keycodes auto-release, 
please let me know.

Many thanks,

---------- Forwarded message ----------
Date: Thu, 30 Apr 2009 22:35:51 +0100 (BST)
From: Jamie Lentin <jm@lentin.co.uk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org
Subject: [PATCH] Add support for OQO 01+ multimedia keys

OQO 01+ multimedia keys produce 6x on press, e0 6x upon release. As a
result, Linux thinks that another key has been pressed (or is repeating), 
when it is actually a release of the same key.  Remap e0 6x to a release of 
6x.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---

Comments welcome---I'm rather aware that I'm adding a fair chunk of extra
code for 3 keys on a fairly obscure device and that my C is rusty to say
the least, but I thought I'd give it a go anyway.  If there are major
objections to this, my fallback plan is to make both 6x and e0 6x
auto-release, which may in fact be preferred.  If I've missed something
really obvious please point it out :)

  drivers/input/keyboard/atkbd.c |   41 
+++++++++++++++++++++++++++++++++++++++-
  1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c 
b/drivers/input/keyboard/atkbd.c
index 444dec0..ecf9e9d 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -227,10 +227,12 @@ struct atkbd {
  };

  /*
- * System-specific ketymap fixup routine
+ * System-specific keymap fixup routine
   */
  static void (*atkbd_platform_fixup)(struct atkbd *, const void *data);
  static void *atkbd_platform_fixup_data;
+static unsigned int (*atkbd_platform_fixup_function)(struct atkbd *,
+				unsigned int);

  static ssize_t atkbd_attr_show_helper(struct device *dev, char *buf,
  				ssize_t (*handler)(struct atkbd *, char 
*));
@@ -431,6 +433,12 @@ static irqreturn_t atkbd_interrupt(struct serio 
*serio, unsigned char data,

  	code = atkbd_compat_scancode(atkbd, code);

+	/*
+	 * Perform platform-specific fixups
+	 */
+	if (unlikely(atkbd_platform_fixup_function))
+		code = atkbd_platform_fixup_function(atkbd, code);
+
  	if (atkbd->emul && --atkbd->emul)
  		goto out;

@@ -895,6 +903,21 @@ static unsigned int 
atkbd_amilo_pa1510_forced_release_keys[] = {
  };

  /*
+ * OQO 01+ multimedia keys (64--66), say e0 6x when they mean f0 6x, i.e. 
upon
+ * release. Remap e4--e6 (from compat_scancode) to a release of 64--66.
+ */
+static unsigned int atkbd_oqo_01plus_remap_release_keys(struct atkbd 
*atkbd,
+				unsigned int code)
+{
+	if (code == 0xe4 || code == 0xe5 || code == 0xe6) {
+		atkbd->release = 1;
+		code &= 0x7f;
+	}
+
+	return code;
+}
+
+/*
   * atkbd_set_keycode_table() initializes keyboard's keycode table
   * according to the selected scancode set
   */
@@ -1478,6 +1501,13 @@ static int __init atkbd_setup_forced_release(const 
struct dmi_system_id *id)
  	return 0;
  }

+static int __init atkbd_setup_inline_fix(const struct dmi_system_id *id)
+{
+	atkbd_platform_fixup_function = id->driver_data;
+
+	return 0;
+}
+
  static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
  	{
  		.ident = "Dell Laptop",
@@ -1560,6 +1590,15 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] 
__initdata = {
  		.callback = atkbd_setup_forced_release,
  		.driver_data = atkbd_amilo_pa1510_forced_release_keys,
  	},
+	{
+		.ident = "OQO Model 01+",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZEPTO"),
+		},
+		.callback = atkbd_setup_inline_fix,
+		.driver_data = atkbd_oqo_01plus_remap_release_keys,
+	},
  	{ }
  };

-- 
1.6.2.1

