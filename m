From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH RESEND 0/2] cap11xx: add LED support
Date: Tue,  4 Aug 2015 21:24:54 -0700
Message-ID: <1438748696-28452-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-input@vger.kernel.org

Several cap11xx variants have LEDs that be can be controlled, and this
patchset implements this functionality

Matt Ranostay (2):
  dt: add cap11xx LED documentation
  cap11xx: add LED support

 .../devicetree/bindings/input/cap11xx.txt          |  19 +++
 drivers/input/keyboard/cap11xx.c                   | 140 ++++++++++++++++++++-
 2 files changed, 156 insertions(+), 3 deletions(-)

-- 
1.9.1
