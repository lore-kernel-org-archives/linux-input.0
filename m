From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] Input: uinput - fix Spectre v1 vulnerability
Date: Tue, 16 Oct 2018 13:13:13 +0200
Message-ID: <20181016111313.GA28307@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-input@vger.kernel.org

setup.code can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/input/misc/uinput.c:512 uinput_abs_setup() warn: potential
spectre issue 'dev->absinfo' [w] (local cap)

Fix this by sanitizing setup.code before using it to index dev->absinfo.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/input/misc/uinput.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 8ec483e..97b0809 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -42,6 +42,8 @@
 #include <linux/input/mt.h>
 #include "../input-compat.h"
 
+#include <linux/nospec.h>
+
 #define UINPUT_NAME		"uinput"
 #define UINPUT_BUFFER_SIZE	16
 #define UINPUT_NUM_REQUESTS	16
@@ -497,6 +499,7 @@ static int uinput_abs_setup(struct uinput_device *udev,
 
 	if (setup.code > ABS_MAX)
 		return -ERANGE;
+	setup.code = array_index_nospec(setup.code, ABS_MAX + 1);
 
 	dev = udev->dev;
 
-- 
2.7.4
