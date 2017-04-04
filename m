From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 07/33] docs: input/cd32: convert it to ReST format
Date: Tue,  4 Apr 2017 07:52:17 -0300
Message-ID: <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491302719.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491302719.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491302719.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491302719.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491302719.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491302719.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34337
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754107AbdDDMDD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 08:03:03 -0400
In-Reply-To: <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491302719.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

Currently, it misses a title, and the table is not valid for
ReST.

Adjust them, in order for it to be able to parse on Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/cd32.txt | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/input/cd32.txt b/Documentation/input/cd32.txt
index a003d9b41eca..2bffe0f33e5e 100644
--- a/Documentation/input/cd32.txt
+++ b/Documentation/input/cd32.txt
@@ -1,3 +1,7 @@
+==========
+Amiga CD32
+==========
+
 I have written a small patch that let's me use my Amiga CD32
 joypad connected to the parallel port. Thought I'd share it with you so
 you can add it to the list of supported joysticks (hopefully someone will
@@ -5,15 +9,15 @@ find it useful).
 
 It needs the following wiring:
 
-CD32 pad   |   Parallel port
-----------------------------
-1 (Up)     |    2 (D0)
-2 (Down)   |    3 (D1)
-3 (Left)   |    4 (D2)
-4 (Right)  |    5 (D3)
-5 (Fire3)  |   14 (AUTOFD)
-6 (Fire1)  |   17 (SELIN)
-7 (+5V)    |    1 (STROBE)
-8 (Gnd)    |   18 (Gnd)
-9 (Fire2)  |    7 (D5)
-
+===========    =============
+CD32 pad       Parallel port
+1 (Up)          2 (D0)
+2 (Down)        3 (D1)
+3 (Left)        4 (D2)
+4 (Right)       5 (D3)
+5 (Fire3)      14 (AUTOFD)
+6 (Fire1)      17 (SELIN)
+7 (+5V)         1 (STROBE)
+8 (Gnd)        18 (Gnd)
+9 (Fire2)       7 (D5)
+===========    =============
-- 
2.9.3


