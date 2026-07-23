Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640093D954D;
	Thu, 23 Jul 2026 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834687; cv=none; b=uIgQ/yr5daA5T/eAFKt5UXC6T8ZGKOCmt3bLuY7xuphnTRm/qLPITEDEAcwN7k3CONLacpReAmpxzm2JLCZGe/JhG14GK77ziokxpHFfLtk8VgAWzSH/q+nyV37Db26tixWqSLa7Gi2crW2d73ZXOD8rfmtdag+meTQxA90+ag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834687; c=relaxed/simple;
	bh=SbIfnvgSjJKlnfJuMv2bCPAWMoq+L0ZH2BQgEn9//Uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tuIZkFJuRB5BqDMqrA+ICeJutKko/99o4h4pIdMtoslp6d0K+iP2CyJrEFZITvYRviZiDdNEHmhcVlvB3owRt6zAheWzhuMGdUkHD928s1XQ4LmeMYBlkpQhfNUWssXvT2GMAR/pUjzMjDvNchjzR3fjlnJNKDERZ1lBWcxu1sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XE5iYapV; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XE5iYapV"
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DE2EB9D86D;
	Thu, 23 Jul 2026 21:24:43 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nv_NDWa0Tz9x; Thu, 23 Jul 2026 21:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1784834683; bh=SbIfnvgSjJKlnfJuMv2bCPAWMoq+L0ZH2BQgEn9//Uo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XE5iYapVu+jR+7F/FAMsNEo5Vi9OASVv9c3qYfW0x+tRvh6LC0BJ7SwKgFdXOYMUT
	 XX1KOvqsGlirZfx5eSYxO7UUQbfJOLEYV7hy81EEMOAgOJYI0Fp6zOK2n/J7ggxWfR
	 Nte+Xjca8f7V4sVH+gEKFk2KuWNgdvdCm6CsIPQ5kCjxccdC7uzkF/CHHXHiKlfkBc
	 vNqpwB7M7unl+blyOZA5/uFKnx+Nw+tYL7j75w/6sdXwSnukMdpHpV5pouYk1MILZ6
	 x9yRbEGqPAA6pNS0noEiMJ/aDUgA1xEAfjIqbNkB9mQn8cDgdgI6Y3yyDLF4Au2xWU
	 x/HG6xFM3VYHA==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 24 Jul 2026 00:54:05 +0530
Subject: [PATCH 3/5] Input: zinitix - add support for modes 0 and 1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-zinitix-modes-v1-3-f6df7d86a878@disroot.org>
References: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
In-Reply-To: <20260724-zinitix-modes-v1-0-f6df7d86a878@disroot.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michael Srba <Michael.Srba@seznam.cz>, 
 Linus Walleij <linusw@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, 
 Kaustabh Chakraborty <kauschluss@disroot.org>

Zinitix touchscreens have three modes, numbered 0 to 2. The driver
implements mode 2, and leaves out modes 0 and 1. The difference in the
touchscreen modes is the schema of the event data.

Implement modes 0 and 1 in the driver, along with their event structs.
Maintain a common, canonical event struct which is to be the superset of
the mode-specific structs. With that, introduce functions to convert the
mode event info to the canonical format.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/input/touchscreen/zinitix.c | 138 +++++++++++++++++++++++++++++++++---
 1 file changed, 130 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index fdcb80f52c91..42010f23445e 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -145,7 +145,37 @@ struct point_coord {
 	u8	angle;
 };
 
+struct point_coord_mode0 {
+	__le16	x;
+	__le16	y;
+	u8	width;
+	u8	sub_status;
+};
+
 struct touch_event {
+	__le16	status;
+	__le16	event_flag;
+	u8	finger_mask;
+	u8	time_stamp;
+	struct point_coord point_coord[MAX_SUPPORTED_FINGER_NUM];
+};
+
+struct touch_event_mode0 {
+	__le16	status;
+	u8	finger_mask;
+	u8	time_stamp;
+	struct point_coord_mode0 point_coord[MAX_SUPPORTED_FINGER_NUM];
+};
+
+struct touch_event_mode1 {
+	__le16	status;
+	__le16	event_flag;
+	u8	finger_mask;
+	u8	time_stamp;
+	struct point_coord_mode0 point_coord[MAX_SUPPORTED_FINGER_NUM];
+};
+
+struct touch_event_mode2 {
 	__le16	status;
 	u8	finger_mask;
 	u8	time_stamp;
@@ -440,6 +470,103 @@ static void zinitix_report_keys(struct bt541_ts_data *bt541, u16 icon_events)
 				 bt541->keycodes[i], icon_events & BIT(i));
 }
 
+static int zinitix_read_point_status_mode0(struct bt541_ts_data *bt541,
+					   struct touch_event *event)
+{
+	struct touch_event_mode0 event_mode0;
+	int ret;
+	int i;
+
+	ret = zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
+				&event_mode0, sizeof(struct touch_event_mode0));
+	if (ret)
+		return ret;
+
+	event->status = event_mode0.status;
+	event->finger_mask = event_mode0.finger_mask;
+	event->time_stamp = event_mode0.time_stamp;
+
+	for (i = 0; i < ARRAY_SIZE(event_mode0.point_coord); i++) {
+		event->point_coord[i].x = event_mode0.point_coord[i].x;
+		event->point_coord[i].y = event_mode0.point_coord[i].y;
+		event->point_coord[i].width = event_mode0.point_coord[i].width;
+		event->point_coord[i].sub_status = event_mode0.point_coord[i].sub_status;
+	}
+
+	return 0;
+}
+
+static int zinitix_read_point_status_mode1(struct bt541_ts_data *bt541,
+					   struct touch_event *event)
+{
+	struct touch_event_mode1 event_mode1;
+	int ret;
+	int i;
+
+	ret = zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
+				&event_mode1, sizeof(struct touch_event_mode1));
+	if (ret)
+		return ret;
+
+	event->status = event_mode1.status;
+	event->event_flag = event_mode1.event_flag;
+	event->finger_mask = event_mode1.finger_mask;
+	event->time_stamp = event_mode1.time_stamp;
+
+	for (i = 0; i < ARRAY_SIZE(event_mode1.point_coord); i++) {
+		event->point_coord[i].x = event_mode1.point_coord[i].x;
+		event->point_coord[i].y = event_mode1.point_coord[i].y;
+		event->point_coord[i].width = event_mode1.point_coord[i].width;
+		event->point_coord[i].sub_status = event_mode1.point_coord[i].sub_status;
+	}
+
+	return 0;
+}
+
+static int zinitix_read_point_status_mode2(struct bt541_ts_data *bt541,
+					   struct touch_event *event)
+{
+	struct touch_event_mode2 event_mode2;
+	int ret;
+	int i;
+
+	ret = zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
+				&event_mode2, sizeof(struct touch_event_mode2));
+	if (ret)
+		return ret;
+
+	event->status = event_mode2.status;
+	event->finger_mask = event_mode2.finger_mask;
+	event->time_stamp = event_mode2.time_stamp;
+
+	for (i = 0; i < ARRAY_SIZE(event_mode2.point_coord); i++) {
+		event->point_coord[i].x = event_mode2.point_coord[i].x;
+		event->point_coord[i].y = event_mode2.point_coord[i].y;
+		event->point_coord[i].width = event_mode2.point_coord[i].width;
+		event->point_coord[i].sub_status = event_mode2.point_coord[i].sub_status;
+		event->point_coord[i].minor_width = event_mode2.point_coord[i].minor_width;
+		event->point_coord[i].angle = event_mode2.point_coord[i].angle;
+	}
+
+	return 0;
+}
+static int zinitix_read_point_status(struct bt541_ts_data *bt541,
+				     struct touch_event *event)
+{
+	switch (bt541->zinitix_mode) {
+	case 0:
+		return zinitix_read_point_status_mode0(bt541, event);
+	case 1:
+		return zinitix_read_point_status_mode1(bt541, event);
+	case 2:
+		return zinitix_read_point_status_mode2(bt541, event);
+	default:
+		dev_err(&bt541->client->dev, "Mode %d is unsupported\n",
+			bt541->zinitix_mode);
+		return -EINVAL;
+	}
+}
+
 static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 {
 	struct bt541_ts_data *bt541 = bt541_handler;
@@ -451,8 +578,7 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, void *bt541_handler)
 
 	memset(&touch_event, 0, sizeof(struct touch_event));
 
-	error = zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
-				  &touch_event, sizeof(struct touch_event));
+	error = zinitix_read_point_status(bt541, &touch_event);
 	if (error) {
 		dev_err(&client->dev, "Failed to read in touchpoint struct\n");
 		goto out;
@@ -682,13 +808,9 @@ static int zinitix_ts_probe(struct i2c_client *client)
 		bt541->zinitix_mode = DEFAULT_TOUCH_POINT_MODE;
 	}
 
-	if (bt541->zinitix_mode != 2) {
-		/*
-		 * If there are devices that don't support mode 2, support
-		 * for other modes (0, 1) will be needed.
-		 */
+	if (bt541->zinitix_mode > 2) {
 		dev_err(&client->dev,
-			"Malformed zinitix,mode property, must be 2 (supplied: %d)\n",
+			"Malformed zinitix,mode property, must be 0, 1, or 2 (supplied: %d)\n",
 			bt541->zinitix_mode);
 		return -EINVAL;
 	}

-- 
2.54.0

