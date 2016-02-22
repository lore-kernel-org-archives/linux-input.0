From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH v3 0/3] Syscon support for iProc touchscreen driver
Date: Mon, 22 Feb 2016 13:19:36 +0530
Message-ID: <1456127379-25866-1-git-send-email-raveendra.padasalagi@broadcom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:54495
	"EHLO mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751433AbcBVHtr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2016 02:49:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>

This patchset is based on v4.5-rc3 tag and its tested on
Broadcom Cygnus SoC.

The patches can be fetched from iproc-tsc-v3 branch of
https://github.com/Broadcom/arm64-linux.git

Changes since v2:
 - Omitted '0x' in "tsc node" definition in dt documentation file
 - Omitted '0x' in "ts_adc_syscon" definition in dt documentation file
 - Added "brcm,iproc-ts-adc-syscon" compatible string in "ts_adc_syscon"
   node. Updated dt documentation file to reflect this change.

Raveendra Padasalagi (3):
  input: cygnus-update touchscreen dt node document
  input: syscon support in bcm_iproc_tsc driver
  ARM: dts: use syscon in cygnus touchscreen dt node

 .../input/touchscreen/brcm,iproc-touchscreen.txt   |  59 +++++++-
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  11 +-
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 152 +++++++++++++++------
 3 files changed, 173 insertions(+), 49 deletions(-)

-- 
1.9.1

