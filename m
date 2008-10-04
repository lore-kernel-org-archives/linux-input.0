From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: document i8042.debug in kernel-parameters.txt
Date: Sat, 4 Oct 2008 23:28:19 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0810042326540.26779@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:53459 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753539AbYJDV2U (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Oct 2008 17:28:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Input: document i8042.debug in kernel-parameters.txt

i8042.debug parameter was missing in Documentation/kernel-parameters.txt. 
Add it.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 

 Documentation/kernel-parameters.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 1150444..c44bf65 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -796,6 +796,7 @@ and is between 256 and 4096 characters. It is defined in the file
 			Defaults to the default architecture's huge page size
 			if not specified.
 
+	i8042.debug	[HW] Toggle i8042 debug mode
 	i8042.direct	[HW] Put keyboard port into non-translated mode
 	i8042.dumbkbd	[HW] Pretend that controller can only read data from
 			     keyboard and cannot control its state
