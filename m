From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH] Input: Fix double equality sign in uevent
Date: Sat, 18 Dec 2010 20:31:57 +0100
Message-ID: <1292700717-1610-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, stable@kernel.org
List-Id: linux-input@vger.kernel.org

Looking at the uevent stream for input devices, all properties
are on the form "A=B" except the bitmap values, which are on the
form "A==B". Remedied with this patch.

Cc: stable@kernel.org
Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
Hi Dmitry,

Unless the input bitmap properties should really behave differently,
this patch ought to be a candidate for 2.6.37.

Thanks,
Henrik

 drivers/input/input.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index c3e5fc7..bed725f 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1471,7 +1471,7 @@ static int input_add_uevent_bm_var(struct kobj_uevent_env *env,
 {
 	int len;
 
-	if (add_uevent_var(env, "%s=", name))
+	if (add_uevent_var(env, "%s", name))
 		return -ENOMEM;
 
 	len = input_print_bitmap(&env->buf[env->buflen - 1],
-- 
1.7.2.3
