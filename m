From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH -next] input: mouse/hgpk.c needs module.h
Date: Fri, 29 Jul 2011 21:14:41 -0700
Message-ID: <20110729211441.5de62eca.rdunlap@xenotime.net>
References: <20110729173827.716f57ff6e00095a3efc6449@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110729173827.716f57ff6e00095a3efc6449@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, akpm <akpm@linux-foundation.org>
List-Id: linux-input@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

hgpk.c uses interfaces from linux/module.h, so it should
include that file.  This fixes build errors.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/input/mouse/hgpk.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20110729.orig/drivers/input/mouse/hgpk.c
+++ linux-next-20110729/drivers/input/mouse/hgpk.c
@@ -32,6 +32,7 @@
 #define DEBUG
 #include <linux/slab.h>
 #include <linux/input.h>
+#include <linux/module.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
 #include <linux/delay.h>
