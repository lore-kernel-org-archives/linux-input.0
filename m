From: Michael Ellerman <mpe@ellerman.id.au>
Subject: [RESEND PATCH] input/joystick/analog: Use get_cycles() on PPC
Date: Thu,  8 Jun 2017 14:42:53 +1000
Message-ID: <1496896973-13848-1-git-send-email-mpe@ellerman.id.au>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:60363 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750788AbdFHEm7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 8 Jun 2017 00:42:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org

The analog joystick driver spits a warning at us:

  drivers/input/joystick/analog.c:176:2: warning: #warning Precise timer
  not defined for this architecture.

PPC has get_cycles() so use that.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/input/joystick/analog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 3d8ff09eba57..06962b63f3a6 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -163,7 +163,7 @@ static unsigned int get_time_pit(void)
 #define GET_TIME(x)	do { x = (unsigned int)rdtsc(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"TSC"
-#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_TILE)
+#elif defined(__alpha__) || defined(CONFIG_MN10300) || defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_TILE) || defined(CONFIG_PPC)
 #define GET_TIME(x)	do { x = get_cycles(); } while (0)
 #define DELTA(x,y)	((y)-(x))
 #define TIME_NAME	"get_cycles"
-- 
2.7.4

