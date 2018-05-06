From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5/9] input: ati_remote2: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:49 +0200
Message-ID: <20180506112404.24872-6-wsa+renesas@sang-engineering.com>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ville Syrjala <syrjala@sci.fi>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/input/misc/ati_remote2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index ded5b84e336dae..d8fd58fdf05086 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -22,7 +22,7 @@ MODULE_LICENSE("GPL");
 /*
  * ATI Remote Wonder II Channel Configuration
  *
- * The remote control can by assigned one of sixteen "channels" in order to facilitate
+ * The remote control can be assigned one of sixteen "channels" in order to facilitate
  * the use of multiple remote controls within range of each other.
  * A remote's "channel" may be altered by pressing and holding the "PC" button for
  * approximately 3 seconds, after which the button will slowly flash the count of the
-- 
2.11.0
