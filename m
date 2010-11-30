From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 0/8] input: gpio_keys_polled fixes
Date: Tue, 30 Nov 2010 19:44:15 +0100
Message-ID: <1291142663-1011-1-git-send-email-juhosg@openwrt.org>
References: <4CF541ED.80905@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:37486 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525Ab0K3So0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Nov 2010 13:44:26 -0500
In-Reply-To: <4CF541ED.80905@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Gardiner <bengardiner@nanometrics.ca>, linux-input@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kevin Hilman <khilman@deeprootsystems.com>, nsekhar@ti.com

This set contains my latest fixes on top of Dmitry's changes.

Gabor Juhos (8):
  input: gpio_keys_polled: add MODULE_ALIAS
  input: gpio_keys_polled: return -EINVAL if wakeup specified
  input: gpio_keys_polled: avoid possible division by zero
  input: gpio_keys_polled: use DIV_ROUND_UP to compute the threshold value
  input: gpio_keys_polled: precompute threshold value in the probe routine
  input: gpio_keys_polled: use tabs instead of spaces for indentation
  input: gpio_keys_polled: remove a local variable
  input: gpio_keys_polled: fix Kconfig help text

 drivers/input/keyboard/Kconfig            |    4 +-
 drivers/input/keyboard/gpio_keys_polled.c |   30 +++++++++++++++-------------
 2 files changed, 18 insertions(+), 16 deletions(-)

-- 
1.7.2.1

