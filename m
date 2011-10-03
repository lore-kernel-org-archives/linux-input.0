From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH] Input: evdev - use monotonic clock for event timestamps
Date: Mon,  3 Oct 2011 14:43:20 +0800
Message-ID: <1317624200-9762-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Kurtz <djkurtz@chromium.org>
List-Id: linux-input@vger.kernel.org

Using wallclock time for event timestamps subjects inter-event timing to
ntp and other clock adjustments.  This complicates userspace drivers
that use these timestamps to calculate velocities, or while processing
state transitions.

Instead, use the kernel monotonic clock for event timestamps, which is
at least guaranteed never to go backwards.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/evdev.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 4cf2534..118f936 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -94,8 +94,11 @@ static void evdev_event(struct input_handle *handle,
 	struct evdev *evdev = handle->private;
 	struct evdev_client *client;
 	struct input_event event;
+	struct timespec now;
 
-	do_gettimeofday(&event.time);
+	getrawmonotonic(&now);
+	event.time.tv_sec = now.tv_sec;
+	event.time.tv_usec = now.tv_nsec/1000;
 	event.type = type;
 	event.code = code;
 	event.value = value;
-- 
1.7.3.1
