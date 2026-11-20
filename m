Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164060;
	b=W5Pfmj55L5S9TE7HHUJDDmPZ6cC6r4q+Ls/lVgiF80W1M43sZe7CrYVMtOnXwPZqkudP
	 pR0XCaiOQZlfs47q30d+ehIvK2AVPqgyeGmtiCYHLs0Y0ygny/9uKcIH90bz5W8yLQJRD
	 OjHW6em1GghLCdhJlWXi+y8340vf3pYue4zXbieFBlWFCn0HVc74X4zdnUaz2k678Hwr9
	 GzZtZWvYe7sSmU2STFkq5WjwTtQwH8EUoWjKkkAflZ+ftf+8oVhK9s4jJRUUpPPjMkeKU
	 7Zb3ZjVcidP7x1rIICAYRgocUsG0i9LwUchgPGOWrg0yZGstKQToEa67tfUJrMjtP7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=PUXUXXOO5iNBSWhR9dVDhL+xLFTr0pkbQo+C0Dqwezk=;
	b=qzWciioC9chMwe9osbluZaANktpuuKfnN43/vZw+za60AjjyCFKUU3fI8vL86N5X1QsV
	 HvyX9qdnOdH5j4Cu0YJU8/xH5tF59VXUNRyRP51qZUJnn8PT9Q3vsbBO/z/9xn98lh5xJ
	 4YNXKgduoVyxBZjQDVsAndP53meb1E3Fnd2Wep9GEbLf+i7SfwZsTFghzX2CN/85uQjhj
	 d7zKNsZtLJqnYfaptfpJoyWIhQdAlmNHV9LrRMsqp8xtyXEvKTuciWe8ohtzcS29Qv020
	 +cMkeMBb0+xV8lCV/rrJkCDg981H6fzYzpRdiGOTsiQrLc8zl905sYWlyEnpbYfFZZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XwuvkxuJ;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3A606A338
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32A3A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XwuvkxuJ
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3863db981d4so141320eec.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164059; x=1795768859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PUXUXXOO5iNBSWhR9dVDhL+xLFTr0pkbQo+C0Dqwezk=;
        b=XwuvkxuJZSWwDhEkBjSfmCIYGsCXQ7BuuRgzQxRUnw61kCKpn6LU3ucPcwcZE7bRmA
         n9ajyBH+Agv+YxQaO+deWUiXo+KmtdUmgRfebphuUBq+lgMWG7d684VVWw+HEwalRjPb
         KCd569zZAweZvWsCaneu9l3/FFTelaj67v2fuz7twfjt9GGvypvaZdshvoYQVxE1AClk
         dE12pOIxIsQlKULmrmh7TlV3hgtYz9vsHoQaz7Tazm83YXUwwmh5hzeylfvD5aITxMPv
         QhOv6Mnehxzp6wGGS+0zwHvsHrRvBOvu5LLr7I4xziV0OLIGXXtL6yDsBnCRhKrT3pPO
         Wm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164059; x=1795768859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PUXUXXOO5iNBSWhR9dVDhL+xLFTr0pkbQo+C0Dqwezk=;
        b=U0bVZOqJopGlbOeeGj2INmiQX1QcM/r3SxCGqjpsZR0Biyid7T0yHjDFXju/rgCaau
         3hB8nSltBDTXGIC18M3vmDbk2oVcoBxNxJnfZR4PAe8CVK+FW8sw+vpXjHpxgDVwXEmF
         kEjmb8Vsk/NbLZSYlzlsaWF5Dp2ANd+8Ok3AJlu7BNAMqpbcaS+dH4IP6nPZvJug6ZRF
         NOD7Epw/RAme/dEfYlVhnJq4r7i0BMiBrogbYNajFp91h7dmfOXclKsU2Ya/i1NBQgWC
         oL3VFPPtmg2n5SG3I5iG85WZLfERnXrQMpC1lNv5TaciNkPzGvei+9ddAdZLyx/QtvBC
         OC+g==
X-Forwarded-Encrypted: i=1; AL+hErFF7UaCJ8Bl2r0za1oHxx+08VWWEeVFHicmYj9NvZLbhL7yyXVVEx6pRpI4KrnQentvuM5JViQo6/ehvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8tyf5iKz9HkT6dZrY86K1P+vKL+bzfmP3zX5yD9oxQ290St3l6
	vIJ/aXNflWoTPnSmFPeJ+BI9hVuuuKFedSU0HHtQL7gSc/uaePdwK+QK
X-Gm-Gg: AZFdTZcA5/Vr3iCuB1H/wlfrDT0TOAMagq2GhpmtgmZ6av0qPPDVhz44vkVVQDRFsv3
	fEvrl2ERdxAejlYZjVJataGJZV6JkU71pyx+3UArkUX+BzGzV7GWAlNJV/wGp0vyery+R/EXPtN
	Icpa9odJn2jfNyehEr7OX4xlWc2nQSHuJMkIgiyTSrG0kfquWoYkWVJrJD21m+zic0NismkJJaK
	2DeHhqDgFGdJxuWCUBltYqmPnv05mJOytQq9HSlaLFHlblNxjxjvYKemoCga8vhfck51XwY7jKp
	ewFgiqxenz7jbrRodC7H7UQz1kV2gq5eKOHQToj7v36yrr6rFnOmKHc/xhVqOrZ9rmKOyad0gO2
	tNO2EhMESQORE7pVIKXd3RZwhTj4FUIlBMbljhUiphhqRD7hEX2xpQbwyMN6QjC/iJ8kFygbv0T
	MU9GWoReDEkaq7vdhAuoorcnSrV6FaSuUvuy2KWMILhlneFhR/0DFGyACPZn8HbXmmqErkCsQcc
	0iBWDwtSNQ0EKUBRhzWJKYbBDXGnMfrKluzT8axkxOBjD/EQXk2dd519qQq7bMhrqiYCL96WFu/
	tyBexLp4UA8UseW6aHL80+PXair498ex7tCbgKc4KMuXJC4k41rirDJXO2ih3glosFqmRzNrC4O
	3AX0ymCxay8bPWYu7LQ==
X-Received: by 2002:a05:7300:c01b:20b0:385:4b9:18ea with SMTP id 5a478bee46e88-38571027a68mr2361900eec.35.1795164059305;
        Fri, 20 Nov 2026 00:40:59 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:40:58 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:49 -0800
Subject: [PATCH v3 01/14] HID: logitech-hidpp: fix G920 force-feedback
 initialization timeout
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
Message-Id: <20261120-hid-logitech-hidpp-v3-1-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Commit 544315e40172 ("HID: logitech-hidpp: move FF initialization to
.input_configured()") moved Logitech G920 force-feedback querying and
initialization into hidpp_input_configured(), which runs during
hid_connect(). Because hidpp_probe() calls hid_device_io_stop() across
hid_connect(), incoming HID++ responses from the device are blocked
and g920_get_config() times out with -ETIMEDOUT.

Temporarily re-enable HID device I/O around g920_get_config() in
hidpp_input_configured() so the hardware configuration queries receive
their replies during input setup.

Fixes: 544315e40172 ("HID: logitech-hidpp: move FF initialization to .input_configured()")
Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
Closes: https://lore.kernel.org/r/CAPb1+K1-pirdLGZ1wTUw26G6pvhg7rGP3QZ172ys5DB7rNCf5w@mail.gmail.com
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 60fc6b86a085..85d8d168ff15 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4096,7 +4096,9 @@ static int hidpp_input_configured(struct hid_device *hdev, struct hid_input *hid
 		if (!list_is_first(&hidinput->list, &hdev->inputs))
 			return 0;
 
+		hid_device_io_start(hdev);
 		ret = g920_get_config(hidpp, &data);
+		hid_device_io_stop(hdev);
 		if (!ret)
 			ret = hidpp_ff_init(hidpp, &data);
 

-- 
2.56.1.750.gf70dc682cf-goog

