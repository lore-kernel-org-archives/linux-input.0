From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv4 1/4] mfd: da9052: fix manual ADC read after timed out read
Date: Fri, 30 Jun 2017 16:35:03 +0200
Message-ID: <20170630143506.10541-2-sebastian.reichel@collabora.co.uk>
References: <20170630143506.10541-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170630143506.10541-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

It is possible that under heavy system load, the counter in the completion
struct, used for waiting for end of AD conversion, gets incremented twice.
To make sure the driver recovers from this situation, the completion struct
should be reinitialized.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/mfd/da9052-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
index a88c2065d8ab..977418ca9117 100644
--- a/drivers/mfd/da9052-core.c
+++ b/drivers/mfd/da9052-core.c
@@ -386,6 +386,8 @@ int da9052_adc_manual_read(struct da9052 *da9052, unsigned char channel)
 
 	mutex_lock(&da9052->auxadc_lock);
 
+	reinit_completion(&da9052->done);
+
 	/* Channel gets activated on enabling the Conversion bit */
 	mux_sel = chan_mux[channel] | DA9052_ADC_MAN_MAN_CONV;
 
-- 
2.11.0
