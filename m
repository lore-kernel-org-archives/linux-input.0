Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661FA282F30;
	Sat,  9 May 2026 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778314942; cv=none; b=oHkoelTd9ThOFF1I67fn+0z8Mm/BzXq6BgxLbtbr7QO4jMigU48GrY/X7HlBHAtpXqxyXeS8L3GJASPoETIjqtOlY2nlD1uem1ahe/0R9tv1L7L0B6Lvdc1CmNQPULNtZ/p2/Fjf5JQjkzNNWUpn5vnjcpVEqh6QlGjl/ctjLLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778314942; c=relaxed/simple;
	bh=TBneldTY+F1jLhmgUfcH7ezAZjnvTXi0aOth5dzlcPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nulMQNsdYkp2hcA5XiEilPHzYREf2E1LrxvenagEXsYRaMHv7aOnEMk4VY2owtc+nR/OVVUBxvslv7gA9OoJ9NQ1XE3Nog+18kBmJyZlGUN212OP5pxu8BaVMbL7JyD87IBWkynozxOA1HgOp+3cSMqPvDzYKx/FHJ3UKATtqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=nwKHKg2C; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="nwKHKg2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778314910;
	bh=mpiyPm5hIKxyUSOwINxXUdjQSMzoKliJjuBIXtHcXYY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=nwKHKg2Cwk12WlcI9JvBDsRsr7vkzne52NiMZscx/CqeRVDrZpyB9qGYIsD+hDsiK
	 d028wqIAC+KBw2CRMK+NwNNhUmpLL6ZI6CJc6koLJ7gfIq5krs+DDLZ658rk1naa5g
	 x6myZmFwXTvT2gL6EbdKTQugKLKNpwIxARp8tmDk=
X-QQ-mid: zesmtpip2t1778314895t56bd8620
X-QQ-Originating-IP: A33mfvdNSoccIiZuTgrBJOZ1A99y+m/LqVls1tDXXaM=
Received: from PEN202512010004 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 09 May 2026 16:21:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14727995001244344790
EX-QQ-RecipientCnt: 5
From: Xu Rao <raoxu@uniontech.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com
Subject: [PATCH] HID: i2c-hid: add reset quirk for BLTP7853 touchpad
Date: Sat,  9 May 2026 16:21:32 +0800
Message-ID: <882C8FD17740299C+20260509082132.2188313-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mmv6ZbnMzK1tz8De4TwiQppr4LSVy8epNBIOKhj+fdbzoehpBwxiAgrw
	YoC0Alw2XZTPfWN+qE8MQXOGvN851wnDqKWoHpw8JbJ6v0AeT0WpiVFO4pCcWKAxqnWfqXP
	QuUwVEpldt6xXnIVjer4ZvShEbXeEXi5PjXkvZ0ePhJKEbD7pll8nXYmiChK0EQWImtiA/H
	OtNVlVE4tdLef6YHN6kGwFrBzEjxwR4Zclg5hw1IKAOahyOMuH/2eln7SaR6h1ZXjPeJYGo
	y5910FHIvCh92etEWiUOuSQ0UkwMD4AIjCAY3IoV2BySM5lcHJ15VLJiKyrPIidI/oyIO2u
	UaGjTozFjJRXv7F7FRgGokuNHIjNGjwEnafa5ljJPpBsmopZDbfzRKpCTZ1yJ304aJ7n9u8
	2nSGwC06l1Te7Sc42P2l7+kb72q9fnEwxyQa+5vi4zcCjQU1GDIddV5p0GSwwN0hG0ZPQPV
	97TMLi1hAj9Dceh5gWbCPuqZEYkeRiBfGyp5zP1gHMPtlTaphdxXXyKGDMXSGXi4VWBmbIG
	rfRPjEY0bEitBVZIzQHN5SgGanoLrqOrg+y16ajnCm2lIyVfOUkk9czeaP8N5kfvB5qAiri
	AGL31vQuMFMDqa8Mja+lJXTWjCAiUsXLl6m2MsZfT7T+3r1/0UEMa/QUwsY7S8KZ3R/lvEE
	a+gICXMWzzHqEbR1uasjJ58iV/8ybfKT5qqR05U744qKFl6wI42NR/T7+QXLyq9Gq2NY96q
	1TMsXm1Ypqer5jvb9iSUiYlmFZwcswL8E6lUcRQEv3z/1mDuH9ZZXeHsab8hHN0zgL21kLO
	gvmZnTiUJDIfwKLQTBQYbLD/PzGt5tDfjHxUMVBNLRiPXtRH8mfIUxXh1cidG7BZCl7gz3j
	cL6HsYr/0MSWFbws+ydmNUHlaAl6jyvVmKOB093eY2AkdOLBBS3nt85xIUqG84q+99fm4da
	L7ewncMbqD6paqvgsigRxuggvOKquMzDYgUJTlA/trroaUIiQ0Y5Ij+38lPf2vdJHl4wjo5
	paP7aaRC1DCQO7lzGGDWadESYZkzPMO1cILZo5JXR1T6hbsyd2q2ufEXWjAfIO6ki7mnmOm
	w==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

The BLTP7853 I2C HID touchpad may fail to probe after reboot or
reprobe because reset completion is not signalled to the host. The
driver then waits for the reset-complete interrupt until it times out
and the device probe fails:

  i2c_hid i2c-BLTP7853:00: failed to reset device.
  i2c_hid i2c-BLTP7853:00: can't add hid device: -61
  i2c_hid: probe of i2c-BLTP7853:00 failed with error -61

Add I2C_HID_QUIRK_NO_IRQ_AFTER_RESET for the device so i2c-hid does
not wait for a reset interrupt that may never arrive.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/hid/hid-ids.h              | 3 +++
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0cf63742315b..dcb0b34cd069 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -277,6 +277,9 @@
 #define USB_VENDOR_ID_BIGBEN	0x146b
 #define USB_DEVICE_ID_BIGBEN_PS3OFMINIPAD	0x0902

+#define I2C_VENDOR_ID_BLTP		0x36b6
+#define I2C_PRODUCT_ID_BLTP7853		0xc001
+
 #define USB_VENDOR_ID_BTC		0x046e
 #define USB_DEVICE_ID_BTC_EMPREX_REMOTE	0x5578
 #define USB_DEVICE_ID_BTC_EMPREX_REMOTE_2	0x5577
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 5a183af3d5c6..baff2728603e 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -149,6 +149,8 @@ static const struct i2c_hid_quirks {
 		 I2C_HID_QUIRK_BOGUS_IRQ },
 	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_0D42,
 		 I2C_HID_QUIRK_DELAY_WAKEUP_AFTER_RESUME },
+	{ I2C_VENDOR_ID_BLTP, I2C_PRODUCT_ID_BLTP7853,
+		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
 	{ 0, 0 }
 };

--
2.50.1


