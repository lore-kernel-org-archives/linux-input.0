Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC2485CF5;
	Fri, 11 Sep 2026 13:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789132750; cv=none; b=oor9Gcl9C4SGI3wwBkSeyDK3Vf9EkRj1mJqSXa2SM/08POlMWCPqGe/5dOD1UauLlitx68Qlrvrt+efBJv8m+pEZsjMMGh8/xKewlwy2aSBfwFjBBgv1DvgNM2SAM94+bc4R6oywdqc0oxIlhKsrI4wq07s5ZMWeVQwXUBjL41k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789132750; c=relaxed/simple;
	bh=GcXzytzKN9oT5ZVnaueWYxC6sVn/VfV17oLTQK+fWD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6AtvnVq+d1L3J0eShmJaitOCaDv7nCEDlODjJgXQ7wxC0fa6qJ0iyaJK2iNKbjZeWoWLbsw5PABAAq5x8gFvvYgoApgcZVlY9w3nKXSd8zS8LHwJY8rpS19YnD3BzqGGXyctnAmEimucoDjjblwi0SfuCtqhZ4kFR71FyOKW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5Vpsxzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5Vpsxzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DD01F000FF;
	Fri, 11 Sep 2026 13:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789132746;
	bh=tZJSW9SnQf6T/6GcphXIvYrkgxNHzEz3N+RuxYwKqig=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=R5VpsxzxH96lMgkfIxMAhSwtTm1hpOxPfs5LEb1rLZn6N6nqWCizC9jpw82k5PnUJ
	 g9xqaVD7u9Dc5Y+xmd5zahQB9CoDOh/Djuz3EAB97M4ykfSi5ogoSuuCFpSS1l0ZrW
	 ZyDdN1Ysw5wZi36I8DbIDJEbdwqi6YC9WE5kln19Vvw9q9xtaOsmJGNk2VXMgBnNQw
	 S4tk2Ol5rAQwDJcWydWcWuC0jrx/PIab4uHs57OngoTo7LkeV1Vikj/jyGzglGHtLA
	 nqzmKehv5VWygbbJZNKgi0S/3BMwbeWd8NJIhaUTRInTfsnqf+VKrNaWUa9H6XjK8p
	 GY8DdQgDguKjg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 11 Sep 2026 15:18:28 +0200
Subject: [PATCH 2/3] Input: synaptics-rmi4: Support drm_panel_follower
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-topic-rmi4_panel_follower-v1-2-c1b2cf1cdb62@oss.qualcomm.com>
References: <20260911-topic-rmi4_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com>
In-Reply-To: <20260911-topic-rmi4_panel_follower-v1-0-c1b2cf1cdb62@oss.qualcomm.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789132733; l=8878;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=YVBgC4uCz7Vu57EVqEm4wjQijdVoYBc5xBMY9i+sAXg=;
 b=VkahASbKCJyCCT1D1J36e5+aYela7LwxLgzQFkFDUSQqvnXppSM3SIb4MI8+WmBbxceoPfimm
 MYx9RksWnDQCAXNUeesV8WHLY7BhgDBWF5af2xx/l5s37gbrg2dkW5s
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Many RMI4 implementations are present on in-cell panels with very
tight power sequencing requirements, normally handled by the DRM panel
driver in Linux.

If that doesn't take place first, the integrated touchscreen IC refuses
to work properly.

Add support for drm_panel_follower to take care of that dependency.

Assisted-by: LLM
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/input/rmi4/Kconfig   |   1 +
 drivers/input/rmi4/rmi_i2c.c | 170 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 147 insertions(+), 24 deletions(-)

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index 5db58fc9e11b..15f7534d6626 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -16,6 +16,7 @@ if RMI4_CORE
 config RMI4_I2C
 	tristate "RMI4 I2C Support"
 	depends on I2C
+	depends on DRM || !DRM
 	help
 	  Say Y here if you want to support RMI4 devices connected to an I2C
 	  bus.
diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
index e11d0acb9b96..84877030aefe 100644
--- a/drivers/input/rmi4/rmi_i2c.c
+++ b/drivers/input/rmi4/rmi_i2c.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
+#include <drm/drm_panel.h>
 #include "rmi_driver.h"
 
 #define BUFFER_SIZE_INCREMENT 32
@@ -40,6 +41,9 @@ struct rmi_i2c_xport {
 
 	struct regulator_bulk_data supplies[2];
 	u32 startup_delay;
+	struct drm_panel_follower panel_follower;
+	bool powered;
+	bool transport_registered;
 };
 
 #define RMI_PAGE_SELECT_REGISTER 0xff
@@ -187,17 +191,99 @@ static void rmi_i2c_regulator_bulk_disable(void *data)
 {
 	struct rmi_i2c_xport *rmi_i2c = data;
 
+	guard(mutex)(&rmi_i2c->page_mutex);
+
+	if (!rmi_i2c->powered)
+		return;
+
 	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
 			       rmi_i2c->supplies);
+	rmi_i2c->page = -1;
+	rmi_i2c->powered = false;
 }
 
 static void rmi_i2c_unregister_transport(void *data)
 {
 	struct rmi_i2c_xport *rmi_i2c = data;
 
+	if (!rmi_i2c->transport_registered)
+		return;
+
 	rmi_unregister_transport_device(&rmi_i2c->xport);
+	rmi_i2c->transport_registered = false;
 }
 
+static int rmi_i2c_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct rmi_i2c_xport *rmi_i2c = container_of(follower,
+						    struct rmi_i2c_xport,
+						    panel_follower);
+	int error;
+
+	error = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
+				      rmi_i2c->supplies);
+	if (error)
+		return error;
+	rmi_i2c->powered = true;
+
+	msleep(rmi_i2c->startup_delay);
+
+	/* The page-select register is reset when the sensor loses power. */
+	mutex_lock(&rmi_i2c->page_mutex);
+	error = rmi_set_page(rmi_i2c, 0);
+	mutex_unlock(&rmi_i2c->page_mutex);
+	if (error)
+		goto err_power_off;
+
+	if (rmi_i2c->transport_registered) {
+		error = rmi_driver_resume(rmi_i2c->xport.rmi_dev, false);
+		if (error) {
+			dev_warn(&rmi_i2c->client->dev,
+				 "Failed to resume device: %d\n", error);
+			rmi_driver_suspend(rmi_i2c->xport.rmi_dev, false);
+			rmi_i2c_regulator_bulk_disable(rmi_i2c);
+		}
+		return error;
+	}
+
+	dev_info(&rmi_i2c->client->dev,
+		 "registering I2C-connected sensor\n");
+
+	error = rmi_register_transport_device(&rmi_i2c->xport);
+	if (error)
+		goto err_power_off;
+
+	rmi_i2c->transport_registered = true;
+	return 0;
+
+err_power_off:
+	rmi_i2c_regulator_bulk_disable(rmi_i2c);
+	return error;
+}
+
+static int rmi_i2c_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct rmi_i2c_xport *rmi_i2c = container_of(follower,
+						    struct rmi_i2c_xport,
+						    panel_follower);
+	int error = 0;
+
+	if (rmi_i2c->transport_registered) {
+		error = rmi_driver_suspend(rmi_i2c->xport.rmi_dev, false);
+		if (error)
+			dev_warn(&rmi_i2c->client->dev,
+				 "Failed to suspend device: %d\n", error);
+	}
+	rmi_i2c_regulator_bulk_disable(rmi_i2c);
+
+	return error;
+}
+
+static const struct drm_panel_follower_funcs rmi_i2c_panel_follower_funcs = {
+	.panel_prepared = rmi_i2c_panel_prepared,
+	.panel_unpreparing = rmi_i2c_panel_unpreparing,
+};
+
 static int rmi_i2c_probe(struct i2c_client *client)
 {
 	struct rmi_device_platform_data *pdata;
@@ -235,10 +321,12 @@ static int rmi_i2c_probe(struct i2c_client *client)
 	if (error < 0)
 		return error;
 
-	error = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
-				       rmi_i2c->supplies);
-	if (error < 0)
-		return error;
+	of_property_read_u32(client->dev.of_node, "syna,startup-delay-ms",
+			     &rmi_i2c->startup_delay);
+
+	rmi_i2c->client = client;
+	mutex_init(&rmi_i2c->page_mutex);
+	rmi_i2c->page = -1;
 
 	error = devm_add_action_or_reset(&client->dev,
 					  rmi_i2c_regulator_bulk_disable,
@@ -246,27 +334,53 @@ static int rmi_i2c_probe(struct i2c_client *client)
 	if (error)
 		return error;
 
-	of_property_read_u32(client->dev.of_node, "syna,startup-delay-ms",
-			     &rmi_i2c->startup_delay);
-
-	msleep(rmi_i2c->startup_delay);
-
-	rmi_i2c->client = client;
-	mutex_init(&rmi_i2c->page_mutex);
-
 	rmi_i2c->xport.dev = &client->dev;
 	rmi_i2c->xport.proto_name = "i2c";
 	rmi_i2c->xport.ops = &rmi_i2c_ops;
 
 	i2c_set_clientdata(client, rmi_i2c);
 
+	error = devm_add_action_or_reset(&client->dev,
+					  rmi_i2c_unregister_transport,
+					  rmi_i2c);
+	if (error)
+		return error;
+
+	if (drm_is_panel_follower(&client->dev)) {
+		rmi_i2c->panel_follower.funcs = &rmi_i2c_panel_follower_funcs;
+
+		if (device_can_wakeup(&client->dev)) {
+			dev_warn(&client->dev,
+				 "Can't wakeup if following panel\n");
+			device_set_wakeup_capable(&client->dev, false);
+		}
+
+		error = devm_drm_panel_add_follower(&client->dev,
+						     &rmi_i2c->panel_follower);
+		if (error)
+			return error;
+
+		return 0;
+	}
+
+	error = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
+				      rmi_i2c->supplies);
+	if (error)
+		return error;
+	rmi_i2c->powered = true;
+
+	msleep(rmi_i2c->startup_delay);
+
 	/*
 	 * Setting the page to zero will (a) make sure the PSR is in a
 	 * known state, and (b) make sure we can talk to the device.
 	 */
+	mutex_lock(&rmi_i2c->page_mutex);
 	error = rmi_set_page(rmi_i2c, 0);
+	mutex_unlock(&rmi_i2c->page_mutex);
 	if (error) {
 		dev_err(&client->dev, "Failed to set page select to 0\n");
+		rmi_i2c_regulator_bulk_disable(rmi_i2c);
 		return error;
 	}
 
@@ -275,14 +389,10 @@ static int rmi_i2c_probe(struct i2c_client *client)
 	error = rmi_register_transport_device(&rmi_i2c->xport);
 	if (error) {
 		dev_err(&client->dev, "failed to register sensor: %d\n", error);
+		rmi_i2c_regulator_bulk_disable(rmi_i2c);
 		return error;
 	}
-
-	error = devm_add_action_or_reset(&client->dev,
-					  rmi_i2c_unregister_transport,
-					  rmi_i2c);
-	if (error)
-		return error;
+	rmi_i2c->transport_registered = true;
 
 	return 0;
 }
@@ -293,12 +403,14 @@ static int rmi_i2c_suspend(struct device *dev)
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
 	int ret;
 
+	if (rmi_i2c->panel_follower.panel)
+		return 0;
+
 	ret = rmi_driver_suspend(rmi_i2c->xport.rmi_dev, true);
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
-	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
-			       rmi_i2c->supplies);
+	rmi_i2c_regulator_bulk_disable(rmi_i2c);
 
 	return ret;
 }
@@ -309,10 +421,14 @@ static int rmi_i2c_resume(struct device *dev)
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
 	int ret;
 
+	if (rmi_i2c->panel_follower.panel)
+		return 0;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
-				    rmi_i2c->supplies);
+				   rmi_i2c->supplies);
 	if (ret)
 		return ret;
+	rmi_i2c->powered = true;
 
 	msleep(rmi_i2c->startup_delay);
 
@@ -329,12 +445,14 @@ static int rmi_i2c_runtime_suspend(struct device *dev)
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
 	int ret;
 
+	if (rmi_i2c->panel_follower.panel)
+		return 0;
+
 	ret = rmi_driver_suspend(rmi_i2c->xport.rmi_dev, false);
 	if (ret)
 		dev_warn(dev, "Failed to resume device: %d\n", ret);
 
-	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
-			       rmi_i2c->supplies);
+	rmi_i2c_regulator_bulk_disable(rmi_i2c);
 
 	return 0;
 }
@@ -345,10 +463,14 @@ static int rmi_i2c_runtime_resume(struct device *dev)
 	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
 	int ret;
 
+	if (rmi_i2c->panel_follower.panel)
+		return 0;
+
 	ret = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
-				    rmi_i2c->supplies);
+				   rmi_i2c->supplies);
 	if (ret)
 		return ret;
+	rmi_i2c->powered = true;
 
 	msleep(rmi_i2c->startup_delay);
 

-- 
2.55.0

