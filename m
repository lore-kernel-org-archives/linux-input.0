From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/7] Input: tm2-touchkey: Add support for Aries and Midas
Date: Fri, 28 Dec 2018 16:46:02 +0100
Message-ID: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

This patches adds support for Aries (Samsung i9000) and Midsa (Samsung S3)
based devices to TM2 Touchkey driver.

Changes from v1:
  - Added Reviewed-by to some patches
  - Use ints for keycodes (they could be bigger than 255)
  - Droped separate name changes
  - Added missing const in few places
  - Removed redundant cast

Jonathan Bakker (5):
  Input: tm2-touchkey: Correct initial brightness
  Input: tm2-touchkey: Allow specifying custom keycodes
  Input: dt-bindings: tm2-touchkey: Document new keycodes property
  Input: tm2-touchkey: Add support for aries touchkey variant
  Input: dt-bindings: tm2-touchkey: Add support for aries touchkey

Simon Shields (2):
  Input: tm2-touchkey: Add support for midas touchkey
  Input: dt-bindings: tm2-touchkey: Add support for midas touchkey

 .../bindings/input/cypress,tm2-touchkey.txt   |   9 +-
 drivers/input/keyboard/tm2-touchkey.c         | 132 +++++++++++++-----
 2 files changed, 108 insertions(+), 33 deletions(-)

-- 
2.17.1
