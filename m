From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 4/6] input: sparcspkr: Fix module autoload for OF platform
 drivers
Date: Thu, 27 Aug 2015 19:00:16 +0200
Message-ID: <20150827170016.GA5567@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-input@vger.kernel.org

These platform drivers have a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
---
 drivers/input/misc/sparcspkr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/sparcspkr.c b/drivers/input/misc/sparcspkr.c
index 54116e5..210300b 100644
--- a/drivers/input/misc/sparcspkr.c
+++ b/drivers/input/misc/sparcspkr.c
@@ -254,6 +254,8 @@ static const struct of_device_id bbc_beep_match[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(bbc_beep_match);
+
 static struct platform_driver bbc_beep_driver = {
 	.driver = {
 		.name = "bbcbeep",
@@ -333,6 +335,8 @@ static const struct of_device_id grover_beep_match[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(of, grover_beep_match);
+
 static struct platform_driver grover_beep_driver = {
 	.driver = {
 		.name = "groverbeep",
-- 
2.4.6
