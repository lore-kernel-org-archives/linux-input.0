From: Jason Andryuk <jandryuk@gmail.com>
Subject: [PATCH] i2c-hid: Fix "incomplete report" noise
Date: Fri, 22 Jun 2018 12:25:49 -0400
Message-ID: <20180622162549.9563-1-jandryuk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: john-s-84@gmx.net, Jason Andryuk <jandryuk@gmail.com>, stable@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Commit ac75a041048b ("HID: i2c-hid: fix size check and type usage")
started writing messages when the ret_size is <= 2 from i2c_master_recv.
However, my device i2c-DLL07D1 returns 2 for a short period of time
(~0.5s) after I stop moving the pointing stick or touchpad.  It varies,
but you get ~50 messages each time which spams the log hard.
[  95.925055] i2c_hid i2c-DLL07D1:01: i2c_hid_get_input: incomplete report (83/2)

This has also been observed with a i2c-ALP0017.
[ 1781.266353] i2c_hid i2c-ALP0017:00: i2c_hid_get_input: incomplete report (30/2)

Only print the message when ret_size is totally invalid and less than 2
to cut down on the log spam.

Reported-by: John Smith <john-s-84@gmx.net>
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
John Smith originally reported this, but his post did not include a git
formatted patch nor a Signed-off-by.
https://www.spinics.net/lists/linux-input/msg56171.html
https://patchwork.kernel.org/patch/10374383/

When ret_size is 2, hid_input_report is passed 0 and returns early.  ret_size
== 2 seems to be a header size saying there is no content.  Should
i2c_hid_get_input just return early in that case?

Also, should this condition be noted to stop an interrupt from firing to
avoid the ~50 bogus messages?

 drivers/hid/i2c-hid/i2c-hid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index c1652bb7bd15..eae0cb3ddec6 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -484,7 +484,7 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
 		return;
 	}
 
-	if ((ret_size > size) || (ret_size <= 2)) {
+	if ((ret_size > size) || (ret_size < 2)) {
 		dev_err(&ihid->client->dev, "%s: incomplete report (%d/%d)\n",
 			__func__, size, ret_size);
 		return;
-- 
2.17.1
