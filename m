From: Raveendra Padasalagi <raveendra.padasalagi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 0/3] Syscon support for iProc touchscreen driver
Date: Sat, 27 Feb 2016 12:29:53 +0530
Message-ID: <1456556396-4759-1-git-send-email-raveendra.padasalagi@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Raveendra Padasalagi <raveendra.padasalagi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patchset is based on v4.5-rc3 tag and its tested on
Broadcom Cygnus SoC.

The patches can be fetched from iproc-tsc-v4 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v3:
 - Renamed touchscreen node "tsc" to "touchscreen" in dt binding document
 - Added support for syscon only based register access in touch screen
   driver and removed "regs" based register access. Updated dt binding
   document to reflect the changes.
 - Removed "brcm,iproc-touchscreen-syscon" compatible string support in
   dt binding document and touchscreen driver implementation.

Changes since v2:
 - Omitted '0x' in "tsc node" definition in dt documentation file
 - Omitted '0x' in "ts_adc_syscon" definition in dt documentation file
 - Added "brcm,iproc-ts-adc-syscon" compatible string in "ts_adc_syscon"
   node. Updated dt documentation file to reflect this change.

Changes since v1:
 - Enhanced touchscreen driver to handle syscon based register access if
   "brcm,iproc-touchscreen-syscon" compatible string is provided in dt
 - Normal register access is handled through readl and writel API's if
   "brcm,iproc-touchscreen" compatible string is provided.
 - Updated touchscreen dt node document to reflect the new changes.
 - Updated change logs in each patchset to reflect the new changes

Raveendra Padasalagi (3):
  input: cygnus-update touchscreen dt node document
  input: syscon support in bcm_iproc_tsc driver
  ARM: dts: use syscon in cygnus touchscreen dt node

 .../input/touchscreen/brcm,iproc-touchscreen.txt   | 21 ++++--
 arch/arm/boot/dts/bcm-cygnus.dtsi                  | 11 ++-
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 79 ++++++++++++----------
 3 files changed, 69 insertions(+), 42 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
