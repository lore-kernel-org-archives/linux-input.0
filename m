From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 0/4] Nomadik SKE keypad updates
Date: Sun, 17 Jun 2012 16:17:29 +0200
Message-ID: <1339942649-20049-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:42484 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757385Ab2FQORr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jun 2012 10:17:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

From: Linus Walleij <linus.walleij@linaro.org>

This is a cut down version of the earlier sent Nomadik SKE
keypad patch set excluding the controversial switch to a
workqueue for the key scanning. This is done in order for us
to move forward reducing the delta of this driver.

Naveen Kumar Gaddipati (4):
  input/nomadik-ske: add multi key press support
  input/nomadik-ske: suspend and resume support
  input/nomadik-ske: get rid of multiple interrupts
  input/nomadik-ske: cleanup of probe and some more code style

 drivers/input/keyboard/nomadik-ske-keypad.c |  236 ++++++++++++++++-----------
 1 file changed, 138 insertions(+), 98 deletions(-)

-- 
1.7.9.2

