From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/8] Input: docs - remove disclaimer/GPL notice
Date: Sat, 15 Apr 2017 22:11:41 -0700
Message-ID: <20170416051145.13618-4-dmitry.torokhov@gmail.com>
References: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170416051145.13618-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-input@vger.kernel.org

This is just a part of kernel documentation, it does not require explicit
license notice.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/input/index.rst | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/Documentation/input/index.rst b/Documentation/input/index.rst
index 32c0515fd24b..5887c79173b8 100644
--- a/Documentation/input/index.rst
+++ b/Documentation/input/index.rst
@@ -2,27 +2,6 @@
 The Linux Input Documentation
 =============================
 
-Disclaimer
-==========
-
-This program is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the Free
-Software Foundation; either version 2 of the License, or (at your option)
-any later version.
-
-This program is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-more details.
-
-You should have received a copy of the GNU General Public License along
-with this program; if not, write to the Free Software Foundation, Inc., 59
-Temple Place, Suite 330, Boston, MA 02111-1307 USA
-
-For your convenience, the GNU General Public License version 2 is included
-in the package: See the file COPYING.
-
-
 Core API
 ========
 
-- 
2.12.2.762.g0e3151a226-goog
