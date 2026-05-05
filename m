Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1407AE571
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 04:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956896; cv=none; b=QtyrKjwj4xxfPjIE5OByxQjWtc6TjiU/5WCmecKCq4UQq0/JYEENciH9IskTGVXa6wLIWYp5vP5fZgi+cMiIJ02NPM5EC+N7QyMr0C8x5HxKlp4XZzGZMjtiP4PvkN11/sZJspcJtsBedrYuJJeSogzFbN5YkzfKGuDk1yHTy54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956896; c=relaxed/simple;
	bh=0MtYgSj/NitZn5u6OtEpC3+gcIoCllGRGm3ph1ThnIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bBfRUq3C8Yq2rBh9WCHdPGmxvMgPE7ntjRxXftM8p6ml4rYpDLRKQ+LQQqBYqHT4H+N7yQr22vIHQ0qouA3FcUwcDQYEFtiN8qb8ZB03CROORdKFuWZIZpLsgGAKl61d4Wl8pldyNTByQ85Ym6J0FiV+UTXpFcuFzSBnaWb6Qnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEuGPt54; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEuGPt54"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2ef8d6ba48bso1808370eec.1
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 21:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777956894; x=1778561694; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEEAW3YT8FmhRJfj7wfLubyLNhdaKFHK0+eDQ6GzjtM=;
        b=SEuGPt54oR3XcDXElA/X4CF7jfDe8X2zakcDFYzBEdphHtckArekNXIrtLj1DSqMgd
         VG0vmPp7BHDVNwmXlsEmvyyud1TrUQhPHT5UmiUj2ajU7pjmAur2mFdKGiJKffKH0Q8g
         Oet04jet1Hg9t50CODfXq95WD9UuIFpOumo56zL8rtogN/+8dkqaUqUQtM+Buwzhuj+G
         i5k2sAtROvEfoUTNQzIAQ+bcf6i/mJX3z9Sc6+DbK+NoisZL+STcJi/J1Jd24t0WQ05M
         g8paovPa8Cfq3RLf7ErX2yJDTqef0uFEMbopPIkW3U8TghS/FAcIa9nKEXzFJ+RGijpd
         UxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777956894; x=1778561694;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEEAW3YT8FmhRJfj7wfLubyLNhdaKFHK0+eDQ6GzjtM=;
        b=G84hRZRu8r65hKQCLU0g9/WDWaNjCfzdPYi9Y8h9IumcKQE3hTGz8r3Y2pGfH99KCy
         6Ojd9Ts5JlNakllNTo0ZSS5zNeGt5NhVXm2WvUQD5NvJZN+LtlHwE0YJbFR+A/ToMApV
         U1GoPdYu37CjlC2qA7p199/jB6VYO4e0Gi7K0ecNJPilAFTRBEPzT2QOmKl3buMFmybG
         JSwDA9F86ta2Fvq8+H/XH7mLyGbvNMy1Zl2hubzqpY2nUqv73C4plsRYBaWV2Iya97gM
         6xX9TZRi53X5sfKABmy5nMcabS3qyod0hJUj3UhGzmzHRUEbUjYihAc+HkAQsDzdLnYI
         sK/g==
X-Gm-Message-State: AOJu0YxB1xJSMz4Z9HHM4nIQdUVulhvFJkI7ArVx8NplzShftyAofz9/
	JJEEIv4VCsfmn2HG1hPdwrhGOCh2wuLaw80oAXHe+fZah4kYSl7aTsrNAvUCWw==
X-Gm-Gg: AeBDiesmxlDVIxCc2gsI5sLmE+twdrMS2RyAEs0v+TXqWdEOZEvv8nmJtpo/milx66m
	b6lbIvOb8U67jemEc7bbNZRj6NQiuvXa2T3tNjb2URDDpVo2H4z1Gz1HOGwluF2YOpk2IAZXMh/
	lSKPOdF+B3f0tgAufdoFjppLu83pSw2fvtd6ifRaDCKk3hG05TzuViz7wLFlmgchcMCxAnxlzx8
	lLicCvA+R1QAR998ktpNmzERO9lZBrWn0jPMAIfb+AHkfb97A63DyYIP34zDG+Dj5wsKKg5pgUn
	6rPqaEp8VwlPpSf4F+YSG9EoqEkxBrodaRdejypfmwfhS2m91yDMzBoN/zKbDfO0nK2kkbVvU0s
	OXjeFI5Phx0nPihz3r+cC4PojFhmn6qCSQlYBztjnpIM/HhEJ6BBaAV0rSMpVXFSgpGSoVKqUld
	JgRHjVugB3Y7epiGDFmEWRa6bFUXOkKse+M/mHInr6rzh9FI/kzkEp1H9rS5134XLEyVS6FreW5
	BM=
X-Received: by 2002:a05:7300:ca8:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-2f3d079b5c9mr1185466eec.11.1777956893334;
        Mon, 04 May 2026 21:54:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889cf53sm24669389eec.5.2026.05.04.21.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 21:54:52 -0700 (PDT)
Date: Mon, 4 May 2026 21:54:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Mark Featherston <mark@embeddedts.com>, Kris Bahnsen <kris@embeddedts.com>, 
	Marek Vasut <marex@nabladev.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ads7846 - consolidate coordinate filtering logic
Message-ID: <afl3WtbabMFNjE24@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The ads7846 driver has two separate filtering functions,
ads7846_filter() and ads7846_filter_one(), for the full-duplex and
half-duplex SPI paths, respectively.

They can be consolidated by extracting the core filtering logic for a
single command into a helper function, ads7846_filter_cmd(), which
iterates from l->skip to l->count. The half-duplex setup function is
updated to set l->skip = l->count - 1 so that the helper only processes
the last sample, preserving the original half-duplex behavior.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Not tested so will appreciate if someone could give it a spin.

 drivers/input/touchscreen/ads7846.c | 74 +++++++++++++++--------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index d3b529333ca2..093f4b56cc18 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -759,52 +759,54 @@ static bool ads7846_cmd_need_settle(enum ads7846_cmds cmd_idx)
 	return false;
 }
 
-static int ads7846_filter(struct ads7846 *ts)
+static int ads7846_filter_cmd(struct ads7846 *ts, unsigned int cmd_idx)
 {
 	struct ads7846_packet *packet = ts->packet;
-	int action;
-	int val;
-	unsigned int cmd_idx, b;
+	struct ads7846_buf_layout *l = &packet->l[cmd_idx];
+	unsigned int b;
 
-	packet->ignore = false;
-	for (cmd_idx = packet->last_cmd_idx; cmd_idx < packet->cmds - 1; cmd_idx++) {
-		struct ads7846_buf_layout *l = &packet->l[cmd_idx];
+	for (b = l->skip; b < l->count; b++) {
+		int val = ads7846_get_value(&packet->rx[l->offset + b]);
 
-		packet->last_cmd_idx = cmd_idx;
+		switch (ts->filter(ts->filter_data, cmd_idx, &val)) {
+		case ADS7846_FILTER_REPEAT:
+			if (b == l->count - 1)
+				return -EAGAIN;
+			break;
 
-		for (b = l->skip; b < l->count; b++) {
-			val = ads7846_get_value(&packet->rx[l->offset + b]);
-
-			action = ts->filter(ts->filter_data, cmd_idx, &val);
-			if (action == ADS7846_FILTER_REPEAT) {
-				if (b == l->count - 1)
-					return -EAGAIN;
-			} else if (action == ADS7846_FILTER_OK) {
-				ads7846_set_cmd_val(ts, cmd_idx, val);
-				break;
-			} else {
-				packet->ignore = true;
-				return 0;
-			}
+		case ADS7846_FILTER_OK:
+			ads7846_set_cmd_val(ts, cmd_idx, val);
+			return 0;
+
+		case ADS7846_FILTER_IGNORE:
+		default:
+			return -EIO;
 		}
 	}
 
-	return 0;
+	return -EIO;
 }
 
-static int ads7846_filter_one(struct ads7846 *ts, unsigned int cmd_idx)
+static int ads7846_filter(struct ads7846 *ts)
 {
 	struct ads7846_packet *packet = ts->packet;
-	struct ads7846_buf_layout *l = &packet->l[cmd_idx];
-	int action, val;
-
-	val = ads7846_get_value(&packet->rx[l->offset + l->count - 1]);
-	action = ts->filter(ts->filter_data, cmd_idx, &val);
-	if (action == ADS7846_FILTER_REPEAT)
-		return -EAGAIN;
-	else if (action != ADS7846_FILTER_OK)
-		return -EIO;
-	ads7846_set_cmd_val(ts, cmd_idx, val);
+	unsigned int cmd_idx;
+	int error;
+
+	packet->ignore = false;
+	for (cmd_idx = packet->last_cmd_idx; cmd_idx < packet->cmds - 1; cmd_idx++) {
+		packet->last_cmd_idx = cmd_idx;
+
+		error = ads7846_filter_cmd(ts, cmd_idx);
+		if (error) {
+			if (error == -EAGAIN)
+				return -EAGAIN;
+
+			packet->ignore = true;
+			return 0;
+		}
+	}
+
 	return 0;
 }
 
@@ -857,7 +859,7 @@ static void ads7846_halfd_read_state(struct ads7846 *ts)
 		if (msg_idx == ts->msg_count - 1)
 			break;
 
-		error = ads7846_filter_one(ts, msg_idx);
+		error = ads7846_filter_cmd(ts, msg_idx);
 		if (error == -EAGAIN) {
 			continue;
 		} else if (error) {
@@ -1119,7 +1121,7 @@ static int ads7846_halfd_spi_msg(struct ads7846 *ts,
 		l->offset = offset;
 		offset += max_count;
 		l->count = max_count;
-		l->skip = 0;
+		l->skip = max_count - 1;
 		size += sizeof(*packet->rx) * max_count;
 	}
 
-- 
2.54.0.545.g6539524ca2-goog


-- 
Dmitry
