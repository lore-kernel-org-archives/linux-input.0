From: Linus Walleij <linus.walleij@linaro.org>
Subject: [RESEND: PATCH 0/2] TC3589x keypad device tree support
Date: Wed,  9 Apr 2014 09:27:27 +0200
Message-ID: <1397028447-15347-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:48202 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932638AbaDIH1r (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 03:27:47 -0400
Received: by mail-wg0-f46.google.com with SMTP id b13so2052667wgh.29
        for <linux-input@vger.kernel.org>; Wed, 09 Apr 2014 00:27:45 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>

RESEND: can we merge this to the MFD+input trees now?

It seems no subsystem maintainers have any opinions and the DT
bindings people are silent on the matter since weeks.

Linus Walleij (2):
  mfd: tc3589x: Add device tree bindings
  input: tc3589x-keypad: support probing from device tree

 Documentation/devicetree/bindings/mfd/tc3589x.txt | 107 ++++++++++++++++++++++
 drivers/input/keyboard/tc3589x-keypad.c           |  66 ++++++++++++-
 2 files changed, 171 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/tc3589x.txt

-- 
1.9.0

