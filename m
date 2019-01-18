From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/7] [media] doc-rst: switch to new names for Full Screen/Aspect keys
Date: Fri, 18 Jan 2019 15:30:32 -0800
Message-ID: <20190118233037.87318-2-dmitry.torokhov@gmail.com>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We defined better names for keys to activate full screen mode or
change aspect ratio (while keeping the existing keycodes to avoid
breaking userspace), so let's use them in the document.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/media/uapi/rc/rc-tables.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/media/uapi/rc/rc-tables.rst b/Documentation/media/uapi/rc/rc-tables.rst
index c8ae9479f842..57797e56f45e 100644
--- a/Documentation/media/uapi/rc/rc-tables.rst
+++ b/Documentation/media/uapi/rc/rc-tables.rst
@@ -616,7 +616,7 @@ the remote via /dev/input/event devices.
 
     -  .. row 78
 
-       -  ``KEY_SCREEN``
+       -  ``KEY_ASPECT_RATIO``
 
        -  Select screen aspect ratio
 
@@ -624,7 +624,7 @@ the remote via /dev/input/event devices.
 
     -  .. row 79
 
-       -  ``KEY_ZOOM``
+       -  ``KEY_FULL_SCREEN``
 
        -  Put device into zoom/full screen mode
 
-- 
2.20.1.321.g9e740568ce-goog
