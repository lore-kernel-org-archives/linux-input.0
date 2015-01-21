From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH RESEND 0/2] Add regulator-haptic device tree
Date: Wed, 21 Jan 2015 16:55:58 +0900
Message-ID: <1421826960-26491-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jaewon Kim <jaewon02.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

This patch series adds regulator-haptic device tree in rinato and monk boards.

The regulator-haptic has haptic motor and it is controlled by
voltage of regulator via force feedback framework.

regualtor-haptic driver merged at linux-next
ref : https://lkml.org/lkml/2014/12/17/477

Jaewon Kim (2):
  ARM: dts: exynos3250-rinato: Add regulator-haptic node for haptics
  ARM: dts: exynos3250-monk: Add regulator-haptic node for haptics

 arch/arm/boot/dts/exynos3250-monk.dts   |    7 +++++++
 arch/arm/boot/dts/exynos3250-rinato.dts |    7 +++++++
 2 files changed, 14 insertions(+)

-- 
1.7.9.5
