From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5] Input: make the GPIO mouse useful
Date: Sun, 17 Sep 2017 13:14:40 +0200
Message-ID: <20170917111445.30880-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:52794 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdIQLO6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 17 Sep 2017 07:14:58 -0400
Received: by mail-lf0-f47.google.com with SMTP id b127so5662805lfe.9
        for <linux-input@vger.kernel.org>; Sun, 17 Sep 2017 04:14:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc: Linus Walleij <linus.walleij@linaro.org>

The GPIO mouse device does not have any in-kernel users.

This series converts it to use descriptors, adds device tree
bindings and adds device tree probing so it can be used for
embedded target etc without proper mouse ports.

An alternative is to simply delete the driver. But I took
pity in it and I am also worried that the number of out-of-tree
users could be pretty large.

Hans-Christian: can you express your idea for the future of
this driver? Does this look all right to you? Do you want to
add some users in some device trees maybe?

Linus Walleij (5):
  input: mouse: Kill off platform data for GPIO mouse
  input: mouse: Rename GPIO mouse variables
  input: mouse: Add DT bindings for GPIO mice
  input: mouse: Convert GPIO mouse to use descriptors
  input: mouse: Add device tree probing to GPIO mouse

 .../devicetree/bindings/input/gpio-mouse.txt       |  32 ++++
 drivers/input/mouse/gpio_mouse.c                   | 195 +++++++++++----------
 include/linux/gpio_mouse.h                         |  61 -------
 3 files changed, 130 insertions(+), 158 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-mouse.txt
 delete mode 100644 include/linux/gpio_mouse.h

-- 
2.13.5

