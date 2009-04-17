From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH] Input: Fix documentation. Event type is EV_KEY, not REL_KEY.
Date: Fri, 17 Apr 2009 06:30:23 -0300
Message-ID: <1239960623-28133-1-git-send-email-cascardo@holoscopio.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade.minaslivre.org ([72.232.18.203]:37063 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433AbZDQJ7I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2009 05:59:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

---
 Documentation/input/input.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/input/input.txt b/Documentation/input/input.txt
index 686ee99..b93c084 100644
--- a/Documentation/input/input.txt
+++ b/Documentation/input/input.txt
@@ -278,7 +278,7 @@ struct input_event {
 };
 
   'time' is the timestamp, it returns the time at which the event happened.
-Type is for example EV_REL for relative moment, REL_KEY for a keypress or
+Type is for example EV_REL for relative moment, EV_KEY for a keypress or
 release. More types are defined in include/linux/input.h.
 
   'code' is event code, for example REL_X or KEY_BACKSPACE, again a complete
-- 
1.6.2.2

