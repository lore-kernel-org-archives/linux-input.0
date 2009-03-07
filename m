From: Matthew Garrett <mjg@redhat.com>
Subject: Re: suspend / hibernate nomenclature
Date: Sat, 7 Mar 2009 20:39:46 +0000
Message-ID: <20090307203946.GA9942@srcf.ucam.org>
References: <1235992429.3858.58.camel@hughsie-work.lan> <20090307154842.GA3947@srcf.ucam.org> <20090307164151.GB24668@khazad-dum.debian.net> <20090307164840.GA4800@srcf.ucam.org> <15e53e180903071225h47bcdbaj83986b50f06135c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56105 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbZCGUjv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Mar 2009 15:39:51 -0500
Content-Disposition: inline
In-Reply-To: <15e53e180903071225h47bcdbaj83986b50f06135c3@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On Sat, Mar 07, 2009 at 08:25:27PM +0000, Richard Hughes wrote:

> Xorg and evdev already does the right thing, we have XF86Hibernate
> now. All I have to do is patch HAL to check the kernel version and
> then everything in userspace we care about should just work. We have
> to sort out the insane mappings sooner or later, and what I've put in
> linux-next seems to be the right way of dong this, rather than the way
> things used to be (suspend -> hibernate, sleep->suspend,
> standby->sleep). I'm fed up of debugging why sleep buttons don't work
> right in userspace when the kernel isn't sure what button to emit.

We don't have to at all - as far as I've been able to tell, the kernel 
is utterly consistent in its current usage. The only drivers that emit 
KEY_SLEEP are either embedded-specific (where it's clearly suspend to 
RAM and not hibernate), the ACPI driver (where usage in other operating 
systems is consistent with it being suspent to RAM) and the panasonic 
and thinkpad drivers which use it consistently. If there's any 
confusion, it's over the fact that KEY_SUSPEND is is used for suspend to 
RAM in a (smaller) number of places.

I'd suggest reverting these current patches and doing something like the 
following and then changing any drivers where it's worth clarifying 
things. This has exactly the same effect with the advantage that no 
userspace needs to be changed.

diff --git a/include/linux/input.h b/include/linux/input.h
index 1249a0c..90abe27 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -263,7 +263,7 @@ struct input_absinfo {
 #define KEY_MENU		139	/* Menu (show menu) */
 #define KEY_CALC		140	/* AL Calculator */
 #define KEY_SETUP		141
-#define KEY_SLEEP		142	/* SC System Sleep */
+#define KEY_SUSPEND_TO_RAM	142	/* SC System Sleep */
 #define KEY_WAKEUP		143	/* System Wake Up */
 #define KEY_FILE		144	/* AL Local Machine Browser */
 #define KEY_SENDFILE		145
@@ -324,7 +324,7 @@ struct input_absinfo {
 #define KEY_PROG3		202
 #define KEY_PROG4		203
 #define KEY_DASHBOARD		204	/* AL Dashboard */
-#define KEY_SUSPEND		205
+#define KEY_HIBERNATE		205
 #define KEY_CLOSE		206	/* AC Close */
 #define KEY_PLAY		207
 #define KEY_FASTFORWARD		208
@@ -377,6 +377,10 @@ struct input_absinfo {
 
 /* Range 248 - 255 is reserved for special needs of AT keyboard driver */
 
+/* Deprecated - use KEY_SUSPEND_TO_RAM and KEY_HIBERNATE instead */
+#define KEY_SLEEP		KEY_SUSPEND_TO_RAM
+#define KEY_SUSPEND		KEY_HIBERNATE
+
 #define BTN_MISC		0x100
 #define BTN_0			0x100
 #define BTN_1			0x101

-- 
Matthew Garrett | mjg59@srcf.ucam.org
