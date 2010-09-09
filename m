From: chris@cnpbagwell.com
Subject: [PATCH 0/4] input: wacom - And Bamboo Pen Support
Date: Wed,  8 Sep 2010 23:02:28 -0500
Message-ID: <1284004952-12701-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39639 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab0IIECn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 00:02:43 -0400
Received: by gyd8 with SMTP id 8so442073gyd.19
        for <linux-input@vger.kernel.org>; Wed, 08 Sep 2010 21:02:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pingc@wacom.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

These patches build upon previous Bamboo Touch patches from Henrik and
add support for others in family that support Pen&Touch or Pen-only

These patch set is based on support in linuxwacom Bamboo driver.

Chris Bagwell (4):
  input: wacom - Request tablet data for Bamboo Pens
  input: wacom - move Bamboo Touch irq to own function
  input: wacom - Add support for Bamboo Pen
  input: wacom - disable Bamboo touchpad when pen is being used.

 drivers/input/tablet/wacom_sys.c |    9 ++--
 drivers/input/tablet/wacom_wac.c |   95 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 95 insertions(+), 9 deletions(-)

-- 
1.7.2.2

