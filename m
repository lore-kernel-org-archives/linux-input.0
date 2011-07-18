From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 0/2] add device tree probe support for gpio_keys
Date: Tue, 19 Jul 2011 00:45:06 +0800
Message-ID: <1311007508-8096-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47782 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab1GRQds (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jul 2011 12:33:48 -0400
Received: by iwn6 with SMTP id 6so3239885iwn.19
        for <linux-input@vger.kernel.org>; Mon, 18 Jul 2011 09:33:47 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

The first patch gets the driver stop referencing platform_data after
.probe exits.  And the second patch adds the actual device tree probe
support for the driver.

Shawn Guo (2):
      Input: gpio-keys: do not reference platform_data after .probe exits
      Input: gpio-keys: add device tree probe support

 Documentation/devicetree/bindings/gpio/key.txt |   57 +++++++++++
 drivers/input/keyboard/gpio_keys.c             |  128 +++++++++++++++++++-----
 2 files changed, 161 insertions(+), 24 deletions(-)
