From: Joe Perches <joe@perches.com>
Subject: [PATCH 6/6] hid: simplify an index check in hid_lookup_collection
Date: Thu,  9 Dec 2010 19:29:08 -0800
Message-ID: <e7178835751a133007146aef5674edea96206ed2.1291951482.git.joe@perches.com>
References: <alpine.LNX.2.00.1012091454010.508@pobox.suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1012091454010.508@pobox.suse.cz>
In-Reply-To: <cover.1291951482.git.joe@perches.com>
References: <cover.1291951482.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Save the struct hid_collection * in a temporary to shorten
the generated code a bit and perhaps improve readability.

$ size drivers/hid/hid-core.o*
   text	   data	    bss	    dec	    hex	filename
  16460	     78	      8	  16546	   40a2	drivers/hid/hid-core.o.new
  16469	     78	      8	  16555	   40ab	drivers/hid/hid-core.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hid/hid-core.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 796012e..ee05170 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -178,10 +178,14 @@ static int close_collection(struct hid_parser *parser)
 
 static unsigned hid_lookup_collection(struct hid_parser *parser, unsigned type)
 {
+	struct hid_collection *collection = parser->device->collection;
 	int n;
-	for (n = parser->collection_stack_ptr - 1; n >= 0; n--)
-		if (parser->device->collection[parser->collection_stack[n]].type == type)
-			return parser->device->collection[parser->collection_stack[n]].usage;
+
+	for (n = parser->collection_stack_ptr - 1; n >= 0; n--) {
+		unsigned index = parser->collection_stack[n];
+		if (collection[index].type == type)
+			return collection[index].usage;
+	}
 	return 0; /* we know nothing about this usage type */
 }
 
-- 
1.7.3.3.464.gf80b6
