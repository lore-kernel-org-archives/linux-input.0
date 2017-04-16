From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/8] Input: fix "Game console" heading level in joystick documentation
Date: Sat, 15 Apr 2017 22:11:40 -0700
Message-ID: <20170416051145.13618-3-dmitry.torokhov@gmail.com>
References: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-input@vger.kernel.org

The heading level should be the same as for other devices.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/input/joystick.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/input/joystick.rst b/Documentation/input/joystick.rst
index 202f5a090675..c9c175ffc2ff 100644
--- a/Documentation/input/joystick.rst
+++ b/Documentation/input/joystick.rst
@@ -465,7 +465,7 @@ No more joystick types are supported now, but that should change in the
 future if I get an Amiga in the reach of my fingers.
 
 Game console and 8-bit pads and joysticks
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+-----------------------------------------
 
 See :ref:`joystick-parport` for more info.
 
-- 
2.12.2.762.g0e3151a226-goog

