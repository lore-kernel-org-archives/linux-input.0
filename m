From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 0/7] Nomadik SKE keypad updates
Date: Sun, 13 May 2012 14:43:28 +0200
Message-ID: <1336913008-9977-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:53503 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751421Ab2EMMnh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 May 2012 08:43:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

From: Linus Walleij <linus.walleij@linaro.org>

This hardens the SKE keypad driver a bit by adding some bug fixes
and features. This development has been pending for a while so
this is a try to catch up a bit on it.

Karl-Johan Perntz (2):
  input/nomadik-ske: move key scanning to delayed work
  input/nomadik-ske: add sleepy GPIO mode

Naveen Kumar Gaddipati (5):
  input/nomadik-ske: add multi key press support
  input/nomadik-ske: suspend and resume support
  input/nomadik-ske: get rid of multiple interrupts
  input/nomadik-ske: cleanup of probe and some more code style
  input/nomadik-ske: add sysfs file to enable/disble SKE keypad

 arch/arm/plat-nomadik/include/plat/ske.h    |   23 +-
 drivers/input/keyboard/nomadik-ske-keypad.c |  630 ++++++++++++++++++++++-----
 2 files changed, 547 insertions(+), 106 deletions(-)

-- 
1.7.9.2

