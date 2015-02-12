From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: [PATCH v3 0/2] input: rotary encoder: Add wake up support
Date: Thu, 12 Feb 2015 16:40:36 +0100
Message-ID: <1423755638-9294-1-git-send-email-sylvain.rochet@finsecur.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:55107 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbbBLPkn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Feb 2015 10:40:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sylvain Rochet <sylvain.rochet@finsecur.com>

Changes since v2:
  * Using false instead of 0 on boolean
  * Splitted DT documentation in separate patch

Changes since v1:
  * Using DT property wakeup-source instead of rotary-encoder,wakeup
  * Renamed int wakeup to bool wakeup_source
  * Patch cleanup (checkpatch.pl)

Sylvain Rochet (2):
  DT: Documentation: input: rotary encoder: Add wakeup-source property
  input: rotary encoder: Add wake up support

 .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
 Documentation/input/rotary-encoder.txt             |  1 +
 drivers/input/misc/rotary_encoder.c                | 37 ++++++++++++++++++++++
 include/linux/rotary_encoder.h                     |  1 +
 4 files changed, 40 insertions(+)

-- 
2.1.4

