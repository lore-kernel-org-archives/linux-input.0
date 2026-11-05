Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876117;
	b=Wy9bzUjooDEgtEWy7S9OmnGoBYmkq0EYzcCtFNxdT+0EYXe+jB+A0DYl7FUeO6Tq0UPR
	 GQMSA4d5PimVmRQZjrX4vyg0jBMaxc3oWenXTMA0vWUTgfxm0nSNl+JOVcMw6PI7CcgiV
	 l0xPv+ojQrlWspQ2P3wT0qCBIZw+QDuYU04WI8V0PikmzQCwCl/RIGE22J+rhrAxLAy7p
	 YFu161ajizC3VfFDvvleGiHdSmA6MK52/jE4nZKlzpyG4SpgWTiad/ifcP3fwOfftZ8cU
	 0VbSmamDu7vFPy1JE/MJvVAVY3OtSicDOqk10WKilCqIUTUHrxug+UUL9NdxMhNYIDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876117;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Uav8r8vkr617BpZOKppFlAjMoyKZE3s8hNp+NfaErNc=;
	b=c/kBr1NNcjO/+o4mN07cf3cfGTaoBFyYQUx9wFqBZeUINFuB7e4hnWUyrnD2aKzbFhjA
	 sNzreFqfp2T5hvBkADIGd0ZtHfl7UjYfa0EKSPQM0BgKj56E5SvF4C8O+r97jK6Ak7l9c
	 2UUujAR/DYzxSnJI9gYgdHVy0ZWdtPOyjAoGw+j+d8xwjaNMRKyL6R7lWtYGuw5nbBhFX
	 zBiEH/spUnRTOFtY3t+/ma8c7kN3SVIFjwHYF6CaJyG60QNfgxL4G+ikdnnbAU1ijqGJ/
	 uVvGtmJzkPOUrMgGDWoXFF8EogwvNHltP2R7gg43eq2LN4X93m3D5qrZlo4ZpUnOtFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDRuM+x7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A991606D805;
	Thu,  5 Nov 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDRuM+x7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793876107;
	b=gWMm+zcLEZ/+ElMbBJPiTgVBfCZXhPW1kb2pKZd3wKLuoWp4/AcfatVCnVmO53W8c5tU
	 QWt+wYwe3qik6+1uwpKJMa65Evqij8//8j+AH6buiSNCtgU6i26R3tgt8WaYHiYV5Xgp/
	 bIBCn84LZ9k6WTUsiH12N3H96PpojyeONbM2MpegeGNA83qxukiOVe0Nubw9zRzFVtSO1
	 FRicpNquC4YnYd3yv9I7gSHUF0+gXAOBQInBuFCaqD6XTla0VovhruMJg/b0mIl/2MWCW
	 0VbrWPsz76WXmtoS+GLXcIxua5Cg8/Qmr7aLo6fBk6Diza8n0VvnCdqeMLmP4s3RsJA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793876107;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Uav8r8vkr617BpZOKppFlAjMoyKZE3s8hNp+NfaErNc=;
	b=iYcpvH3W9PtcScl9P1eRZcn5axzjHDi9gR5hVSDzQ7/UfYVqEH1Z9BOzTHxYWvW+r7Xe
	 OYV4uR9DYMdtFfzS5C4oJf0oM7dwZ1tPKBTr6QHN9yD4klXZTqxiV6zDIA2S2hGe0BHXM
	 cCEbI4xTHycMzlSrnYwHsJXDDcM97rpL0DXcklwmiRNyP/DrvoA+8fWAraFlJJa/2MMxo
	 5bF4dEevbZ0nZNiZD11u8kphG3AFpEWeQq5jsC3hN9T8hwglQOaPypQh0ypdh3PdY1Di3
	 flS59JPbAcagXRq1zHC46OXogiF8+xm2rVQjlhvE5FqfGai5M9DejqJU/CC12ZjDgYA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 814F21F00A17;
	Thu,  5 Nov 2026 10:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876107;
	bh=Uav8r8vkr617BpZOKppFlAjMoyKZE3s8hNp+NfaErNc=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=BDRuM+x7m4N//eFIemIRtAa69jjwox/w51Wbnl4zx28cpPX7XqrB0LbqxayOvndqR
	 fycPEs50zooQJQIJZQZ6AYxiTqvJ9E6CYz4zDCYqgId7NN+5QznS3WcTfdp2bkge4n
	 DywNxUlI0EKTDChINQVPu2wCHXc5QO+hv1pkd0MDPFFeldrK68Sby4JhkfVcYyts/W
	 V9WOeaBQUOJN/FMp1Mt3Qboz+MOcTbOv/B23GgZk/Xymic/fo18T8Ym9le3BwFjFgH
	 oEaXbgjTPPZAZ9/kAWBQ3+G4PuOsbar1mWLxaou5/NQ+1SX9MrD1MZAhDCKfaG/6os
	 G1tbSwKCkp1oA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D59AD471D6;
	Thu,  5 Nov 2026 10:55:02 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Subject: [PATCH v8 00/11] Add Initial Support For MSM8952, Add General
 Mobile Shamrock
Date: Thu, 05 Nov 2026 13:54:04 +0300
Message-Id: <20261105-msm8952-initial-support-v8-0-311ae8e8f14b@mainlining.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OTWrDMBAF4KsErasyGus3q96jdCFLY0eQ2EZ2T
 Uvw3SuHUgy1s3zDzDfvzkbKiUZ2Pt1ZpjmNqe9KsC8nFi6+a4mnWDJDQA0OHL+NN+sU8tSlKfk
 rHz+Hoc8T1+BBuYAkFLFyPWRq0tdDfv8o+ZLGqc/fj0ezWKe/psBDcxYcOJCRqIytFcq3m0/dt
 ax17WufW7bCM24xfYxhwYyzoexhjCR2sWqDoTjGqoLVTjexagidrXcx+YcJgCfNZMEoxBCEDxo
 h7GJqg4knzVTBhFUGjHQOaR/TGwztMabXZmBijLYOjdzHzAar4BgzBfPRSOsDVUbFf9iyLD8L3
 UErkQIAAA==
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793876100; l=6061;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=kT+nfZeqU75MSXRD8dtUdyfdeDh4MjryUfytbr2xwjU=;
 b=rpa+yv6ZfoMBTgbpxQhjDhGmZSd25JUwDll3WMweDmlZP35ZsEgHn+5PbZKbYFUXKs0rsyuW8
 oUmDoBvc6vLCM7Pk9xbAX4m+T6k5tEu/7NQHW6zh242rpsq4lQKBLcn
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
Changes in v8:
- Change USB ASYNC and USB to USB DP and USB DM on mpm (Konrad).
- Removed mdss mpm as I saw problems related to it on my last tests.
- Changed thermals cooling maps from hot point to passive point (sashiko).
- Added tbu clock to mdp and gpu_iommu. (Konrad and sashiko).
- Dropped the "assisted-by LLM" from the msm8952.dtsi patch.
- Link to v7: https://patch.msgid.link/20261030-msm8952-initial-support-v7-0-ad748ace375d@mainlining.org

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
 arch/arm64/boot/dts/qcom/msm8952.dtsi              | 2912 ++++++++++++++++++++
 12 files changed, 3419 insertions(+), 38 deletions(-)
---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20260909-msm8952-initial-support-60a059c2e15e

Best regards,
--  
Muzaffer Kadir <muzafferkadir@mainlining.org>


