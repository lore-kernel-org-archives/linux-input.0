From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] hid: roccat modules interdependencies
Date: Thu, 27 May 2010 09:07:06 -0700
Message-ID: <20100527090706.6c2bc555.randy.dunlap@oracle.com>
References: <20100527152628.b23a14c6.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20100527152628.b23a14c6.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

hid-roccat-kone calls the hid-roccat module interfaces,
so the former should depend on or select the latter to prevent
build errors, like:

hid-roccat-kone.c:(.text+0x133ed2): undefined reference to `roccat_report_event'
hid-roccat-kone.c:(.text+0x133fa8): undefined reference to `roccat_disconnect'
hid-roccat-kone.c:(.text+0x1353be): undefined reference to `roccat_connect'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/hid/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20100527.orig/drivers/hid/Kconfig
+++ linux-next-20100527/drivers/hid/Kconfig
@@ -358,6 +358,7 @@ config HID_ROCCAT
 config HID_ROCCAT_KONE
 	tristate "Roccat Kone Mouse support"
 	depends on USB_HID
+	select HID_ROCCAT
 	---help---
 	Support for Roccat Kone mouse.
 
