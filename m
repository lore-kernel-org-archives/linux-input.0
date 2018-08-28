From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] HID: input: fix leaking custom input node name
Date: Tue, 28 Aug 2018 13:29:55 +0200
Message-ID: <20180828112955.11318-2-stefan@agner.ch>
References: <20180828112955.11318-1-stefan@agner.ch>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180828112955.11318-1-stefan@agner.ch>
Sender: stable-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Make sure to free the custom input node name on disconnect.

Cc: stable@vger.kernel.org # v4.18+
Fixes: c554bb045511 ("HID: input: append a suffix matching the application")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Found with kmemleak, after unplugging a Logitech Unifying receiver:

unreferenced object 0xc2345b80 (size 64):
  comm "kworker/0:1", pid 20, jiffies 4294955181 (age 320.740s)
  hex dump (first 32 bytes):
    4c 6f 67 69 74 65 63 68 20 55 53 42 20 52 65 63  Logitech USB Rec
    65 69 76 65 72 20 53 79 73 74 65 6d 20 43 6f 6e  eiver System Con
  backtrace:
    [<8fec5a71>] __kmalloc_track_caller+0x1dc/0x300
    [<5b926275>] kvasprintf+0x60/0xcc
    [<21fc360f>] kasprintf+0x38/0x54
    [<3b6ce9f0>] hidinput_connect+0x23a8/0x4c60
    [<deaab707>] hid_connect+0x30c/0x38c
    [<5a28f7c9>] hid_hw_start+0x44/0x64
    [<267d70e8>] hid_generic_probe+0x34/0x38
    [<d68c31b1>] hid_device_probe+0xdc/0x13c
    [<09414e91>] really_probe+0x1d8/0x2c4
    [<f9d7157f>] driver_probe_device+0x68/0x184
    [<1def17c8>] __device_attach_driver+0xa0/0xd4
    [<d3b2081b>] bus_for_each_drv+0x60/0xc0
    [<379d02f8>] __device_attach+0xdc/0x144
    [<7026ace5>] device_initial_probe+0x14/0x18
    [<44527d01>] bus_probe_device+0x90/0x98
    [<cf58bf2f>] device_add+0x424/0x62c

 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 4e94ea3e280a..ac201817a2dd 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1815,6 +1815,7 @@ void hidinput_disconnect(struct hid_device *hid)
 			input_unregister_device(hidinput->input);
 		else
 			input_free_device(hidinput->input);
+		kfree(hidinput->name);
 		kfree(hidinput);
 	}
 
-- 
2.18.0
