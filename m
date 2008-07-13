From: Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH] hid: apple_fn_keys F5 and F6
Date: Sun, 13 Jul 2008 18:12:55 +0200
Message-ID: <1215965784.20146.0.camel@alnilam>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:48224 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752200AbYGMQQP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Jul 2008 12:16:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, robfitz@273k.net, akpm@osdl.org, jikos@jikos.cz, vojtech@suse.cz, dmonakhov@openvz.org

From: Henrik Rydberg <rydberg@euromail.se>

In drivers/hid/hid-input.c, the apple_fn_keys translation table
contains no entries for the F5 and F6 keys. This patch maps the F5 and
F6 keys to KBDILLUMDOWN and KBDILLUMUP, respektively, which make them
work as keyboard backlight control keys.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---

This patch is against the linux-next tree: v2.6.26-rc9-7639-g60392c2

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 0ef778a..1b2e8dc 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -100,6 +100,8 @@ static struct hidinput_key_translation apple_fn_keys[] = {
        { KEY_F2,       KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
        { KEY_F3,       KEY_FN_F5,          APPLE_FLAG_FKEY }, /* Expos<E9> */
        { KEY_F4,       KEY_FN_F4,          APPLE_FLAG_FKEY }, /* Dashboard */
+       { KEY_F5,       KEY_KBDILLUMDOWN,   APPLE_FLAG_FKEY },
+       { KEY_F6,       KEY_KBDILLUMUP,     APPLE_FLAG_FKEY },
        { KEY_F7,       KEY_PREVIOUSSONG,   APPLE_FLAG_FKEY },
        { KEY_F8,       KEY_PLAYPAUSE,      APPLE_FLAG_FKEY },
        { KEY_F9,       KEY_NEXTSONG,       APPLE_FLAG_FKEY },

