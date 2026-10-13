Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D448D87C
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912933; cv=none; b=lLCh93Omzl6LU3o1hUo8d2PXDraxYvDx5fsclmG1UXMjTnIfbz0frwIlarxSkqf37Kve937wFABcTkIhz3bgWdOGv15QBCP4qDYo3JzhWv/fLUVW3OY9z6K2Eso9f6Zb8pbc6dJs3WtIWN3eaF3x/Kn4w65zVr1blnrfhVNcYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912933; c=relaxed/simple;
	bh=yeWbkoIS6TzaXJxFeRrC28JWQXFRjVppj/nrT0wPWBM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KIPapICNHTP8aLpGMHXeuUlyllxbL95W0Atbo/uIhD5aF7bPk/uOgn1Mt+eI5d6kidpSwAFgUusP9hc3db6fUqNX5JfpvMgWyDsJsGo8S9EH0Xm4/VIoGfIhFgIaAdBKODWyizyUakDeGpRgsnY3VB5/l67tW6+Koq+AJbybps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvNuHzuu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvNuHzuu"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a161d9b8c7so23020375e9.3
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791912928; x=1792517728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9S5oWKl9lJl3zE64Lxd43NHv+pVgZpr/FmTp9jsXZP4=;
        b=TvNuHzuuSLhIpRu/ycapSiMH5AYTUGhNWECK/ahMJeDhZL86f9lfjvB4ngS4vFxIrn
         RtqjZT/84m0FUABPuk43HCeS3FFhyxiG3YfUAY6WMQ+XgHWqDW3eRk/hB07MahsIjKZh
         7vyjXSVnhXCO7OsFqgSPU4fpc+doUg4Q3w62lZGR/pK9iyHqKrc8Hm03bAbi1qb0zFQi
         WIPHySkM7i2YfZsQiKRdguyejSNail1JYwwmK8fcMcMk+6hTWmjN2cfqXyBcDPLWowC0
         HJxK1+DPt8cRkD3bzWEq5ta96r36XQwWXi6VyWx3YmUGbmC327UPkANxqeFsHGYQ7IBc
         GkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791912928; x=1792517728;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9S5oWKl9lJl3zE64Lxd43NHv+pVgZpr/FmTp9jsXZP4=;
        b=dFXsbfvBaj2ZIQ3Jfu94mgf1yjgbyJauShdl60iv+INPZ8PBm6QE5XU0FKFBHMgTzo
         vJksB7jnVzhUhPGX5vDDeE5Ts3TiKUz1/gGCWt17abrzPxLJkF73o/1a1t7utBCEXpGk
         YcWGmp+u1weOmaiuL1ChLzQY8uT1364PFks2qAz/js/3xJxc6Htsz+6Pg9YobiaUebx5
         uy4a53R2Xalb5xnnuN5Q569F+9mghvZbxcKD9wEtsYKvaV0iwIWPDj7s3IgZ6rU3JdvW
         dneLwahVBaFh9hY8sFANw8UGlai7gJkl3a8LozdoRT1+qMjLglT2pjvv010WXnPVsU0f
         Uc8w==
X-Forwarded-Encrypted: i=1; AKwUvBwMcp/xxwGXT92ArYkJRSmTQVCtIw1sK9XIS1o2EfKOMhfgU/ZkLL2TGsSIGvQHaTtz7p162CDPPnEEcg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLByfaT5x1exWzULBwDFfBl4cLc8l98Zw7Hs3B5GJQ0j42cQ4Ab
	nQCDkM+PbkN6l38eheT1Ko9zRNE44POkG68YpbUGymtFZ26BkIlkuT1b
X-Gm-Gg: AYBFou2/O+QX4knpYOKIbUJmYE3CeEOZJw279spWWO2VCiYVmtzXE+NNfBRtFYvjrMi
	ZvC7TQPF49fw4r0q0GvVm0byJgBRNWlO/pB3DgE8t/qpYODG87sDzfmlw0Lue8x58uElL5IU/Nt
	jQCEa/eJPyydnXDmzwaQt2Vz/PT1sxdDkQtXSNXtHVZsvYtiMh3PxBDaq3m6FuHNFQY0OO/1ae8
	bqxUqOdgUWMX/6KBj8V47rFR7azfyh1vxijp+pkiiTR44aKizL5AecfvcEO7i0O7xOHgUkoundH
	OFnPtnvVBNoULBl1c9DtVrnd86KGNJ+NfYmSea9PhNoO8Z2n2aSJsFSdvY6qOuqa1VAYaflLk6f
	lpLrIHc5mFKJVbyacTi0Js2Q1HqLDMubuUvnqfS/44chXtd5xvwVyERi3BhPkuUtCKpQaWMUNrf
	fCh9f9exY6hgEAsVjL1/EfKF6ZiKth4mE/+srNsYcN4K7tNCb3QGUCEQYyRf68u7ZaBYALvOwQu
	gBpwaTp8Dn11/R6osM9EP8ncSLyWQ==
X-Received: by 2002:a05:600c:190b:b0:4a1:82cc:1e9a with SMTP id 5b1f17b1804b1-4a18e4b2b25mr264581455e9.17.1791912927910;
        Tue, 13 Oct 2026 10:35:27 -0700 (PDT)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18ca51465sm284127195e9.4.2026.10.13.10.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 10:35:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Ion Agorria <ion@agorria.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Florian Krischer <florian.krischer@fkr.dev>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v11 0/7] mfd: Add support for Asus Transformer embedded controller
Date: Tue, 13 Oct 2026 20:34:56 +0300
Message-ID: <20261013173504.451391-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for embedded controller used in Asus Transformers for
managing power and input functions.

---
Changes in v2:
- converted sysfs debug exports into debugfs
- added kernel-doc comments for exposed functions
- fixed minor typos and inconsistencies

Changes in v3:
- dropped DockRAM commits (both schema and driver)
- integrated DockRAM functionality directly into the controller driver
- EC schema moved to embedded controllers folder
- removed all cell descriptions from the schema
- removed all compatibles from the cell drivers
- adjusted naming conventions to better align with the ASUS Transformers
- defined EC variant sets to provide coverage for all known devices

Changes in v4:
- grouped known programming models of EC chronologically (both schema
  and driver)
- call debugfs init only if CONFIG_DEBUG_FS is enabled

Changes in v5:
- added asus,tf600t-ec-dock compatible to schema
- rebased on top of v7.0
- kzalloc > kzalloc_obj in keys and kbc

Changes in v6:
- removed asus_ec_handle_smi casting
- asus_dockram_access_ctl > asus_ec_get_ctl in control_reg_*
- fixed battery Kconfig description

Changes in v7:
- added status check of devm_kasprintf where missing
- devm_asus_ec_register_notifier dropped, added .remove where it was used
- removed cell_to_ec, asus_dockram_read, asus_dockram_write, asus_ec_* public API
  asus_ec_i2c_command, devm_asus_ec_register_notifier, asus_ec_read, asus_ec_write
- renamed asusec_info > asusec_core
- ec-kbc: added packed size check
	  ret > error
	  improved key remap logic
- ec-keys: improve formatting and comments 
	   ret > error
	   switched to dev_err_probe
- ec-leds: reworked to register both leds via loop
- ec-mfd: adjusted Kconfig description
	  fixed smbus operation sizes
	  fixed saving of EC fw model
	  adjusted IRQ flags
	  converted to use definer for set cell composition
	  added factory mode states enum and handling
	  defined some "magic" values
	  self > client, info > ec, ecreq > ecreq_gpio, priv > ddata
	  asus_ec_chip_data data > asus_ec_chip_info info
	  ec_data > ec_buf, ctl_data > ctl_buf
	  added and improved comments, added structure descriptions
	  asus_ec_magic_debug > asus_ec_susb_on_status
	  removed all dev_dbg and most of dev_info
	  pronts with model, fw behavior, factory and susb state preserved
	  switched to MFD_CELL_* macros
	  removed debugfs
- ec-battery: swithced to BIT macro
	      lock usage moved to asus_ec_battery_get_value
	      in asus_ec_battery_poll_work fixed possible rescheduling fail
	      in asus_ec_battery_poll_work fixed missing not charging
- ec-charger: POWER_SUPPLY_PROP_MODEL_NAME set as the first check

Changes in v8:
- added MODULE_ALIAS
- renamed DOCKRAM_* to ASUSEC_*
- ec-keys: input_handler moved into private structure
- ec-leds: added brightness_get
- ec-mdf:  fixed i2c_smbus_* return checks ()
	   improved model storing
- ec-batt: added status check of devm_kasprintf

Changes in v9:
- fixed i2c_smbus_read_i2c_block_data return check
- blocking_notifier_chain_register moved before serio registration
- adjusted get_unaligned_le16 bounds check
- unsigned long long > u64
- iterator vars made scoped
- removed "magic" values from ec-mfd
- simplified logging, detect split into detect and init
- improved error logs formatting
- adjusted handler in media keys to connect strictly to dock keyboard

Changes in v10:
- ec-kbc: fixed possible out of buffer reads
- ec-kbc: set notifier_call before blocking_notifier_chain_register
- ec-keys: dropped input_unregister_device which should be handled by devm_input_allocate_device

Changes in v11:
- applied changes from Florian Krischer (read_size parameterized and fix keyboard response framing)
- ec-kbc: switch notifier and serio register calls
- ec-keys: used WRITE_ONCE()/READ_ONCE() for priv->special_key_pressed
---

Michał Mirosław (6):
  mfd: Add driver for ASUS Transformer embedded controller
  input: serio: Add driver for ASUS Transformer dock keyboard and
    touchpad
  input: keyboard: Add driver for ASUS Transformer dock multimedia keys
  leds: Add driver for ASUS Transformer LEDs
  power: supply: Add driver for ASUS Transformer battery
  power: supply: Add charger driver for Asus Transformers

Svyatoslav Ryhel (1):
  dt-bindings: embedded-controller: document ASUS Transformer EC

 .../asus,tf201-ec-pad.yaml                    | 119 ++++
 drivers/input/keyboard/Kconfig                |  10 +
 drivers/input/keyboard/Makefile               |   1 +
 .../input/keyboard/asus-transformer-ec-keys.c | 310 ++++++++++
 drivers/input/serio/Kconfig                   |  15 +
 drivers/input/serio/Makefile                  |   1 +
 drivers/input/serio/asus-transformer-ec-kbc.c | 169 ++++++
 drivers/leds/Kconfig                          |  11 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-asus-transformer-ec.c       | 125 ++++
 drivers/mfd/Kconfig                           |  16 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/asus-transformer-ec.c             | 562 ++++++++++++++++++
 drivers/power/supply/Kconfig                  |  22 +
 drivers/power/supply/Makefile                 |   2 +
 .../supply/asus-transformer-ec-battery.c      | 289 +++++++++
 .../supply/asus-transformer-ec-charger.c      | 208 +++++++
 include/linux/mfd/asus-transformer-ec.h       |  94 +++
 18 files changed, 1956 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
 create mode 100644 drivers/input/keyboard/asus-transformer-ec-keys.c
 create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
 create mode 100644 drivers/leds/leds-asus-transformer-ec.c
 create mode 100644 drivers/mfd/asus-transformer-ec.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-battery.c
 create mode 100644 drivers/power/supply/asus-transformer-ec-charger.c
 create mode 100644 include/linux/mfd/asus-transformer-ec.h

-- 
2.53.0

