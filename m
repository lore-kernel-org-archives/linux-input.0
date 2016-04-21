From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH] Input: update documentation for EVIOCGMASK/EVIOCSMASK
Date: Thu, 21 Apr 2016 13:18:26 +1000
Message-ID: <20160421031826.GA6719@jelly.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:32157 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbcDUDSd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2016 23:18:33 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

The current implementation does not match the most intuitive reading of the
documentation. The documentation suggests that anything after FOO_CNT would
be reset to zeroes. The implementation however works on long boundaries
instead.

For example, a client requesting the EV_REL mask will see the first 64 bits
set to one in the default mask, everything else is zero. Setting a mask will
apply the mask for the first 64 bits, the others are cleared.

There are few use-cases where this actually matters to a client - if a
device doesn't have the event code anyway the mask doesn't matter. So change
two absolute statements to a "may" to indicate that bits may or may not be
set.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 include/uapi/linux/input.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 0111384..6069524 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -181,7 +181,7 @@ struct input_mask {
  * The default event mask for a client has all bits set, i.e. all events
  * are forwarded to the client. If the kernel is queried for an unknown
  * event type or if the receive buffer is larger than the number of
- * event codes known to the kernel, the kernel returns all zeroes for those
+ * event codes known to the kernel, the kernel may return zeroes for those
  * codes.
  *
  * At maximum, codes_size bytes are copied.
@@ -204,7 +204,7 @@ struct input_mask {
  * is unknown to the kernel, or if the number of event codes specified in
  * the mask is bigger than what is known to the kernel, the ioctl is still
  * accepted and applied. However, any unknown codes are left untouched and
- * stay cleared. That means, the kernel always filters unknown codes
+ * may be cleared. That means, the kernel always filters unknown codes
  * regardless of what the client requests.  If the new mask doesn't cover
  * all known event-codes, all remaining codes are automatically cleared and
  * thus filtered.
-- 
2.7.3

