Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B52FC89C;
	Sun,  1 Mar 2026 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329896; cv=none; b=kMDMm9Y221EeuOU66/QcGcF0/AIqzXXGA2Age804mlHdKwkhgu5IrGTDWJODTfhDdNKRiddctEgNPdEBZ/vCemKfEOvVMIc9y6BeNko16n7+ZHs2k7Ri0XjXOXvzVZeM2ND5+qdFN3KiCgLiXSULNoPi2yOZtpuAfSMu4f8eMG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329896; c=relaxed/simple;
	bh=4mooUjkFYtVwuPe1sqeZO0h770fCHiODOMfNXps+jHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LLa3gURD+1j59LSsLnqUEvBMjSI7S+dR3Yw2NtyvUJOrzVGr4+GtYN+yuHo0biiLT55Urk6U1V9TnSCWQY5EEBEoTC8/D8QVpnABLYrdD/JJMrHE9AQ/RU0YSU6/cXFparrE19wsPHKT9xDyQXDI2DF0FF5Obz5NFuAqttbczao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pk+IbEzN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pk+IbEzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAF6C19421;
	Sun,  1 Mar 2026 01:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329895;
	bh=4mooUjkFYtVwuPe1sqeZO0h770fCHiODOMfNXps+jHc=;
	h=From:To:Cc:Subject:Date:From;
	b=Pk+IbEzN+ZoxMklqFavmZVNm0tPOSIkXDpKlRlRuDHwjAzylRxSOlQXSEXPxNhsn4
	 bRxtjHkNCtGBSGHATWPdA15QlgwFr4XzRaeGYJRnfrcJlIlRJNgU5IRwyO7sLI+EI7
	 E2fBGJSBzKOgdw1wbbalHaakG5ravi8h0tH8FhCHspz/aCWseqydSwB45uMTA6L0wJ
	 dCz2U07daOVu7MqsL9PPdps8KqINJoZUrVmDsNwV7GRCgKOMS4dpZ/QDbVbmb2Jl+r
	 NgsE3pmmeRzMrh91NYuzvZ2RPnUqHEHrIMsixiq26UbNa+VGWfyJFrcv0SaXeQsILk
	 7Ism71A1MZoqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ii4gsp@gmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "Input: synaptics_i2c - guard polling restart in resume" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:51:33 -0500
Message-ID: <20260301015134.1717924-1-sashal@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
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




