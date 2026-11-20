Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164253;
	b=18UXC5Icpi2MP9kseDv8hz1nBhD7b4BD3IycO32blWfE0NETKic/jjvPApHWlYi9JxPr
	 BafJpHxarv8Nefh8FCO0cj3Wj3UsqwkoP4Qu+zQ8eWEsgSXafFJo0jSew2ChHCRPZrHDS
	 YHWOe52kPNwMbh4iuq959DsQQngkpnOjGaaocFzc1RflH1RKIhxlN13HM6gmi8ZHtlJSO
	 Hi1vOLp2VWdEJzHFQoOcUaybDE8wmzqnDPuJSdZmQqBsqGGu/v7lYiKLC5q3lV6yKYLx0
	 pYAKZ4/wox3780sm73Trx6g1syYvluzJ2ykX5mbriQjob2NbEchA/NgpegGoOilJGqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vV2d7SamsF9BbiK6MJIIboxgwzjtmzdUXZZLAxIMzUI=;
	b=sWSBAPPc3qIPpV7YpVXM7U95ahB2GXydPIg+9ClAa1iDSebNsyWdppKx7lPnWHxWd/JI
	 bNqTkXhfQXEr1DlzMbsqaDCVOG+DYW/g9bNfsc9cw3wLJ/ymPJ9vUG0QKy/WME8YBqElZ
	 FV0DO0As0uLmm2O+TGdCwXameaN9fKgfJeNYYY0ydArLeRWZtY0c5rmjRSUi3Mos6PV+/
	 0brR59Ip+ikA1bfWUwnPCcytOQI/BOi9LbGBJXnLMd5PU8X6awz5BTO0ruskhgDysR3yC
	 Sr146Yt5iz181bSw6b4IgvVVhyptMmyf/hqCeIKJLMZkx/yxCTO2+U7OaISukVc8Waw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNm9FCL7;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E699606A8A7
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E699606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nNm9FCL7
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b24f4b15c4so684378c88.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164251; x=1795769051; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vV2d7SamsF9BbiK6MJIIboxgwzjtmzdUXZZLAxIMzUI=;
        b=nNm9FCL7p5JyHEBpadR+ese9GRsU0ADRQBVc/A9DoLDIObbzlosZy3Y7j4Kht8hJwW
         Tr2FkS5u9dvfBN5iHcFaG5j/i3uqfm7oXFzjzpnAsCt2dtD+XbrSVXgPfSZVlm+Lsnwe
         wD8xzo3vIuXUVbYngblAZx3IUzvxwgrnkEj/nBwLU/8J2ZwZNTKSNOLV5kpRsURiFGoz
         SYjT7Up/hdyIoJT0LIht8xp0ze/RJ4aOyGmYyKf2IJ9l+nKYbDXeJSaj4n2Qok6Xuh4S
         YqCD3ALqfAYvCEhkD9gZoXIM15rqu5g8/u0c2wH7eBj/YTkAMqx8q+dkixxGIPPH7ulX
         xZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164251; x=1795769051;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vV2d7SamsF9BbiK6MJIIboxgwzjtmzdUXZZLAxIMzUI=;
        b=ez4dVHUKEBzuq02oLZi8I6IM5AuJ3D11PE/nExJUaWAIiInpWDldBZrb/SPjbXta+u
         MtF/JY8Ja32cbR9+PAdw0ua9JJhtmggkQys/uV4Tsx4a/zHPTWWzSvnAPrFB78ZFWo39
         1/9nWuFN6fuIo96bAFUBZIhQnn9w002d1I96y1OPez8J2ejjJcZcLKNrU3TOhRY5YkCT
         0D2KDTjxllMWjcP0Vt+B8aXZQ1V3pQYAWOdB1pAwipfBPotzWyJp73TFzcEc5BWcxVMy
         FVNOmQfA+94Igcm920toQIaNTkdMbK/WjL8P1ImJDa1cQeDVV6P1yAoyxUatkySqlsdq
         wuXA==
X-Forwarded-Encrypted: i=1; AL+hErH+LM95r0hTRZQQtoqo1EjvOygLQ8DJilERqZJbd+HDp2eh/duiYI55EI1Qg90SFyhPsM1PAkbA1eUM7A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/La/L0tf2qQ1U/0Ji+lrMgilRJkos+xZcZ4jCrbs8pbymaWUJD
	WU9DylUfzCi9zcbl3K8ONC0D3E3CBu2AXGBaQROwSjyhoG3QQO5jiQKZ
X-Gm-Gg: AYBFou3WwnWxx4svHxkdmjsD7GeJA84gfQK6gANq5HA3r8EauTY9xsRsysFmgf655+C
	z5M0a7vY+PdIlJTkJ3a+WW2wALTviRAiuHkp8c1aa+fOqpmt2jEc0GECCaMDLTAhGoazjVEgIDh
	I/TsvrMyrxmXHuesqiELHcadDzkRARWD3Vo6BB+5erZDUVNWmtpXm26bA/aTSyLcRlmUrTNTa2M
	hREOg93LQIK24niYEuM7Y1wVBdf1NiTssOHHPKpGVV+ExpQN3poYSlMGA0F9ILHaDNcouzXJynz
	kKSPtNZcXAYLWOSdrVeMw01hUjp0WwKSh41WNJSZBNTASOqSkZlfUmcQ+2pF+44RaF8kQ9Vf7P1
	ToM9RV0vsKaoLXaDt20srBnLQoEQqLtFiehskAtNrOyzLtpNRDdOdhUNevZ7Vffo+deBQsUDUln
	ZZpei9PwXGQN6NaQv71J5C7b1qW/M8fIw5Mp5ZymxMTUTt4r/6tsb0PimgJZmQWcLMpD/DFb9g3
	z+lnvLpM/nfu9LzSjJ5DrOmDl9q/kF5tX8tuPmbfwE/JUY95aQt6oN43k5+dZLKtk+BbQbApeNv
	mgFvKP8ZSHwGrUPLFGFcEdMD12zzqzm4N7TbmYvWGOSkSFZ7NebUOvMeRkzzwILQo4opQD/evpO
	1IU4108JY4kh8QRlP9p16/kB57oak0GmvJgZcbaNQ
X-Received: by 2002:a05:701b:428a:20b0:1ad:1574:aa9d with SMTP id a92af1059eb24-1b5566e0ecemr2281882c88.0.1795164251283;
        Fri, 20 Nov 2026 00:44:11 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:10 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:43:52 -0800
Subject: [PATCH v3 01/18] HID: logitech-hidpp: keep connect work disabled
 until hid_connect() completes
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-hid-logitech-hidpp-next-v3-1-ba39242d4336@gmail.com>
References: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

During probe, initial feature discovery and device queries run with
device I/O active before hid_connect() exports input and hidraw
interfaces. An unsolicited wireless connect notification (0x41)
received during this window queues connect work (hidpp_connect_event),
which can run while hid_device_io_stop() has paused transport or race
with hid_connect().

Keep connect work disabled from initialization until after hid_connect()
has finished and device I/O is restarted, ensuring that connect work
only executes after interfaces are fully established.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 966c5932528d..cd42783f85b6 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4774,6 +4774,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	INIT_WORK(&hidpp->work, hidpp_connect_event);
+	disable_work(&hidpp->work);
 	INIT_WORK(&hidpp->reset_hi_res_work, hidpp_reset_hi_res_handler);
 	mutex_init(&hidpp->send_mutex);
 	init_waitqueue_head(&hidpp->wait);
@@ -4825,6 +4826,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	/* Check for connected devices now that incoming packets will not be disabled again */
 	hid_device_io_start(hdev);
+	enable_work(&hidpp->work);
 	schedule_work(&hidpp->work);
 	flush_work(&hidpp->work);
 

-- 
2.56.1.750.gf70dc682cf-goog

