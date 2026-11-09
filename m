Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204683;
	b=WAgUJS56rx9IENc6OXc3d7sUmnkbMImZtrWNnTI5KjdM2saGCHs+AjTrUBBIGHbXQeUG
	 ZYNm2+QUvBtAdfNJESFO2WUr7UaMA+6/YJEb83TmxLzNDhrZShb6RZ5SKn0HQTdbgWdg7
	 etOdzAqAQgH/QRQp1ZdcxrZ6cytN7UWoELLup4BGtG57ynJdrhUi1iQRWONeM0Hnp+Tyo
	 1e3gt6dGDwV+bDqluqB/HI+mW614/hnxRDgveBrh9HWY/N/x1u5XLLwQDpRDuXzw1NPys
	 1QFtnWVyGyD450khTAlt44TeZ/JcGU6chgb+EkvOMmhTWPJXvgAXIkodzr7pEG0n3rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a7gqQCE7m2HcC9JXg0W4AViJmVsQ3/d2B0qIqfzhxCs=;
	b=dkgE1sqXkEHRqhUD3KLX0kDzpBrP1LUbzHeQQS3XSXS8dl5rzpkokgTgwzC7naH881Rc
	 MzinQA3i5My463W9C8uZUSi2sPRM6D3vOqUmwrUu4+CqswFeVEdMtriNx9PydLEF8GHyQ
	 fQdDdV6q0zA093Xiw5ffHh5c3emYTJytRr8pKRIQowVJ8CoRIG8mUXVDhUb20dmMHAHtq
	 vf4xsc+lMJTBqyB4YGHKCgS7NcqaptRBf/Ga02SEzBTfbujeVr8yH+yEOcktMlpWhZsCi
	 8ztZUv2d6grNAEQtr3NjzWQA1fzHVK8rECngPrNijbvm1Lc1evfK+qz0CpB2Yeksr+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ijQpypUd;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2B7606D82B
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F2B7606D82B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ijQpypUd
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36f8cdd30beso1230807eec.1
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204683; x=1794809483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a7gqQCE7m2HcC9JXg0W4AViJmVsQ3/d2B0qIqfzhxCs=;
        b=ijQpypUdFVKiGv+vQLOqzPulMs9nwKZebdBfLKi3prmngSfONCPy9LKCVKay960cxN
         QxdHyXNONs27fF5uK9vOAzKfph50ClbNcgxvgnoa7gU3uoWOp0Qh3xxCxFE1ZfbfuOW8
         qUuS8FKTLY4pkpbXd/KTn5wWTfulmeNkbd1tRYEtUYI7UWQ1ofX8Axwtij0PFjsNrc2k
         fFhhvZ/r6iyQI54E4G2iHfOycqPvuK+YqQoNDjc9OWIW1zIHPEvc6HGsiaCfwc7TGulS
         hafcagAqe/+IPE+GHRniso6qEo+olSSaHptgrbugY0U9wdLALkoekbT2C9zEePEP2WuW
         Lf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204683; x=1794809483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a7gqQCE7m2HcC9JXg0W4AViJmVsQ3/d2B0qIqfzhxCs=;
        b=fzLURlUcQrGU3ERUNda+g3faee17PPot4A3WoK1ZZB6Fi3sjWxw3Y/6DZJiGzU1H2Q
         mdlu9b8YtQbxVukZTq4OIysvyCmy88CMz6xpG6kW/RJupr6yBjqbHk/iVsbMh0emzNMe
         erG9C2b6k5Z0sEt2+vjT1VzjRoYtb0X0Ckm0DaDcaRG3l/9T51/96NDIhWTIjjxFGj9X
         9KQ8hHecl+GWWW+U3AnxCtjw23Nt1nuNWA07RxoCd0GC9A8WnuV2xmRvq2JYcLFvqT4u
         edL6F+TPN1sbY57anvr0jg8N74nHHlDQmpyz3TZ4LdDgWpMfv3UeNPbGSJFPZwz/0OZd
         2Qeg==
X-Forwarded-Encrypted: i=1; AL+hErFsi0FAoZ5hL3lk4zf3aawYYFX2Wm8LP7SdO9+jKgg9x0Urg6KNySjFtLIUEua3Be3H830tgFx4AfJR2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9EPLRATne/Ku2hvzZvWD5Yu7MHrsR5jA25GyC1ucqSQhs2SHfk
	+kKnFUeOtyJTq5PqQ7fhBoir2dOAaBvab+UH89PnE+pK4ibvmIidr8I0dBF7tQ==
X-Gm-Gg: AYBFou3/vXZz4jGuDmP6REoS3CttrL+hI2/ojRhFcustwins4ykGnHj12NiLOMgQ+Lq
	riJ9bexcFZ0HRQ45HyrmzoHNBi0uYCnZVLL7xBq2qeKUzYZ724FStwTf2ssUHp34IPzFIAbTkKk
	9qvPhf0EmyGNNVdL/57waEX8PHQlpxLyEYJ3AXzcKEnQSKw9ZfM99MVNDTnnGUFK1WP4cgFd0gV
	fZIrh3aaPsWxDVE2wnhA0HtshvgEjeCBZ2Fc30GueYeXoDV/K4RMxXNcQ0qwe5pqnrvOH4jyW/e
	XTie9ptWs53cvNLnwSHMXDI/lemLYsMUGhYC+DtXUh6ZsrcgcpLLIAiIMNqNGlFqDeEpWwdALJn
	JylNbJFj5oFCI4QtQDcUEeChXUXhTE01kkZNyOjAz8LQ2o4PVJ1M2vbv6SMTaiy3i1seXVhvz9w
	ybsH1mYoxcL67idfmT5Yk2gHXzzfieNXQxyS4D0Sdvl22u4O1nQcdA0Xldm4Sc70B9Z5AZ5K2+q
	Xh4J2fsPpLNnjFQymELkg7dPh6kRMZ5E0Y+RENXm/9jgMMKOHSZ9B9m8mX/rvG9CYKkJpRWueim
	5tuiZUC6ygw5ewQXFUUPqXM9s5n5jehzlh3kaD0mHAQlicA+t9CTh6hGyRzvrGFqxG32cDlMZ0x
	C6UWtlzSuhxwh3jY4
X-Received: by 2002:a05:7300:824b:b0:369:d6ed:f2b5 with SMTP id 5a478bee46e88-3725f013280mr5779318eec.39.1794204682322;
        Sun, 08 Nov 2026 22:11:22 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:21 -0800 (PST)
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
Subject: [PATCH 09/18] HID: logitech-hidpp: use sysfs_emit() in hidpp_ff_range_show()
Date: Sun,  8 Nov 2026 22:10:53 -0800
Message-ID: <20261109061103.2887636-10-dmitry.torokhov@gmail.com>
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

Formatting the G920 wheel range sysfs output with scnprintf() passes
buffer sizes manually instead of using the standard sysfs helper. Use
sysfs_emit() in hidpp_ff_range_show() to align with current kernel sysfs
conventions.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0a82914ea314..1ed940352fd2 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2784,7 +2784,7 @@ static ssize_t hidpp_ff_range_show(struct device *dev, struct device_attribute *
 	struct hidpp_device *hidpp = hid_get_drvdata(hid);
 	struct g920_data *g920 = hidpp->private_data;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", g920->range);
+	return sysfs_emit(buf, "%u\n", g920->range);
 }
 
 static ssize_t hidpp_ff_range_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
-- 
2.56.0.506.g506a7eabc5-goog

