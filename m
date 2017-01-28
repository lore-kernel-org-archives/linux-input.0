From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND] Initialize axis values in joydev_open_device()
Date: Sat, 28 Jan 2017 11:01:00 -0800
Message-ID: <20170128190100.GA32332@dtor-ws>
References: <20161218202050.GX10002@yggdrasil2.lan.raphnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35101 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751684AbdA1TBF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 28 Jan 2017 14:01:05 -0500
Received: by mail-pg0-f66.google.com with SMTP id 204so27754477pge.2
        for <linux-input@vger.kernel.org>; Sat, 28 Jan 2017 11:01:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161218202050.GX10002@yggdrasil2.lan.raphnet.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Raphael Assenat <raph@raphnet.net>
Cc: linux-input@vger.kernel.org

Hi Raphael,

On Sun, Dec 18, 2016 at 03:20:50PM -0500, Raphael Assenat wrote:
> Postpone axis initialization to the first open instead of doing it once
> in joydev_connect. This is to make sure the generated startup events
> are representative of the current joystick state rather than what
> it was when joydev_connect() was called, potentially much earlier.
> 
> This solves issues with joystick driven menus that start scrolling
> up each time they are started, until the user moves the joystick to
> generate events. In emulator menu setups where the menu program is
> restarted every time the game exits, the repeated need to move the
> joystick to stop the unintended scrolling gets old rather quickly...
> 
> Unless I misunderstood the intent of JS_EVENT_INIT, I think the startup
> events should reflect the current state of the joystick. Please consider
> applying if it makes sense.

Sorry for the delay and what you are saying certainly makes sense.
Unfortunately with the patch as is we end up re-initializing calibration
coefficients every time user opens device (assuming that there is only
one user of joystick device at a time), whereas before one could have a
small utility calibrating the joystick, and then go on to using it with
some other application (game). How about we keep most of the
initialization in connect() and only populate axis data in open(), like
below?

-- 
Dmitry


Input: joydev - do not report stale values on first open

From: Raphael Assenat <raph@raphnet.net>

Postpone axis initialization to the first open instead of doing it
in joydev_connect. This is to make sure the generated startup events
are representative of the current joystick state rather than what
it was when joydev_connect() was called, potentially much earlier.
Once the first user is connected to joydev node we'll be updating
joydev->abs[] values and subsequent clients will be getting correct
initial states as well.

This solves issues with joystick driven menus that start scrolling
up each time they are started, until the user moves the joystick to
generate events. In emulator menu setups where the menu program is
restarted every time the game exits, the repeated need to move the
joystick to stop the unintended scrolling gets old rather quickly...

Signed-off-by: Raphael Assenat <raph@raphnet.net>
Patchwork-Id: 9479395
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joydev.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index abd18f31b24f..db5e290e897e 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -187,6 +187,17 @@ static void joydev_detach_client(struct joydev *joydev,
 	synchronize_rcu();
 }
 
+static void joydev_refresh_state(struct joydev *joydev)
+{
+	struct input_dev *dev = joydev->handle.dev;
+	int i, val;
+
+	for (i = 0; i < joydev->nabs; i++) {
+		val = input_abs_get_val(dev, joydev->abspam[i]);
+		joydev->abs[i] = joydev_correct(val, &joydev->corr[i]);
+	}
+}
+
 static int joydev_open_device(struct joydev *joydev)
 {
 	int retval;
@@ -201,6 +212,8 @@ static int joydev_open_device(struct joydev *joydev)
 		retval = input_open_device(&joydev->handle);
 		if (retval)
 			joydev->open--;
+		else
+			joydev_refresh_state(joydev);
 	}
 
 	mutex_unlock(&joydev->mutex);
@@ -872,7 +885,6 @@ static int joydev_connect(struct input_handler *handler, struct input_dev *dev,
 		j = joydev->abspam[i];
 		if (input_abs_get_max(dev, j) == input_abs_get_min(dev, j)) {
 			joydev->corr[i].type = JS_CORR_NONE;
-			joydev->abs[i] = input_abs_get_val(dev, j);
 			continue;
 		}
 		joydev->corr[i].type = JS_CORR_BROKEN;
@@ -887,10 +899,6 @@ static int joydev_connect(struct input_handler *handler, struct input_dev *dev,
 		if (t) {
 			joydev->corr[i].coef[2] = (1 << 29) / t;
 			joydev->corr[i].coef[3] = (1 << 29) / t;
-
-			joydev->abs[i] =
-				joydev_correct(input_abs_get_val(dev, j),
-					       joydev->corr + i);
 		}
 	}
 
