Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795863967;
	b=fNKLxmLYfhtR4f2Jl4p09gtzOp15fmBF7zMbqnscHa41hMt4qYWX9VivQDyFJewQhdFs
	 XXCm0AuECLTc3pMMLiwQgg4hFqr9iqwbMB+/Xx0KYHaclWqpkk/OxU8+n/xIAknyaJNZA
	 wPAIxEsx/Vl4kmnAZoHrHKMrSo0Rd57xqjMhQUTnvWbe17Ym6BpX41vyshKBth/X1Z7Jd
	 l2g8jmID7ApuMwFZojKBq05bC2lZocSznx35Qt6k4Z7XiTXgEqxk/khu6taHXWwJHmI4y
	 bDoNvBXzsTd0d4yX9o1opInY0ZKMO9MeyhIkwy55gbwczND2bdMnqNVId53fpXaZw7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795863967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9elUEGS8ZMCG5n67rjT/NP1myfuDmUd44dHD3MtYbHw=;
	b=oaJGA5n7p0DFZK8fr3LxGXc+mS3q94zDec5NLCnh7J3QeKWafWO9DsyrvPynUp7f722g
	 tqb4dpFLpgo50IVmPne1edSnfotQ8caN2WBasEK/mxVgTWYnZ3vTP2wF9gH606Cur1uf2
	 cJaJ7B9mI/8A0xZs7y/BlmQzsGpmMmlfHVXt6BOm5jmINOElGpFdaAI3a/zOPy6Bd5zvX
	 jgMpBur9L7YLzV/YUAtVF1qyCwrCzoTIkAzOCWsO2CJVcBnERQbG835TbVMqIe1/cKip2
	 WrYQx23PwuDaxYRFArJ+aadId+0HLD+aeHxnXwkAkFN9Z7FDAJ7jsgY2e2XGgOv04SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lzMSW5Xv;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5A606A31F
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 11:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D5A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lzMSW5Xv
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-38190551625so16922194eec.1
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 03:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795863967; x=1796468767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9elUEGS8ZMCG5n67rjT/NP1myfuDmUd44dHD3MtYbHw=;
        b=lzMSW5XvBZa0Km+PMZ53MbleVvm8VgMV+HSwO3D/MBIwJwFGTrRaPMAhap9mNF8In8
         llBvC5YzKaHvU5Amsd/GQVKh7qQFcUMxp+al3gtZUDa83cyFeNs2KsDy2xkg26TBhS5+
         KE+lnfzgi3ydFs7eFK85AJpX1J7yo0+lG8NQ+b6KYyAalUyD4L89QwveW41FUgy0gdyV
         MA71DPjVHVvFrKmaDGGRIQuoc0qGKhvtNq0Y3vnVUOhM4SIfMx3I+4GMJZuH7sRxCfaj
         8mSNkga1wPS3mziJyN0XK+se5Voi+qZduXGfe33/dmH00fKGM3XZ3dF7vTbEB4N1fjHP
         67iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795863967; x=1796468767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9elUEGS8ZMCG5n67rjT/NP1myfuDmUd44dHD3MtYbHw=;
        b=Wgk3jJRjZ9Abbs+3Yd+8iXgpEe9EtGjVDzXMefL7+3rWMi4o0X6HNO8UpfL0CXohl3
         huIFN28QuO2zYRMbR0HwMT1ZAkic4XRV9aAg1Ah6azTDovle9uRxubwdtj38WX+XdV5I
         2pAcV2EPE+zxO8PgJEPEvwvxjGUrcBwe62BUGgwTf4sicjSTsapmTtyyhK0RATNDqMdI
         dZMnUxEZleDpR64IgBELm6oju0b9G7A/4vgiTfuHXezh35RhseYKxampdS3PmRgzhQqH
         FE/kC8CDWVzVrd9flBCeTuAdXMjK9+EZwFkWwxSH3bT1P4+IGHG1dzIAUFwlTOnLKSdR
         xGxw==
X-Forwarded-Encrypted: i=1; AL+hErGx2YB4Qb94VT04KCDchSRUXx8Tn3w5acJlMe4YWYitilmLK84Trba9fujeV4Mub/dAEq2IzNVp3kWUzA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+TaQmUAE8XPS1ZSoEyHMgrkhFoxKVMVUbtJAYCe+VmlHB1UD6k
	Kn2EyX+TzfAwG7P9SysJmfPabwnG9qlwdDhLwVbbNEERTBPn5aKNgsam
X-Gm-Gg: AZFdTZetmS+hceWW8EzvaHx1EchrlE/M/x7i2zZsMNzAeBbr5DPpMLz4Kap+Zhbokwv
	+DPLTh+zJSJU6ILYr3N10TS1akAIVBQRIGsAzYKyK+PyZVrSwxsoWhW2AmcMOenyzUA+2MA9GuK
	CjdE1ySDfSIcFGwmpoy1w/9OaUlNlyha6FzhqtusGOBT+H10yCFtu6HgWS2wXLqgX8dgKmVjV5h
	DfwKYMkOeDdZqXeRJKYrx0xhuEaW9OU4lFfjFdw2BT04BpBkk0QsvC5yP8834fJhjK6NkBYgLIo
	NSiUX4DF/fG0LPcW0kYjKglsMZg3GsH9ZxiO4843hkUI/dhRBDlNAZEEaKNacREFIo0lvnMYOIh
	anV0xvfnMLkVL3ON2XRPSXHBALa3sdPv78UHH7Pyn1YdI55Hz72wh5rE7k9T5bMeqy1G7p8Mb89
	KbgHBr4T4XnjwCbKfRyaYuXsU6geq61nyI3KxRLLhminD/cs9mb+Q+/aTjl19Ppb3bkYprHV3nC
	Iyu0SsDmBB1TmnVmPVr4TdQebag8cu9D6HYKuVSMaCUi3bDs24SOBAjgJB4zkxT+V3Oeaao4X28
	z1/7X7QmPEqaYbvlkkEK3ZO+ncSQRR030JTa07ZjYBQ2c8whjQCRKM3NLVmwx4hZIkA+71FmL73
	egF7Kdnz5X54WVzbh/Mg8yRkr5xpdsrHXHeNDiVIl0ABXTeZxHGcgA6iIE8KYeOhElw9G89hr4R
	0eMLpW1i09Dv5AW77udml2mWnDv3Zu+SVv7VGag7+FUx1HvA==
X-Received: by 2002:a05:693c:69dc:b0:386:aff0:6109 with SMTP id 5a478bee46e88-386aff061f8mr18761873eec.2.1795863966589;
        Sat, 28 Nov 2026 03:06:06 -0800 (PST)
Received: from spark-da2e.tail8e743c.ts.net ([211.105.22.106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm40958970eec.17.2026.11.28.03.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:06:06 -0800 (PST)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: HID: wacom: battery teardown races with input reports
Date: Sat, 28 Nov 2026 11:04:03 +0000
Message-ID: <20261128110415.772810-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Found by coverage-guided fuzzing of the HID subsystem through /dev/uhid.
No patch is attached; I am reporting the lifetime issue first and can test
candidate fixes with the standalone and syzkaller reproducers.

Kernel: mainline 7.2.0-g66498c75b4f8 (arm64, KASAN)
Files:  drivers/hid/wacom_sys.c, drivers/hid/wacom_wac.c
Impact: use-after-free write; kernel panic
Repro:  standalone C and syzkaller; also reproduced on a Pixel 9 Pro

## Report

The clearest report is a write into a freed struct power_supply:

  BUG: KASAN: slab-use-after-free in test_and_set_bit
  Write of size 8
   queue_work_on
   schedule_work
   power_supply_changed
   wacom_notify_battery
   wacom_status_irq
   wacom_wac_irq
   wacom_raw_event
   __hid_input_report
   uhid_char_write

The object was allocated by devm_power_supply_register() from
wacom_battery_work(), and freed by power_supply_dev_release() through
devres_release_group() in wacom_destroy_battery().  The freeing worker and
the uhid writer were different tasks.

## Analysis

wacom_destroy_battery() releases the devres group before clearing the
published pointer:

  if (wacom->battery.battery) {
          devres_release_group(&wacom->hdev->dev,
                               &wacom->battery.bat_desc);
          wacom->battery.battery = NULL;
  }

At the same time, the input-report path does:

  if (battery->battery)
          power_supply_changed(battery->battery);

This leaves an immediate freed-but-non-NULL window.  Merely reversing the
two statements is not sufficient: an input path can load the old pointer,
be overtaken by teardown, and then call power_supply_changed() on the freed
object.  The create/destroy side and report side need lifetime
serialization, for example using the same exclusion already held by the
input-report path.

The reproducer alternates the wireless-module bit in Wacom status reports,
causing battery creation and destruction while continuing to inject input.
It requires only /dev/uhid.  Besides the KASAN report, the standalone
reproducer caused a Pixel 9 Pro kernel panic in power_supply_uevent() after
about 11 seconds.

## Upstream status

Rechecked against mainline, linux-next, HID maintainer branches, and lore
through 2026-11-28.  The defect remains unpatched and I found no matching
submission.
