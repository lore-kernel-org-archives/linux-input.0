Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190094;
	b=rKbv4dgoDWcpCoU+EDXgTOC5LeBMDZM4vewfo1slwz01zN6/ujeFY9w7V7Fti2mPdTCx
	 UtsoT3gzzdX3+BIWtnCdBv9fxEShc38VVIJbyYFAOnmh+9cQYtLw1K5v2LJz5BgqRjEJq
	 DB4lSrUokElhuDJb81j7lNdSWL9ch6k8aeBYPKHk0dHKsjU/cSqUofZETBgQBsgYq6VQ7
	 dBDb6TplWfFUTJQPA+fW1GyaBKKuo5UIgcr/3if/OhVg3M/JcOCacs1lmkMFbixVA81V2
	 5JSS2esGM2O6WMwieGChslPv6UtBItwma0gDR3w2s4JOxIuXdF2kweVS88DUDUKLMgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3+aCHgVYgy4GxhOiFEAFYeoXQcQ3nMSgt2tm+XSQojA=;
	b=oiW5C5/x4pLTMg+ziGKnE36LO1uqZ1npORUTR/DnRf0q8F0aAMG2YOs9xOTLXfU2Xti7
	 FnjfS8XMVCrhcozUmwg6JHSt/aYnxNkYFYifA9c6i7YPy+k1KY48ppWaVmMorQJm3RtV3
	 fj1leJD2xQ2CfSIbHcym0oXpCJJ6iz3tddg+pBqAU7B3Tor6QkFeccrBC7xKoEYOMze4f
	 WTrhpntSWaDHnjhoenheNFBOmSDZ9xWMs6hbhBmm5nxdqYfJeKVIJsNW8IjrvVLxKUBA3
	 UjHZy+5LFM8pQHBVZ98FmN4GaBqC75VBp38NAGgtYR0DoJDc8Wrx0cuhnLLDVeMlqKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RD5/lCtn";
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA40C606A332
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA40C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RD5/lCtn
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-49d64a88222so1425490f8f.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795190092; x=1795794892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3+aCHgVYgy4GxhOiFEAFYeoXQcQ3nMSgt2tm+XSQojA=;
        b=RD5/lCtnOo+RVTTI7oVZaKgd9Q6AkBDr/99U8FJkjIF5smpOcyVCzuMQxHGfar6mJP
         37JcniEPoUaZpTyUdt7yOTWPLtrvvu8AzDXr/L34n/+/Nc9nXYOPlfV4w2V781MMQM8G
         53Na36tf6jUaKgxhT0zm5Wm3KIMtVpSTLF9W5oh/1KR1iwQmFF+qHaWV8PVJ+kHJX1iX
         RPoDVVb4F+Eh7tSV8FPxMIWWzu8Zhcdj03O6TponxyFSrrZ9YPmtJdT7HnrqNxKkFDQf
         7ojn0P8k9fkZxWsWkHoFIirgqk+ylgTPwXP7F3bPNM7Qc/OO+JHnYCtfr3DUp3YIo8zH
         gQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190092; x=1795794892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+aCHgVYgy4GxhOiFEAFYeoXQcQ3nMSgt2tm+XSQojA=;
        b=KI6GEtiVuIkZcl57liQt4aw8Z0tpQ+JgvlbcGaWuJOqkr+8ltSdFI196iGRlRDpeNB
         KohTSE+14fs84uXdgUQBKb9LdZpqoujO+EayqCCdNv01CsxTaOw4dmUc/FGqtFMR2gME
         WI+KHF9qfSNDnmdC5rsBeOODPnwo8ApgSNM8gKtTlC8zeKW/H5YxYgBujvyCCHbpDuv4
         Tqk8AiPRZo8OL+dmBdGyTiVcIYUK+5IglXmbaBVX/cjnJfdMQ8m+GJ2RxGriLBvyZn45
         6oxF/9NT9SEvp118OJK/4ux08xHXE6CJjrwy+FXfaA0MQzDdWj1SjIN5Ymqty2tTwBM9
         3c2w==
X-Forwarded-Encrypted: i=1; AL+hErEnLFMQsnT0W9TU9vYyzbuaQvQ8E9thaoBdRNa68tH1MOX/9MB+t+/3LVJGz+oeQ+epvtnukKspwlPYng==@vger.kernel.org
X-Gm-Message-State: APuU4Z/HdMUDdTVjRwmJ0jUknTVl8ZK/qEd9mFZOrEmHOz4Qa+wxF+bF
	U2iV83Du0433+6AX6gdDyO0L3QO4CXqwX/G/eHV1LuQyuHp24sbGAIGw
X-Gm-Gg: AYBFou2ncdPfEsUQDu/LCZDr7XBSN6p1nfqf91Xib02szGlNEiyK0uVMDslPMglL6kc
	vnyyK1QZLJXSXQjNZMlsihX07+qbQC+W0S67LRGLgzBC/HA2dKasRGndGnFW0wKoA0p6RVEt9WI
	3kOeomHso8lgTW9+Jczkw1/Ya7tkEe2wY7mMdgoyduvnMNMljPXuTLEEEEuMEPtc73+M6/vjoTt
	+WCyb+wWluxi9X/kNL36/Pkk7BnlKwi1MEPmy/ScBDxBsTbzVl8eMia8JKgm9ByJe7n/Ex1beKR
	nIu2/TIiuab5mGlgZbB+Dv5p0h+tYYyWClbLf14AWuhiSS+2+Voa1WVgtpI+TPPUYcqoWKT0GP6
	U4QmvUta6Gi/HagtnTVhrCQ8P+Z/oxuGzf/UmyM6I0P7miGnVUflU6+nbK1YlhkdnbP/77I4yAr
	WuI8d4axyUzYXewE0qD0xtT+kg2SsE8bz01iv+NpozDh6b56WbN9Xw5F1ZGSOj0s0T4Ag9fSCNb
	QFJQ/wJicJ7sQFDM9OJcyEG5Bt1DWUN2Xbc3a4Qzim8RyCRunB0cyWS5HDCGKAq4yePhVQIxx4N
	aD7kRRA1pesOh6oLAUiXZ6D/cIDskE6wqm036L72L3hMyVmgHsvRUdkkHmvDscJ33OHmzGgVmbn
	tk23WHa+knJ1wGNjIoWNe
X-Received: by 2002:a05:600c:4504:b0:4b4:a551:681a with SMTP id 5b1f17b1804b1-4bb887fc396mr78640565e9.3.1795190092017;
        Fri, 20 Nov 2026 07:54:52 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu. [178.164.182.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:54:51 -0800 (PST)
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
Subject: [PATCH v5 00/10] arm64: dts: qcom: add LG V60 ThinQ 5G (timelm) support
Date: Fri, 20 Nov 2026 16:54:39 +0100
Message-Id: <20261120155450.7719-1-rofikcoga@gmail.com>
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
- Silicon Works SW42902 I2C touchscreen controller
- PM8150B USB Type-C controller in sink mode with USB-PD and
  orientation switch
- QCA6390 Bluetooth HCI controller on UART6

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
 .../input/touchscreen/lg,sw42902.yaml         |  72 ++
 MAINTAINERS                                   |  19 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 814 ++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |  13 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43103.c      | 587 +++++++++++++
 drivers/input/touchscreen/Kconfig             |  13 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/sw42902.c           | 360 ++++++++
 12 files changed, 1951 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/lg,sw43103.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
 create mode 100644 drivers/gpu/drm/panel/panel-lg-sw43103.c
 create mode 100644 drivers/input/touchscreen/sw42902.c

-- 
2.39.5
