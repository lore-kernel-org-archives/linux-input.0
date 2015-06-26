From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2 0/1] cap11xx: add runtime PM support
Date: Thu, 25 Jun 2015 21:20:22 -0700
Message-ID: <1435292423-20895-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
List-Id: linux-input@vger.kernel.org

Important Notes:
* Depends on v6 of "cap11xx: add LED support" patchset to applied first

Changes from v1:
* ifdef CONFIG_PM to prevent "unused functions" warning from compiler
* Added cap11xx_set_sleep() stub for systems built without PM

Matt Ranostay (1):
  cap11xx: add runtime PM support

 drivers/input/keyboard/cap11xx.c | 84 +++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 18 deletions(-)

-- 
1.9.1

