From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 24/43] compat_ioctl: remove joystick ioctl translation
Date: Wed,  9 Oct 2019 21:10:24 +0200
Message-ID: <20191009191044.308087-24-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

The joystick driver already handles these just fine, so
the entries in the table are not needed any more.

Cc: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 398268604ab7..a214ae052596 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -11,8 +11,6 @@
  * ioctls.
  */
 
-#include <linux/joystick.h>
-
 #include <linux/types.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
@@ -444,11 +442,6 @@ COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
 COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
-/* joystick */
-COMPATIBLE_IOCTL(JSIOCGVERSION)
-COMPATIBLE_IOCTL(JSIOCGAXES)
-COMPATIBLE_IOCTL(JSIOCGBUTTONS)
-COMPATIBLE_IOCTL(JSIOCGNAME(0))
 };
 
 /*
-- 
2.20.0
