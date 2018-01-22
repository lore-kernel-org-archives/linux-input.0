From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] Input: docs - use PROPERTY_ENTRY_U32() directly
Date: Mon, 22 Jan 2018 14:54:57 +0200
Message-ID: <20180122125457.6226-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59876 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbeAVMzB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Jan 2018 07:55:01 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Instead of using PROPERTY_ENTRY_INTEGER() with explicitly supplied type,
use PROPERTY_ENTRY_U32() dedicated macro.

It will help modify internals of built-in device properties API.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/input/devices/rotary-encoder.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/input/devices/rotary-encoder.rst b/Documentation/input/devices/rotary-encoder.rst
index b07b20a295ac..810ae02bdaa0 100644
--- a/Documentation/input/devices/rotary-encoder.rst
+++ b/Documentation/input/devices/rotary-encoder.rst
@@ -108,9 +108,9 @@ example below:
 	};
 
 	static const struct property_entry rotary_encoder_properties[] __initconst = {
-		PROPERTY_ENTRY_INTEGER("rotary-encoder,steps-per-period", u32, 24),
-		PROPERTY_ENTRY_INTEGER("linux,axis",			  u32, ABS_X),
-		PROPERTY_ENTRY_INTEGER("rotary-encoder,relative_axis",	  u32, 0),
+		PROPERTY_ENTRY_U32("rotary-encoder,steps-per-period", 24),
+		PROPERTY_ENTRY_U32("linux,axis",		      ABS_X),
+		PROPERTY_ENTRY_U32("rotary-encoder,relative_axis",    0),
 		{ },
 	};
 
-- 
2.15.1

