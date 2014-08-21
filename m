From: Dan Murphy <dmurphy@ti.com>
Subject: input: drv2667: add support for drv2667 haptic driver
Date: Thu, 21 Aug 2014 13:19:01 -0500
Message-ID: <1408645143-25690-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45498 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854AbaHUST3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Aug 2014 14:19:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Adding support for the TI DRV2667 haptic driver.
This device driver a linear resonant actuator (LRA)
based on user space requests to provide either a
vibration or a haptic tactile response to an input.

This device has the ability to store wave patterns in RAM
and these patterns can be executed based on user input.

For this initial series I added just the basic vibration
pattern along that will continuously execute until
the user indicates to stop.

[PATCH 1/2] doc: dt/bindings: input: introduce TI DRV2667 haptic
[PATCH 2/2] input: misc: Add support for the DRV2667 haptic driver
