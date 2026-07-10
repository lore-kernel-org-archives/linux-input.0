Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31553B4EAA;
	Fri, 10 Jul 2026 21:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718366; cv=none; b=YKdNAiW4TEEapJgMsZJH0Mn5y/Q7pPBuouCjqkMWpJEM/0r1VpwciZv2TvSo2pXhPLF1y3cWHRH9HdLuLfQ9dY8IdH5AFAxj2ccZI+nysNu3BVBizExh/bTDJFSHOggFnqk2d8jh1rOvM7AzqWiPOWHFMenwKgsnBVtJR6UUYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718366; c=relaxed/simple;
	bh=KCoIXftqxvMIlbHd/+Q6zDopubqMGimatUiAU9Ob5KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKUyL9nGHmuDojtlqGxjl98ot+I4x1421fBxbdkSeFLLsZ/RX73qsdbVZOqAIkCEiB4ghkvCQ44FgS1swLVTtboHo6pMCPSI69/qydWON3JIYkJEUr9GGRdXZh7/pIgiRovDgRYd5kU7r2akcm5mKd4+Qd7YLwuv2OUgF6mRVuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frHDnkcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frHDnkcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742011F00A3A;
	Fri, 10 Jul 2026 21:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718364;
	bh=eZanIfnrkhP9ZJDH71JStizixWoWH6JYnaCWx4Prg74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=frHDnkcmDBR2gIGW6aGRXiWv4G5ZYB91kx0gxe8CdCfdQHmI79WhcGESdkJhQ63pg
	 5lsf0E7xuFouqbEeXSxoX3TUa0W1f/9CmjtipWDlzEaPSvapFKNjrKlCu6KU3MoA45
	 pXfNZkt9PF9di3zH/XlFp+dEwptS3eo/oAPFrhCMQsroaznqd6t57BArO61pquqBJM
	 y+bSH7vEgNLCJlL2e5NRz0qZh8ElTB2o0dKC7beZJliROAiPe9bjY3g050Mely+5oQ
	 odTg0N/kxyryN/aMIw29GZ613D/2u77+e2S4nFhXZHQUr38MzBxuByIsLMK9xgU9ji
	 jVuAySxP6lxlQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-gpio@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 5/6] [v6] x86/olpc: select GPIOLIB_LEGACY
Date: Fri, 10 Jul 2026 23:18:53 +0200
Message-Id: <20260710211854.1371746-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260710211854.1371746-1-arnd@kernel.org>
References: <20260710211854.1371746-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The OLPC GPIO controller sets up a fixed number space that is used
by at least two drivers:

arch/x86/platform/olpc/olpc-xo1-sci.c: In function 'setup_ec_sci':
arch/x86/platform/olpc/olpc-xo1-sci.c:358:13: error: implicit declaration of function 'gpio_request' [-Wimplicit-function-declaration]
  358 |         r = gpio_request(OLPC_GPIO_ECSCI, "OLPC-ECSCI");
      |             ^~~~~~~~~~~~
sound/pci/cs5535audio/cs5535audio_olpc.c: In function 'olpc_analog_input':
sound/pci/cs5535audio/cs5535audio_olpc.c:41:9: error: implicit declaration of function 'gpio_set_value'; did you mean 'gpiod_set_value'? [-Wimplicit-function-declaration]
   41 |         gpio_set_value(OLPC_GPIO_MIC_AC, on);

The AMD Geode platform that this is based on is now marked as
'Orphaned' in Kconfig, and it is likely that there are no XO1
users on modern kernels, but so far there is no consensus on
removing it entirely.

Select CONFIG_GPIOLIB_LEGACY for this platform and make sure the
sound driver portion cannot be compiled without this.

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v3..v5: no changes
    v2: update changelog text
---
 arch/x86/Kconfig                         | 1 +
 arch/x86/platform/olpc/olpc-xo1-sci.c    | 2 +-
 sound/pci/Kconfig                        | 1 +
 sound/pci/cs5535audio/cs5535audio_olpc.c | 2 +-
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..4ad8a7bbd93d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2976,6 +2976,7 @@ config OLPC
 	bool "One Laptop Per Child support"
 	depends on !X86_PAE
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select OF
 	select OF_PROMTREE
 	select IRQ_DOMAIN
diff --git a/arch/x86/platform/olpc/olpc-xo1-sci.c b/arch/x86/platform/olpc/olpc-xo1-sci.c
index 30751b42d54e..a5b47960ba32 100644
--- a/arch/x86/platform/olpc/olpc-xo1-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo1-sci.c
@@ -9,7 +9,7 @@
 
 #include <linux/cs5535.h>
 #include <linux/device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/legacy.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index e0996a9d90b0..6366f72b3667 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -300,6 +300,7 @@ config SND_CS5535AUDIO
 	tristate "CS5535/CS5536 Audio"
 	depends on X86_32 || MIPS || COMPILE_TEST
 	depends on HAS_IOPORT
+	depends on GPIOLIB_LEGACY || !OLPC
 	select SND_PCM
 	select SND_AC97_CODEC
 	help
diff --git a/sound/pci/cs5535audio/cs5535audio_olpc.c b/sound/pci/cs5535audio/cs5535audio_olpc.c
index 122170a410d9..cfdcc5bf4341 100644
--- a/sound/pci/cs5535audio/cs5535audio_olpc.c
+++ b/sound/pci/cs5535audio/cs5535audio_olpc.c
@@ -9,7 +9,7 @@
 #include <sound/info.h>
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
-#include <linux/gpio.h>
+#include <linux/gpio/legacy.h>
 
 #include <asm/olpc.h>
 #include "cs5535audio.h"
-- 
2.39.5

