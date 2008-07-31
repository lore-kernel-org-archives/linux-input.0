From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= <Uwe.Kleine-Koenig@digi.com>
Subject: [PATCH 0/3] Updates for gpio-keys
Date: Thu, 31 Jul 2008 21:04:20 +0200
Message-ID: <1217531063-2472-1-git-send-email-Uwe.Kleine-Koenig@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail164.messagelabs.com ([216.82.253.131]:5572 "EHLO
	mail164.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbYGaTZ5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2008 15:25:57 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org


Hello,

some time ago I posted a patch that allows using gpio-keys for gpios
that can only trigger an irq on one one edge.

This is still the main reason I modified gpio-keys for.

What's new (apart from some clean-ups that went into seperate patches)
is that the edges that don't trigger an irq (only one or even both) are
now polled.  This should make the driver generic enough to substitute
all other gpio-key drivers.  (I didn't check this though.)

As a result gpio-keys now depends on INPUT_POLLDEV which together with
an increased memory footprint should be the only downside.

I appreciate any constructive feedback.

Best regards
Uwe

Uwe Kleine-K=C3=B6nig (3):
  Input: gpio-keys - optimize interrupt handler
  Input: gpio-keys - simplify argument list for report_event
  Input: gpio-keys - add polling support

 drivers/input/keyboard/Kconfig     |    1 +
 drivers/input/keyboard/gpio_keys.c |  194 +++++++++++++++++++++++++---=
--------
 include/linux/gpio_keys.h          |    3 +
 3 files changed, 138 insertions(+), 60 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
