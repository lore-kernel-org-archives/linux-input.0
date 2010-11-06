From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 3/3] HID: roccat: declaring meaning of pack pragma usage in
 kone and pyra driver
Date: Sat, 06 Nov 2010 19:53:32 +0100
Message-ID: <1289069612.5166.4.camel@neuromancer>
References: <1287943025.2623.16.camel@neuromancer>
	 <alpine.LNX.2.00.1011041418530.15851@pobox.suse.cz>
	 <1288978962.2585.15.camel@neuromancer>
	 <alpine.LNX.2.00.1011051400250.15851@pobox.suse.cz>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-15.arcor-online.net ([151.189.21.55]:48407 "EHLO
	mail-in-15.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752144Ab0KFSxe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 6 Nov 2010 14:53:34 -0400
In-Reply-To: <alpine.LNX.2.00.1011051400250.15851@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>, Stephane Chatty <chatty@enac.fr>, Don Prince <dhprince-devel@yahoo.co.uk>, Dmitry Torokhov <dtor@mail.ru>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Using pack pragma to prevent padding bytes in binary data structures
used for hardware communication. Explanation of these pragmas was requested.
This patch does for kone and pyra what another patch does for koneplus.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-kone.h |    3 +++
 drivers/hid/hid-roccat-pyra.h |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.h b/drivers/hid/hid-roccat-kone.h
index 130d656..cb0ed99 100644
--- a/drivers/hid/hid-roccat-kone.h
+++ b/drivers/hid/hid-roccat-kone.h
@@ -14,6 +14,9 @@
 
 #include <linux/types.h>
 
+/*
+ * Binary data structures for communication with hardware must have no padding.
+ */
 #pragma pack(push)
 #pragma pack(1)
 
diff --git a/drivers/hid/hid-roccat-pyra.h b/drivers/hid/hid-roccat-pyra.h
index 22f80a8..31d7b3e 100644
--- a/drivers/hid/hid-roccat-pyra.h
+++ b/drivers/hid/hid-roccat-pyra.h
@@ -14,6 +14,9 @@
 
 #include <linux/types.h>
 
+/*
+ * Binary data structures for communication with hardware must have no padding.
+ */
 #pragma pack(push)
 #pragma pack(1)
 
-- 
1.7.2.3



