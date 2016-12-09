From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/4] x86/init: remove i8042_detect() form platform ops
Date: Fri,  9 Dec 2016 12:57:40 -0800
Message-ID: <1481317061-31486-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1481317061-31486-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481317061-31486-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>
List-Id: linux-input@vger.kernel.org

Now that i8042 uses flag in legacy platform data, i8042_detect() is
no longer used and can be removed.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/x86/include/asm/x86_init.h         | 2 --
 arch/x86/kernel/x86_init.c              | 2 --
 arch/x86/platform/ce4100/ce4100.c       | 6 ------
 arch/x86/platform/intel-mid/intel-mid.c | 7 -------
 4 files changed, 17 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c4d09c7..85b2ae5 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -206,7 +206,6 @@ struct x86_legacy_features {
  * @set_wallclock:		set time back to HW clock
  * @is_untracked_pat_range	exclude from PAT logic
  * @nmi_init			enable NMI on cpus
- * @i8042_detect		pre-detect if i8042 controller exists
  * @save_sched_clock_state:	save state for sched_clock() on suspend
  * @restore_sched_clock_state:	restore state for sched_clock() on resume
  * @apic_post_init:		adjust apic if neeeded
@@ -228,7 +227,6 @@ struct x86_platform_ops {
 	bool (*is_untracked_pat_range)(u64 start, u64 end);
 	void (*nmi_init)(void);
 	unsigned char (*get_nmi_reason)(void);
-	int (*i8042_detect)(void);
 	void (*save_sched_clock_state)(void);
 	void (*restore_sched_clock_state)(void);
 	void (*apic_post_init)(void);
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 76c5e52..ca85d20 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -89,7 +89,6 @@ struct x86_cpuinit_ops x86_cpuinit = {
 };
 
 static void default_nmi_init(void) { };
-static int default_i8042_detect(void) { return 1; };
 
 struct x86_platform_ops x86_platform = {
 	.calibrate_cpu			= native_calibrate_cpu,
@@ -100,7 +99,6 @@ struct x86_platform_ops x86_platform = {
 	.is_untracked_pat_range		= is_ISA_range,
 	.nmi_init			= default_nmi_init,
 	.get_nmi_reason			= default_get_nmi_reason,
-	.i8042_detect			= default_i8042_detect,
 	.save_sched_clock_state 	= tsc_save_sched_clock_state,
 	.restore_sched_clock_state 	= tsc_restore_sched_clock_state,
 };
diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index b27bccd..a783caf 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -23,11 +23,6 @@
 #include <asm/io_apic.h>
 #include <asm/emergency-restart.h>
 
-static int ce4100_i8042_detect(void)
-{
-	return 0;
-}
-
 /*
  * The CE4100 platform has an internal 8051 Microcontroller which is
  * responsible for signaling to the external Power Management Unit the
@@ -145,7 +140,6 @@ static void sdv_pci_init(void)
 void __init x86_ce4100_early_setup(void)
 {
 	x86_init.oem.arch_setup = sdv_arch_setup;
-	x86_platform.i8042_detect = ce4100_i8042_detect;
 	x86_init.resources.probe_roms = x86_init_noop;
 	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
 	x86_init.mpparse.find_smp_config = x86_init_noop;
diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index ce119d2..cf8ff1c 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -156,12 +156,6 @@ out:
 	regulator_has_full_constraints();
 }
 
-/* MID systems don't have i8042 controller */
-static int intel_mid_i8042_detect(void)
-{
-	return 0;
-}
-
 /*
  * Moorestown does not have external NMI source nor port 0x61 to report
  * NMI status. The possible NMI sources are from pmu as a result of NMI
@@ -192,7 +186,6 @@ void __init x86_intel_mid_early_setup(void)
 	x86_cpuinit.setup_percpu_clockev = apbt_setup_secondary_clock;
 
 	x86_platform.calibrate_tsc = intel_mid_calibrate_tsc;
-	x86_platform.i8042_detect = intel_mid_i8042_detect;
 	x86_init.timers.wallclock_init = intel_mid_rtc_init;
 	x86_platform.get_nmi_reason = intel_mid_get_nmi_reason;
 
-- 
2.8.0.rc3.226.g39d4020
