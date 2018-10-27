From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH v2] HID: moving to group maintainership model
Date: Sat, 27 Oct 2018 14:25:48 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810271425060.23511@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1810271417230.23511@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>
Date: Sat, 27 Oct 2018 14:16:13 +0200
Subject: [PATCH] HID: moving to group maintainership model

Benjamin and myself will from now on be sharing maintainership
responsibilities for hid.git.

Update maintainers to reflect that change, and also move a git
repository to shared space at kernel.org.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Stephen, could you please update the hid.git URL for linux-next as below? 
Thanks.

v1->v2: Update all occurences in MAINTAINERS

 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0c4c5003998..4715cb8d9584 100644
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
@@ -15254,9 +15254,9 @@ F:	include/linux/usb/gadget*
 
 USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REMOTE CONTROLS, ...)
 M:	Jiri Kosina <jikos@kernel.org>
-R:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
+M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
 L:	linux-usb@vger.kernel.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git
 S:	Maintained
 F:	Documentation/hid/hiddev.txt
 F:	drivers/hid/usbhid/


-- 
Jiri Kosina
SUSE Labs
