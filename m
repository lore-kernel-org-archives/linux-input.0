From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] MAINTAINERS: update input subsystem patterns
Date: Wed, 28 Jun 2017 16:40:35 -0700
Message-ID: <20170628234035.GA21357@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35797 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdF1Xkj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Jun 2017 19:40:39 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>

Add include/uapi/linux/input-event-codes.h and Documentation/input to
the file patterns, so that patches touching these files get copied
to linux-input mailing list.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8eec557bb2c5..f5af54a52f99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6602,8 +6602,10 @@ S:	Maintained
 F:	drivers/input/
 F:	include/linux/input.h
 F:	include/uapi/linux/input.h
+F:	include/uapi/linux/input-event-codes.h
 F:	include/linux/input/
 F:	Documentation/devicetree/bindings/input/
+F:	Documentation/input/
 
 INPUT MULTITOUCH (MT) PROTOCOL
 M:	Henrik Rydberg <rydberg@bitmath.org>
-- 
2.13.2.725.g09c95d1e9-goog


-- 
Dmitry
