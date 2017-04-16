From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/8] Input: docs - note that MT-A protocol is obsolete
Date: Sat, 15 Apr 2017 22:11:43 -0700
Message-ID: <20170416051145.13618-6-dmitry.torokhov@gmail.com>
References: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-input@vger.kernel.org

Everyone should be using multitouch protocol B (slotted) now.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/input/multi-touch-protocol.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/multi-touch-protocol.rst b/Documentation/input/multi-touch-protocol.rst
index 81775d7c1997..8035868c56bc 100644
--- a/Documentation/input/multi-touch-protocol.rst
+++ b/Documentation/input/multi-touch-protocol.rst
@@ -22,6 +22,9 @@ describes how to send the raw data for all contacts to the receiver. For
 devices capable of tracking identifiable contacts (type B), the protocol
 describes how to send updates for individual contacts via event slots.
 
+.. note::
+   MT potocol type A is obsolete, all kernel drivers have been
+   converted to use type B.
 
 Protocol Usage
 --------------
@@ -400,9 +403,6 @@ in a finger packet must not be recognized as single-touch events.
 For type A devices, all finger data bypasses input filtering, since
 subsequent events of the same type refer to different fingers.
 
-For example usage of the type A protocol, see the bcm5974 driver. For
-example usage of the type B protocol, see the hid-egalax driver.
-
 .. [#f1] Also, the difference (TOOL_X - POSITION_X) can be used to model tilt.
 .. [#f2] The list can of course be extended.
 .. [#f3] The mtdev project: http://bitmath.org/code/mtdev/.
-- 
2.12.2.762.g0e3151a226-goog
