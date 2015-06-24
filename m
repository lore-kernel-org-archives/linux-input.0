From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v6 0/2] cap11xx: add LED support
Date: Tue, 23 Jun 2015 23:50:52 -0700
Message-ID: <1435128654-19454-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34659 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbFXGty (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2015 02:49:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: zonque@gmail.com, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

changes from v5:
* Dropped linux,led-brightness DT property
* Removed several ifdefs to LED CLASS
* Added cap11xx_init_leds stub

Matt Ranostay (2):
  dt: add cap11xx LED documentation
  cap11xx: add LED support

 .../devicetree/bindings/input/cap11xx.txt          |  19 +++
 drivers/input/keyboard/cap11xx.c                   | 140 ++++++++++++++++++++-
 2 files changed, 156 insertions(+), 3 deletions(-)

-- 
1.9.1

