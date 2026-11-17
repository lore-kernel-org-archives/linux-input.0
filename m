Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945917;
	b=ZyXieIx2Tjl0VTTBwHIaZlNgeGlekOfhdPcuPK4dLA1ZrrSiJjtbK9tl6HYpbbLBOgyT
	 5JRAoEsojA5+XYd8AjGTvuTxjey10N6ApN9/BBxDwMSmmTL4GzCK3MnMpnBqSi7WgcZyA
	 AkaGBSW8LVwQpmHsv6qux/WUnqmw0sGYxDrKQ+No7MljoRAr1WacOGRz5VYJHUoq5G6R7
	 SZuM6Dyw4o8kjHEs+DKpGjg0sw/TbWmOW/gu5Wgc/s7Dem2Qtq7tH0R9k3DQp1fiPo860
	 JA7Cpe6FyYJbGwM6u8lK7jcAzOVizj7RnAZFUYgFqSF8SMltVTsEPz6Jzilo+xPdO2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oQ6kVNTKtHM/GlFIwNb9GkcrSJOUH3g4l0nbt5E8WPg=;
	b=ZyDI7L8gNgUc7A7dmxcbRdD4vYWZRfVb9i31BHQgjNUEL7e2P+dM2TtcY6iH4W/rB6zd
	 sSAMxWDO7UdIUuPE7eSa9YdmqRtCEpBdaXooeySE8ACNDXZ6Aj2qGLMiEc8f/0wC/daUu
	 4wTx9TwSft8KyL1C2q9OctHOrSx1gIsKxSOHz6tmVEnqgiaQR0dF/7KRqGkS7VLf415NL
	 AvhLf3hHaajEaZ1la3K3o+gclVURBmVYlrbSMgJ1O062G3Ed4VsAHar/XfcbTcEQXQyKv
	 Yd/RpP7bhyY+Kl4BUFgeMlGUQIfniy+p6Qsz6bpiy1k6FwRxZb10d0ukSz+RXvZElLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SUyVBPRK;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9DD60A6F60
	for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 20:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA9DD60A6F60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SUyVBPRK
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so158601f8f.0
        for <linux-input@vger.kernel.org>; Tue, 17 Nov 2026 12:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945915; x=1795550715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oQ6kVNTKtHM/GlFIwNb9GkcrSJOUH3g4l0nbt5E8WPg=;
        b=SUyVBPRKvlIPfyyfb6ETZn6Oj8b+gAXpZ80SFzVZXHh1crDmixmj41Va2EnEXc8FOX
         9f98bIqfQM1Xa0Nksu+TZxCa+HmDaHxPppk8Y9ZM+BDDT1f5poSw3b/+kgZ/mIS1o2UV
         sWTKIA/hzmTGVe9vcRqtxbiZuKWqmGihhxzWNTxa/SicsmYe9eZeE++3LR7L+cKywBRo
         QiDIJxvRqORTekCjEsTfNBMPXP3ak0NIm3LBwDpSSB/pdziXocUb45WHMc4uJySF03eJ
         dKZuF+UFj2Cd5sKkR+fLI0RjiI74dwW62oojhyG9zJmBaNMS2UxMqjwXTBQQyD3YovYj
         0gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945915; x=1795550715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oQ6kVNTKtHM/GlFIwNb9GkcrSJOUH3g4l0nbt5E8WPg=;
        b=ZIQAaxj4lb7zbFUaFBYbo2Kd6jrIEx5dh3NRqOoYWQOGpUOcdtDZuBq5imzeHNKW2H
         vppThoPqbWI17bcySwR4tFAE1imLCBqUNl818oJ8aJVyYstJ+CI5Dvto+UVcditNuN6R
         xYSdT30FfUCj6Ax2f50/FniWojDwd4qUw4o3AapVDh0yPFR8mI6VSCiIuuaGyrCbsOH2
         qq//cN7eqWOkoNLReF3Ox4qi/42HMcQXivhJ05DY0+5sPVgwJoEQGz59TsqINYbPqpWL
         IfQNNmS/uqSFI9hPlx6HxDvkb3fsUEnlKxUdIWRmQt6u0CpRIVpsecGIJxFZR3VTXY25
         uJwQ==
X-Forwarded-Encrypted: i=1; AL+hErE0JeBV3rjeORrcMS5DXtCRlxWYLA/DCz7hXjH2nEZuDPditIsU+Lp4fDMFZo8v4md8yj+s0Ls7Y9tzlA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+kMWVhla6snbxsjRfkIsrVFpaKs9TJKgHHZ8D4XeiziIsbZeuW
	KHV292cRa0WfnzC/wqWzFdNG+ZVMriQiFrdH5gSVr7NlEpp4AWgh25xS
X-Gm-Gg: AZFdTZfIdlWSWMfcgvN3Rwh4p8SdGdPrwGUqHqKIE+KnYG1kwGmMftRG1+B0/iUmdTR
	V4QyDSP8L2TC9Dkd6sm9SRNa0tdWlqFEHezqbukW4UCpnTk6GKe0C97CzFZhv7TqLjoGDeI6kvc
	PDygLQFdCuAlq6nAzCqVQvjzNbc1geB4MZGvbcQfZ/AoLq9N313ZWVJZpynu6DFRQ6goGvVHt1R
	/MVO6gHDC5UwOrT+Y8jIpf5R36wxu1nhUSP8eEV59AmgYYNCo5e1UOuWzP1kfOClVzFatHJml+6
	dJhEGbXWnBEUASZL/TDrVvg6t5cjt/wBjbYUUQZp0IFHpik39+kDC9Lp4LjBSR6Ow+bSJnbEDv/
	1IycL/LFmGuVjIUb4vYJlYuerKfwutXHSExfcxaFWma9WZTQWcLYAZbb1oDv3tJFyV/fxrE3qXt
	5X54Pu7VON3QQCKKo/CM6TcFegFMycZoVTSJtq0/ZVeWq9M8pAzhwOiy/r0zhWITepec1XzEg53
	AfCFhZ3h+C7C2ob9AUWLYZSFiEiOvDe5BhRLhyYlGvdY+0kIDYxDp1gtJpfhONI5q2axoor2nPd
	A/e7WRAsB0p4A8YFPHkXxDa7MOD7
X-Received: by 2002:a05:6000:4555:b0:4a4:7328:21f1 with SMTP id ffacd0b85a97d-4a63ac6be9fmr782897f8f.24.1794945915115;
        Tue, 17 Nov 2026 12:05:15 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:14 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v4 06/16] HID: ft260: i2c: reduce bus-error message severity
Date: Tue, 17 Nov 2026 22:04:12 +0200
Message-ID: <20261117200423.19561-7-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117200423.19561-1-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
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

The driver logged errors when the FT260 reported an I2C bus error or
when ft260_i2c_write / ft260_smbus_write failed after such a status.
That was meant to flag unexpected failures, but bus scans (i2cdetect,
HWMON discovery, transceiver monitoring, and similar) hit missing
devices routinely and should not fill dmesg with lines such as:

  ft260 0003:0403:6030.0001: ft260_i2c_write: failed with -5

Keep returning -EIO, but print those via ft260_dbg. Still use hid_err in
ft260_hid_output_report_check_status for actual HID/USB transport
failures, which are genuine errors.

Drop the extra __func__ from the write-path ft260_dbg calls; the helper
already prints the function name.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>

---
v2:
Fix for the issue reported by Sashiko: the write-path messages
printed the function name twice, because ft260_dbg() already prints it.
---
 drivers/hid/hid-ft260.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index bdd55b35df9a..f722ef0ddf06 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -579,7 +579,7 @@ static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 	 * to 1, bit 1 is also set to 1.
 	 */
 	if (report.bus_status & FT260_I2C_STATUS_ERROR) {
-		hid_err(hdev, "i2c bus error: %#02x\n", report.bus_status);
+		ft260_dbg("i2c bus error: %#02x\n", report.bus_status);
 		return -EIO;
 	}
 
@@ -613,6 +613,7 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
+		hid_err(hdev, "%s: failed with %d\n", __func__, ret);
 		ft260_i2c_reset(hdev);
 		return ret;
 	}
@@ -652,7 +653,6 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 			   int len, u8 flag)
 {
 	int ret, wr_len, idx = 0;
-	struct hid_device *hdev = dev->hdev;
 	struct ft260_i2c_write_request_report *rep =
 		(struct ft260_i2c_write_request_report *)dev->i2c_wr_buf;
 
@@ -683,7 +683,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 		ret = ft260_hid_output_report_check_status(dev, (u8 *)rep,
 							   wr_len + 4);
 		if (ret < 0) {
-			hid_err(hdev, "%s: failed with %d\n", __func__, ret);
+			ft260_dbg("failed with %d\n", ret);
 			return ret;
 		}
 
@@ -699,7 +699,7 @@ static int ft260_i2c_write(struct ft260_device *dev, u8 addr, u8 *data,
 static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 			     u8 *data, u8 data_len, u8 flag)
 {
-	int ret = 0;
+	int ret;
 	int len = 4;
 
 	struct ft260_i2c_write_request_report *rep =
@@ -724,7 +724,7 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 
 	ret = ft260_hid_output_report_check_status(dev, (u8 *)rep, len);
 	if (ret < 0)
-		hid_err(dev->hdev, "%s: failed with %d\n", __func__, ret);
+		ft260_dbg("failed with %d\n", ret);
 
 	return ret;
 }
-- 
2.43.0

