From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] appletouch: add myself as maintainer
Date: Wed, 24 Oct 2007 13:46:23 +0200
Message-ID: <1193226383.4510.28.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

After the last patch that broke appletouch for powerbooks again (many
more have previously been proposed), I'd like to take over
maintainership of this driver to make sure it doesn't break again in the
future.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 MAINTAINERS |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.orig/MAINTAINERS	2007-10-24 13:44:34.550220973 +0200
+++ linux-2.6/MAINTAINERS	2007-10-24 13:45:31.630206271 +0200
@@ -398,6 +398,12 @@ P:	Arnaldo Carvalho de Melo
 M:	acme@ghostprotocols.net
 S:	Maintained
 
+APPLETOUCH TOUCHPAD DRIVER
+P:	Johannes Berg
+M:	johannes@sipsolutions.net
+L:	linux-input@atrey.karlin.mff.cuni.cz
+S:	Maintained
+
 ARC FRAMEBUFFER DRIVER
 P:	Jaya Kumar
 M:	jayalk@intworks.biz
