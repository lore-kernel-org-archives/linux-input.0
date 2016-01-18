From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/4] rotary-encoder: use generic device properties
Date: Mon, 18 Jan 2016 09:41:38 -0800
Message-ID: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36090 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063AbcARRlo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2016 12:41:44 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>, Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi,

This series tries to move the driver away from legacy platform data towards
using platform-independent way of retrieving both configuration parameters and
GPIOs (device_property_read_* and gpiod APIs).

This is based on top of 2 Timo's patches converting the driver to use devm* API
and threaded IRQs. I uploaded all changes into 'rotary-encoder' branch of my
tree.

I do not have hard ware so please give it a spin, especially on raumfield as it
uses branch new way of passing platform parameters to the driver.

Thanks.

-- 
Dmitry
