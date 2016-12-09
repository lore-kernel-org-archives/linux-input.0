From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/4] x86/init: fix a couple typos in arch/x86/include/asm/x86_init.h
Date: Fri,  9 Dec 2016 12:57:41 -0800
Message-ID: <1481317061-31486-5-git-send-email-dmitry.torokhov@gmail.com>
References: <1481317061-31486-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481317061-31486-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/x86/include/asm/x86_init.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 85b2ae5..7ba7e90 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -59,7 +59,7 @@ struct x86_init_irqs {
 
 /**
  * struct x86_init_oem - oem platform specific customizing functions
- * @arch_setup:			platform specific architecure setup
+ * @arch_setup:			platform specific architecture setup
  * @banner:			print a platform specific banner
  */
 struct x86_init_oem {
@@ -208,12 +208,12 @@ struct x86_legacy_features {
  * @nmi_init			enable NMI on cpus
  * @save_sched_clock_state:	save state for sched_clock() on suspend
  * @restore_sched_clock_state:	restore state for sched_clock() on resume
- * @apic_post_init:		adjust apic if neeeded
+ * @apic_post_init:		adjust apic if needed
  * @legacy:			legacy features
  * @set_legacy_features:	override legacy features. Use of this callback
  * 				is highly discouraged. You should only need
  * 				this if your hardware platform requires further
- * 				custom fine tuning far beyong what may be
+ * 				custom fine tuning far beyond what may be
  * 				possible in x86_early_init_platform_quirks() by
  * 				only using the current x86_hardware_subarch
  * 				semantics.
-- 
2.8.0.rc3.226.g39d4020
