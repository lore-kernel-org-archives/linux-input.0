From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/3] omap3evm: Get keypad and touchscreen working again
Date: Fri,  5 Feb 2010 14:09:46 +0530
Message-ID: <1265359186-13938-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>
List-Id: linux-input@vger.kernel.org

This set contains patches to get the keypad and touchscreen
working after changes to new MUX framework.

The keypad macros had to be updated after migration to the
matrix_keypad as well.

Sanjeev Premi (3):
  omap3evm: Add mux settings for keypad
  omap3evm: Fixes after moving to matrix_keypad
  omap3evm: Configure GPIO175 for touchscreen PEN_IRQ

 arch/arm/mach-omap2/board-omap3evm.c |   33 +++++++++++++++++++++------------
 1 files changed, 21 insertions(+), 12 deletions(-)

