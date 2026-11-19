Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107265;
	b=fsOqt4JC7dW1jrVeq4tZJwk8zBeUC0hNjbv4i2IAt1HPOJyY6646XBaByJ0EXqY807Wx
	 MuawXVSEIxatvcIE2VCjaBMQrgKR5xGYc2whkLyflNlORQfifubf0YZqo3oP3/eLPoxQE
	 dRwMFVN12a7C+rN/JUxhnwjQjBe5FO9iZEQp3oPGuO45XyvXE872IQxiQYScfvk1/B1cH
	 g1lwP7QWzdajdrZFBXR4KVUGDJs982hUvsOhAZ9hsu1J1zk69aDtpJoe/hW74gouluUeP
	 tOIpO+i2oocj+0cHXX9NVaMg651yq85Kz9uPytF6jn6xN+3Wp636my7MglZ/+T7NobQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cL9QLrw802xMK6esPwClrrDVtfE9WjyNqvjQf8BYnaE=;
	b=jbbtPIKKD/MY0b9B8SITBCMriVYtP2EjxtXA/QfthaxI0kOtSK/gdCrJv14sUOcBIIVL
	 oJoUcaOhS3CIMIZaI8OPhIjc3FpBMDQulbucQLZQoxW352OrfCkhxJ8WQqt/ExY4s/aeD
	 A61BK4BQGsNDi6hbwaSknhpHxXxFPm+Is0eT4J4LY96QEDt7ly0NeafM2ml8ITyQN4HRF
	 xkQz0eDrvtqh5mZq5ovzFMyZv/e90PViPdRkt9qKdTOiemftDOyiXKof34HFRjHXUa3NN
	 2Rbchmo0/z503Udua1TB8SmIh5Cz6m25jK8+vJT9ha6LQbnQF/PlgBCpMiHsWBWDXjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XC3aEdLx;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F13A606A320
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F13A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XC3aEdLx
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb606491faso14564135e9.3
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 08:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795107264; x=1795712064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cL9QLrw802xMK6esPwClrrDVtfE9WjyNqvjQf8BYnaE=;
        b=XC3aEdLx7SDskhcnFmdxv7gCLJxLxYRqT7mtgTzUC5MUyNxH5a67pSJ3rHTWZTfXNx
         DEfXntVNjyBEEPrBMk/rqM3PVc5t8Dx6i8eMb+SMFP52EaFjR0b7xeM0w4OOnAcMyKrN
         q1PB6w9tfSzTL7mfz1lLYah9N+SpnxYedUNlfKLm6OtB1Z5fae/qh+Rz22QxvCveY0hi
         G7p73QNYIEXmhN42IEjU+T5rAPs0Q9OA1w4u+Ew5GkWgHetYHMfLw+Krd8F+fVROXqpr
         fJ1b0oWGN+huEjRtEMLUVuCJiq+T9UNMde9Ep5usoQ0tmwAQkfYVUppEMlMdo3h2ez0B
         683g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795107264; x=1795712064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cL9QLrw802xMK6esPwClrrDVtfE9WjyNqvjQf8BYnaE=;
        b=hXdjX34NOvEPhWo64H2JID3awocmxz+TpgVWxEncsAnJrI4Dny+AZhRgw+Kqndyzz5
         Lbam4h2DU8c2X1F2jhob7dMthKOWsfdCsqJu8Rk0yLXYwGdpsxlm7NqGU+7OqsSaEGeN
         +xKdaNSzrXdagI0PmDlUX43W+IgwBYUtcJrBPX5xiZ00d5EjE0c+fWqdpx8gG69MEnrp
         fBK8gjV5X4xQwM53jKakCePFslfFDSOvlR7sQ7GSeExLmfCqNafvb3PnjPjb/DAwe+04
         XrzEfW3PufQGHQ+4dlHz0/tnRf43AYBxFmaKRQ+eXRgCAPlVaew4Du9/gSFUPG9i2x0+
         LVxQ==
X-Forwarded-Encrypted: i=1; AL+hErFBnSzH/7LyXbC/fu67uqrCE+bTiPwYgHBa4bBycn+qMGDPeFKBc1LFFvGyaQErmxj2VegiNz85VU9/9g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9NdyoiUX/hrEpy8Ni1aizz+BGnEsvkaE/qPjRz48xBLdlP3lbo
	ZT8k6HIAZkGLSgfkB6w8J9lsLRRy/Qqql1nr8dg3THchrdf08XLxJxV2
X-Gm-Gg: AYBFou2ekeGZO9lUIkiCXnkATfaVburCTrP3T7wbO4ROh6gAqQJwrj7z/uon4VYmeGS
	SFCuMD54fGQh+fik45z5CF3XwMiAxk3YdujMvG9uzE/8VGrZ+2C7nPT/gw4/bxW27g+j8Y/56ZL
	qwQexlbFGpY1+6ICy51DbJxWWlTy4/a/5DCxLoE+C4sc1UiJ8ZA9C9ZIduip7w0OFzkWs+ORtCa
	DN+nkdC59jS/3M20RMsZpZhAjQG66grg7IwRvYvEsxmZhpVbL5fILL+47rNhv+57S4KF57iIBZK
	BTJRAbHmMI/B6AdM7H2MMzNq+WfexzstPBC1g5Av1JLf1G2dJsZJtR9yfdcjv+rEksjpdWRp5KG
	hARkmlnHenw9Lbtx9lZdkYiLUfcpbr/TVD3EHe5PCKU6eeBYTWlp2h9a/EK64cKBoMuTG4ALASz
	Cj0qbZQH1W9kdKjAfvVdgq+MHIm5MiMx+56fU1flA/hQLWmx2NRUg1MppNBFgHUIAQtzw6Twkco
	A68MjKkf6p+lj/kH+/Sh0R7wjOegUld2kKeok1KnLB/mnkTfTOqoB+fTMK/7PtRknxV7D5LwzMY
	7mC1CHZZ9SjkvKU8qKoNzSEx+WdA1UmtJsfu/CsB8efFqVobNT4fePNWeHceVOWcRsy8Xunm/rg
	=
X-Received: by 2002:a05:600c:1d08:b0:4a2:392:9de2 with SMTP id 5b1f17b1804b1-4bb8882bd7bmr1438135e9.28.1795107263457;
        Thu, 19 Nov 2026 08:54:23 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:54:23 -0800 (PST)
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
	Ivon Argel <ivonargel13@gmail.com>,
	Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v3 00/10] arm64: dts: qcom: add LG V60 ThinQ 5G (timelm) support
Date: Thu, 19 Nov 2026 17:54:10 +0100
Message-Id: <20261119165420.24466-1-rofikcoga@gmail.com>
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
- GPIO keys (Volume Down, Google Assistant) and PON keys (Power, Volume Up)
- Simple framebuffer (continuous splash handed off from bootloader)
- Adreno 650 GPU with GMU and zap shader
- LG SW43103 1080x2460 DSI command mode AMOLED panel with DSC
- Silicon Works SW42902 I2C touchscreen controller
- PM8150B USB Type-C controller in sink mode with USB-PD and
  orientation switch
- QCA6390 Bluetooth HCI controller on UART6

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

Abdur Rofik (10):
  dt-bindings: arm: qcom: add LG V60 ThinQ 5G (timelm)
  arm64: dts: qcom: add LG V60 ThinQ 5G (timelm) support
  dt-bindings: display: panel: add LG SW43103
  drm/panel: add LG SW43103 panel driver
  dt-bindings: input: touchscreen: add Silicon Works SW42902
  Input: touchscreen: add Silicon Works SW42902 support
  arm64: dts: qcom: sm8250-lg-timelm: enable SW43103 panel
  arm64: dts: qcom: sm8250-lg-timelm: add SW42902 touchscreen
  arm64: dts: qcom: sm8250-lg-timelm: enable USB Type-C
  arm64: dts: qcom: sm8250-lg-timelm: add QCA6390 Bluetooth

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 .../bindings/display/panel/lg,sw43103.yaml    |  69 ++
 .../input/touchscreen/lg,sw42902.yaml         |  73 ++
 MAINTAINERS                                   |  19 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 815 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43103.c      | 587 +++++++++++++
 drivers/input/touchscreen/Kconfig             |  13 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/sw42902.c           | 360 ++++++++
 12 files changed, 1953 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
 create mode 100644 drivers/gpu/drm/panel/panel-lg-sw43103.c
 create mode 100644 drivers/input/touchscreen/sw42902.c

-- 
2.39.5
