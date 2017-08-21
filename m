From: Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: [PATCH v9 0/2] serio: PS/2 gpio bit banging driver for serio bus
Date: Mon, 21 Aug 2017 21:31:40 +0200
Message-ID: <20170821193142.29688-1-danilokrummrich@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, rdunlap@infradead.org, devicetree@vger.kernel.org, robh@kernel.org
Cc: Danilo Krummrich <danilokrummrich@dk-develop.de>
List-Id: linux-input@vger.kernel.org

v2: Removed one verbose print statement, changed another one to dev_dbg.
v3: - fixed compiler warning on blackfin
    - depends on GPIOLIB
    - clarify documentation
v4: - fixed concurrent calls to ps2_gpio_write (serio->write)
    - use gpiod API·
    - use generic device properties
    - request irq separately, do not use gpiod_to_irq
    - abort when gpio is connected via slow bus·
    - Fixed a bug where PS2_CMD_RESEND is always send after tx failed once.
      The makes the write functionallity work better, tough timing is still
      critical.
    - disable irq initially until ps2_gpip_open (serio->open) is called
v5: Checked again why timings are that hard to reach while in tx mode and·
    discovered that there is an extra clock pulse between stop bit sent from
    host and acknowledgement from device. By just skipping this clock pulse
    tx works fine now, though it still happens sometimes that the timing can·
    not be reached of course.
v6: - fixed typos
    - use of_match_ptr
v7: remove unnecessary barriers
v8: - split patch to have a separate one for the dt binding
    - remove ps2-gpio prefix in binding
v9: In "dt-bindings: new binding for ps/2 gpio devices" required property list
    was not matching the example node.

Danilo Krummrich (2):
  serio: PS/2 gpio bit banging driver for serio bus
  dt-bindings: new binding for ps/2 gpio devices

 .../devicetree/bindings/serio/ps2-gpio.txt         |  23 ++
 Documentation/gpio/drivers-on-gpio.txt             |   5 +
 drivers/input/serio/Kconfig                        |  11 +
 drivers/input/serio/Makefile                       |   1 +
 drivers/input/serio/ps2-gpio.c                     | 453 +++++++++++++++++++++
 5 files changed, 493 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt
 create mode 100644 drivers/input/serio/ps2-gpio.c

-- 
2.14.1
