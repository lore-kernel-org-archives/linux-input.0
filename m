From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] cap11xx: add runtime PM support
Date: Wed, 24 Jun 2015 20:37:44 -0700
Message-ID: <1435203465-11592-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33116 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbbFYDgn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2015 23:36:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-pm@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

Important Notes:
* Depends on v6 of "cap11xx: add LED support" patchset to applied first

Matt Ranostay (1):
  cap11xx: add runtime PM support

 drivers/input/keyboard/cap11xx.c | 74 ++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 18 deletions(-)

-- 
1.9.1

