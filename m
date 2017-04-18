From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: xpad - do not suggest writing to Dominic
Date: Mon, 17 Apr 2017 20:26:44 -0700
Message-ID: <20170418032644.GA10689@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, binary1230@yahoo.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Do not recommend people write to Dominic, rather everyone should be using
linux-input mailing list.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/input/devices/xpad.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/input/devices/xpad.rst b/Documentation/input/devices/xpad.rst
index c7c4e154bd34..5a709ab77c8d 100644
--- a/Documentation/input/devices/xpad.rst
+++ b/Documentation/input/devices/xpad.rst
@@ -88,12 +88,6 @@ the default settings.
 HOWEVER if you have an unknown dance pad not listed below, it will not
 work UNLESS you set "dpad_to_buttons" to 1 in the module configuration.
 
-PLEASE, if you have an unknown controller, email Dom <binary1230@yahoo.com> with
-a dump from /proc/bus/usb and a description of the pad (manufacturer, country,
-whether it is a dance pad or normal controller) so that we can add your pad
-to the list of supported devices, ensuring that it will work out of the
-box in the future.
-
 
 USB adapters
 ============
-- 
2.12.2.762.g0e3151a226-goog


-- 
Dmitry
