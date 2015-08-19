From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v3 0/1] cap11xx: add runtime PM support
Date: Tue, 18 Aug 2015 18:21:28 -0700
Message-ID: <1439947289-10750-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35144 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbbHSBVd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2015 21:21:33 -0400
Received: by pdob1 with SMTP id b1so18713132pdo.2
        for <linux-input@vger.kernel.org>; Tue, 18 Aug 2015 18:21:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

Changes from v2:
* rebased patchset
* correct order of pm suspend operations in cap11xx_remove()

Matt Ranostay (1):
  cap11xx: add runtime PM support

 drivers/input/keyboard/cap11xx.c | 77 ++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 18 deletions(-)

-- 
1.9.1

