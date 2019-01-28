From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 047/107] Input: rotary-encoder - don't log EPROBE_DEFER to kernel log
Date: Mon, 28 Jan 2019 11:18:47 -0500
Message-ID: <20190128161947.57405-47-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Uwe Kleine-König <uwe@kleine-koenig.org>

[ Upstream commit 0832e93632c61987d504e251b927a2be769dd21a ]

When a driver fails to bind because a resource it still missing it's not
helpful to report this as (usually) probing is repeated later.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/rotary_encoder.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 1588aecafff7..72eee6d55527 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -240,8 +240,10 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 
 	encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
 	if (IS_ERR(encoder->gpios)) {
-		dev_err(dev, "unable to get gpios\n");
-		return PTR_ERR(encoder->gpios);
+		err = PTR_ERR(encoder->gpios);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev, "unable to get gpios: %d\n", err);
+		return err;
 	}
 	if (encoder->gpios->ndescs < 2) {
 		dev_err(dev, "not enough gpios found\n");
-- 
2.19.1
