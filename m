Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020F244665;
	Sun,  1 Mar 2026 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328173; cv=none; b=L41yW2L34eLGmyLpv2MjjbHLzwSFUH1Ok+GN1s6ah6uMsB+xb2B/gAAH+FxKEf5uiGgBDI7lbn8JB7I0cKW3XRvyzbANehVqXlh6Ug0hfYZtpDWBiqaJfSdVRuHubZuuqEXAOPMKQgyD1xGUXdyK/H8LM4v8JBePPeQYwJmZ1gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328173; c=relaxed/simple;
	bh=eooLo3EGgRbkNhCKvM0IUV8ZLLqutmMOmqp90MFCuH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ln4YypMmqH/BQSlQG9W9gK8U9zt4d5LCU2VUTXaehuEgyFpIxXQclryS4e3YYNLECaqJ+sc/i85DWUqQ6H5hVCqV9cJ2qQGQ+A7PxPDK3ky+w9MrHkdZZ6maJKt//Zx4EfMhpis3mn9wskMv8+MhT2ooEqjp67uEDOJ4IdJMPCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCSOC3se; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCSOC3se"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9B1C19424;
	Sun,  1 Mar 2026 01:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328173;
	bh=eooLo3EGgRbkNhCKvM0IUV8ZLLqutmMOmqp90MFCuH0=;
	h=From:To:Cc:Subject:Date:From;
	b=GCSOC3sep+oTaPC5N/PT44vSxYqZU8Dvf86I2iDtypUn9K2hviJqHHWX3fIbfGeUM
	 BEVNVEZy8w3bBqwXnDClMK70/F3vq4A8LRBUOPdjSjI1XKaULFTM70xjLxMir+FGM1
	 D3sXIsUNi7+0p+KO+lgCxOYNAGusOoE3i/v/LAstY5nFAB8xku95dWLh/eYP2kS4T2
	 dND49HnidMGJXO46dUkxY3uSynLnzdHJC+kjKUa76ub97bXx1jcotcIFkhaHX89RME
	 KsMHVoxm8BahfRVcJsyi+8iN32aqGmyVp7HPojcPVa5+cJkTxHTAk+PkDaJUkrdsY7
	 FHA6fCuY9CpNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ii4gsp@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "Input: synaptics_i2c - guard polling restart in resume" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:22:51 -0500
Message-ID: <20260301012251.1679409-1-sashal@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
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




