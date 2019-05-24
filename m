From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 0/8] Fix Elan I2C touchpads in latest generation from Lenovo
Date: Fri, 24 May 2019 15:50:38 +0200
Message-ID: <20190524135046.17710-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, Aaron Ma <aaron.ma@canonical.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Here comes the v3.

Very few changes from v2:
- dropped the last 2 patches where I tried to be smart, and it turns out
  that it was not very a good idea
- also removed the only other blacklisted model, as it has been tested with
  the v2 and it is also now working properly

Cheers,
Benjamin

Benjamin Tissoires (8):
  Input: elantech - query the min/max information beforehand too
  Input: elantech - add helper function elantech_is_buttonpad()
  Input: elantech - detect middle button based on firmware version
  dt-bindings: add more optional properties for elan_i2c touchpads
  Input: elan_i2c - do not query the info if they are provided
  Input: elantech/SMBus - export all capabilities from the PS/2 node
  Input: elan_i2c - handle physical middle button
  Input: elantech: remove P52 and P72 from SMBus blacklist

 .../devicetree/bindings/input/elan_i2c.txt    |  11 +
 drivers/input/mouse/elan_i2c_core.c           |  72 +++-
 drivers/input/mouse/elantech.c                | 320 ++++++++++--------
 drivers/input/mouse/elantech.h                |   8 +
 4 files changed, 246 insertions(+), 165 deletions(-)

-- 
2.21.0
