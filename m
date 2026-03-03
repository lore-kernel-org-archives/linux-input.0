Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E41359A80
	for <linux-input@vger.kernel.org>; Tue,  3 Mar 2026 22:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772577688; cv=none; b=fvb2iyGYhgU4YW+YUxVj0Rv08kyEmoQkbqBamukr5+Mvl6fAkjt/II6pDOEpEtKx7o5hgikm6Ax0fTSQIl2rggnhkYtfwy/HvNbK+G5COVhGzHWqEUue6GV/cNVpz/7qSl3SwcHsLh7EIcs1gNmp7ANHSybUz0U/bm/piSLYbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772577688; c=relaxed/simple;
	bh=cnemxvZykv0NVXvgFWgt2sdzj4Nbwdq86pdHwy4dSTQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NJ5eANlBnmXq+FoERHq1XJ/ezBeaahrG28XXg6eEolZ3YHgOkZRHYMapxJCXXazi8SH0c+8WG2hT8ekTDBed1sZrJKr3yXBdECXLlgmt6corUUu7zNHXAFYQuD4rMVwYPG7XxBJVmvjCcx14Twjjd1mH3xTDcIDJl61pBy8kLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1vxYQe-0000sx-7b; Tue, 03 Mar 2026 23:41:24 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v6 0/4] Input: Add support for TouchNetix aXiom touchscreen
Date: Tue, 03 Mar 2026 23:41:18 +0100
Message-Id: <20260303-v6-10-topic-touchscreen-axiom-v6-0-8ac755add12b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI5jp2kC/4XPwWqEQAwG4FdZ5twpyTgTnZ76HqWHccyuc6jK6
 Ipl8d0bhaWFCl4CfwJfkocaOSce1dvloTLPaUx9J4FeLiq2obuxTo1kZcBYKMHqmTSCnvohRan
 32I4xM3c6LKn/kpErCblCQFRiDJmvadn9j0/JbRqnPn/v62bcuruMiP5EnlGDJjTWG1f7Eqv3g
 bvbfcp9l5bXhtXGz+ZJOnDmlDRCBsdNLWcHAjgki1+yMnhGFkJ6CzEyU1OH4pC0T5IAgc5Iu5H
 sa/Kxku/pkHR/SDy90gl59ZYhsCGK9T9yXdcfqtVEThsCAAA=
X-Change-ID: 20240704-v6-10-topic-touchscreen-axiom-105761e81011
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Russ Weight <russ.weight@linux.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Marco Felsch <kernel@pengutronix.de>, Henrik Rydberg <rydberg@bitmath.org>, 
 Danilo Krummrich <dakr@kernel.org>, andrew.thomas@touchnetix.com, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, kernel@pengutronix.de, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

Hi,

this adds the support for the TouchNetix aXiom touchcontroller family.

The following features are added:
 - I2C communication
 - Input event handling
 - Touchcontroller firmware (AXFW) updates
 - Touchcontroller config (TH2CFGBIN) updates
 - Poll or IRQ support

Many thanks for Dmitry's input on my v5. I included all changes
requested from him.

Regards,
  Marco

Changes in v6:
- Link to v5: https://lore.kernel.org/r/20260111-v6-10-topic-touchscreen-axiom-v5-0-f94e0ae266cb@pengutronix.de
- Fix update POLL mode
- Fix max. input values
- Resolve some "TODO" and "Downstream" comments (Andrew)
- Add 0d, xl fw_variant (Andrew)
- Use 2sec timeout for u02 swreset (Andrew)
- Fix IRQ-runmode input-device registration after FW update
- Drop legacy ALC firmware support, since no fw sanity check could be performed
  which is bad for user experience if they provided the wrong file accidentally.
- drop BLP_PRE_MODE
- make AXIOM_U31 rev.1 required
- axiom_usage_supported: drop iter and instead use new usage_table_by_baseaddr
- axiom_axfw_fw_write: drop goto error handling
- adapt comments
- rework axiom_i2c_probe (Dmitry)
- rework axiom_power_*_device and axiom_parse_firmware (Dmitry)
- rework axiom_register_input_dev (Dmitry)
- rework axiom_register_fwl (Dmitry)
- rework axiom_cfg_fw_cancel (Dmitry)
- rework axiom_cfg_fw_write (Dmitry)
- rework axiom_verify_volatile_mem (Dmitry)
- rework axiom_write_cfg_chunk (Dmitry)
- rework axiom_cfg_fw_prepare (Dmitry)
- rework axiom_axfw_fw_* functions (Dmitry)
- rework axiom_blp_reset (Dmitry)
- rework axiom_blp_write_chunk (Dmitry)
- rework axiom_enter_bootloader_mode (Dmitry)
- rework axiom_axfw_fw_prepare (Dmitry)
- rework regmap_read/write (Dmitry)
- rework axiom_u34_rev1_process_report (Dmitry)
- rework axiom_cdu_wait_idle (Dmitry)
- rework axiom_u64_cds_enabled (Dmitry)
- rework axiom_u42_get_touchslots (Dmitry)
- rework axiom_u33_read (s/ret/error/) (Dmitry)
- rework axiom_u31_device_discover (Dmitry)
- simple s/ret/error/ (Dmitry)
- rework u04 handling (Dmitry)
- rework u02 handling (Dmitry)
- align function name accordingly (Dmitry)
- fix indentation (Dmitry)

Changes in v5:
- Link to v4: https://lore.kernel.org/r/20260106-v6-10-topic-touchscreen-axiom-v4-0-9e9b69c84926@pengutronix.de
- fix sysfs documentation description indentation and date

Changes in v4:
- Link to v3: https://lore.kernel.org/r/20250821-v6-10-topic-touchscreen-axiom-v3-0-940ccee6dba3@pengutronix.de
- rebased on top of v6.19-rc1
- collect r-b tags

Changes in v3:
- Link to v2: https://lore.kernel.org/r/20250529-v6-10-topic-touchscreen-axiom-v2-0-a5edb105a600@pengutronix.de
- firmware: fix commit message (Russ)
- dt-bindings: Add ack from Krzysztof
- dt-bindings: make use of GPIO_ACTIVE_LOW (Krzysztof)
- dt-bindings: drop 'panel: true' property (Krzysztof)
- driver: make use of sysfs_emit (Greg)
- driver: s/WARN()/dev_warn()/ to not take down the system (Greg)
- driver: fix build dependency error by adding "depends on DRM || !DRM"
- driver: harmonize usage printing to u%02X

Changes in v2:
- Link to v1: https://lore.kernel.org/r/20241119-v6-10-topic-touchscreen-axiom-v1-0-6124925b9718@pengutronix.de
- Rework the firmware-duplicate handling -> expose the error to the
  userspace
- Drop Krzysztof Kozlowski ACK and RB
- Add panel-follower support
- Add sysfs-driver-input-touchnetix-axiom documentation
- Add support for new firmware 4.8.9
- Add support to handle 2D and 3D firmware

---
Kamel Bouhara (2):
      dt-bindings: vendor-prefixes: Add TouchNetix AS
      dt-bindings: input: Add TouchNetix axiom touchscreen

Marco Felsch (2):
      firmware_loader: expand firmware error codes with up-to-date error
      Input: Add TouchNetix aXiom I2C Touchscreen support

 .../testing/sysfs-driver-input-touchnetix-axiom    |   80 +
 .../input/touchscreen/touchnetix,ax54a.yaml        |   62 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 drivers/base/firmware_loader/sysfs_upload.c        |    1 +
 drivers/input/touchscreen/Kconfig                  |   17 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/touchnetix_axiom.c       | 3084 ++++++++++++++++++++
 include/linux/firmware.h                           |    2 +
 lib/test_firmware.c                                |    1 +
 9 files changed, 3250 insertions(+)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20240704-v6-10-topic-touchscreen-axiom-105761e81011

Best regards,
-- 
Marco Felsch <m.felsch@pengutronix.de>

