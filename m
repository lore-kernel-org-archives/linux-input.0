From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: potential info leak in input_event_to_user()
Date: Fri, 23 Sep 2011 09:22:07 +0300
Message-ID: <20110923062207.GF4387@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:48061 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab1IWGWQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Sep 2011 02:22:16 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Smatch has a new check for Rosenberg type information leaks where
structs are copied to the user with uninitialized stack data in them.

The issue here is that struct input_event_compat has a hole in it.

struct input_event_compat {
        struct compat_timeval {
        } time;                             /*     0     0 */

        /* XXX 8 bytes hole, try to pack */

        short unsigned int         type;    /*     8     2 */


Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
index e46a867..007850a 100644
--- a/drivers/input/input-compat.c
+++ b/drivers/input/input-compat.c
@@ -44,6 +44,8 @@ int input_event_to_user(char __user *buffer,
 	if (INPUT_COMPAT_TEST) {
 		struct input_event_compat compat_event;
 
+		memset(&compat_event, 0, sizeof(compat_event));
+
 		compat_event.time.tv_sec = event->time.tv_sec;
 		compat_event.time.tv_usec = event->time.tv_usec;
 		compat_event.type = event->type;
