Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD3CC00528
	for <linux-input@archiver.kernel.org>; Wed,  2 Aug 2023 12:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbjHBMvC (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 2 Aug 2023 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjHBMup (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 2 Aug 2023 08:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6482B359C;
        Wed,  2 Aug 2023 05:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 766AF61965;
        Wed,  2 Aug 2023 12:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DD8C433C7;
        Wed,  2 Aug 2023 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690980593;
        bh=Ljcd5pbRznBECm60MkpvEmPwtPvPGHtbOUqrvZAEUXg=;
        h=From:To:Cc:Subject:Date:From;
        b=UHge9AgJBACU7icvP8phQt6fsIRMdR7DlykH8zzWKulsEUBV1zlGKLcQmxIT9da1H
         0RyYngdd7F24SJMP9jJ8f2j4URwDX3deiM9ebO8cPsXL4HwJOLmjE7eLbHfAxbkCv7
         sBJsNudHGCCv7WMi2Xtu2qJwR9u/6wtRWR0TJVLsvyy5QCD1zzUMe6UALKpG6PKzuI
         97YTYg7OgxKWZ6uv8G05c5tAFGIpUXAZaPR3z4vd/j8oqB+4m8pxn2oB9u2sMfiFiX
         m3QZRZRwBGbQzT1DnYUrOINTPNH//QCxAzWKc3MH0NaUyqkqq/qmYa+Gktx3Pi7AUo
         eoR/hGQXXw0Lg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Douglas Anderson <dianders@chromium.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: i2c-hid: add more DRM dependencies
Date:   Wed,  2 Aug 2023 14:49:40 +0200
Message-Id: <20230802124947.1355415-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When a symbol is selected that has extra dependencies,
anything that selects it must have the same dependencies.
With the added CONFIG_DRM reference from I2C_HID_CORE,
this broke a couple of drivers that now also depend
on DRM:

WARNING: unmet direct dependencies detected for I2C_HID_CORE
  Depends on [m]: HID_SUPPORT [=y] && I2C_HID [=y] && (DRM [=m] || !DRM [=m])
  Selected by [y]:
  - I2C_HID_OF [=y] && HID_SUPPORT [=y] && I2C_HID [=y]
  - I2C_HID_ACPI [=y] && HID_SUPPORT [=y] && I2C_HID [=y] && ACPI [=y]
  - I2C_HID_OF_GOODIX [=y] && HID_SUPPORT [=y] && I2C_HID [=y] && OF [=y]
x86_64-linux-ld: vmlinux.o: in function `i2c_hid_core_remove':
(.text+0xfc8826): undefined reference to `drm_panel_remove_follower'
x86_64-linux-ld: vmlinux.o: in function `i2c_hid_core_probe':
(.text+0xfc8da0): undefined reference to `drm_is_panel_follower'

Add the corresponding DRM||!DRM dependencies on each one that
is affected.

Fixes: 96a37bfd232ae ("HID: i2c-hid: Support being a panel follower")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/i2c-hid/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/i2c-hid/Kconfig b/drivers/hid/i2c-hid/Kconfig
index 2bdb55203104b..ef7c595c9403c 100644
--- a/drivers/hid/i2c-hid/Kconfig
+++ b/drivers/hid/i2c-hid/Kconfig
@@ -9,6 +9,7 @@ if I2C_HID
 config I2C_HID_ACPI
 	tristate "HID over I2C transport layer ACPI driver"
 	depends on ACPI
+	depends on DRM || !DRM
 	select I2C_HID_CORE
 	help
 	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
@@ -25,6 +26,7 @@ config I2C_HID_OF
 	tristate "HID over I2C transport layer Open Firmware driver"
 	# No "depends on OF" because this can also be used for manually
 	# (board-file) instantiated "hid-over-i2c" type i2c-clients.
+	depends on DRM || !DRM
 	select I2C_HID_CORE
 	help
 	  Say Y here if you use a keyboard, a touchpad, a touchscreen, or any
@@ -41,6 +43,7 @@ config I2C_HID_OF
 config I2C_HID_OF_ELAN
 	tristate "Driver for Elan hid-i2c based devices on OF systems"
 	depends on OF
+	depends on DRM || !DRM
 	select I2C_HID_CORE
 	help
 	  Say Y here if you want support for Elan i2c devices that use
@@ -56,6 +59,7 @@ config I2C_HID_OF_ELAN
 config I2C_HID_OF_GOODIX
 	tristate "Driver for Goodix hid-i2c based devices on OF systems"
 	depends on OF
+	depends on DRM || !DRM
 	select I2C_HID_CORE
 	help
 	  Say Y here if you want support for Goodix i2c devices that use
-- 
2.39.2

