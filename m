From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: potential info leak in uiput_ff_upload_to_user()
Date: Fri, 23 Sep 2011 09:22:40 +0300
Message-ID: <20110923062240.GG4387@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:48645 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab1IWGXC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Sep 2011 02:23:02 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pingc@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>, Aristeu Rozanski <aris@ruivo.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

Smatch has a new check for Rosenberg type information leaks where
structs are copied to the user with uninitialized stack data in them.

The issue here is that struct uinput_ff_upload_compat has a hole in
it.

struct uinput_ff_upload_compat {
        int                        request_id;           /*     0     4 */
        int                        retval;               /*     4     4 */
        struct ff_effect_compat    effect;               /*     8     0 */

        /* XXX 44 bytes hole, try to pack */

        struct ff_effect_compat    old;                  /*    52     0 */

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 7360568..40e2ba4 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -528,6 +528,8 @@ static int uinput_ff_upload_to_user(char __user *buffer,
 	if (INPUT_COMPAT_TEST) {
 		struct uinput_ff_upload_compat ff_up_compat;
 
+		memset(&ff_up_compat, 0, sizeof(ff_up_compat));
+
 		ff_up_compat.request_id = ff_up->request_id;
 		ff_up_compat.retval = ff_up->retval;
 		/*
