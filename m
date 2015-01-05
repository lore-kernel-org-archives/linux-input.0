From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: wacom: add support of the Pen of the Bamboo Pad
Date: Mon,  5 Jan 2015 16:32:13 -0500
Message-ID: <1420493533-11639-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1420493533-11639-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420493533-11639-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>
Cc: josep.sanchez.ferreres@est.fib.upc.edu, Ping Cheng <pinglinux@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Bamboo Pads are using the generic processing but their report descriptors
differ from the ISDv* line. The pen fields are marked with the .physical
as Digitizer_Pen, which makes also sense.

Add this field to the checks and enable for free Bamboo Pads.

Reported-by: Josep Sanchez Ferreres <josep.sanchez.ferreres@est.fib.upc.edu>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi Jason,

I still did not managed to put in shape the regression tests for the Wacom
recordings we have. I do not think this will impact the current supported
devices (none that I have present the HID_DG_PEN application/logical/physical
tag).

It would be good still if you could have a look and validate the patch series.

Cheers,
Benjamin

 drivers/hid/wacom_wac.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 7436f2b..7afd929 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -74,6 +74,7 @@
 
 #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
 				 ((f)->physical == HID_DG_STYLUS) || \
+				 ((f)->physical == HID_DG_PEN) || \
 				 ((f)->application == HID_DG_PEN))
 #define WACOM_FINGER_FIELD(f)	(((f)->logical == HID_DG_FINGER) || \
 				 ((f)->physical == HID_DG_FINGER) || \
-- 
2.1.0
