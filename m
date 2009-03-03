From: Scott James Remnant <scott@canonical.com>
Subject: [PATCH 12/31] input: Auto-load mousedev module when psaux device opened.
Date: Tue, 3 Mar 2009 15:32:15 +0000
Message-ID: <6c577b415dffe0df86954f2f3971e15a9336d6c6.1236702228.git.scott@canonical.com>
References: <cover.1236702228.git.scott@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zelda.netsplit.com ([87.194.19.211]:34602 "EHLO
	zelda.netsplit.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755029AbZCJQnj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2009 12:43:39 -0400
In-Reply-To: <cover.1236702228.git.scott@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

The mousedev module is missing the char-major-10-1 alias that would cause
it to be auto-loaded when the /dev/psaux device is opened.  This patch
adds the alias.

Signed-off-by: Scott James Remnant <scott@canonical.com>
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/input/mousedev.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index ef99a7e..dfde8ee 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -1065,6 +1065,8 @@ static struct miscdevice psaux_mouse = {
 	PSMOUSE_MINOR, "psaux", &mousedev_fops
 };
 static int psaux_registered;
+
+MODULE_ALIAS_MISCDEV(PSMOUSE_MINOR);
 #endif
 
 static int __init mousedev_init(void)
-- 
1.6.0.5

