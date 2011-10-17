From: chris@cnpbagwell.com
Subject: [PATCH 0/6] Add support for new (3rd generation) Bamboo P&T's.
Date: Sun, 16 Oct 2011 20:29:35 -0500
Message-ID: <1318814981-30607-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41288 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab1JQB3s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Oct 2011 21:29:48 -0400
Received: by gyb13 with SMTP id 13so2513599gyb.19
        for <linux-input@vger.kernel.org>; Sun, 16 Oct 2011 18:29:47 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

[ resending to correct mailing list.  Sorry for duplat linux-kernel. ]

Wacom has released in the last month a 3rd generation of their
Bamboo Pen and Touch line and this patch series adds support
for them all. There are 3 new models.  2 include stylus and touch
support and can track up to 16 touches.  1 is a stylus only tablet.

A squashed version of this patch series has been tested by 1 user
for each tablet type over at linuxwacom-discuss mailing list.

Chris Bagwell (6):
  Input: wacom - cleanup feature report for bamboos
  Input: wacom - remove unused bamboo HID parsing
  Input: wacom - add some comments to wacom_parse_hid
  Input: wacom - relax Bamboo stylus ID check
  Input: wacom - read 3rd gen Bamboo Touch HID data
  Input: wacom - 3rd gen Bamboo P&Touch packet support

 drivers/input/tablet/wacom_sys.c |   94 ++++++++++++++++++++++++++++++++---
 drivers/input/tablet/wacom_wac.c |  101 ++++++++++++++++++++++++++++++++++----
 drivers/input/tablet/wacom_wac.h |    4 +-
 3 files changed, 179 insertions(+), 20 deletions(-)

-- 
1.7.6.4

