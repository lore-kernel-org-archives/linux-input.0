Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794636013;
	b=Y47nIaann63AaEtEbfg78/XwU9u/w6FLednmqJixqrcNUThGv20bk8diERCTi2fbw+SZ
	 BpNdB1gsRLhRhc6c4SrfP719bRLtRTyUZ21ZCfCDaZ8EGZyLJwRef5vfPsGt/vJE3D7xn
	 3/4UaNXbHoaYoee4ZYQwA8aadzBNTcTT0pV/tUPuRx8glc8H4Vg5q0zLC2GsJdmdHQVfQ
	 eYojv1Ha0COQZtCBrypnExPWSLqv3kn0q0LiW6mvBmj4zuBbvqn0y2e05JnuIwIHr4ij2
	 eBtKIGLlhAzVn9oT0nZ4KcE3IW1/GEIugAYXSfrGN6xM+Bfetq5w8vKdvNXXeXuACNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794636013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=NfuC547+tfDP/ZnK34MTsgmeKITWfmTasB7CUQvzVbo=;
	b=qZxtE3yjnjE7pyyb5xHOKX1kne8xBkbW6cya53LtZZgTP+BET+8I8nPFKwi68s+YJ4Qw
	 Ag0Vl64kI7Gwbaj62yzCBMy49aS4ZKq8fAjj51ltSPSPvukyr9wi+lD8H5+shpN1HPpLR
	 msaSIOq3345gLfEdEZV9V5ZVnAgRZ7zNhSpikM4whxxE1p4zKa8KQkFFpaFkYGYZL0Xme
	 54a3muDJEkkT7iUZykUTXwjGbezTwr2Z/rCKoQpyOdZ2hTB9EI5ckpN2f0tsrwblLjOzj
	 KPUWqEiABGT2Dkgr0dESRjgFtmhyA1lJKNi0BTziZHYN1pGOE2LGeBU94LslFmMdu5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EiKPqTQU;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09760A2630
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 06:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD09760A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EiKPqTQU
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a2761c69fbso1253250c88.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 22:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794636011; x=1795240811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfuC547+tfDP/ZnK34MTsgmeKITWfmTasB7CUQvzVbo=;
        b=EiKPqTQUMCQoiFs9r/xUvD8DNKzfFBFi0GGeN0/JEQIr+4/yw+9louFBnp8gtkfNAD
         o7W6TAQ9+6+pifP08PqVl1CAClUbRhoS5hxLxZ0cco+iHjNDbimraaXo3RqXR53OCi49
         iqzrDU+HGdbjFBBteFyjzf4euwrtdNUK+UV+Fx09SyVmiefGNkGeishOfENAYKAOG5qD
         ztK47c1QArK/SZrt6IMj3RsKnvixtsueFTeVOmq//GvxjCqmMe7a3HUIAFjJbvpel62z
         HZeq0dsaRCjLL1Mq2SvB5wU0WikzgueXNoEx4DM0vlDbiNxpFOXKg5fcTCXBDnLKjnBG
         F0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794636011; x=1795240811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfuC547+tfDP/ZnK34MTsgmeKITWfmTasB7CUQvzVbo=;
        b=qPgHPoW9NWGGJRU5iuZyHgKUUKdskGHFioGNKJjNaVWXQrjdwWW1cjvWyTo8HEoEQj
         05PaLTer5eo0dGpG1Igkrn5sMuV6cIYLXltcpWyr87mVuZfuUS0DRp2rXPvAofLVfpWM
         ZGF5Gterannx0irVeTm91sw9zRpMkzrVsXyQasFHhZikSb5RNcKIsC8gcZakFQgD7Yy3
         tiiRXTNXWQ1y+UcJ7ANvi33ECagHG/c4tanzaKnSl2wkqWBc0bgAiGAplfJ+pw8YbQVr
         6S4WHnZMmqNgoYhU0fmknAhjhrV8gTBZVgP0cWeMJ2VFU65Nak876TDMWyDY+/R+u7cQ
         ZZtA==
X-Gm-Message-State: APuU4Z9+KKfbJrioAyYaQXqoC+/wAC1oCkQKXW3y9Q0KADFk5w3X47rJ
	NaRFAoomVYSv7ZivfoJxlehuPr0G00/0mRU6QlcXqLyXSJdNL/HHLJpT
X-Gm-Gg: AYBFou2WsXoHtMw3lpJcbT616ZOYkwvaNMQziuSKkEtvtzdSsNkFWbltvV+ksZxJcau
	8uSY8IjVusd1gWntjh4DJJNzifgmdyRtwqROH0tAlOqJ5mdLXQ8QU6ugoD/9JmlZIQk/Rv3iXca
	gMEYRT5Axogub/3xMY/0kzAPAZrBTHIGM3JUb5n41j9ONFoHxyCMaBs01Pp0zUjOEfJvaZ4/VFy
	03GEfgmTwRgvuptZvWKjWBljYF8nxr2N+76Lh0vY5o9Q176Ofb6gydkCHEuboxc/OOrSLzwXXtk
	95qFRHmLAyfn7OKCAf7lu7vapaKp9Mhg9FBc2nyu+YDDg00J5MmbXPYCxyTzXT8UoPtnwEly5kH
	PngResGbw+WcB3/LzXal3xXLJXZDZSrtVZdnWD5V2GZgceCXEbmF1Pj4LcHQOuiXS6K99orm0uS
	iPQI/59ub5nJnciUL50wpC35TVoSdZw4hTUSKxPAgotM9JkNurEkhB1S7G9j2bqf/lctX/G1H4N
	hW7cHgcjtaWPdnzRwbOIBv17nQyxMWIv456CClgHVgYXJzY7xNY7tjPJN354h7MeGJTonC68cUV
	zaiyrks343QNdygBlRGULDx3zL7sSAmRllqie0Vyc1lzCicLIwj9sPNM9A8F91NZJ4N1TPzPezp
	ApFojs+dt4TztcwS5
X-Received: by 2002:a05:701b:418f:20b0:1ab:de8b:5f0f with SMTP id a92af1059eb24-1b50319d4f5mr4632900c88.40.1794636011415;
        Fri, 13 Nov 2026 22:00:11 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b2519sm11323590c88.13.2026.11.13.22.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 22:00:10 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 13 Nov 2026 21:59:57 -0800
Subject: [PATCH 07/12] HID: rmi: do not mutate shared platform data
 template
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
Message-Id: <20261113-hid-rmi-v1-7-afc43d97d766@gmail.com>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Probing a device with physical buttons modifies the static platform data
template directly, altering GPIO configuration for any devices probed
afterward.

Make the shared template read-only and adjust the per-device platform
data copy instead.

Fixes: 0b2c7a897378 ("HID: rmi: Make hid-rmi a transport driver for synaptics-rmi4")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-rmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index a4406bc6af43..0a5d32dbe881 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -613,7 +613,7 @@ static int rmi_check_valid_report_id(struct hid_device *hdev, unsigned type,
 	return 0;
 }
 
-static struct rmi_device_platform_data rmi_hid_pdata = {
+static const struct rmi_device_platform_data rmi_hid_pdata = {
 	.sensor_pdata = {
 		.sensor_type = rmi_sensor_touchpad,
 		.axis_align.flip_y = true,
@@ -776,12 +776,12 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)
-		rmi_hid_pdata.gpio_data.disable = true;
-
 	data->xport.dev = hdev->dev.parent;
 	data->xport.pdata = rmi_hid_pdata;
 	data->xport.pdata.irq = data->rmi_irq;
+	if (data->device_flags & RMI_DEVICE_HAS_PHYS_BUTTONS)
+		data->xport.pdata.gpio_data.disable = true;
+
 	data->xport.proto_name = "hid";
 	data->xport.ops = &hid_rmi_ops;
 

-- 
2.56.0.679.gc527c65306-goog

