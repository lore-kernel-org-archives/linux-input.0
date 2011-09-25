From: chris@cnpbagwell.com
Subject: [PATCH v2 0/3] Input: wacom bamboo improvements
Date: Sun, 25 Sep 2011 14:09:25 -0500
Message-ID: <1316977768-823-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39118 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab1IYTJs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Sep 2011 15:09:48 -0400
Received: by ywb5 with SMTP id 5so3796333ywb.19
        for <linux-input@vger.kernel.org>; Sun, 25 Sep 2011 12:09:48 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

There is no code changes in this v2.  Since I now have access
to next tree on github, I thought it would help to resend
patches relative to that tree.

I also added the additional Reviewed-by and Acked-by tags from
mailing list review.

Old description:

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

