From: joe@perches.com
Subject: [PATCH] [217/2many] MAINTAINERS - HID CORE LAYER
Date: Sun, 12 Aug 2007 23:28:35 -0700
Message-ID: <46bffa13.u2UP+i4L1tdJi0Sf%joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, jkosina@suse.cz, akpm@linux-foundation.org
List-Id: linux-input@vger.kernel.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index bdbf999..4a8770c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2071,6 +2071,8 @@ M:	jkosina@suse.cz
 L:	linux-input@atrey.karlin.mff.cuni.cz
 T:	git kernel.org:/pub/scm/linux/kernel/git/jikos/hid.git
 S:	Maintained
+F:	drivers/hid/
+F:	include/linux/hid*
 
 HIGH-RESOLUTION TIMERS, CLOCKEVENTS, DYNTICKS
 P:	Thomas Gleixner
