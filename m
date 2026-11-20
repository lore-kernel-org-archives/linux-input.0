Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164259;
	b=cV9Vnyf7onGTHYex07z9oUxagITEHQOUEeT++AEvHN6Etmbq9aWIuejxzAISSlrdCWPP
	 AfV/nXhKlj+MrDJ0KwDh+AB5VRWj5eN26v8ZxaZeaofRsbyRBwwAp4O3rrY9d6tbUY0BP
	 prZnjIeISWaBnSjQTlzQiSZkwkgJkpKwpAf+22lOX8Vfrw1/CTzX0sL2ElTMCPNGNsWut
	 EaqbOdqJxH3UoTWY3AoV2436OC+0fbY/oMB/it6BYjekI+2tvMC8sw6WvY2N2uOsl3J6n
	 tNdjSreO35kiaJA9kdmJB/Y1FUO/k1HdQmLzyRDwJHTtt7wVXaU7wh3CTjiXYW28Nzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=jGsUaimTKRgwm19cze5+eu6IryKYQ+oQFYi+323HxWg=;
	b=FeaSl1cX7LrWTtIj+q1kzWMilUoeac/nLRzSwS2QpGMDx4EhSW9rteSBMjdHB3OUUoGo
	 LxI2ulmtwD3RU8t/FiTIfSdXF5Q1YQLDqa3/RCI7Fdp4b/S24aqRZdgMQRs2amSPUr0F3
	 OdLMAsNZodDASCmx0RS04xRk4BGZ7eShwyCxOZgMc3rStJV3ZHSe57hadQrzxe6JdfEL8
	 gSBNj2JWSVxzKH/60mbLnYtVUvIMQOPeh0TX1VCURtJGqXo/K8CkQM8xyfYLwTVsAMo4+
	 3LK1wwYxHi1Byh7sQeBQ5eykZeQFyOGV6Tj9sHmO8yqh0WWOhj+NLjPvMNd9i8MIKVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Si6A8syQ;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5AB60A262D
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA5AB60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Si6A8syQ
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3b4944a0eso565486c88.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164258; x=1795769058; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGsUaimTKRgwm19cze5+eu6IryKYQ+oQFYi+323HxWg=;
        b=Si6A8syQscdTAm+t/PwZXgRMdYzyOTEibotcK7OtRRQ3EFTI9ZJ8P9dUwFFz6+DClj
         EjsgrFdfBjDI5xt0YfipbotPsIAVky5oVbAJBCwKBgCC8m7VppB0AG0g1LaRHSqfBwdz
         S5wLaosptpsPrGw416/ZoFhS6uf2ssykJLpMrMePmIK7GaTxZVyzM2gkC8z3+hUs30w0
         MsMRoGU2q5g0p/OAs9QyEUrWHehZjRePp7bEFxl/WxS7aj3erQQECqeQmcmIGO9OwfAL
         rQPv9GmbzARLMeE/qIual+KITxRS78Zx2FYBl+hOobBYueuewQ6QERWb1ENRG1w+qgEn
         hlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164258; x=1795769058;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jGsUaimTKRgwm19cze5+eu6IryKYQ+oQFYi+323HxWg=;
        b=xT0EkwdFOkG3h/FaLPu0CUVLtTXHGC+dFqD/Ms315ti88IvTjfaKwt/+LcuyX9OYmo
         I743x5YTKbV7mx8eDJyd5jnBW1Scki7Hj86EY8ntQ2iAr+o/mSxxPg1dou7Egd/e499y
         aXSflRLqcd03AGh6Vcjx9Rxi+OyK08u/ictUWjApHfL/bjYAWyN9xcIEiayyxyKlfjfE
         8l5xE7uv2lJG7zfzRY2M8BsItDqWREOEB+cmtw9ZFK+JFyaLW8CeNhNuKSnk9bQCIfXP
         Td90BGphM/AjzUwlUWPDID79aGwVueqGfIW2S5DKQqksPXVTO1yv0uufnUr3e9rbd98P
         xfrQ==
X-Forwarded-Encrypted: i=1; AL+hErGnJFJIPmdzmwJpbfhMkRXdcZpLCdl2Fp25RHTDs8lYGPsOmRE6PX10ZKB3k+3mEWVmhMjcp/rKdL0fTA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+CifB8r/B3h/AfO1WSXLMbUt6MZx+RobDcXIxgA/0GboAMGzCk
	DdWj4BsrwrwgL1iffOZapRu4B3ePZtyBlLVwXROFBJfJdA2zMPjtgfKz
X-Gm-Gg: AYBFou3WcEny01Az7fIrr6KCn59qcEXr/upnc/KFxuv4IIDJim6i0K2PSUKg3dhucML
	+znKT/ceVAQ45Z7lcf0TmrUN9kqDvNNeYKcIZry8x64PyRuCJjii/ZmDp1vrlMCHuN6dwR/fbAd
	M58Po5xdXDclJH//o39uaca6fBfBENtFVyaQWo/qMwxi6Tb/dnxu2NUwA302B3eR43KTFsLcNue
	VLbfmHluc8Lg+o+l8G9m0YETrp2qC5HkcX5JnGL0EHxSBsE1J1iRNBLp0GWSPdC2tb8uPZ6m9RV
	YbW4tC2/8nFW5MXtLYKr4upVuxSm5Y9/0qVM7WJAolOpVB6WQQsKun3mSZeCPvshG3gpwhEl5dN
	/yqCtumF6PZ3g8J4HpKxQCDN6BG82AdcPVi3OCG1DNXZAmxCSlt0T4KID5LVXwyY+37tx7rLtEv
	w9NTOuIqO/sCofITN+yVnjVnLL0elygrnPGCjvKhTv5N7gK1mfU8apq4TQ7vpD8N2OtXS93N+jm
	CiAGG7nvj+l83Kkj0IMdgnJmV0OUVnWG7phzzjQ6Vd5N/LRPcRRW2FtgKFJYHIN1HB6I1w+JFYM
	31t2n5DGlx1hGbWvebbYkDLaHsNyYenWNW3EWHMOhCs0dzZrD7NWRU1o13ziBSMIltVd02rsdye
	+o22+BHo0k7unIFZYMQ==
X-Received: by 2002:a05:7022:7f14:b0:1b5:39fb:c6ba with SMTP id a92af1059eb24-1b5568fe968mr2136164c88.35.1795164258080;
        Fri, 20 Nov 2026 00:44:18 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:17 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:43:56 -0800
Subject: [PATCH v3 05/18] HID: logitech-hidpp: use sysfs_emit() in
 hidpp_ff_range_show()
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
Message-Id: <20261120-hid-logitech-hidpp-next-v3-5-ba39242d4336@gmail.com>
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

Formatting the G920 wheel range sysfs output with scnprintf() passes
buffer sizes manually instead of using the standard sysfs helper. Use
sysfs_emit() in hidpp_ff_range_show() to align with current kernel sysfs
conventions.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 19adf5796807..58f7cf84b995 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2729,7 +2729,7 @@ static ssize_t hidpp_ff_range_show(struct device *dev, struct device_attribute *
 	struct hidpp_device *hidpp = hid_get_drvdata(hid);
 	struct g920_data *g920 = hidpp->private_data;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", g920->range);
+	return sysfs_emit(buf, "%u\n", g920->range);
 }
 
 static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)

-- 
2.56.1.750.gf70dc682cf-goog

