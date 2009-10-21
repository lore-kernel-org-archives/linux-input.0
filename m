From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REPOST] [PATCH] Add support for OQO 01+ multimedia keys (fwd)
Date: Tue, 20 Oct 2009 21:49:36 -0700
Message-ID: <20091021044936.GA386@core.coreip.homeip.net>
References: <alpine.DEB.1.10.0906302300290.9420@woodchuck.wormnet.eu> <20091020013859.GD24370@core.coreip.homeip.net> <alpine.DEB.2.00.0910202110360.11516@bunsen.wrottesley.wormnet.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:37144 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbZJUEth (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2009 00:49:37 -0400
Received: by pxi1 with SMTP id 1so1946050pxi.33
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2009 21:49:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0910202110360.11516@bunsen.wrottesley.wormnet.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jamie Lentin <jamie@lentin.co.uk>
Cc: linux-input@vger.kernel.org

On Tue, Oct 20, 2009 at 09:12:38PM +0100, Jamie Lentin wrote:
> On Mon, 19 Oct 2009, Dmitry Torokhov wrote:
>
>> On Tue, Jun 30, 2009 at 11:06:49PM +0100, Jamie Lentin wrote:
>>> Apologies for reposting, but it'd be nice to get something along these
>>> lines merged.  If there's suggestions of other things I could try, or
>>> you'd prefer a patch to make the "up" and "down" keycodes auto-release,
>>> please let me know.
>>>
>>
>> I am sorry, I completely missed your patch and just now was going
>> through my inbox and saw it...
>
> Not to worry---so long as the patch wasn't so offensive you couldn't bring
> yourself to reply :)

;)

>
>> Could you please tell me if OQO has external PS/2 port?
>
> No, it has a PS/2 trackpoint and gravity mouse (easter-egg mode where the
> firmware turns accelerometer input into mouse) built-in, but I doubt
> they'll provide much useful info.
>

OK, I was just concerned about the scancode mangling screwing up
external keyboard but in absence of PS/2 ports this point is moot.

I rearranged the code a bit, could yo please try it out to make sure I
did not screw it up and I will apply it.

Thanks!

-- 
Dmitry


Input: Add support for OQO 01+ multimedia keys (fwd)

From: Jamie Lentin <jamie@lentin.co.uk>

OQO 01+ multimedia keys produce 6x on press, e0 6x upon release.
As a result, Linux thinks that another key has been pressed (or is
repeating), when it is actually a release of the same key. Mangle the
release scancode when running on OQO so that driver recognizes it as
such.

Since the device does not have external PS/2 ports mangling is safe
since there is no chance that an external keyboard is connected.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/atkbd.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)


diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index a651237..4452eab 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -233,6 +233,7 @@ struct atkbd {
  */
 static void (*atkbd_platform_fixup)(struct atkbd *, const void *data);
 static void *atkbd_platform_fixup_data;
+static unsigned int (*atkbd_platform_scancode_fixup)(struct atkbd *, unsigned int);
 
 static ssize_t atkbd_attr_show_helper(struct device *dev, char *buf,
 				ssize_t (*handler)(struct atkbd *, char *));
@@ -393,6 +394,9 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 
 	input_event(dev, EV_MSC, MSC_RAW, code);
 
+	if (atkbd_platform_scancode_fixup)
+		code = atkbd_platform_scancode_fixup(atkbd, code);
+
 	if (atkbd->translated) {
 
 		if (atkbd->emul || atkbd_need_xlate(atkbd->xl_bit, code)) {
@@ -923,6 +927,22 @@ static unsigned int atkbd_volume_forced_release_keys[] = {
 };
 
 /*
+ * OQO 01+ multimedia keys (64--66) generate e0 6x upon release whereas
+ * they should be generating e4-e6 (0x80 | code).
+ */
+static unsigned int atkbd_oqo_01plus_scancode_fixup(struct atkbd *atkbd,
+						    unsigned int code)
+{
+	if (atkbd->translated && atkbd->emul == 1 &&
+	    (code == 0x64 || code == 0x65 || code == 0x66)) {
+		atkbd->emul = 0;
+		code |= 0x80;
+	}
+
+	return code;
+}
+
+/*
  * atkbd_set_keycode_table() initializes keyboard's keycode table
  * according to the selected scancode set
  */
@@ -1527,6 +1547,13 @@ static int __init atkbd_setup_forced_release(const struct dmi_system_id *id)
 	return 0;
 }
 
+static int __init atkbd_setup_scancode_fixup(const struct dmi_system_id *id)
+{
+	atkbd_platform_scancode_fixup = id->driver_data;
+
+	return 0;
+}
+
 static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 	{
 		.ident = "Dell Laptop",
@@ -1663,6 +1690,15 @@ static struct dmi_system_id atkbd_dmi_quirk_table[] __initdata = {
 		.callback = atkbd_setup_forced_release,
 		.driver_data = atkdb_soltech_ta12_forced_release_keys,
 	},
+	{
+		.ident = "OQO Model 01+",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZEPTO"),
+		},
+		.callback = atkbd_setup_scancode_fixup,
+		.driver_data = atkbd_oqo_01plus_scancode_fixup,
+	},
 	{ }
 };
 
