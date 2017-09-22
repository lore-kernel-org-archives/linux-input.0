From: =?UTF-8?q?Jean-Fran=C3=A7ois=20T=C3=AAtu?=
        <jean-francois.tetu@savoirfairelinux.com>
Subject: [PATCH] Documentation: input: ff: fix small typos
Date: Fri, 22 Sep 2017 14:27:24 -0400
Message-ID: <1506104844-10209-1-git-send-email-jean-francois.tetu@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:48264 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdIVS1r (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 14:27:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-doc@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Jean-Fran=C3=A7ois=20T=C3=AAtu?= <jean-francois.tetu@savoirfairelinux.com>

Fix small typos in the Instructions and Uploading sections. Fix a typo in
the start/stop effect example usage code.

Signed-off-by: Jean-François Têtu <jean-francois.tetu@savoirfairelinux.com>
---
 Documentation/input/ff.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/ff.rst b/Documentation/input/ff.rst
index 26d4619..0c02e87 100644
--- a/Documentation/input/ff.rst
+++ b/Documentation/input/ff.rst
@@ -31,7 +31,7 @@ To enable force feedback, you have to:
 
 Before you start, let me WARN you that some devices shake violently during the
 initialisation phase. This happens for example with my "AVB Top Shot Pegasus".
-To stop this annoying behaviour, move you joystick to its limits. Anyway, you
+To stop this annoying behaviour, move your joystick to its limits. Anyway, you
 should keep a hand on your device, in order to avoid it to break down if
 something goes wrong.
 
@@ -121,7 +121,7 @@ uploaded, but not played.
 The content of effect may be modified. In particular, its field "id" is set
 to the unique id assigned by the driver. This data is required for performing
 some operations (removing an effect, controlling the playback).
-This if field must be set to -1 by the user in order to tell the driver to
+The "id" field must be set to -1 by the user in order to tell the driver to
 allocate a new effect.
 
 Effects are file descriptor specific.
@@ -178,7 +178,7 @@ Control of playing is done with write(). Below is an example:
 	stop.code = effect.id;
 	stop.value = 0;
 
-	write(fd, (const void*) &play, sizeof(stop));
+	write(fd, (const void*) &stop, sizeof(stop));
 
 Setting the gain
 ----------------
-- 
2.7.4

