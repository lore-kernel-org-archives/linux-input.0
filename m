From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 07/33] docs: input/cd32: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:50 -0300
Message-ID: <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:35273 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbdDASQd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 14:16:33 -0400
In-Reply-To: <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
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


