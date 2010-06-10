From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: fixup X86_MRST selects
Date: Thu, 10 Jun 2010 12:04:45 -0700
Message-ID: <201006101204.45709.dmitry.torokhov@gmail.com>
References: <20100609133443.38f1f957.sfr@canb.auug.org.au> <201006091540.43122.dmitry.torokhov@gmail.com> <4C1018C0.6020304@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48161 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab0FODPj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 23:15:39 -0400
In-Reply-To: <4C1018C0.6020304@oracle.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jacob Pan <jacob.jun.pan@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, akpm <akpm@linux-foundation.org>

On Wednesday, June 09, 2010 03:42:08 pm Randy Dunlap wrote:
> On 06/09/10 15:40, Dmitry Torokhov wrote:
> > On Wednesday, June 09, 2010 03:29:21 pm Randy Dunlap wrote:
> >> +++ linux-next-20100609/drivers/input/keyboard/Kconfig
> >> @@ -70,9 +70,10 @@ config KEYBOARD_ATARI
> >>  
> >>  config KEYBOARD_ATKBD
> >>         tristate "AT keyboard" if EMBEDDED || !X86
> >> +       depends on !X86 || (X86 && !X86_MRST)
> > 
> > Should it be simply 'depends on !X86_MRST' and then we could kill
> > '!X86_MRST' conditionals in selects?
> 
> Duh, that sounds good, yes.

Actually, I do not think this is a correct approach. While Moorestown does
not have i8042 theoretically it is possible to add AT-style keyboard by
other means (however unlikely it is) so we should not be disabling it.

We should, however, disallow i8042 from being selected. Could you please
tell me if the patch below works for you?

Thanks!

-- 
Dmitry

Input: fixup X86_MRST selects

From: Randy Dunlap <randy.dunlap@oracle.com>

Some of the recent X86_MRST additions make some "select"s
conditional on X86_MRST but missed some related kconfig symbols,
causing:

drivers/built-in.o: In function `ps2_end_command':
(.text+0x257ab2): undefined reference to `i8042_check_port_owner'
drivers/built-in.o: In function `ps2_end_command':
(.text+0x257ae1): undefined reference to `i8042_unlock_chip'
drivers/built-in.o: In function `ps2_begin_command':
(.text+0x257b40): undefined reference to `i8042_check_port_owner'
drivers/built-in.o: In function `ps2_begin_command':
(.text+0x257b6f): undefined reference to `i8042_lock_chip'

when SERIO_I8042=m, SERIO_LIBPS2=y, KEYBOARD_ATKBD=y.

We need to make i8042 dependant upon !X86_MRST and allow deselecting
atkbd on Moorestown even when !CONFIG_EMBEDDED.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/Kconfig |    2 +-
 drivers/input/serio/Kconfig    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index 9522b89..d3a99de 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -69,7 +69,7 @@ config KEYBOARD_ATARI
 	  module will be called atakbd.
 
 config KEYBOARD_ATKBD
-	tristate "AT keyboard" if EMBEDDED || !X86
+	tristate "AT keyboard" if EMBEDDED || !X86 || X86_MRST
 	default y
 	select SERIO
 	select SERIO_LIBPS2
diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 3bfe8fa..256b9e9 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -22,7 +22,7 @@ config SERIO_I8042
 	tristate "i8042 PC Keyboard controller" if EMBEDDED || !X86
 	default y
 	depends on !PARISC && (!ARM || ARCH_SHARK || FOOTBRIDGE_HOST) && \
-		   (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN
+		   (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN && !X86_MRST
 	help
 	  i8042 is the chip over which the standard AT keyboard and PS/2
 	  mouse are connected to the computer. If you use these devices,
