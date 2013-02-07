From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH 0/2] Input misc/bma150.[ch] one fix and one improvement
Date: Fri,  8 Feb 2013 00:58:23 +0100
Message-ID: <1360281506-13618-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:50830 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487Ab3BGX7b (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 18:59:31 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Albert Zhang <xu.zhang@bosch-sensortec.com>, Eric Andersson <eric.andersson@unixphere.com>, Jonathan Cameron <jic23@cam.ac.uk>, Antonio Ospite <ao2@amarulasolutions.com>

From: Antonio Ospite <ao2@amarulasolutions.com>

Hi,

Patch 1 in the series fixes a panic Michael was experiencing.

Patch 2 makes it easier to use the actual values the implementation
expects in the platform data.

Regards,
   Antonio

Michael Trimarchi (2):
  Input: misc/bma150.c, fix checking pm_runtime_get_sync() return value
  Input: misc/bma150.[ch], make some defines public and fix some
    comments

 drivers/input/misc/bma150.c |   14 +-------------
 include/linux/bma150.h      |   16 ++++++++++++++--
 2 files changed, 15 insertions(+), 15 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
