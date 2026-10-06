Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50483EE1D8;
	Tue,  6 Oct 2026 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791288941; cv=none; b=lMcUNVp4d/yWd55i0kaYRyysuHyouZZXx7pZtdfrix7ycP6p/b/l37DWc1NgH2IX6bfAO1Xbe38DtwSD5A1yHtOBL33UHjlsAlLveDdwXrptmdtmxHjFh7cmyD4r3eA9e8WojzsH83SmCa9FEcBNMwQFWGcNMHgAK0DZ1y+yDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791288941; c=relaxed/simple;
	bh=rYCBbrg6VaozSAt8qT2CvuJdZ2GptJZIPsnjcyJQKUE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BKV9SUV7UQn8HdYFfz0+y1z+f5sBRwE4Yi/pzEVHs4HOR+HTS087ukp/eIktJW/icS2l7cL9oM+c5dM46LpCM/h6V4ajF5IUkVMCZT4WjFpFYyu60w/NryJAwKHS/jJRlUFXBY8UoQIN+L4gLX1s1NeMO9sSTb2kEjbYYuDT3DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdRt9J32; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdRt9J32"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6664C4AF0B;
	Tue,  6 Oct 2026 12:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791288940;
	bh=rYCBbrg6VaozSAt8qT2CvuJdZ2GptJZIPsnjcyJQKUE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZdRt9J32LcOc7hFkdqRc0knbJ30Eir0jBNe9U514CISBDdPhh7wS4wC8/uowEHGMg
	 M+/RyNJY3NnClSBW7V3zr9Q0pBXiDYT2yArX4p1j/L6lb8jIcw/BZIHXF3fdSGWv6A
	 31+NnIARV561UFV0x3eIbM3lBbvTw/mWex63xAsSYWRQyrCF7L0Gb4y2li3mMqg7OV
	 hgrWvH0e/5BhNWFB8+TsP0Sf/Jo/5dHVVs9orLboIHjgYcqcJA9cFjKx7wDdo1kcfR
	 r9jka/B/yZxfAFLFQiXHWnHKhjWMmkuyBu8bbqMBlo51KsFVsKV3ImFUvUwXUUQxTN
	 6hvjvF5Bcgr4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8467CCA5FF0;
	Tue,  6 Oct 2026 12:15:40 +0000 (UTC)
From: Muzaffer Kadir via B4 Relay <devnull+muzafferkadir.mainlining.org@kernel.org>
Subject: [PATCH v4 0/7] Add Initial Support For MSM8952, Add General Mobile
 Shamrock
Date: Tue, 06 Oct 2026 15:15:07 +0300
Message-Id: <20261006-msm8952-initial-support-v4-0-ecdcc1ac620c@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ6CMBAF4KuQrq1pBwrUlfcwLvgZYBJpSYtEQ
 7i7hbggUZZv8t43M/PoCD27RDNzOJEna0JIThGrusK0yKkOmYGAVGihee/7XCvgZGik4sH9cxi
 sG3kqCqF0BSgVsrAeHDb02uTbPeSO/Gjde3s0yfX6NSUcmpPkggvMElBZXipIrn1B5hFqpj1b1
 7IVnmCPpccYBCzTeRV6UNco/2LxDgN5jMUBK3Xa1HGDoPPyB1uW5QNfLoJSXQEAAA==
X-Change-ID: 20260909-msm8952-initial-support-60a059c2e15e
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abelvesa@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 linux-pm@vger.kernel.org, linux-input@vger.kernel.org, 
 Muzaffer Kadir <muzafferkadir@mainlining.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791288938; l=3733;
 i=muzafferkadir@mainlining.org; s=20260816; h=from:subject:message-id;
 bh=rYCBbrg6VaozSAt8qT2CvuJdZ2GptJZIPsnjcyJQKUE=;
 b=CizsLT+23ueq94HTcVvhJxrkLy7dnhL+aXcQ77BQ3VrL2ubqpS9ezdLtcYgQ0Vph6KvqZOL7I
 oeb3Go0K5dODlkyC1pvpp+CnnZw0VQousR/V3UNs4egDm+6lx80rRTB
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
Muzaffer Kadir (7):
      dt-bindings: nvmem: Add compatible for MSM8952
      dt-bindings: iommu: qcom,iommu: Add MSM8952 IOMMU to SMMUv2 compatibles
      dt-bindings: thermal: tsens: Add MSM8952
      thermal: qcom: tsens: Add support for MSM8952 tsens
      arm64: dts: qcom: Add initial support for MSM8952
      dt-bindings: input: touchscreen: goodix: Add binding for GT970
      arm64: dts: qcom: generalmobile-shamrock: new device

 .../bindings/input/touchscreen/goodix.yaml         |   35 +-
 .../devicetree/bindings/iommu/qcom,iommu.yaml      |    1 +
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |    1 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |    1 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 .../dts/qcom/msm8952-generalmobile-shamrock.dts    |  435 ++++
 arch/arm64/boot/dts/qcom/msm8952.dtsi              | 2720 ++++++++++++++++++++
 drivers/thermal/qcom/tsens-v1.c                    |   44 +
 drivers/thermal/qcom/tsens.c                       |    3 +
 drivers/thermal/qcom/tsens.h                       |    2 +-
 10 files changed, 3227 insertions(+), 16 deletions(-)
---
base-commit: bf1ee2bd5c2da8992f33c8950ef194aaff74ed6c
change-id: 20260909-msm8952-initial-support-60a059c2e15e

Best regards,
--  
Muzaffer Kadir <muzafferkadir@mainlining.org>


