Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B9407CF0;
	Mon, 29 Jun 2026 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738230; cv=none; b=nVQJpWEDbN5y+6m0cA9e/r8pi+HpCimCIE+x/qo/oMMpkh7sQ3/MkZ6jUPBZgrU2iRDYLCKZ6DNvL4VFVmXEJK1y+7jMxAO2cCFReWsa+BUdPPDVWH3WwSrsnGBa5RPESo9cukT2R6GDljJt9FBFIfvLfEcU0g8YT+ztjEVRv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738230; c=relaxed/simple;
	bh=QxZGvrOIN0fSMKxM7XYCXodrrxEoocN4xSyCDnHnW00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLcAtuCqQ+ClrGHkLcWOeVFTbJKI614wvUYPO4Gndukp6YqGjytqpi7ja7mUlQhhbWcMGRCnphGnHtx9vPSW3Xm+rhp/XoZ6yXWv1PM/AYU9sf8y5i24j8SGXqez9Skon2tJwnyJchTBLyP/VaIcqi/cmYOyruZ+wNce3r6uuJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayu5fucu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayu5fucu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50011F000E9;
	Mon, 29 Jun 2026 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782738229;
	bh=/KDLXd4EonMqcbqH12ZdRT21OBdHeMxLOstM2OQjqkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ayu5fucum1ifUqmcCpgQYrDnmdQJ273pZ6EnZJ2nT0bkE8AY3LOBFdDtnmZx4PHEi
	 CgLLiYW1o5T6MpIrBjBxMlM+LicAoU/587Pq+FIJCmXHh6mFsg5u5V8pThLFtYLbdi
	 6mj1f6JU/Nwg7TbjuSycWvI8bndl6I34O5P+cv8KLZj7GnWpj5qJprePU1rHYgE5ry
	 hIxfp1qMgD7STi161QfakLUc6y8cmnt0ggfFaDhcRnfHBEKd69C9zFQ6eyP8cUqzrp
	 2nA3P+CA+GawU3psXdhuVm1GPauumhcp66O4ANzdzkUBkL3UlllRfwcGBgzn+qywxi
	 D3YQ6rxn/Eo8Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-gpio@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH 1/6] [v5] sh: select legacy gpiolib interface
Date: Mon, 29 Jun 2026 15:03:24 +0200
Message-Id: <20260629130329.1291953-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260629130329.1291953-1-arnd@kernel.org>
References: <20260629130329.1291953-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Many board files on sh reference the legacy gpiolib interfaces that
are becoming optional. To ensure the boards can keep building, select
CONFIG_GPIOLIB_LEGACY on each of the boards that have one of the
hardcoded calls.

Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2..v5: no changes. The patch did not make it into v7.2-rc1, so
        I'm keeping it with the rest of the series
---
 arch/sh/Kconfig                        | 1 +
 arch/sh/boards/Kconfig                 | 8 ++++++++
 arch/sh/boards/mach-highlander/Kconfig | 1 +
 arch/sh/boards/mach-rsk/Kconfig        | 3 +++
 4 files changed, 13 insertions(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index d5795067befa..d60f1d5a94c0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -462,6 +462,7 @@ config CPU_SUBTYPE_SHX3
 	select CPU_SHX3
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select PINCTRL
 
 # SH4AL-DSP Processor Support
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 1af93be61b1f..d89b74177233 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -80,6 +80,7 @@ config SH_7724_SOLUTION_ENGINE
 	select SOLUTION_ENGINE
 	depends on CPU_SUBTYPE_SH7724
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	imply SND_SOC_AK4642 if SND_SIMPLE_CARD
 	help
@@ -199,6 +200,7 @@ config SH_SH7757LCR
 	bool "SH7757LCR"
 	depends on CPU_SUBTYPE_SH7757
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
 config SH_SH7785LCR
@@ -226,6 +228,7 @@ config SH_URQUELL
 	bool "Urquell"
 	depends on CPU_SUBTYPE_SH7786
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select HAVE_PCI
 	select NO_IOPORT_MAP if !PCI
 
@@ -233,6 +236,7 @@ config SH_MIGOR
 	bool "Migo-R"
 	depends on CPU_SUBTYPE_SH7722
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
@@ -242,6 +246,7 @@ config SH_AP325RXA
 	bool "AP-325RXA"
 	depends on CPU_SUBTYPE_SH7723
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Renesas "AP-325RXA" support.
@@ -251,6 +256,7 @@ config SH_KFR2R09
 	bool "KFR2R09"
 	depends on CPU_SUBTYPE_SH7724
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  "Kit For R2R for 2009" support.
@@ -259,6 +265,7 @@ config SH_ECOVEC
 	bool "EcoVec"
 	depends on CPU_SUBTYPE_SH7724
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	imply SND_SOC_DA7210 if SND_SIMPLE_CARD
 	help
@@ -329,6 +336,7 @@ config SH_MAGIC_PANEL_R2
 	bool "Magic Panel R2"
 	depends on CPU_SUBTYPE_SH7720
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Magic Panel R2 if configuring for Magic Panel R2.
diff --git a/arch/sh/boards/mach-highlander/Kconfig b/arch/sh/boards/mach-highlander/Kconfig
index b0abd03cac4e..cd3a553ce30c 100644
--- a/arch/sh/boards/mach-highlander/Kconfig
+++ b/arch/sh/boards/mach-highlander/Kconfig
@@ -20,6 +20,7 @@ config SH_R7785RP
 	bool "R7785RP board support"
 	depends on CPU_SUBTYPE_SH7785
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 
 endchoice
 
diff --git a/arch/sh/boards/mach-rsk/Kconfig b/arch/sh/boards/mach-rsk/Kconfig
index f0299bc4416f..3810937aa5d4 100644
--- a/arch/sh/boards/mach-rsk/Kconfig
+++ b/arch/sh/boards/mach-rsk/Kconfig
@@ -12,16 +12,19 @@ config SH_RSK7201
 config SH_RSK7203
 	bool "RSK7203"
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	depends on CPU_SUBTYPE_SH7203
 
 config SH_RSK7264
 	bool "RSK2+SH7264"
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	depends on CPU_SUBTYPE_SH7264
 
 config SH_RSK7269
 	bool "RSK2+SH7269"
 	select GPIOLIB
+	select GPIOLIB_LEGACY
 	depends on CPU_SUBTYPE_SH7269
 
 endchoice
-- 
2.39.5

