From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 0/2] Fix OF match for adxl34x driver
Date: Thu, 15 Jan 2015 16:54:13 +0200
Message-ID: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:51520 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbbAOOxv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Jan 2015 09:53:51 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert@glider.be>

Hello,

This patch set fixes OF matching for the adxl34x driver when the DT node lists
a device-specific "adi,adxl345" or "adi,adxl346" compatible value first.

The first version (see http://www.spinics.net/lists/linux-i2c/msg18107.html)
added an OF match entry for the "adi,adxl34x" compatible string. The
discussion that followed concluded that that compatible string should be
deprecated and that the driver should match the device-specific strings
instead.

The first patch thus deprecates the "adi,adxl34x" compatible string by
removing it the DT trivial devices list, and the second patch then adds an OF
match table to the adxl34x driver.

Laurent Pinchart (2):
  DT: i2c: Deprecate adi,adxl34x compatible string
  input: adxl34x: Add OF match support

 .../devicetree/bindings/i2c/trivial-devices.txt     |  3 +--
 drivers/input/misc/adxl34x-i2c.c                    | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart

