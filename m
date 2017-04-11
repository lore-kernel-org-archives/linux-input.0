From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH] docs-rst: add input docs at main index and use kernel-figure
Date: Tue, 11 Apr 2017 07:01:19 -0300
Message-ID: <1183dff3e0dd809c866d646a0c41ddbc4452d85e.1491904368.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Martin Kepplinger <martink@posteo.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The input subsystem documentation got converted into ReST.

Add it to the main documentation index and use kernel-figure
for the two svg images there.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---

Jon/Dmitry,

This patch contains the final bits of the input documentation
conversion. The linux-input tree has already the ReST conversion
patches, but it doesn't have the
Documentation/sphinx/load_config.py script with implements
the kernel-figure directive, as it got merged via docs tree.

So, either one of you should merge from the other tree or this
patch should be sent in separate upstream after both trees
gets merged. What do you prefer?

Thanks!
Mauro


 Documentation/index.rst    | 1 +
 Documentation/input/ff.rst | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 61306a22888d..bc67dbf76eb0 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -67,6 +67,7 @@ needed).
    driver-api/index
    core-api/index
    media/index
+   input/index
    gpu/index
    security/index
    sound/index
diff --git a/Documentation/input/ff.rst b/Documentation/input/ff.rst
index c30f185216a0..0ea123c64dd2 100644
--- a/Documentation/input/ff.rst
+++ b/Documentation/input/ff.rst
@@ -129,11 +129,11 @@ Effects are file descriptor specific.
 See <linux/input.h> for a description of the ff_effect struct. You should also
 find help in a few sketches, contained in files shape.svg and interactive.svg:
 
-.. figure:: shape.svg
+.. kernel-figure:: shape.svg
 
     Shape
 
-.. figure:: interactive.svg
+.. kernel-figure:: interactive.svg
 
     Interactive
 
-- 
2.9.3


