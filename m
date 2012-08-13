From: Vojtech Bocek <vbocek@gmail.com>
Subject: [PATCH 1/1] Input: joydev - fix axes values sent in initial js_event
Date: Tue, 14 Aug 2012 00:11:54 +0200
Message-ID: <1344895914-32127-1-git-send-email-vbocek@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Vojtech Bocek <vbocek@gmail.com>
List-Id: linux-input@vger.kernel.org

Initial input event has not yet arrived in joydev_connect()
where values are set, which means default values of input_absinfo
are used for init event, not the actual values from joystick.

Signed-off-by: Vojtech Bocek <vbocek@gmail.com>
---
 drivers/input/joydev.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index 26043cc..11f24b4 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -318,9 +318,14 @@ static int joydev_generate_startup_event(struct joydev_client *client,
 			event->value = !!test_bit(joydev->keypam[event->number],
 						  input->key);
 		} else {
+			int evnum = client->startup - joydev->nkey;
+			int val = input_abs_get_val(input, joydev->abspam[evnum]);
+
+			joydev->abs[evnum] = joydev_correct(val, &joydev->corr[evnum]);
+
 			event->type = JS_EVENT_AXIS | JS_EVENT_INIT;
-			event->number = client->startup - joydev->nkey;
-			event->value = joydev->abs[event->number];
+			event->number = evnum;
+			event->value = joydev->abs[evnum];
 		}
 		client->startup++;
 	}
-- 
1.7.10.4
