From: James M Leddy <james.leddy@canonical.com>
Subject: [PATCH] Remap micmute to F20
Date: Tue, 28 Aug 2012 19:32:19 -0400
Message-ID: <1346196739-3619-1-git-send-email-james.leddy@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33103 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab2H1Xcb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Aug 2012 19:32:31 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: James M Leddy <james.leddy@canonical.com>

Because of a limitation of the X11 protocol, we can't use micmute in
it's current mapping. I've chosen to map this to F20, since we do
similar things with the touchpad buttons for the same reason. Whatever
we use, we will have to agree with xkeyboard-config.

http://lists.freedesktop.org/archives/xorg-devel/2012-August/033442.html

Signed-off-by: James M. Leddy <james.leddy@canonical.com>
---
 keymaps/module-lenovo |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/keymaps/module-lenovo b/keymaps/module-lenovo
index 8e38883..f94678d 100644
--- a/keymaps/module-lenovo
+++ b/keymaps/module-lenovo
@@ -14,4 +14,4 @@
 0x15 volumedown
 0x16 mute
 0x17 prog1 # ThinkPad/ThinkVantage button (high keycode: "vendor")
-0x1A micmute # Microphone mute
+0x1A f20 # Microphone mute
-- 
1.7.9.5

