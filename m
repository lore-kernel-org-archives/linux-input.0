From: "Arce, Abraham" <x0066660@ti.com>
Subject: [RFC] [PATCH 0/3] OMAP4 Keyboard Controller Support
Date: Tue, 13 Apr 2010 20:10:40 -0500
Message-ID: <27F9C60D11D683428E133F85D2BB4A53043D9EE7F4@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41812 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071Ab0DNBKn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Apr 2010 21:10:43 -0400
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Keyboard controller for OMAP4 includes

 - built-in scanning algorithm
 - debouncing feature
 - handling mechanism up to 9 x 9 keys
 - wake-up event generation

These patches have been tested in a SDP4430 board.
Taking OMAP4 TI tree as code base, omap4_next-wip branch
  http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=summary

---
 arch/arm/configs/omap_4430sdp_defconfig |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c     |   61 ++---
 drivers/input/keyboard/Kconfig          |    9 +
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/omap4-keypad.c   |  366 +++++++++++++++++++++++++++++++
 5 files changed, 403 insertions(+), 37 deletions(-)

