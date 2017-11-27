From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH v2] input: pegasus_notetaker: add license information
Date: Mon, 27 Nov 2017 08:44:01 +0100
Message-ID: <20171127074401.16388-1-martink@posteo.de>
References: <20171126004259.xjl2icw3gbyg3hck@dtor-ws>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171126004259.xjl2icw3gbyg3hck@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: gregkh@linuxfoundation.org, pombredanne@nexb.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
List-Id: linux-input@vger.kernel.org

This adds an SPDX license identifier to this driver I wrote some time back.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

Thanks for the feedback. GPL2+ was what I had in mind. My bad. And as I
already see a lot of SPDX tags using /**/ comments, I'll use that too.
I think if it is hand-written, it shouldn't look too ugly. And in case
that's really a no-go, it seems that many many files need to be changed
again in any case.

                          martin

patch revisions
---------------
v2: use /**/ comments and fix the license tag to match MODULE_LICENSE()


 drivers/input/tablet/pegasus_notetaker.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
index 47de5a81172f..93fe8ecab767 100644
--- a/drivers/input/tablet/pegasus_notetaker.c
+++ b/drivers/input/tablet/pegasus_notetaker.c
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Pegasus Mobile Notetaker Pen input tablet driver
  *
-- 
2.11.0
