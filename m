From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?=
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/3] HID: cp2112: fix interface specification URL
Date: Thu,  2 Nov 2017 12:12:42 +0100
Message-ID: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Julien Boibessot <julien.boibessot@armadeus.com>, =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 drivers/hid/hid-cp2112.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 078026f..28e3c18 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -21,7 +21,7 @@
  * Data Sheet:
  *   http://www.silabs.com/Support%20Documents/TechnicalDocs/CP2112.pdf
  * Programming Interface Specification:
- *   http://www.silabs.com/Support%20Documents/TechnicalDocs/AN495.pdf
+ *   https://www.silabs.com/documents/public/application-notes/an495-cp2112-interface-specification.pdf
  */
 
 #include <linux/gpio.h>
-- 
2.7.3
