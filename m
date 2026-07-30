Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9FC429CEA;
	Thu, 30 Jul 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414319; cv=none; b=o8jMHg6lWO3K5r1nU+w+h+8sYJCHEyP2Kp6x7jZPaBkMJQCm1tNTuL4vsJa3B57IqFW3qavKX57UOoUWiGrVIztvqV+IEjf9ql9z0EVCUPjTX0IChfAUl8NFWTjdC+jwJRcpmLRdH3KQAavNpCnnZMVGL1qtKP5HdrhH2CQijLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414319; c=relaxed/simple;
	bh=3LB/SwSch/lV1orsaev3FNbt7W0g/t0h+plJgsPEkWw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=G4hRMQ+ha7I203/SY1EjXhxwZ3OrLRf8+jAL3eU2ESly2lx6adwNH3LQ096gnolvnIzKDxf354C+LjttBG2TMxXY3eH7q+pPCa4A7tn1bFFtebvVx/Ik2p+zap+7Ec5gJgNGAXjNSsCKmZoRK5W+ROwffhO/uNXckjUzVy1KulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=tw3dJVtZ; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="tw3dJVtZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785414310;
	bh=pc3c08DQpdHYRFp45NXyFnRi2yliXjxSUnIm0bgVycI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tw3dJVtZOPmy7jbAHyQTjZTxGTwkfW5J06N5MkYKka1E/6cH3jO3YiYc2TShntkOh
	 SOxX26PXz/UhdOaeUI0XSxCPq7Un2iOnS3sgHVJWMpVAArQTojsTFluQgFmX5ypV+y
	 iTrP/C2ORterIA6xTXGXpq/98PS3tA1H5KQoOYV8=
Received: from VM-0-7-ubuntu.. ([101.35.250.50])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 648A204C; Thu, 30 Jul 2026 20:25:08 +0800
X-QQ-mid: xmsmtpt1785414308toq32y2or
Message-ID: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>
X-QQ-XMAILINFO: MUl6Z5IrFzo71DDzUUOo1N8AXJP+YrUXEwmNjyNbKQtiG8I18wNngsqDEoHJ93
	 x+s8lfo7Y3vNxzAWf1LxJrdsHBeeGJBnUBjT4+8U5OssrC84tMBEvYkIdO/HnhvyzFxorHKp+6hx
	 ttqfOfpjVOV/70vcY8HkFdspXvt6uZCdlgTkfTo2lJQhVXRfak3Gw6Dpw0PyLAQmhk87eQVBz5Ig
	 7609gDAxanekQ3HLeQ3nSrO1x89NCUTsWVBoWJ1YWJqjf+f1ouanB+Jv7Ujw/OpCD1n4YCfz57+x
	 fi6sFymZJl2Qu+P85dmK2loT3wxCYxpFpALYYbrWJupsuNYgGOIFiXIVPvsDy5jlxQUZ5gGHZNYE
	 9ya1YTHpZXPD4sWhGxJeyZgbLfNSq45h8eZcJMjYm735rzSnqiv1YAMGHlzgGNMMv3PZl3/B5Iih
	 pgLb2HZrvPTGoA1Z8pZS2uKJWPa0pwp0VkhAEJxVM5a8QQXurApzISA7V1feYV5ioKja38AR7Gaj
	 chGFoOLKG1+8RjVQBwV6svFK2kC3oKW9uaUnrVcONH73hg3M3UG1t7rCoDXC4XVZSYBti6GFsrCo
	 9FKbIVV0aVbL8saDdcK3qCsmCRSngx0w6rjm+BTI+N24hHMNVrPXsF1Ixt1kHVLVhC/FNFacLDmd
	 44ARK0W8NbbLPdzPRFCl4wenv5AiIggkNSS9XojiJEADXkR10qtZUc+fojfU9P9rhLiu1z5wzlew
	 Vir0jmrYMGitHiKG7g8Xiddl1kKwUEJO28xRT9O4EcY0aKrcQY6T2t3Y8iuyIUvNGuS4vU6XT+5g
	 kr0zfl7A+LUa1qRUR6QEGaIl6sHxMUNd8+F6U0sdaOVKacGcLZIe3vGjrisR4X7GtNfk9RzDcmdm
	 WRLgh0fwqCgTpO5oLqh3RicJGqpt4ehgleneccw0YKO0AeD+CQidn1ymVdW/mRwj0GgkxMiXNDGv
	 sZAw40M/ijMbU6kjnXcm8bZ62jpMLcnWEvaIXzdxd9Yt2SxOzLNXbpCjdx/CebfGC2K8oCA4PC6e
	 xgRb1M9rNz7I3sKj4KG6t5BOkNRRL35PTufhDf9u3YGWgf3W9Vh2UcYKMuGF26k2p49HY30MFUnk
	 EblFcNgUSIP6q8vj/Sy+RjPfQqow1ksmod+uuQ5/OdbxbLdmA2TXuTwhvGAQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shen Yongchao <grayhat@foxmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shen Yongchao <grayhat@foxmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: intel-ish-hid: clamp HID device count to MAX_HID_DEVICES
Date: Thu, 30 Jul 2026 20:25:08 +0800
X-OQ-MSGID: <20260730122508.256019-1-grayhat@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730120215.226176-1-grayhat@foxmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HOSTIF_DM_ENUM_DEVICES response handler takes the HID device
count from the first payload byte of the ISH firmware response
(max 255) and stores it in hid_dev_count without any bounds
check.  This value propagates to num_hid_devices and is used to
index five fixed-size arrays in struct ishtp_cl_data
(MAX_HID_DEVICES = 32): report_descr[], report_descr_size[],
hid_sensor_hubs[], hid_descr[], and hid_descr_size[].

If the firmware reports more than 32 devices, hid_ishtp_cl_init()
writes past all five arrays, corrupting subsequent struct fields
(including work_struct members with embedded function pointers)
and potentially adjacent heap objects.

Clamp hid_dev_count to MAX_HID_DEVICES at the single point where
it enters the driver (process_recv, ENUM_DEVICES branch), which
covers both the probe and the reset paths.

This is a data-validation hardening fix: the ISH firmware is
within the platform trust boundary (loaded via CSME).

This patch was drafted with AI assistance; the vulnerability
analysis and source-level verification were done manually.

Signed-off-by: Shen Yongchao <grayhat@foxmail.com>
Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 6d64008..XXXXXXX 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -123,6 +123,8 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl, void *recv_buf,
 				break;
 			}
 			client_data->hid_dev_count = (unsigned int)*payload;
+			if (client_data->hid_dev_count > MAX_HID_DEVICES)
+				client_data->hid_dev_count = MAX_HID_DEVICES;
 			if (!client_data->hid_devices)
 				client_data->hid_devices = devm_kcalloc(
 						cl_data_to_dev(client_data),

