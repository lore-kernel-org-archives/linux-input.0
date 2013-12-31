From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH 0/2] input: mt: Add helper function to send end events
Date: Mon, 30 Dec 2013 18:06:39 -0800
Message-ID: <1388455601-17033-1-git-send-email-eu@felipetonello.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:54315 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab3LaCHH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Dec 2013 21:07:07 -0500
Received: by mail-ob0-f172.google.com with SMTP id gq1so12244673obb.17
        for <linux-input@vger.kernel.org>; Mon, 30 Dec 2013 18:07:06 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: "Felipe F. Tonello" <eu@felipetonello.com>, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

From: "Felipe F. Tonello" <eu@felipetonello.com>

Adds a helper function to send end touch events for active tracking ids.
And also implements it in egalax driver.

Felipe F. Tonello (2):
  input: mt: Add helper function to send end events
  input: egalax: report end state in suspend callback

 drivers/input/input-mt.c              | 33 +++++++++++++++++++++++++++++++++
 drivers/input/touchscreen/egalax_ts.c |  5 +++++
 include/linux/input/mt.h              |  2 ++
 3 files changed, 40 insertions(+)

-- 
1.8.3.1

