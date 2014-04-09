From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: rmi: do not stop the device at the end of probe
Date: Wed,  9 Apr 2014 11:01:34 -0400
Message-ID: <1397055694-6312-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Well, this is embarrassing, if the device is stopped at the end of probe,
we get into big troubles (it even oopses my kernel).

This was a leftover of an attempt to be smart when sending the patch,
I deeply apologies.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi Jiri,

well, first thanks for having integrating hid-rmi in your for 3.16 branch.

While backporting it to 3.13 so Fedora can get it, I noticed a tiny difference
(besides formatting) between the version I submitted and the one I asked people
to test...

...facepalm.

Cheers,
Benjamin

 drivers/hid/hid-rmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 699d631..7da9509 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -848,7 +848,6 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return -EIO;
 	}
 
-	hid_hw_stop(hdev);
 	return 0;
 }
 
-- 
1.9.0
