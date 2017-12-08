From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/5] sun8i-a83t: Add touchscreen support on TBS A711
Date: Fri,  8 Dec 2017 22:54:14 +0100
Message-ID: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: simon.budig-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hello everyone,

This patch series adds touchscreen support (FocalTech EDT-FT5x06
Polytouch) for TBS A711 (Allwinner sun8i-a83t SoC).
This touchscreen is using i2c so this series adds support of this bus
on A83T.

Series information:
   - Based on last linux-next (next-20171208)
   - Had dependencies on AXP209 Quentin Schultz's series:
   https://www.spinics.net/lists/linux-gpio/msg26913.htmlx

Patch 01: Add i2c0 node on a83t device tree.
Patch 02: Add i2c0 pin group.
Patch 03: Enable i2c0 on TBS A711.
Patch 04: Add support for regulator in the FocalTech touchscreen driver
because A711 tablet is using a regulator to power-up the touchscreen.
Patch 05: Add the touchscreen node in A711 TBS tablet.

Thank you in advance for any review.
Best regards,
Mylène

Mylène Josserand (5):
  arm: dts: sun8i: a83t: Add I2C0 node
  arm: dts: sun8i: a83t: Add I2C0 pins group
  arm: dts: sun8i: a83t: a711: Enable I2C0
  Input: edt-ft5x06 - Add support for regulator
  arm: dts: sun8i: a83t: a711: Add touchscreen node

 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 18 +++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi         | 16 +++++++++++++++
 drivers/input/touchscreen/edt-ft5x06.c    | 33 +++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
