From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] input: axp20x-pek: make dev_attr_startup and dev_attr_shutdown static
Date: Thu, 17 Aug 2017 10:17:10 +0100
Message-ID: <20170817091710.15095-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, Quentin Schulz <quentin.schulz@free-electrons.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The functions dev_attr_startup and dev_attr_shutdown are local to the
source and do not need to be in global scope, so make them static.

Cleans up sparse warnings:
symbol 'dev_attr_startup' was not declared. Should it be static?
symbol 'dev_attr_shutdown' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/misc/axp20x-pek.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 4f7d208071d4..1fa8cd1b2dbf 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -191,9 +191,10 @@ static ssize_t axp20x_store_attr_shutdown(struct device *dev,
 				 axp20x_pek->info->shutdown_mask, buf, count);
 }
 
-DEVICE_ATTR(startup, 0644, axp20x_show_attr_startup, axp20x_store_attr_startup);
-DEVICE_ATTR(shutdown, 0644, axp20x_show_attr_shutdown,
-	    axp20x_store_attr_shutdown);
+static DEVICE_ATTR(startup, 0644, axp20x_show_attr_startup,
+		   axp20x_store_attr_startup);
+static DEVICE_ATTR(shutdown, 0644, axp20x_show_attr_shutdown,
+		   axp20x_store_attr_shutdown);
 
 static struct attribute *axp20x_attributes[] = {
 	&dev_attr_startup.attr,
-- 
2.11.0
