From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH v2 0/2] sun8i-a83t: Add touchscreen support on TBS A711
Date: Thu, 28 Dec 2017 17:33:34 +0100
Message-ID: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com, quentin.schulz@free-electrons.com
List-Id: linux-input@vger.kernel.org

Hello everyone,

This is a V2 of the patch series that adds touchscreen support
(FocalTech EDT-FT5x06 Polytouch) for TBS A711 (Allwinner sun8i-a83t SoC).
Based on last linux-next (next-20171222).

Changes since v1:
   - Remove patches 01 and 02 as Chen-Yu Tsai sent a similar patch:
   https://patchwork.kernel.org/patch/10111431/
   and it is merged on last next-20171222.
   (See commit f066f46ce5a5 "ARM: dts: sun8i: a83t: Add I2C device nodes and pinmux settings")
   - Update regulator according to Dmitry Torokhov's review: remove "optional"
   suffix while retrieving the regulator, rename it into "vcc" instead of
   "power" and add bindings documentation.
   - Update device tree according to Maxime Ripard's review: remove the
   label and rename the node.
   - Squash patch 03 with patch 05 to add I2C0 and touchscreen's node
   in one patch (see patch 02).

Patch 01: Add support for regulator in the FocalTech touchscreen driver
because A711 tablet is using a regulator to power-up the touchscreen.
Patch 02: Add i2c0 and touchscreen's node for A711 TBS tablet.

Thank you in advance for any review.
Best regards,
Mylène

Mylène Josserand (2):
  Input: edt-ft5x06 - Add support for regulator
  arm: dts: sun8i: a83t: a711: Add touchscreen node

 .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          | 16 +++++++++++
 drivers/input/touchscreen/edt-ft5x06.c             | 33 ++++++++++++++++++++++
 3 files changed, 50 insertions(+)

-- 
2.11.0
