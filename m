Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688F3B6BE3;
	Fri, 10 Jul 2026 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718369; cv=none; b=sFQvEWODAh+XwPNvvDlVOFum/vYfwY5E7h4LBxJo+W433l+NzwGQXWfxBl+aj8njCkT8KGmhyQKlXsMT5uVtC7ot+nZbwWTeGb6hvwQDQVkssZoRgH3A0KjUCAx+iBTZ44IqtVXfIzXLD55K/CWW9rEZ8Pl4+aem6+amDZT+QMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718369; c=relaxed/simple;
	bh=CGIgemArU5dJAVzaKv+UGu8qpVYophNCYabUFgiHvyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z3WAnASKP+/+3Bcs0GqHX9JQ7wdtsSpXx8dhI9DD/vQ8Ra3JKv0aRL85DsgxQYojPGW/8NGxUrPaliLjxtdtwLXEDugpdzWSHK060ksOH95bzLqSVhjQnuNQ7Erag7K0IxS6akny2rXnjbCAF9gauomDJOEuK7L4EjJGcURQvC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzqRqQM9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzqRqQM9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D646C1F000E9;
	Fri, 10 Jul 2026 21:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718368;
	bh=QghtmwXZxb5W4DunHwzaT7QrfF2R8OUV76vdsj6iuCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nzqRqQM9UKEcb6u3h7LdWZkyvgPVkTqE+sURmz7WxBKi3vnQpaBD1OM7zuRXY8kHG
	 uDiD2nVCO9iQbCLJ3zrRFC3Rwm7j+mvPplpJxiVZ1U/AAKBvOEj/qM6Z5R2le7aAIe
	 R9X5EBTMexGXw1QrMfXdjutnJsf1Hrc3qVd0w8s3kIDCid7euVPJk7UAyRsyKTQ/XP
	 GFyu2qxiPsvhEg/fA6k+JlcRIj3IpFcQMczd9yIlQ7XPwThdVEmnmOzYJd6NdD2HHO
	 bSpRFqNiAQzf9nbLurHE2bxeWi3YQ1lMtQBSzt7cknUW+BL7nujlhF8YIRNbNrUyBv
	 9wGTv6wB7wpSg==
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
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6/6] [v6] gpiolib: turn off legacy interface by default
Date: Fri, 10 Jul 2026 23:18:54 +0200
Message-Id: <20260710211854.1371746-7-arnd@kernel.org>
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

All users of the legacy interface now select CONFIG_GPIOLIB_LEGACY,
so it can be turned off by default and only get built on platforms
that still have one unconverted driver.

Allow turning it on manually for compile testing, in order to keep
the build coverage of the legacy drivers in allmodconfig and
randconfig.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v5: added patch, now that we are getting closer to completing
    the series
---
 drivers/gpio/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 28cf6d2e83c2..f063bdfd111b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -4,7 +4,14 @@
 #
 
 config GPIOLIB_LEGACY
-	def_bool y
+	bool "Legacy GPIO interfaces" if COMPILE_TEST
+	help
+	  There are a few legacy platforms that use the traditional GPIO
+	  number based interfaces instead of GPIO descriptors.
+	  Say Y here to enable build testing drivers that are specific
+	  to those platforms.
+
+	  If unsure, say N.
 
 config HAVE_SHARED_GPIOS
 	bool
-- 
2.39.5

