From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/6] Input: uinput - allow FF requests to time out
Date: Wed,  6 Sep 2017 17:21:09 -0700
Message-ID: <20170907002112.14097-3-dmitry.torokhov@gmail.com>
References: <20170907002112.14097-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170907002112.14097-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>, Elias Vanderstuyft <elias.vds@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Previously uinput force feedback requests waited for the userspace
indefinitely, which caused users to block when uinput server process
become unresponsive. Let's establish a 30 seconds deadline for servicing
upload and erase force feedback effect actions, so that users have a
chance to abort stuck requests.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/uinput.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 443151de90c6..c30704fa1a06 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -149,7 +149,11 @@ static int uinput_request_submit(struct uinput_device *udev,
 	if (retval)
 		goto out;
 
-	wait_for_completion(&request->done);
+	if (!wait_for_completion_timeout(&request->done, 30 * HZ)) {
+		retval = -ETIMEDOUT;
+		goto out;
+	}
+
 	retval = request->retval;
 
  out:
-- 
2.14.1.581.gf28d330327-goog
