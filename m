From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/4] x86: Trust firmware a bit more about presence of 8042
Date: Fri,  9 Dec 2016 12:57:37 -0800
Message-ID: <1481317061-31486-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34258 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbcLIU5p (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2016 15:57:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>

Hi,

Historically we did not trust PNP data regarding keyboard controllers on
X86, but more and more boards get upset with us if they try to tell us that
there is no keyboard controller and we still go and try to poke at where we
think it might be. To work around this issue let's have a bit more faith in
BIOS data, and if [lack] of PNP devices for mouse and keyboard matches whet
firmware (basically ACPI FADT) tells us, let's abort i8042 probe.

We add a new flag (enum) to x86_platform.legacy structure so we can
distinguish between cases where platform/subarch never has 8042 (such as
MID platform) and cases where firmware says that it is not there, so that
i8042 driver can either abort immediately or go and check for presence of
PNP devices. We also remove x86_platform.i8042_detect() as it is no longer
used (platforms can set value of x86_platform.legacy.i8042 as needed in
quirks).

If you are OK with arch/x86 changes please apply together with the input
part.

Thanks,
Dmitry

Dmitry Torokhov (4):
  x86/init: add i8042 state to the platform data
  Input: i8042 - trust firmware a bit more when probing on X86
  x86/init: remove i8042_detect() form platform ops
  x86/init: fix a couple typos in arch/x86/include/asm/x86_init.h

 arch/x86/include/asm/x86_init.h         | 26 +++++++++++++++++++++-----
 arch/x86/kernel/acpi/boot.c             |  7 +++++++
 arch/x86/kernel/platform-quirks.c       |  5 +++++
 arch/x86/kernel/x86_init.c              |  2 --
 arch/x86/platform/ce4100/ce4100.c       |  6 ------
 arch/x86/platform/intel-mid/intel-mid.c |  7 -------
 drivers/input/serio/i8042-x86ia64io.h   | 10 +++++++---
 7 files changed, 40 insertions(+), 23 deletions(-)

-- 
2.8.0.rc3.226.g39d4020

