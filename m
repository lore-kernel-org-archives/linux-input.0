From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 0/2] Input: nomadik-ske-keypad - clk fixups
Date: Thu, 1 Nov 2012 15:20:00 +0100
Message-ID: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:54596 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761540Ab2KAOU4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Nov 2012 10:20:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Ulf Hansson <ulf.hansson@linaro.org>

From: Ulf Hansson <ulf.hansson@linaro.org>

Due to the convert to the common clk driver these changes for clks are needed.

Ulf Hansson (2):
  Input: nomadik-ske-keypad - fixup use of clk
  Input: nomadik-ske-keypad - start using the apb_pclk

 drivers/input/keyboard/nomadik-ske-keypad.c |   34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

-- 
1.7.10

