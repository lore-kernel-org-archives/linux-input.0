From: Chen Gang <gang.chen.5i5j@gmail.com>
Subject: [PATCH] drivers: input: touchscreen: sur40: use static variable instead
 of stack varialbe for 'packet_id'
Date: Wed, 27 Nov 2013 10:15:33 +0800
Message-ID: <529555C5.7030404@gmail.com>
References: <528AD6B3.1060507@gmail.com> <20131125011908.GA18921@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:44057 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947Ab3K0CNd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Nov 2013 21:13:33 -0500
In-Reply-To: <20131125011908.GA18921@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, floe@butterbrot.org, rydberg@euromail.se, David Herrmann <dh.herrmann@gmail.com>
Cc: rkuo <rkuo@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

'packet_id' is used for checking sequence whether in order, it need be
static variable independent from sur40_poll().

The related warning (with allmodconfig under hexagon):

  drivers/input/touchscreen/sur40.c: In function 'sur40_poll':
  drivers/input/touchscreen/sur40.c:297:6: warning: 'packet_id' may be used uninitialized in this function [-Wuninitialized]


Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
---
 drivers/input/touchscreen/sur40.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
index cfd1b7e..5dfd01a 100644
--- a/drivers/input/touchscreen/sur40.c
+++ b/drivers/input/touchscreen/sur40.c
@@ -251,7 +251,7 @@ static void sur40_poll(struct input_polled_dev *polldev)
 	struct sur40_state *sur40 = polldev->private;
 	struct input_dev *input = polldev->input;
 	int result, bulk_read, need_blobs, packet_blobs, i;
-	u32 packet_id;
+	static u32 packet_id;
 
 	struct sur40_header *header = &sur40->bulk_in_buffer->header;
 	struct sur40_blob *inblob = &sur40->bulk_in_buffer->blobs[0];
-- 
1.7.7.6
