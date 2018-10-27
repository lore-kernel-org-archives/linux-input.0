From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: moving to group maintainership model
Date: Sat, 27 Oct 2018 14:19:02 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Benjamin and myself will from now on be sharing maintainership 
responsibilities for hid.git.

Update maintainers to reflect that change, and also move a git repository 
to shared space at kernel.org.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Stephen, could you please update the hid.git URL for linux-next as below? 
Thanks.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0c4c5003998..6cdca65bb0a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6588,9 +6588,9 @@ F:	arch/*/include/asm/suspend*.h
 
 HID CORE LAYER
 M:	Jiri Kosina <jikos@kernel.org>
-R:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
+M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
 L:	linux-input@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 S:	Maintained
 F:	drivers/hid/
 F:	include/linux/hid*

-- 
Jiri Kosina
SUSE Labs
