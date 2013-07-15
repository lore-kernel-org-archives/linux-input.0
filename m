From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: [Regression][v3.10][v3.11] Revert "HID: Fix logitech-dj: missing
 Unifying device issue"
Date: Mon, 15 Jul 2013 13:26:56 -0400
Message-ID: <51E430E0.9050304@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40921 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714Ab3GOR1I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jul 2013 13:27:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: adlr@chromium.org, nlopezcasad@logitech.com
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Andrew,

A bug was opened against the Ubuntu kernel[0].  It was found that
reverting the following commit resolved this bug:

commit 8af6c08830b1ae114d1a8b548b1f8b056e068887
Author: Andrew de los Reyes <adlr@chromium.org>
Date:   Mon Feb 18 09:20:23 2013 -0800

    Revert "HID: Fix logitech-dj: missing Unifying device issue"


The regression was introduced as of v3.10-rc1.  Commit 8af6c08 reverts
commit 5962640, so it seems commit 5962640 may still be needed.

I see that you are the author of this patch, so I wanted to run this by
you.  I was thinking of requesting a revert for v3.11, but I wanted to
get your feedback first.


Thanks,

Joe

[0] http://pad.lv/1194649
