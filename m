From: M K <m.kolesinski@gmail.com>
Subject: ELAN0732 I2C Touchscreen Driver
Date: Mon, 20 Mar 2017 01:26:26 -0500
Message-ID: <CALLvBir2m6iuq1ntwZU+ZTahCeHXZQ5DNUb7nPe9jSUXL-AOLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35773 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdCTGdl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Mar 2017 02:33:41 -0400
Received: by mail-vk0-f42.google.com with SMTP id x75so65273131vke.2
        for <linux-input@vger.kernel.org>; Sun, 19 Mar 2017 23:33:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Is there a compatible driver for this device?  I've tried loading
various modules with no success (elants_i2c, hid_multitouch, etc.).

The device shows up under /sys/bus/i2c/devices/i2c-ELAN0732:00

However, xinput does not list it at all.

This is an HP m6-ar004dx laptop (Envy x360) with touchscreen display,
and AMD FX-9800P processor.

Scott Liu suggested I try posting here.


Thanks!
