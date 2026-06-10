Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A9C425CD2
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104309; cv=none; b=YdHeG0EQzQdPjljf+cYDodUeJI/mgHrlsBloLCF/em/uHafz0c46mOEuQ3s70A08zYXy/szIAofeq+nMdDH9j+RaBEqfLNvM+pFcdMRlkHZvDnGOsFeyxM/Wexpu+2ESUdCzeJEYrDcgjqBqdiZ9pVSLOiAA0+ezV9RA0t4t0FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104309; c=relaxed/simple;
	bh=nOLWi0x+sHBQQKxXtuJ+nKnAv2yOVEeKhGv3JPfPYCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pri2lFapHUS/tx8G3u5AeTPCdja416j4WXexh0rTvnU/cTrrw165uaWbpzJrd9pQgkaD8uhqnHqHRggwkd+RRvngxP/LGduYPyA8qzM36bav4eGWWnwFDPmWNiB4JF7N/0C9xL3TlkP1YlX1SrRf29jmgjHFK3TDe8ik2P1WsEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=ZbOd/od5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="ZbOd/od5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso57828945e9.1
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1781104306; x=1781709106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvkxwS9FqCghLm59Hy/sSBR6UhIIHlG6JfFAvyc290A=;
        b=ZbOd/od5QJIXMsxUuOsjrGAgwtbh3hPk7P5BBqxHhiJ1unCKHCNySKuW8w3Dt2Ro+Q
         ziKKsDj6oWnBeGL+pUUewBQsik1OTyRLTNAeLVa9LE9LTGon/kdP8/1x298ZI/f4hSEq
         JRDaL8UOcH1DD7umZtidSCP1N/cI+VbvvRYXJ01/Vz/ujDUvldmG2NjA3z3oqnpb05Js
         FwEuQ0N4MsGwJncknAxkcYh3y/hn5E62k4NxvjJeGuNL1pJORuIc8Zq5LAQOS9JZbmJ+
         rOw6szFDqIjCLPnH7MVPyUffUMKJenOvbwjcyNgXMZ4ThXzQnCOqQ7/YAHPxXrBeH3fy
         ilIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104306; x=1781709106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IvkxwS9FqCghLm59Hy/sSBR6UhIIHlG6JfFAvyc290A=;
        b=UHSsfdEHb6RoXuVUTgXvW91AVWcv5LcdE+Kde+bIZRwE4OY5Be9yj0qjTVoH1yjNsD
         4iBf72esF8qKdXFeTtJLeN0/O1UPVHRAIbl56D4HPjnxovsqIdobrSecjHmcRQEHXKsJ
         MpI5Q0vcGU/v/PJ2r331MdnY1oEG0OjF6YT9nu2bLNKw4yzywU+seV6KY5mGU6SxMjPO
         TcIWXa/m6w9Z9RI8bObLS1jMMDNVO0KtZUmXqCP3/lWIlmO9+LhdmCSxQAlck/s4yf5J
         AoLG0QEBtg+x6/XfW1gwSvFBKGDuW4UIrbgLDzeVoJWwxjqVcrcR91Wod55F/ypATQwH
         rOog==
X-Forwarded-Encrypted: i=1; AFNElJ+WivI9IhtVbKvyuJo2gJqmOPHS45Ed8z+vI0EZ7CGEK5DKYiRZtHbsxoEew3Zf9C1rso/0TmJbDmzHxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqATJMb5J5xZHTutmXiN/IQ302oLSsK2qBbUeUtNvRc4XJel3P
	/b9oHCl9gQUhB1b/INWyYnkKH8DBZvM5tz4aFkPYlU78TSM7x5eBCxOIHp3b9tVt+NFhDemH3C+
	DKRnp
X-Gm-Gg: Acq92OF1z9bAlJbioU/rJSWZ8rSCzfIhBlMPQ6nfuEtHJ8yDVp0UWS9x4fPmZu32ii6
	fE5/ZT3LKzLzB9ZCiiw5E+oE/1vv2pdd9eNt6oI3IAqh3Ri+CuBt1SnM6MBFGXipKp+JkOZexAn
	9nvOpQL/KfP0BjwFij8sf3VOc2r36yvR3wBk4Lu3Jk+5FozrgcunNsVtK5SZ8MNEu6F+EHua138
	vKtb3ny5zIokyzqUvI8WbieJ2AbaSzNyFSNvzZ6mDNeBD9FZS1Tj+BnvpCa6n4vPqh6ACqmTvqP
	5QlZwBRypXkLEi6EC452GulctbMJh/dfoCJ/ks7e4SkNdMqgbimCH/An80nlmU7GaimEqcT8Pxj
	1smmAJ7xIEa1G4PyOfW3Ox0qCvGs3LBAdt1JTwbuh1PzUBZkFGfEghKFULUpREqULOu22Y/5B/j
	eWlan4L7xeOjoiFnWUnAmzG3Dr2U2eLQGay1Zlx+p3LgM5AblWbVs=
X-Received: by 2002:a05:600c:34d6:b0:490:ccf2:6dca with SMTP id 5b1f17b1804b1-490d7223706mr94054015e9.20.1781104305699;
        Wed, 10 Jun 2026 08:11:45 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:1a6e:6004:a565:d3cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm585537575e9.7.2026.06.10.08.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:11:45 -0700 (PDT)
From: "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
Date: Wed, 10 Jun 2026 16:11:34 +0100
Subject: [PATCH v2 11/12] HID: hid-core: sanitize user input in
 'new_id_store'
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-mod-devicetable-hid_device_id-v2-11-a1d7473ccd9c@thegoodpenguin.co.uk>
References: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
In-Reply-To: <20260610-mod-devicetable-hid_device_id-v2-0-a1d7473ccd9c@thegoodpenguin.co.uk>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 "Pawel Zalewski (The Capable Hub)" <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781104294; l=1454;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=nOLWi0x+sHBQQKxXtuJ+nKnAv2yOVEeKhGv3JPfPYCs=;
 b=gv82IWdwbIYExxBV08C4QIt43PqnAoIJx2tjm4l1rDFcodKv/Ayij2OfKSR2H57PnGcH/4xSZ
 CSpFw8N99d3Cj43HP7uivxoq7lDJ+2zTNufk5SHETtVbXnQ3KiBqnIi
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Only accept 'driver_data' values that match an existing 'id_table'
entry within the driver. This makes the field mandatory if the
'id_table' is defined in the HID module and disallows overriding
pre-defined values within the driver module with arbitrary entries
from the command line.

Signed-off-by: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>
---
 drivers/hid/hid-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 41a79e43c82b..e060e5ec4ea6 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2647,6 +2647,8 @@ static ssize_t new_id_store(struct device_driver *drv, const char *buf,
 		size_t count)
 {
 	struct hid_driver *hdrv = to_hid_driver(drv);
+	const struct hid_device_id *ids = hdrv->id_table;
+
 	struct hid_dynid *dynid;
 	__u32 bus, vendor, product;
 	unsigned long driver_data = 0;
@@ -2657,6 +2659,22 @@ static ssize_t new_id_store(struct device_driver *drv, const char *buf,
 	if (ret < 3)
 		return -EINVAL;
 
+	/* Only accept driver_data values that match an
+	 * existing id_table entry
+	 */
+	if (ids) {
+		ret = -EINVAL;
+		while (ids->bus) {
+			if (driver_data == ids->driver_data) {
+				ret = 0;
+				break;
+			}
+			ids++;
+		}
+		if (ret)	/* No match */
+			return ret;
+	}
+
 	dynid = kzalloc_obj(*dynid);
 	if (!dynid)
 		return -ENOMEM;

-- 
2.43.0

