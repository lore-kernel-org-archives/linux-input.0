From: chris@cnpbagwell.com
Subject: [PATCH v2 0/4] input: wacom - Add Bamboo Pen Support
Date: Sat, 11 Sep 2010 13:30:34 -0500
Message-ID: <1284229838-2852-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51725 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab0IKSaw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Sep 2010 14:30:52 -0400
Received: by yxp4 with SMTP id 4so1582104yxp.19
        for <linux-input@vger.kernel.org>; Sat, 11 Sep 2010 11:30:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pingc@wacom.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Addes Bamboo Pen and Pen&Touch support.  Builds on previous
commited support for Bamboo Touch.

Only difference in this patch set is patch #3.  It makes suggested
change to logic for checking pen in-proximity and adds comment
to clarify why 2-bits are checked.

Chris Bagwell (4):
  input: wacom - Request tablet data for Bamboo Pens
  input: wacom - move Bamboo Touch irq to own function
  input: wacom - Add support for Bamboo Pen
  input: wacom - disable Bamboo touchpad when pen is being used.

 drivers/input/tablet/wacom_sys.c |    9 ++--
 drivers/input/tablet/wacom_wac.c |   97 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 97 insertions(+), 9 deletions(-)

-- 
1.7.2.2

