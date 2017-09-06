From: Colin King <colin.king@canonical.com>
Subject: [PATCH] input: surface3_spi: make const array header static, reduces object code size
Date: Wed,  6 Sep 2017 10:51:37 +0100
Message-ID: <20170906095137.21980-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the const array header on the stack, instead make it
static.  Makes the object code smaller by over 180 bytes:

Before:
   text	   data	    bss	    dec	    hex	filename
   6003	   1536	      0	   7539	   1d73	surface3_spi.o

After:
   text	   data	    bss	    dec	    hex	filename
   5726	   1632	      0	   7358	   1cbe	surface3_spi.o

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/input/touchscreen/surface3_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/surface3_spi.c b/drivers/input/touchscreen/surface3_spi.c
index e12fb9b63f31..ecba847889b5 100644
--- a/drivers/input/touchscreen/surface3_spi.c
+++ b/drivers/input/touchscreen/surface3_spi.c
@@ -173,7 +173,7 @@ static void surface3_spi_process_pen(struct surface3_ts_data *ts_data, u8 *data)
 
 static void surface3_spi_process(struct surface3_ts_data *ts_data)
 {
-	const char header[] = {
+	static const char header[] = {
 		0xff, 0xff, 0xff, 0xff, 0xa5, 0x5a, 0xe7, 0x7e, 0x01
 	};
 	u8 *data = ts_data->rd_buf;
-- 
2.14.1
