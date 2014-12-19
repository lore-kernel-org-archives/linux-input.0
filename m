From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v2 0/2] Add support for Broadcom iProc touchscreen
Date: Fri, 19 Dec 2014 14:17:48 -0800
Message-ID: <1419027470-7969-1-git-send-email-jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:7480 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbaLSWSY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Dec 2014 17:18:24 -0500
In-Reply-To: <Jonathan Richardson <jonathar@broadcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Ray Jui <rjui@broadcom.com>, Jonathan Richardson <jonathar@broadcom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, Joe Perches <joe@perches.com>

This patchset contains initial support for the touchscreen on the Broadcom
iProc family of SoCs. This driver has been validated with Cygnus and is expected
to work on other iProc family of SoCs that use the same touchscreen controller.

Changes from v1:
- Add missing newlines to debug messages
- Use BIT macro for defines
- Fix logic in get_tsc_config to improve readability
- Get rid of unnecessary remove() function

Jonathan Richardson (2):
  Input: touchscreen-iproc: Add Broadcom iProc touchscreen driver
  Input: touchscreen-iproc: add device tree bindings

 .../input/touchscreen/brcm,iproc-touchscreen.txt   |   70 +++
 drivers/input/touchscreen/Kconfig                  |   11 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/bcm_iproc_tsc.c          |  535 ++++++++++++++++++++
 4 files changed, 617 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
 create mode 100644 drivers/input/touchscreen/bcm_iproc_tsc.c

-- 
1.7.9.5

