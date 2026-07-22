Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1E135C693;
	Wed, 22 Jul 2026 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784713027; cv=none; b=GSYjnzL+b7LAYXfzqgZrSQXr5xX9DJIpVONhjUD0SxroA1oQYJJougF+TkHp5LMfWrQRccdhMIMaLXH2mjr9mNVE7KQUsvn6NmGrTXijKtml91vbSHYiskhNLXlJSlRonJYhqAYcIpkLQxV2bJBvnqqe1drUUsLkVkR6floYj0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784713027; c=relaxed/simple;
	bh=IZh+pE9qoWoEBTBUE6fYLUCDLfe4MjG0lzWnjN/GIC0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=JanWaDsi5F3jNYHy8T4XVWDoD5LZ43q7PN8G7hrds2JOuFR/0T9OgBhP7LKMTQ6DRjPTTO1vRcPC223fpMemAfRSVdwvgi8rriuJN22y8uXvxDSljjUeCh8E95n7Fx6oDjuzae5nBqAFUAVMADtpKnti1YB0cFafkVsBOIsB5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=l9w2vSM6; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="l9w2vSM6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784713017; bh=prqAjhaEMwHmx2h/HBgdhETvfb0ppwAJiqabQIu5MQU=;
	h=From:To:Cc:Subject:Date;
	b=l9w2vSM6rEBq/ikNiJbGbtCsgQnfKfXIUSQo0eVSAT7HmSO5kGlKQh/YXOgKPRxPM
	 6vJQ73Xfu5Zcdmkb9eGghTCUPlDDhAD5j0iMaskvBh3RtgqtnTPAO//zRaDi0MKfjv
	 A6BP5Y69pk7Pl3YWQGJXgSv/ufK3nJ9+WMsWGPyY=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 936AC4CE; Wed, 22 Jul 2026 17:36:54 +0800
X-QQ-mid: xmsmtpt1784713014tsro1dzxr
Message-ID: <tencent_FE1CA7ED99022E1734F8C9CAB538AB477405@qq.com>
X-QQ-XMAILINFO: M9eC8NU3qAcE94b8wam0z3Q1WQxHAaOGcdQ5YxfDz21Q5eidVg8rbcv93Ixgfp
	 N+He4Kes+mrUto/2BZqLYm75qLU2+tmdlGOpm3MA8m8itVF/XyXUP2Ej+tBKufIgERlkaK9afc93
	 +VNYgaq8DaZNMUSqxfiAlLH0/w/lQPULpM0wHFksCgPgHUaTemAl6vCDnz21LxrmADqvg4j3QgQo
	 n8Q9HdaD/4IfrjihCigdre+/HmJF5hqzNuucIYIG5gH1TylklavVpkpwpHvNzQE8ZjeBBepX45T5
	 G9UYPnBRjFHYnacLokA3Dx6aw2ikfEmMBESklx5RLLFutT+HnJVNUEhjOiC680R82HhQCqzsP9eX
	 s6jVuCLa7tPbynbvSZ/gVxBLP7i34ZAUw4UKu91XKL++ZNn1p+m4uAdWaC3QLGDgOND2jwgJBV3r
	 BpX/yXxiKAXC6Lvww9vYamQUEGawNpYjhx3Ov0T5uzXbejeZB+L9ugAAG9Bsf4fDAGzLMa81eoMV
	 Ksbp0g73X0//kXWVVcV2hcXZXkYdUsvEpDd7HjZDuKoGmgNe2hHGa3kup6vkklKatz16a0TyhaZh
	 Qmc92nIn7dmtOsXA4mb2Ih8I5CqkLcbKnVpOR9U9iDKqmXH2to7pTh7N+PLKUI/qqmoNhF8t6exz
	 5s+n99o+AICXULEIImDzB/t4rZO0/ZzNHu33Wbg4+aMLvXocAUixUKCpL3cjBoVojE+oijkAeaHt
	 UiTsgoG9QAlCbpVBWmoRW4QhG1QvhFE/LjQf0DYPXiKeFqoi8OhVguQjxNdNDRULT300KZeN0s4z
	 MSachmWxAxXq6x4lF7pDvm2CD2eocg7JAo4L4fuZCCSZIJ04PyVohU6Ni2DCC1X4CRpYlaNP9B6V
	 tSbX8xFlOqHk+tywLsDqOW0Xs2m/MduDPvOwKvL3Xa/lJMscnnyyFHp8+h2Mmoz0nZ2NjOj9GGqM
	 44lhstCKL2tL3XY0YdQxkdmvqplxkgWSeo0mTDE0qcTN1QfGV5ZyL/0jXY2U6P
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Chao Huang <958028483@qq.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Huang <huangchao@kylinos.cn>
Subject: [PATCH] HID: i2c-hid: goodix: Disable VDD on VDDIO enable failure
Date: Wed, 22 Jul 2026 17:36:54 +0800
X-OQ-MSGID: <20260722093654.492010-1-958028483@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Huang <huangchao@kylinos.cn>

If enabling VDDIO fails after VDD has been enabled, the power-up
path returns without disabling VDD. This leaves the regulator enabled
and its enable count unbalanced.

Disable VDD before returning the VDDIO error.

Fixes: eb16f59e8e58 ("HID: i2c-hid: goodix: Add mainboard-vddio-supply")
Signed-off-by: Chao Huang <huangchao@kylinos.cn>
---
 drivers/hid/i2c-hid/i2c-hid-of-goodix.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
index f1597ad67e7c..f4dbcd1d1d47 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-goodix.c
@@ -51,8 +51,10 @@ static int goodix_i2c_hid_power_up(struct i2chid_ops *ops)
 		return ret;
 
 	ret = regulator_enable(ihid_goodix->vddio);
-	if (ret)
+	if (ret) {
+		regulator_disable(ihid_goodix->vdd);
 		return ret;
+	}
 
 	if (ihid_goodix->timings->post_power_delay_ms)
 		msleep(ihid_goodix->timings->post_power_delay_ms);
-- 
2.25.1

