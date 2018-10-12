From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/5] Fix Elan I2C touchpads in latest generation from Lenovo
Date: Fri, 12 Oct 2018 16:24:08 +0200
Message-ID: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Since v4.18, we unconditionally switch the I2C capable touchpads over I2C.
In the model I had (a pre-prod t480s I guess), the touchpad was behaving
fine.
However, it occurs that later production models don't expose the clickpad
information from I2C. The Windows driver gets all the information from PS/2
so we should do the same.

The situation is even worse for the P52. Once of the query parameter function
fails, which means the touchpad doesn't even probe. This effectively kills
the touchpad, which is less than ideal.

Dmitry, I am not sure if we should take those for stable in v4.18+.
I'd like to, but given the series is 5 patches, I don't know if this
will be acceptable.
We could revert in stable df077237cf55928f5 but that would mean
distributions will have to revert the revert if they want to provide
the I2C behavior.

So, regarding stable: your call :)

Cheers,
Benjamin

Benjamin Tissoires (5):
  Input: elantech - query the min/max information beforehand too
  Input: elantech - add helper function elantech_is_buttonpad()
  dt-bindings: add more optional properties for elan_i2c touchpads
  Input: elan_i2c - do not query the info if they are provided
  Input: elantech/SMBus - export all capabilities from the PS/2 node

 .../devicetree/bindings/input/elan_i2c.txt         |   8 +
 drivers/input/mouse/elan_i2c_core.c                |  49 +++-
 drivers/input/mouse/elantech.c                     | 272 +++++++++++----------
 drivers/input/mouse/elantech.h                     |   5 +
 4 files changed, 188 insertions(+), 146 deletions(-)

-- 
2.14.3
