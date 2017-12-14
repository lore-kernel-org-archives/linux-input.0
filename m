From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] input - leds: fix bugs found by fuzzing
Date: Thu, 14 Dec 2017 14:25:20 +0100
Message-ID: <20171214132522.20346-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751925AbdLNNZf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Dec 2017 08:25:35 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi,

Peter wrote a fuzzing uinput program[1] to check on libinput,
and the result is that the kernel fails more often than
libinput :)

These 2 patches allow to fix the early failures.

I marked them as stable as I believe eventhough not many
people discovered those and reported them, they should
still be fixed in current kernels.

The fuzzing process still manages to crash the kernel,
bu I have the feeling those crashes are now related
to some races between other userspace process that attempt
to handle the spurious events injected in those random
devices. For instance, the KEY_BLUETOOTH or RF_KILL seem
to manage to mess up my network driver.

Cheers,
Benjamin

[1] https://github.com/whot/fuzzydevice

Benjamin Tissoires (2):
  input - leds: do not iterate over non initialized leds
  input - leds: fix input_led_disconnect path

 drivers/input/input-leds.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.14.3

