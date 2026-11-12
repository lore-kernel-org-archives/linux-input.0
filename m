Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467852;
	b=VvWbzC0S0WbLCjATPiqpdALE41x+s+GIykLdSty65gUawLWsb8N+JQie3kWcdwHK2qln
	 2Z1vx7tpQNQsYP+3JdWIUXN+9/Njb8Ldva+P6Ujgo9jDyIhmD3svCmeei1tlyB1fGN9Si
	 x3pr2whc7w5EmIQzdJ4R/GJCdVZ3J08SoqulnMD1U4vMem+2i7jdUW+rVoArRDrKp+p6w
	 uLK/QwuebT/WizXgWMVUWzmiYsUoIQGnEUDkjTFwhPGoiQ/Fp9UOBL/mDl7oYP6b7TOe/
	 DPYc1Uk2JN7gEhoazbzVl3tqWytrBJoHqUwB+T/a5+Q+S4yiS06iretvPu0wqtPqHjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467852;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iidpbc5QdXD2bR4PBmj+0v3/ktUgHZK4mUFLOB1pc1A=;
	b=mtezIeefU2wj9jX6hqhDbSMubwFQScVbbYeFmFOoGSXg7OUrATwvCinqXtp2nWi5Egw1
	 z5WQ8v+arAOd4V+iIuexxhxrCo55WM4TVQpeKiB50YNUZ+gqu/8lIHCFVmTZtnoDubN3D
	 CnMvMdnEaB57sIKtVz4pnY8YU6DvoCC920QRxqVZXupNrYg8YO2vIfM8dyYejkGCiAj1U
	 W321hsmT5HTnfc1bm7dMu5gfPrkbrpVhgC9eH/2FAwzbL2gwp72EeC9glc/yY53zBV9Bb
	 /Wr3Ms0q0/PWot+IsR1/X375OwdQZcWskE28IBMUKCgw1VyMtTYHRYJx1sZu3jq88wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=DdJX5E2a;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF00606A332;
	Thu, 12 Nov 2026 07:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AF00606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=DdJX5E2a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=DdJX5E2a51FM7RFIYa0ffGtjVzQCw99bGjmLgNd5IxDgu6yGA8/UjNO4pQ5aubyGARi2MSmGJjVI4
	 di6tDAUxPD8Sl2yO+B4IpHsfL2hvF5KfE0J9XV+v909XVBliCNMCqLQ5U0VnVgbYniVx4j5PbV4ovc
	 6Bqk111hcqr7vP4w=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36af56808a3c-ab3df;
	Thu, 12 Nov 2026 15:17:29 +0800 (CST)
X-RM-TRANSID:2ee36af56808a3c-ab3df
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af56808c4f-f716b;
	Thu, 12 Nov 2026 15:17:29 +0800 (CST)
X-RM-TRANSID:2ee96af56808c4f-f716b
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] Input: mpr121 - propagate suspend and resume write errors
Date: Thu, 12 Nov 2026 15:17:27 +0800
Message-ID: <20261112071728.154571-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The power management callbacks ignore failures when disabling and
re-enabling the touch electrodes. A failed resume write can leave
the keyboard disabled while the PM core is told that resume succeeded.

Return the SMBus write result from both callbacks.

Fixes: 36682b81de32 ("Input: add driver FSL MPR121 capacitive touch sensor")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 drivers/input/keyboard/mpr121_touchkey.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 06329cf5c749..973fbc5521a8 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -302,9 +302,7 @@ static int mpr_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, 0x00);
-
-	return 0;
+	return i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, 0x00);
 }
 
 static int mpr_resume(struct device *dev)
@@ -312,10 +310,8 @@ static int mpr_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct mpr121_touchkey *mpr121 = i2c_get_clientdata(client);
 
-	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
+	return i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
 				  mpr121->keycount);
-
-	return 0;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(mpr121_touchkey_pm_ops, mpr_suspend, mpr_resume);
-- 
2.51.0



