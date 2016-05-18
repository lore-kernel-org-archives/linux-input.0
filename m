From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: feed more data into entropy pool
Date: Wed, 18 May 2016 14:32:44 -0700
Message-ID: <20160518213244.GA3167@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33545 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbcERVcs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 May 2016 17:32:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id y7so6067947pfb.0
        for <linux-input@vger.kernel.org>; Wed, 18 May 2016 14:32:48 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, djkurtz@chromium.org

Commit 4369c64c79a22 ("Input: Send events one packet at a time")
significantly reduced amount of entropy input core was feeding to the rest
of the system, because only the very first event in the event block would
be used as source of entropy.

With this change we will be calling add_input_randomness() for every event
that is not filtered by the input core as a duplicate. In addition, all
EV_SYN events are ignored.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index b87ffbd..d95c34e 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -153,8 +153,6 @@ static void input_pass_values(struct input_dev *dev,
 
 	rcu_read_unlock();
 
-	add_input_randomness(vals->type, vals->code, vals->value);
-
 	/* trigger auto repeat for key events */
 	if (test_bit(EV_REP, dev->evbit) && test_bit(EV_KEY, dev->evbit)) {
 		for (v = vals; v != vals + count; v++) {
@@ -371,9 +369,10 @@ static int input_get_disposition(struct input_dev *dev,
 static void input_handle_event(struct input_dev *dev,
 			       unsigned int type, unsigned int code, int value)
 {
-	int disposition;
+	int disposition = input_get_disposition(dev, type, code, &value);
 
-	disposition = input_get_disposition(dev, type, code, &value);
+	if (disposition != INPUT_IGNORE_EVENT && type != EV_SYN)
+		add_input_randomness(type, code, value);
 
 	if ((disposition & INPUT_PASS_TO_DEVICE) && dev->event)
 		dev->event(dev, type, code, value);
-- 
2.8.0.rc3.226.g39d4020


-- 
Dmitry
