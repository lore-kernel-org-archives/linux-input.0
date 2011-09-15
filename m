From: chris@cnpbagwell.com
Subject: [PATCH 0/3] Input: wacom bamboo improvements
Date: Wed, 14 Sep 2011 20:36:25 -0500
Message-ID: <1316050588-13473-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f170.google.com ([209.85.161.170]:60006 "EHLO
	mail-gx0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855Ab1IOBgi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Sep 2011 21:36:38 -0400
Received: by gxk27 with SMTP id 27so2952040gxk.1
        for <linux-input@vger.kernel.org>; Wed, 14 Sep 2011 18:36:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pinglinux@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

The need for patch 3 was recently discussed on linuxwacom
mailing list. During that discussion, I looked closer at pen
code and notice pressure cleanup needed (patch 1) and that
ABS_DISTANCE was not completely implemented (patch 2).

Chris Bagwell (3):
  Input: wacom - remove unneeded touch pressure init
  Input: wacom - add ABS_DISTANCE to Bamboo Pen reports
  Input: wacom - correct max Y value on medium bamboos

 drivers/input/tablet/wacom_wac.c |   47 +++++++++++++++++++++-----------------
 1 files changed, 26 insertions(+), 21 deletions(-)

-- 
1.7.6

