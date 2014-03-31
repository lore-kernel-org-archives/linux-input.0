From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] input: cypress_ps2: Don't report the cypress PS/2 trackpads as a button pad
Date: Mon, 31 Mar 2014 11:08:56 +0200
Message-ID: <1396256936-12652-2-git-send-email-hdegoede@redhat.com>
References: <1396256936-12652-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6803 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753365AbaCaJJC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Mar 2014 05:09:02 -0400
In-Reply-To: <1396256936-12652-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Adam Williamson <awilliam@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>

The cypress PS/2 trackpad models supported by the cypress_ps2 driver emulate
BTN_RIGHT events in firmware based on the finger position, as part of this
no motion events are sent when the finger is in the button area.

The INPUT_PROP_BUTTONPAD property is there to indicate to userspace that
BTN_RIGHT events should be emulated in userspace, which is not necessary
in this case.

When INPUT_PROP_BUTTONPAD is advertised userspace will wait for a motion event
before propagating the button event higher up the stack, as it needs current
abs x + y data for its BTN_RIGHT emulation. Since in the cypress_ps2 pads
don't report motion events in the button area, this means that clicks in the
button area end up being ignored, so INPUT_PROP_BUTTONPAD actually causes
problems for these touchpads, and removing it fixes:

https://bugs.freedesktop.org/show_bug.cgi?id=76341

Reported-by: Adam Williamson <awilliam@redhat.com>
Tested-by: Adam Williamson <awilliam@redhat.com>
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Adam Williamson <awilliam@redhat.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/input/mouse/cypress_ps2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index 87095e2..8af34ff 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -409,7 +409,6 @@ static int cypress_set_input_params(struct input_dev *input,
 	__clear_bit(REL_X, input->relbit);
 	__clear_bit(REL_Y, input->relbit);
 
-	__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 	__set_bit(EV_KEY, input->evbit);
 	__set_bit(BTN_LEFT, input->keybit);
 	__set_bit(BTN_RIGHT, input->keybit);
-- 
1.9.0

