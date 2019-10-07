From: Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 1/3] Input: mms114 - use device_get_match_data
Date: Mon,  7 Oct 2019 22:33:41 +0200
Message-ID: <20191007203343.101466-2-stephan@gerhold.net>
References: <20191007203343.101466-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007203343.101466-1-stephan@gerhold.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
List-Id: linux-input@vger.kernel.org

device_get_match_data is available now, so we can replace the call
to of_device_get_match_data and remove the FIXME comment.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/input/touchscreen/mms114.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index a5ab774da4cc..69c6d559eeb0 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -446,8 +446,7 @@ static int mms114_probe(struct i2c_client *client,
 	data->client = client;
 	data->input_dev = input_dev;
 
-	/* FIXME: switch to device_get_match_data() when available */
-	match_data = of_device_get_match_data(&client->dev);
+	match_data = device_get_match_data(&client->dev);
 	if (!match_data)
 		return -EINVAL;
 
-- 
2.23.0
