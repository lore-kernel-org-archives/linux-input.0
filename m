Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577288;
	b=HBpba7w+T3kxz6LsX+Ocwz1zsoFdBI+k2uDKtqjTsFHL+bWGljdBgcjgMIFfPQBR8FQd
	 PP1PZfzHRDGSNRYGcz+NueJ15OoRzcRJZdNqfzJNwsCw3W6x3i/gjTYsX+MS1vANEnVZg
	 Qp9Mn2tZZMOHTGwZMbODv0YCH8C+rR55Jc91aPC2O67Gs+lQNaoFwBrVP1pk9kDL4pyxq
	 a4LNMwZkcIJNEqQF/lpFicaG4RA1Cz00291NtFQtzviCec1ZKrnXlfp8k9NZEEQ8bNuZW
	 boxN+jdiDwG5/QFa3d/1A1jq8eAREKtNw52PfW9EQBzWnyz7r+Lu2ieFewrriQJpGtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dpKHKp5gi/qM6hKt27rQ9y+edS7uM9GiXWQmWnCs2Fw=;
	b=N+9hAximOTsgT6XV7DJ/lPgQ3olD9e3Rc4u1Lqx3JWbNkqUVSpo3cReiir9L17Zz02H/
	 BH7qg+Fj4dFBNqiItisoM8DgWZ+H60mbj/m9m8iTYWzfRGkibqXeN83y3BrND/4euaxRJ
	 aqnncCfcjRWQvsR9pCezkdpMar1LVBUCg8ocgrdnkZohwBGMODZYxVM1XUTNxTeKOOi1u
	 11Sso1c8nuj1GaVNv9Sn4lUE0UOElpt/TKcDx/VcB5Ge2l4PB2LIdNSImCb0ciAZC5gFJ
	 Hy15jy3sTQTt02/CiriYFGFp71vtavArljWmz8Is6dCSBCkArKyB7hqwO3Eq6y9OlSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m5B5my3P;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C2606A323
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 03:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 858C2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m5B5my3P
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso3295936f8f.2
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 19:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577286; x=1796182086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dpKHKp5gi/qM6hKt27rQ9y+edS7uM9GiXWQmWnCs2Fw=;
        b=m5B5my3PBu4I/zhSUkINaBK0fHEks56PAJ4ijM+dXcC6bKxvHw78DrNDLJqSAKC58V
         fgf16aZD3BhhPTy6PH+WFOM2TaExa+gOr3wmTvHPdA+KjZlYUpBjMXubVb3kttdDTRxo
         tPIR7McPF8YcjKs27pc9m7zCVxf6C91+DCrI/iALC9BsnDx/17tXrgnXUOCmGgg6gZnJ
         ZZzdr70BEIaD5agOPFnYmpifxIiETqJzPBQT5JbHZZkHfPxKP0TgbqaSwm1eOSm9/f00
         x2NLY5SECwQtiwwdIeiQOnycxNJbxj8lkZYKAfWK4W0C27HTpFF9owAWSr8f8U1x3en7
         zEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577286; x=1796182086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dpKHKp5gi/qM6hKt27rQ9y+edS7uM9GiXWQmWnCs2Fw=;
        b=K4AUat+SGQocSx86wZe2ewmDfY2BWH+9zMzCJWsum68gp/K+Do6OpbVkzydRtH5d1q
         JI8VdyyW1VDYztZAKotXTfpAymCZ8ULEIzia3UPX98/rTeNPVCRZa8PFvFgkj0ZwJEnz
         +NdWGikePetoTyXeg+xy9Xc+nrKWyJqYLnd9TqzR2xQSgMge7doeFleM0P/V86AHE3jM
         vPZlV0ARQ+KEGnwj73RGkO8ej2/juWwHe9y4AfuuDtjLsxdQNy0PQTO3EyeYHiAjj/BE
         ZoxjnInlfHF1TKmVekZalk5Sq/PSt2a7f20LNNWj6VwswoSZbOhJ8Tp4RhukFYoTnimQ
         Q7OQ==
X-Forwarded-Encrypted: i=1; AL+hErF7zNPDa673fazgr1PF9bRAarBwo+GYCSbNBoTAKBrl90ytGv9OgpDDJx68Au2OhiQ8MdKKgYYmHcT3zw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ris3QIdt2rDt5y9Rl0zb+lnz0GgJXOal3a51QBkcNe/PiOkSj
	T5CY0aOE0uOLfP/K60+7R7PnRKyyTDFeGhLpKCLJ+Fk1oUGXEFaldhMk
X-Gm-Gg: AZFdTZfUuCRcQ/7rx9Saj/9fZTrqQs3ooVQmU49AhNrU+tMrBI1rrdew1iFSDfD174Y
	oV0GW2SoTR88nQnJR9ry9M5vAYsRTIEhxL9CtejlomS5a1/uhrmPu6hJrdPQI94cpPmUtlzoJUt
	z0xgzuWUwBYEwUyyE9Uc9ClWDJx5ULF2XVM8dKcU9d2lJoTZC35+IZcY8xt+UfgV7usSI83ObAj
	sYrHP8ZZ8gyySC7pCEr6QHO+yzmWEuLnnAeCBoCdiwKS/S/bcjo0BUH6k+Z8IJ1zpyV2t319nPu
	epPAjghX1adlPPWz6duBqhb5CD/kG64TZLsAcq2d4vJk8pweW7j6a5Xw2voZ0bg6buwZNUUu3Sb
	YVVJ0TiTUoUUqagjSZYCI1bHoXmKufDavLs4CIc/madEj7D9q2UMTW4puW0/53QGuQFwUtawFh/
	gDN+WyOG9v9BvtpA3thEo5zgn5Zfp7dLSf2+AA4hIX3z7UacM6QyDryg4PorEY6K9fhQu2P0+zh
	KskPtjA+07cPMsj92PWt47MFBfxP/dMBt2IiQI1w843lvXTdtJF/5XGv/k44mYexR6iXw43uug4
	dQBB8YceMxCEvnUEn0BS2VAKrsOgi+f1lQaGEUlT90dAnnM8OkKJ4BCbk0hJyoKq0MggOqiYgwk
	xZ8BOCRQyHLGA3vLB819TvoUWjEa/HP8=
X-Received: by 2002:a5d:64c9:0:b0:4ae:c8ff:2302 with SMTP id ffacd0b85a97d-4aec8ff24c1mr23040437f8f.49.1795577285648;
        Tue, 24 Nov 2026 19:28:05 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe48sm28918822f8f.23.2026.11.24.19.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:28:04 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v6 0/6] arm64: dts: qcom: add LG V60 ThinQ 5G (timelm) support
Date: Wed, 25 Nov 2026 04:27:56 +0100
Message-Id: <20261125032802.8460-1-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds initial mainline device tree and driver support for the
Qualcomm SM8250-based LG V60 ThinQ 5G (timelm / LM-V600) smartphone.

Hardware features supported in this stage:
- Base board devicetree (sm8250-lg-timelm.dts)
- PM8150, PM8150B, PM8150L, and PM8009 PMICs and regulators
- UFS 3.0 storage and MicroSD card slot
- GPIO keys (Volume Down, Assistant) and PON keys (Power, Volume Up)
- Simple framebuffer (continuous splash handed off from bootloader)
- Adreno 650 GPU with GMU and zap shader
- LG SW43103 1080x2460 DSI command mode AMOLED panel with DSC
- LG SW42902 I2C touchscreen controller
- PM8150B USB Type-C controller in sink mode with USB-PD and
  orientation switch
- QCA6390 Bluetooth HCI controller on UART6

Changes in v6:
- Series structure & DTS:
  - Squash all board DTS additions (base board, panel, touchscreen,
    USB Type-C, Bluetooth) into a single commit per review feedback.
  - Reorder series so DT bindings and drivers precede the board DTS.
  - Sort root and &tlmm child nodes alphabetically in sm8250-lg-timelm.dts.
- Board binding (Documentation/devicetree/bindings/arm/qcom.yaml):
  - Collect Acked-by from Krzysztof Kozlowski.
- MAINTAINERS:
  - Drop the individual board entry for LG V60 ThinQ 5G (timelm).
  - Rename the touchscreen entry to LG SW42902 TOUCHSCREEN DRIVER and
    order entries alphabetically.
- Panel binding & driver (lg,sw43103):
  - Drop redundant literal block indicator '|' from description in
    lg,sw43103.yaml.
  - Clarify vendor as LG only: drop boe,sw43103 compatible and "LG / BOE"
    wording across binding, driver, and Kconfig.
- Touchscreen binding & driver (lg,sw42902):
  - Rename schema title, description, Kconfig text, input device name,
    and MODULE_DESCRIPTION from Silicon Works SW42902 to LG SW42902 for
    vendor consistency.
  - Drop redundant literal block indicator '|' from description in
    lg,sw42902.yaml.

Link: https://lore.kernel.org/r/20261120155450.7719-1-rofikcoga@gmail.com

Changes in v5:
- Touchscreen binding & DTS:
  - Replace separate interrupt-parent and interrupts properties with
    interrupts-extended in the lg,sw42902 binding example and the
    touchscreen@48 DTS node.

Changes in v4:
- Base Device Tree (arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts):
  - Drop vendor brand prefix "Google" from the assistant key description
    per review feedback: rename google-assist-state to assist-state,
    google_assist_state to assist_state, and update label to "Assistant".

Changes in v3:
- Base Device Tree (arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts):
  - Model PM8150L SMPS6 as top-level fixed regulator smpc6-regulator
    (0.88V) rather than in regulators-1, because PM8150L SMPS6 is an ARC
    level resource (ebi.lvl) and querying it via VRM causes
    rpmh_regulator_probe() to fail with -ENODEV.
  - Drop conflicting memory-region reference from framebuffer@9c000000 to
    prevent simple-framebuffer/simpledrm driver warning and mapping size
    mismatch with reserved memory.
  - Add board-specific firmware paths for CDSP
    (qcom/sm8250/LG/timelm/cdsp.mbn) and GPU ZAP shader
    (qcom/sm8250/LG/timelm/a650_zap.mbn).
  - Drop duplicate sdc2_sleep_state pin configuration from &tlmm (already
    defined in sm8250.dtsi) and redundant &pon { status = "okay"; }.
  - Adjust ramoops pmsg-size to 0x100000 (1MB, power-of-two) to prevent
    kernel round-down.
  - Drop unused <dt-bindings/phy/phy.h> header.
- Touchscreen driver (drivers/input/touchscreen/sw42902.c):
  - Fix potential unbalanced regulator disable in error and unbind paths
    by registering devm_add_action_or_reset() after sw42902_power_on()
    succeeds.
  - Guard sw42902_power_off() when suspended to avoid calling
    regulator_bulk_disable() while supplies are already turned off.

Changes in v2:
- General / DCO & Identity:
  - Replaced account handle "rofikkerneldev" with real name
    "Abdur Rofik <rofikcoga@gmail.com>" across all commit authors,
    Signed-off-by trailers, MAINTAINERS entries, and copyright headers
    per Documentation/process/submitting-patches.rst.
  - Replaced un-documented "lge" vendor prefix with documented "lg"
    prefix across devicetree bindings, compatible strings, and dts files.
- Devicetree bindings:
  - Added lg,timelm compatible in arm/qcom.yaml.
  - Added lg,sw43103 panel binding with enable-gpios and
    vddi/vpnl supplies.
  - Added lg,sw42902 touchscreen binding with vcl-supply and
    vdd-supply.
- Device Tree (arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts):
  - Renamed file to sm8250-lg-timelm.dts matching vendor prefix.
  - Reserved memory: folded cont_splash_mem and log regions into base dts;
    sorted all nodes by ascending unit-address.
  - Ramoops: adjusted size allocations ensuring panic dump space is kept.
  - Regulators: dropped unused LDO4 from PM8009 regulators-2 node,
    resolving the invalid 1.05V constraint failure.
  - USB QMP PHY: corrected swapped supplies (vdda-phy to 0.9V l18a_0p9,
    vdda-pll to 1.2V l9a_1p2).
  - GPU: enabled &gmu alongside &gpu to ensure MSM DRM component
    binding succeeds without -ENODEV in a6xx_gmu_init().
  - SDHC: added complete pinctrl states (sdc2_default_state,
    sdc2_sleep_state, sdc2_card_det_n) to &sdhc_2.
  - UFS: added regulator-allow-set-load and regulator-allowed-modes for
    dynamic load scaling.
  - Panel: added enable-gpios to panel@0 node; sorted display nodes
    alphabetically.
  - Touchscreen: used fixed regulators reg_ts_vcl and reg_ts_vdd for
    power supplies instead of raw GPIO toggles.
  - USB Type-C: replaced PDO_BATT with PDO_VAR(5000, 9000, 3000) to
    ensure valid 9V/3A PD sink requests without clamping to 600mA;
    added OF graph ports connecting DWC3 HS and SuperSpeed QMP PHY
    orientation switch.
  - Bluetooth: corrected QCA6390 PMU voltages by setting smps6 (0.95V)
    and smps8 (1.35V) constraints.
  - Cleaned up unused dt-bindings headers and enforced strict alphabetical
    ordering of all referenced label nodes.
- Panel driver (drivers/gpu/drm/panel/panel-lg-sw43103.c):
  - Removed redundant manual unprepare call in sw43103_remove().
  - Guarded sw43103_backlight_update_status() against execution when
    unprepared, avoiding unsynchronized DSI DCS writes.
  - Removed hardcoded full brightness writes in sw43103_enable().
  - Expanded Kconfig help paragraph to 4 lines.
- Touchscreen driver (drivers/input/touchscreen/sw42902.c):
  - Converted GPIO power controls to standard regulator bulk supplies
    (vcl and vdd).
  - Pre-scanned for palm touch reports before queueing MT slots.
  - Used named initializer in struct i2c_device_id table.
  - Followed input subsystem error naming conventions.
- MAINTAINERS:
  - Added entries for LG V60 ThinQ 5G, LG SW43103 panel driver, and
    Silicon Works SW42902 touchscreen driver in strict alphabetical
    order.

---

Abdur Rofik (6):
  dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
  dt-bindings: display: panel: add LG SW43103
  drm/panel: add LG SW43103 panel driver
  dt-bindings: input: touchscreen: add LG SW42902
  Input: touchscreen: add LG SW42902 support
  arm64: dts: qcom: add LG V60 ThinQ 5G (timelm) support

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../bindings/display/panel/lg,sw43103.yaml    |  67 ++
 .../input/touchscreen/lg,sw42902.yaml         |  72 ++
 MAINTAINERS                                   |  13 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 815 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43103.c      | 586 +++++++++++++
 drivers/input/touchscreen/Kconfig             |  13 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/sw42902.c           | 360 ++++++++
 12 files changed, 1943 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
 create mode 100644 drivers/gpu/drm/panel/panel-lg-sw43103.c
 create mode 100644 drivers/input/touchscreen/sw42902.c

-- 
2.39.5

