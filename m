Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793307760;
	b=Ukp7KCUSbUNXtv7K9tElK0GDqGbUCPqUrOA6QFzgOKG6SyVkxjstxs9KtI7KxxlL2dZD
	 nEyA+M2wV4EA0a7dKOhAalpcVM7P/bENwT3CZtU4t9Lpy3AT+68QQEfSdulIpLUTiu/c1
	 JcaOMcgMqxiuXyBmitpe4JQnXNgE3KQK1Yj3AOc8YRsFJTC7mLc1auvjqiyk2/MMTvyQx
	 7h2C0BueKf/OjrLvQC9hiWSW8U8oJtquAQEKOEFjZ4DEZ05lvMLXZ61YxY6JrbWo2VFW9
	 9XpYLMteeHTjPOtJy7SseEO2psEp7TG4zwwLie/gRW17Bk7p4QtC6cb/w/05biZ2LHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793307760;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=1CclvyY7a4SQr1rtPgZZW2/WqyIddkLtoJ9emFTdPsk=;
	b=JLAqPefu4TZnL94Exp+JE/sraTUAnDequNR+a94RCEQjsXmA8u6X/86r8NTYHJKSknBM
	 jgfOi1bmqkgwOEdQP71Q6jB/6J1h5rmR0WXeS3dZ6SdBRsuimXtDOX+CBvAo32hER9CYA
	 lEvSRUJEyz+QfkovOUD/4azWF/PHOjXDyqRe9Makm1yrQ4JUOkmV6mum3Y5p6rKPdGZSw
	 WmkaYIxorgvW9SFhF5fUBEU5bxQpLkLYdatWuxkG/aMnnZ/wBGee+q0p4Y9sP55E8DmTY
	 SmDS7dO88XuyHwjJNSV0qFhVD7qE9PQxqfwfroBK4840pKT+pN4+cqFbImZW6/eYhuA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8JWXz0l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF31606A33D;
	Thu, 29 Oct 2026 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8JWXz0l
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793307760;
	b=iTL/SI5b7mJ3cA3U6+NdytbvWJWOY+nur2qOg+TBBJBS2K03GrOierCcGBOHdGirXMd2
	 9whHsgEUqJ9tC6sXTR6MLZNGyh660ZxkKpPZMn7kh8x8mc5Paw8KPsZY6kFjWajF7pz4C
	 DDi9Amb72nU29R/zjWTtgUvw/ELnXN1T0d5Kdj2c6aSZBa5e3KP60tel/+t6AsOrOMUFL
	 aIeN6ZQiBFMpT5P4y8IvQEezEgRQlpHJIUTl4ix/g5HOfPB19pnwRJHuUTBQNGNO1KyBA
	 Svu49/NjldhxloV4m1r8R21Haoj5wlybroEWFA1SdrRrMXhIMUH8FaK0s86vDBs5lRg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307760;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=1CclvyY7a4SQr1rtPgZZW2/WqyIddkLtoJ9emFTdPsk=;
	b=bmU4OiDFLC4iyGg9hsNnSPZ+isqIw0FTQDlYuaSDqe0hmrK1FeJX8TpJcNUsHwPIA2dd
	 vM6pZIELRzppSgF1Zuoe8CfVHC4uC62mkG2OakKmQ6CG9QmDjEHoPSZSj9ZNyyhyJV/I0
	 pksuH4rgRV5D7JbdptV9YrcUYofO9ItFm/X/fE6v8a7fTZphh7BTOP3tz1zb5Rs9VLPCY
	 r0uA/96MP7WxsCPZUgLH+0VTI0/wQQAWcOwD7rrAGuE4Jr02l5L7nxfwaBpGi4OTcrqvj
	 +Ss8XNA/jSNgWNh3KQcQAod+SKbk4sIvPWl+DBorJL6s9PJCZZbaX9q8YG2N+/T6D9w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 347841F01824;
	Thu, 29 Oct 2026 21:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793307759;
	bh=1CclvyY7a4SQr1rtPgZZW2/WqyIddkLtoJ9emFTdPsk=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=g8JWXz0lbFaX6JosPGDIHwF8gW69RO27/C28eXWJKqAOsMlIMuOFPBrZ5fbIK0PCW
	 WW5N9Jis/tfhmjDmeau/8anTIwq/sbSvmq/SMIGfJ4GntiLhc7KJEkztLwt1YM3txo
	 62TT1ocCsLM2URrcWOdTAcSkzDvpKbQNuVeBA1FjfjsrPvYBLRV8HKZ9eZ3c9hgC0U
	 UtjkVLjlmRNRM+IQPjseZ1SfisF9rDdFubytJXB7eRiD8ayg0QzqnupOj1Nb01IHpH
	 qFlg1RZJZSqX7hvMtf5Tb7ydZAJEwAucMbcPmX6gAJkSwBMnkHAmGbtL0yrVRgtW6f
	 D+xWjOZzzaP6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7EDF6459BA;
	Thu, 29 Oct 2026 21:02:37 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Subject: [PATCH v7 00/11] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
Date: Fri, 30 Oct 2026 00:02:31 +0300
Message-Id: <20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OTWrDMBAF4KsErasyGus3q96jdGFLY0eQ2EZyT
 Uvw3SuHUgy1s3zDzDfvzjKlSJmdT3eWaI45Dn0J5uXE/KXuO+IxlMwQUIMDx2/5Zp1CHvs4xfr
 K8+c4DmniGmpQziMJRaxcj4na+PWQ3z9KvsQ8Den78WgW6/TXFHhozoIDBzISlbGNQvl2q2N/L
 Wt99zqkjq3wjFtMH2NYMOOsL3sYAoldrNpgKI6xqmCN022oWkJnm11M/mEC4EkzWTDywXtRe43
 gdzG1wcSTZqpgwioDRjqHtI/pDYb2GNNrMzAhBNv4Vv7HlmX5AShATUJEAgAA
X-Change-ID: 20260909-msm8952-initial-support-60a059c2e15e
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-remoteproc@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793307755; l=5600;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=f/710DMBCeH1DaZcIhMQg0VmZNSOMZTfOUmb7qsdEJE=;
 b=MgPS4pbxlSjUhNTk+Az7Fn1LktMh5NrC7Wgi+tYZ9+LQQbW6OH6O0BQHHK6uSn+bFIuW6jzlx
 /RC7jpA4POJCye1AG7tabe/zFHyzPhFH5ghXiOuXXiJraVHh+pFTVPU
X-Developer-Key: i=muzafferkadir@mainlining.org; a=ed25519;
 pk=4zkv4suQ3cYcO4Z7CrV8JSSjEGLBGepUtvQCFjgnYIU=
X-Endpoint-Received: by B4 Relay for muzafferkadir@mainlining.org/20260816
 with auth_id=954
X-Original-From: Muzaffer Kadir <muzafferkadir@mainlining.org>
Reply-To: muzafferkadir@mainlining.org

MSM8952 is a SoC with 8 core cpu and Adreno 405 gpu.

Ported without uart connection. ramoops and usb
mainly used to debug.
USB is not enabled in this series because it
depends on the not yet upstreamed (and not developed by me)
pmi8950_smbcharger.

General Mobile shamrock display panel driver
is generated using MSM8916's mdss dsi panel
driver generator and tested with it. I didn't
include it.

Pinctrl driver was submitted and merged here:
https://lore.kernel.org/all/20260907-msm8952-pinctrl-v5-0-9a2d8d72ffdb@mainlining.org/

Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>
---
Changes in v7:
- Dropped the tsens sensors which was renamed at v6 and l2 sensor.
- Wired mdss mpm (sashiko).
- Changed size of master_stats addresses that exist on rpm_msg_ram from
  0x14 to 0x50 (sashiko).
- Renamed crypto_dma and usb_dma to cryptobam and usbbam.
- Changed device dts, si-en led label property to color and function
  properties and replaced multi-led function from indicator to status.
- Fixed hexagon_smsm interrupt, also added adsp_smsm.
- Added opp-tables to sdhci_1 and sdhci_2.
- Link to v6: https://patch.msgid.link/20261028-msm8952-initial-support-v6-0-e07ddd8bcf4c@mainlining.org

Changes in v6:
- Use one-per-line in SoC dtsi as Konrad requested.
- Drop unneeded dr_mode in usb as Konrad requested.
- Drop 1651200000 from pll_opp_table_c1 as Konrad requested.
- Added new patches for more msm8952 specific compatibles as Konrad
  requested.
- Renamed 'aoss0', 'modem', 'camera' sensors to generic names as Konrad
  requested.
- Drop clock-frequency from timer as Konrad requested.
- Switched passive and hot of cpu0-3-thermal trip types
- Link to v5: https://patch.msgid.link/20261011-msm8952-initial-support-v5-0-1857074992ec@mainlining.org

Changes in v5:
- Added opp table for spi and uart.
- Wired all i2c and spi power-domains
- Dropped default slope from thermal driver.
- Link to v4: https://patch.msgid.link/20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org

Changes in v4:
- Dropped 1651200000 freq on cluster 1 because it depends on speedbin 3
  and speedbin is not included in this patch series
- Dropped applied patches
- Changed mdss_dsi0 power-domain to MDSS_GDSC
- Reformatted SoC dtsi file
- Added the remaining reserved-memory entries for not added parts
- Rename adsp_mem to adsp_fw_mem
- Drop the "ts-" prefix of touchscreen pinctrl in device dts.
- Link to v3: https://patch.msgid.link/20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org

Changes in v3:
- Improved GCC driver, also rewrote resets part
- Rewrote the dt-binding side of gcc
- Reformatted Device tree files with dt-check-style tool
- Added reset to sdhci1 and sdhci2
- Added cx regulator to gcc
- Added gcc commit messages that it is a derived driver
- Dropped adsp_mem, renamed lpass_mem to adsp_mem
- Changed tusb320 interrupt from rising to falling as downstream uses
- Link to v2: https://patch.msgid.link/20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org

Changes in v2:
- Changed device dts file as David's and Konrad's suggestions
- Removed accidental duplicated clock assigments and fixed wrong gcc gp1,gp2
  and gp3 parent_maps
- Updated commit messages to make it wrapped at 72 character.
- Fixed spi1 tlmm node naming
- Added remaining spi and i2c nodes
- Wired up mpm
- Add mmio-sram to rpm_msg_ram
- Reformatted msm8952.dtsi
- Removed rpmcc-msm8952 driver entry and replaced it with rpmcc-msm8976
- Merged sdhci tlmm pins to single nodes, now it is similar to existing SoCs
- Rebased to latest linux-next, now storage works
- Removed polling-delay properties from tsens
- Link to v1: https://lore.kernel.org/r/20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org

---
Muzaffer Kadir (11):
      dt-bindings: nvmem: Add compatible for MSM8952
      dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU to SMMUv2 compatibles
      dt-bindings: watchdog: qcom-wdt: Document MSM8952 watchdog
      dt-bindings: sram: qcom,imem: Document MSM8952 compatible
      dt-bindings: mailbox: qcom: Add MSM8952 APCS compatible
      dt-bindings: clock: qcom,a53pll: Add MSM8952 compatible
      dt-bindings: display: msm: dsi-controller-main: Add MSM8952 compatible
      dt-bindings: remoteproc: qcom: adsp: Add MSM8952 ADSP compatible
      arm64: dts: qcom: Add initial support for MSM8952
      dt-bindings: input: touchscreen: goodix: Add binding for GT970
      arm64: dts: qcom: generalmobile-shamrock: new device

 .../devicetree/bindings/clock/qcom,a53pll.yaml     |   25 +-
 .../bindings/display/msm/dsi-controller-main.yaml  |    2 +
 .../bindings/input/touchscreen/goodix.yaml         |   35 +-
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |    1 +
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |    5 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |   31 +-
 .../devicetree/bindings/sram/qcom,imem.yaml        |    1 +
 .../devicetree/bindings/watchdog/qcom-wdt.yaml     |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../dts/qcom/msm8952-generalmobile-shamrock.dts    |  442 +++
 arch/arm64/boot/dts/qcom/msm8952.dtsi              | 2909 ++++++++++++++++++++
 12 files changed, 3416 insertions(+), 38 deletions(-)
---
base-commit: 151a134a4e6ec66f69db8750c66006f5207f7a9d
change-id: 20260909-msm8952-initial-support-60a059c2e15e

Best regards,
--  
Muzaffer Kadir <muzafferkadir@mainlining.org>


