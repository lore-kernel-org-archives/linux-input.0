From: Dudley Du <dudl@cypress.com>
Subject: [PATCH 0/3] cyapa patches instruction
Date: Fri, 24 Jul 2015 13:05:56 +0800
Message-ID: <1437714359-2484-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org
Cc: Dudley Du <dudl@cypress.com>, bleung@google.com, jmmahler@gmail.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

These patches are made based on Dmitry's next tree.
It's aimed to add regulator vcc and of match device tree supported, and also
fix the output unwanted wanring message issue when working with old Gen5
Trackpad device that doesn't support the proximity function.

Dudley Du (3):
  input: cyapa: add regulator vcc support
  input: cyapa: add of match device support and description document
  input: cyapa: fix output unwanted warning issue

 .../devicetree/bindings/input/cypress,cyapa.txt    | 44 ++++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 drivers/input/mouse/cyapa.c                        | 38 +++++++++++++++++++
 drivers/input/mouse/cyapa.h                        |  1 +
 drivers/input/mouse/cyapa_gen5.c                   | 11 ++++--
 5 files changed, 91 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt

-- 
1.9.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------
