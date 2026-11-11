Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380219;
	b=AUyTonicM9vh6bkAzrwuowU7m7OmWMm/WlDSWYbFnicHUbf4qeRobILYyBdVHFpHS4Ye
	 n/jPfNIlCEav02AQj0DjBLF7xBrHYoTC2JwX0cMKscJzcCaLcNjmGe3BuxAOaFW0ieTqO
	 4HpAV3BugW0SaJpnkBYZCylPDSFrIC4LlqhwjnSuP4swywEXqt+rilT2FKRnfoIIJH7nL
	 MpgJTOesFDxjLK7eeZbmdQ3yxrYl4V0y8ohTPUneJaQvAH+g16zHYHUDSuhKUAWX3y57a
	 XfNfy1XbMqGRhdoCwnY8osLZEUBtIK259Rhb6UqVBdPUyY1FMhQj9u2IptPxxSQDpwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380219;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=EdW4k8yvohMzIWfj0xykBEvuZwxJL/83yGbzJ2fx2vw=;
	b=Yi/tI6DSivo8gUWkYSTSlxKZ6CATWvAgVOmoc57Eesms9lwU9d7SAOEiHCxCiOvY4ido
	 qsqeBVVfHEEQb4dpU+Vf2WyqXHfNmCgzyAFlorKR+LLyzxLpduK/K0dx/W5l4ltXLLxKn
	 9OhahkvjZSJhxglS9oPsoC6z1uHVkxhzlEErJoaTHSG7+8cCZM2Tpf0yaQ74qfHJVnrnp
	 /MDzcm01VLxOEHhqnVCSMdB1QP+Ptf9mJ67tnb4gY8RBEgWkK1jHb6gvzP2Hf3Bs83tHg
	 cxrgVjdTQ1qWEv0FJsSweVgg97GeG6NajTL2qPIeJcARDFtpVjCwZhnezWBRcX649qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c4QJEOz6;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7C606B7D0
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9D7C606B7D0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c4QJEOz6
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3ada81853so2560434c88.0
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 22:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380218; x=1794985018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EdW4k8yvohMzIWfj0xykBEvuZwxJL/83yGbzJ2fx2vw=;
        b=c4QJEOz6xAgHzizvYunhbVTDP2Nt0YhZ4CmNh0WEHHjCwBZ7qyEal+UkmjiYKhgRcq
         0krEmbfHv96oMWatc5dUA11NYaUcoCt4qklcMyyiXTo542rnBFTQkH5RTdg2lEi7MPLh
         mT2kjXIf9eF/VYe3pdym+56dzCKqo3Pg3fbv6yE18MWPDxZUDYx93dnuvP34WgzA3gYH
         NJiQV/XsfGpDeAvFV+SpsG8ctz+eDRb/EBMyweTntIHG1aqrxlt36IyUE2UHJyMIAiyV
         XVqE2iavSt0dR5tMiTyeROxJnhkIXxwtA+phDzMypcoiKHFo8QGzzAd7A4KQgXcHnVV+
         n74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380218; x=1794985018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdW4k8yvohMzIWfj0xykBEvuZwxJL/83yGbzJ2fx2vw=;
        b=PtdpBybKvbUxJ03ez6V4/U2xsfOsEjrEIi2CUI21c61FtuH9AIfeVd4G0xiHILEL2i
         8DS0Fv0dbk9NkvXpVWCCh7fLwl5WQYsJv2oaqb9ojDoXVaCSxQYtk9Jwd0Z+OksFJ53w
         Ktq63d85EcPPPHjb3P3f6ISrH4SvpTBXlAeIUlBNc13BPeocr8ul9BvCldtLhKvcujSC
         4UfbSK8qiPk2/JTZGvYdc15YoZZOnPpwQD1HoDSZD+pu93X8XCm7ZpRVa/zLjhVQdPfH
         rczbixTJ83CQxAC0ASr26zALtncrNe3zdPrBLdoEc3G6x4r9zjFiAAcTUA1hrgWGwK25
         rMXQ==
X-Forwarded-Encrypted: i=1; AL+hErGyevh5SibO2/GtHrH1gtNb+OYczgb9d3jUP0YxiqikpvgANRhrAitRyXeYDVqKmIO+GqqG6PgJ5TqXkw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8rVvvT3FLKsOlFOXUnH/Kso0lWGtzwEFPfoKy61ygoDxrtj+IW
	OyTa1CfP5sPe/4VZv6WieFvMGHldzsD4U3knAyOGABwmDscX39OVpSlF
X-Gm-Gg: AYBFou23EQRz1GOzc8cfDU7udI5R2QKlJP1X9SICrufw+v2wGd4EiThxzOHp73n/b8q
	yBoFzEGGN7cGu1SU6scZB3+G2AbEJs+q/Rtb6E6GJla7Ya4+JtUhLCetVDgxc8z3ftUQ5kftDfi
	l9Scxm2qJNyqUAdjOo2WCDPAcQffMK00q36My2tAwqOWDU2HTkHUL3N4fEpTTsmHerL61kfu2xK
	GD57nGHjPrPoh5XrQ6AY2dTB6nsDiZ4sv9qc5Y5U+Lu/qbL6TkLS+IYw4POq3+8Dde96s6mnBNz
	S3D2jKERJmX679KQQImfNrSn+4BucRUCEX6PasKdKE9Q7JM0aEVm7l2SmA31SyqQyLEsjyDNp5V
	w0gHDTGaqPOr8+bLr8Hf7cNfdmMJHpfE7xg7pq2EnAfs3ZlqjZ3j5emEJkPm9LoglzD97bhLjBb
	cU8ZGm8fkfOCqZqRDvslVGh8qZwOYwr2OcBGUOWnEnjM0ykx0HUPLewqL+tnYPAYGMmDPusNRDP
	X7Czlm2gSHkb0FOxApwT98PgEHE+4/APBDQceNOyb97RJODrkQRraRAygTAmGn08vlr6F9/zIOk
	FC3OLGHwRh8t0k42FvI/4/dDLRHaeeM5sB7vACE+3otuDgOjJIV63DqCAuUxY4P5qXXvJMaUlz8
	lvVQZI7FYOQi/9erduQ==
X-Received: by 2002:a05:701b:2302:b0:169:9f67:a91b with SMTP id a92af1059eb24-1b3c02f1010mr1448834c88.12.1794380217651;
        Tue, 10 Nov 2026 22:56:57 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:56 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:20 -0800
Subject: [PATCH v2 22/33] HID: logitech-hidpp: shut down G920 force
 feedback on input unregister
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
Message-Id: <20261110-hid-logitech-hidpp-v2-22-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Force-feedback teardown currently runs only in the force-feedback
destroy callback, which is deferred until the last open event handle
is closed. If userspace holds an open handle across USB disconnect or
driver unbind, device removal frees driver state and destroys the
command mutex while queued force-feedback work is still active, causing
use-after-free errors.

Move workqueue teardown into the force-feedback stop callback so input
unregistration drains queued work while driver and HID state are still
alive. Keep calling stop from destroy as a safety net for registration
failures, guarded so repeated teardown is a safe no-op.

Fixes: 08c453f6d073 ("HID: logitech-hidpp: do all FF cleanup in hidpp_ff_destroy()")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f7fefff0aed4..ceaa57af6eab 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2795,14 +2795,32 @@ static const struct attribute_group *hidpp_dev_groups[] = {
 	NULL
 };
 
-static void hidpp_ff_destroy(struct ff_device *ff)
+static void hidpp_ff_stop(struct ff_device *ff)
 {
 	struct hidpp_ff_private_data *data = ff->private;
-	struct hidpp_device *hidpp = data->hidpp;
+	struct hidpp_device *hidpp;
+
+	hidpp = data->hidpp;
+	if (!hidpp)
+		return;
 
 	hid_info(hidpp->hid_dev, "Unloading HID++ force feedback.\n");
 
 	destroy_workqueue(data->wq);
+
+	data->wq = NULL;
+	data->hidpp = NULL;
+}
+
+static void hidpp_ff_destroy(struct ff_device *ff)
+{
+	/*
+	 * Workqueue teardown normally runs in ff->stop() when the input device
+	 * is unregistered. Still call it here as a safety net for error paths
+	 * before registration completes; once stopped, it becomes a safe no-op
+	 * that never touches freed driver data.
+	 */
+	hidpp_ff_stop(ff);
 }
 
 static int g920_input_open(struct input_dev *dev)
@@ -2881,6 +2899,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 	ff->playback = hidpp_ff_playback;
 	ff->set_gain = hidpp_ff_set_gain;
 	ff->set_autocenter = hidpp_ff_set_autocenter;
+	ff->stop = hidpp_ff_stop;
 	ff->destroy = hidpp_ff_destroy;
 
 	dev->open = g920_input_open;

-- 
2.56.0.542.g3ef89b7020-goog

