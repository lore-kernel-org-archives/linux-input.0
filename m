Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204687;
	b=pcQMB+G5bVt+I7y1HXA63fCDNsJ7EWDgeyOCd3mAOW3oBIeoMlXgRtAgN8LpTsZhdRMy
	 ywu4GEyU4FfIUpebZmNsUDis+Bi4NfEvaWp8HmjB6KcgIN2xQjQgkqYv8l5tvt/3DjV2e
	 j0rGDybtwqEPKIMGhIqmgQSh/1J1/sKQCKtItGFiITG0NYAv9h53gS8g64NwF5TA+FLiY
	 vSVex/v9gcwH056be/D/6VWm5bOJGBQV9+t781N6W91XlBK0I2O6L+7eJWp7nFvtF0jBJ
	 JiSlQ0MFza5hkxms5nvbBHtdlEawPq8EgViTKpCREcaSn8o+gfMFLJaOLiVyNPBt4sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RvWIcIIXPCWIw1rDnK1jAirBnM7DqOltnfOILQIkZoY=;
	b=QQwa6HDCHibamoUFQng4IOJ6xdIG/4Be3BLLBIL47B5/kUQave+X4SdIZe0wjkpI2nM2
	 734cIDjw5vmWxiBSsZj7GrvdgDtF3pcHsPfH4AffnzyIQ54QLFeIUw8fqr6lUG4Zd3EHz
	 p164djj8F+3MkuiBeUgqg8LrTAKuhoZ7kda+SnXjlKeMg+VVgt7NiSgAi/b4l1/K6YJy3
	 79HMiokipXlqLRiN/Temf43BWeHeYqpwa2gyNL62UTaqV0erB67gUxSfE/I7pq8oBV1ug
	 b4ByRexh1d3/+xBSNjTfJ0P2eb+k6Y/TuDnJzC53Feux8KF7/4uGitt3wEHL33bG8zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NGgyAfjr;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B3606D821
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B99B3606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NGgyAfjr
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1887665eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204686; x=1794809486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RvWIcIIXPCWIw1rDnK1jAirBnM7DqOltnfOILQIkZoY=;
        b=NGgyAfjrK9ii4LTmvG4jUz7TgWgVIB85fDPCYxyVKyTzqHdPYC/Tlj9r5qShcf0ITg
         lahCrVMxhhgvc3Zi0uAJeZaFphxz5MlwjBRg0zqFZl/S9+xmgVG2gmAGpz6msm2Rgoa+
         8Y4UR81ccmETxNd3yn5Iand+ARteI+5zBX7QLVUxlBrNOoOfkv1Q8CpYwt+F6HdFdMOu
         QB3NpBGfpIvByFzJr3CXV9p245JWEcl90GsDFl2ju2rB7AhfFVkh169j+Fi21FZXD1fF
         c2V5V0RfzBQjAmokrhCi+OMHJvXkdzFlOWqTZA+RY/wSxy4TAGCvBAbgMN0aWcWwJmgg
         kwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204686; x=1794809486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RvWIcIIXPCWIw1rDnK1jAirBnM7DqOltnfOILQIkZoY=;
        b=j0nCJ+JbsAbKP51lL+yYN6+nYkO6E/8xqFrg2Pkuq89c/4iOBbIT7NRpMdUCi+WN17
         /jxPodUQ30aJPnFp7g/zecbhqENurEAHBFgxtIv9jQ0H91LXhv6yTBm5egkYIYoXQ54w
         ivJWcHY1C/h/Lu0J9Fn9UEAMFt+YbCffMP95sDahxynSPPNPcY0NlF/w+ywnaZMOio8e
         cire6/n6kN9/B5YpEWykdbs/UzD6i2IBDtQT/qasx8gSLdj400BRJ5A30fT9IQ2WltNT
         kTFl22EClG7yRo75fuiM8BCThku4dWbQ1IgatMPslGX2pQvBe66UtdFhtdOhzN0tA5XF
         PWRg==
X-Forwarded-Encrypted: i=1; AL+hErFU8jIk5GNg0sRM7ODMGOzOUIf8+kJDDgfq7ZV+4dKy04XyEQNkWOQckbvCpv0a15g6CYvy+YwWwkNykg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+zF+yagCbDS2x+ROicXAurm3yy7xXBElrlCYZIIM4VUxwnU3r1
	qgpb11uoRv8USOxnwWQDfneXHreWDxeSbfXzoYXkT/Euveqs6oF2VeSfmzADzQ==
X-Gm-Gg: AYBFou1AV3F98U4UVr7BurQR7L5oWQc09hpDzDqQBvYWf7IPiaAbj7Gt+koZv6WTsg8
	0rcmmxkDPWNmyV0gWg2rjxrZMbP7ET5iERuA6k+V3uk2QsDOcj0efg1i5SeFwQs8pg1FsC1QiJu
	GtSq9zQm4WLO1DI9H7iot8vSjuGiH7p04gCtQm6CA0uOS/oGd0Un2ipJqvTt1UzSpWEkIFTomWT
	ZdrTAJK07FsiqZOL6J/pQlcJvtB+BZ4ZGoNiFrxWwlOL55o3+x55nGJ5dlOAvDdvnwgTAMMye/9
	cuEcjtjXF23bCdVXkeH35IxaGegU/hJZ8WDtBIT9SQCwjawl71KIWQXMMqAS2/v0i8Pq8qeosPH
	7ICP4L5ssNTDcqQEXNG73MJgSAykmEa10NHnMiIEFwOhSFLbvpfBjktjHe+pa4NklH3ga36PU8K
	uQQWQitHlrEiH9tIsYT6IiJ4NZUKHbffxAP0BfWiukLhoaBMbMlNqfv0DenxyYbYp6PH03q4qty
	0/K50pqtmmf6eL/hXXf6ia0q7iHRcUKuNPPdQQKKsz+u0B8PY5QHekNRfoKjQ0gQJQiVZeUkWAI
	eVlwRqEf8qEsbRnBqI9M+yg+Rsx9jcy2zvq6ub05SKfC48W4BJUBoWmKA9I00yVCVXtHBSOxBCc
	yH2lu+tqmA8wMCRPn
X-Received: by 2002:a05:7301:9f18:b0:356:7ddb:2e54 with SMTP id 5a478bee46e88-3725641e19bmr9182681eec.29.1794204685753;
        Sun, 08 Nov 2026 22:11:25 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:25 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/18] HID: logitech-hidpp: shut down G920 force feedback on input unregister
Date: Sun,  8 Nov 2026 22:10:55 -0800
Message-ID: <20261109061103.2887636-12-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index ad3edd15cdd2..5169f3873257 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2840,16 +2840,35 @@ static const struct attribute_group *hidpp_dev_groups[] = {
 	NULL
 };
 
-static void hidpp_ff_destroy(struct ff_device *ff)
+static void hidpp_ff_stop(struct ff_device *ff)
 {
 	struct hidpp_ff_private_data *data = ff->private;
-	struct hidpp_device *hidpp = data->hidpp;
-	struct g920_data *g920 = hidpp->private_data;
+	struct hidpp_device *hidpp;
+	struct g920_data *g920;
+
+	hidpp = data->hidpp;
+	if (!hidpp)
+		return;
 
 	hid_info(hidpp->hid_dev, "Unloading HID++ force feedback.\n");
 
 	destroy_workqueue(data->wq);
+
+	g920 = hidpp->private_data;
 	g920->ff = NULL;
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
 
 static void hidpp_ff_close(struct input_dev *dev)
@@ -2922,6 +2941,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 	ff->playback = hidpp_ff_playback;
 	ff->set_gain = hidpp_ff_set_gain;
 	ff->set_autocenter = hidpp_ff_set_autocenter;
+	ff->stop = hidpp_ff_stop;
 	ff->destroy = hidpp_ff_destroy;
 
 	dev->close = hidpp_ff_close;
-- 
2.56.0.506.g506a7eabc5-goog

