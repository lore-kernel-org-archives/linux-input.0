From: Lukas Prettenthaler <lukas@5gsystems.com>
Subject: psmouse synaptics Dell XPS 13 2016
Date: Wed, 2 Aug 2017 01:12:42 +0200
Message-ID: <CAHYm2KBDW87O-5nKyGN1XJWkUROTBaXPOMVzAwva=stmd6KONw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34124 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdHAXMo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 1 Aug 2017 19:12:44 -0400
Received: by mail-pg0-f48.google.com with SMTP id u185so13657447pgb.1
        for <linux-input@vger.kernel.org>; Tue, 01 Aug 2017 16:12:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

hi,

tried setting psmouse.synaptics_intertouch to 1 and it worked

log:
psmouse serio1: synaptics: queried max coordinates: x [..5666], y [..4734]
psmouse serio1: synaptics: queried min coordinates: x [1276..], y [1118..]
psmouse serio1: synaptics: Your touchpad (PNP: DLL075b PNP0f13) says
it can support a different bus. If i2c-hid and hid-rmi are not used,
you might want to try setting psmouse.synaptics_intertouch to 1 and
report this to linux-input@vger.kernel.org.
psmouse serio1: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2a1,
caps: 0xf00323/0x840300/0x12e800/0x0, board id: 3038, fw id: 2375007
input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input6

cheers

Lukas Prettenthaler
