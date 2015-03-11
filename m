From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v3 0/2] Add support for Broadcom iProc touchscreen
Date: Tue, 10 Mar 2015 18:17:47 -0700
Message-ID: <1426036669-21659-1-git-send-email-jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:59240 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbbCKBQq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2015 21:16:46 -0400
In-Reply-To: <Jonathan Richardson <jonathar@broadcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>
Cc: Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org, Joe Perches <joe@perches.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

This patchset contains initial support for the touchscreen on the Broadcom
iProc family of SoCs. This driver has been validated with Cygnus and is expected
to work on other iProc family of SoCs that use the same touchscreen controller.

Changes from v2:
- Misc style changes.
- Removed assumptions about interrupts generated in ISR. It now emits all
  events and then syncs if necessary.
- Removed our rotation property and replaced with the latest
  touchscreen-inverted-x/y. Also added support for the standard optional
  properties touchscreen-size-x/y and touchscreen-fuzz-x/y. Did not add support
  for inverted-x/y at this time as our touchscreen is currently only oriented
  180 degres.

Changes from v1:
- Add missing newlines to debug messages
- Use BIT macro for defines
- Fix logic in get_tsc_config to improve readability
- Get rid of unnecessary remove() function

Jonathan Richardson (2):
  Input: touchscreen-iproc: Add Broadcom iProc touchscreen driver
  Input: touchscreen-iproc: add device tree bindings

 .../input/touchscreen/brcm,iproc-touchscreen.txt   |   76 +++
 drivers/input/touchscreen/Kconfig                  |   11 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/bcm_iproc_tsc.c          |  527 ++++++++++++++++++++
 4 files changed, 615 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
 create mode 100644 drivers/input/touchscreen/bcm_iproc_tsc.c

-- 
1.7.9.5

