Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B9145A1F;
	Sun,  1 Mar 2026 01:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329391; cv=none; b=E+no8tttZtJd7btbZfSTFokTkF3mpvsVaYvOd3Jh5311ZWwUxRh6gu7gRzUl5dkR5yPPzrpwubAeN/vnAH67po+CXCiN/PVkQ+3Q3y78N8luZb4vPf1ViAkxcWpD2XSodDiBbr68tZy0m7Wayzy3ACcCokXAtaxO8b+gUs//xFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329391; c=relaxed/simple;
	bh=1+XTJke1DbiPrAZMQqdYbiZD6BSt71twytbbYtuUiqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qEdrtDvky4M41WV06/p6b6VqJprhP5/vrvgzp5nG0cDtTpwSlV4wHhBnEriyGjGG3IXzU31dg0Uw9nUxG4JE1wu9btE6zPMURDWr6oDTD2609IQOobA++XNe2oFxXXBYvmAwsFrimcYUBDfBag7VQI3B6sxLV6hkO6hShfKhPvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ST5zjSXw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ST5zjSXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77A3C19421;
	Sun,  1 Mar 2026 01:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329391;
	bh=1+XTJke1DbiPrAZMQqdYbiZD6BSt71twytbbYtuUiqM=;
	h=From:To:Cc:Subject:Date:From;
	b=ST5zjSXwXYf7P88Umv7mTSwaq+h6RI0MucQnMw0kFOjifVmbb98772iEjkaQ3v+JB
	 WS8WltnjAez8qlQgufqo3oQCjWIYXD4C3n3A/tLsv+ZMWBZrmc6wuWwP9pP2/edXXj
	 2L+488yd7BGdul9fGDAHpGii+qQMQHhMWStSnox4u1pvclE+Qstbkop1+Na+8s3NXa
	 NjiWC1ILhBNQSrQKciQh9e5yuugmBGSHR+tcTG54SNT8Sajsmt044hAsN2F6fQaQEh
	 3YL9dlLHXvtlbsCfEXq2NCIUjUOuKl2P4MQD7pcyJwyyswdbVlWzwQFXoh6kBUkCNr
	 ke1FM8Jip3abQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ii4gsp@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "Input: synaptics_i2c - guard polling restart in resume" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:43:09 -0500
Message-ID: <20260301014309.1705189-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 870c2e7cd881d7a10abb91f2b38135622d9f9f65 Mon Sep 17 00:00:00 2001
From: Minseong Kim <ii4gsp@gmail.com>
Date: Wed, 21 Jan 2026 10:02:02 -0800
Subject: [PATCH] Input: synaptics_i2c - guard polling restart in resume

synaptics_i2c_resume() restarts delayed work unconditionally, even when
the input device is not opened. Guard the polling restart by taking the
input device mutex and checking input_device_enabled() before re-queuing
the delayed work.

Fixes: eef3e4cab72ea ("Input: add driver for Synaptics I2C touchpad")
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260121063738.799967-1-ii4gsp@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index c8ddfff2605ff..29da66af36d74 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -615,13 +615,16 @@ static int synaptics_i2c_resume(struct device *dev)
 	int ret;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct synaptics_i2c *touch = i2c_get_clientdata(client);
+	struct input_dev *input = touch->input;
 
 	ret = synaptics_i2c_reset_config(client);
 	if (ret)
 		return ret;
 
-	mod_delayed_work(system_dfl_wq, &touch->dwork,
-				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
+	guard(mutex)(&input->mutex);
+	if (input_device_enabled(input))
+		mod_delayed_work(system_dfl_wq, &touch->dwork,
+				 msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
 }
-- 
2.51.0




