Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5A1E230E
	for <linux-input@vger.kernel.org>; Wed,  1 Apr 2026 06:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775023458; cv=none; b=kb0ffxrIEkr81c4b+EK9IswA5PPvG6Za2B45APkVR5UHOJh24jwSRL+z6sGfWHChUI59SGIRsT5IsjZq7ERxT2Bh5S3cZzD3l9k3pZpqB8sFB+wMX00LWuQlIB10Yid8suA/5alu7WKB2K7HgmtQlIVz2/OyVss+m69TLY8m/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775023458; c=relaxed/simple;
	bh=x64yDdQZgmLGRaBVOFotxtbZSMnQmXqVrk3o0i7yamY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jzyOilQoeMH/jbivDIGem7GVNZF5tgZ9UBpfydZzTF9DEnImsk75ZkdVC5YymeJ1mCRqV1waGti61PqTInnIh7v227TrZttOH904bvZPGfKEfErNyxwtACoW0llM4b+HHn4FCM/7xSI5UR2V0Gr+9Ld/RwJDWzkl7ptih2lvyYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXm2X+Rr; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXm2X+Rr"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2c88992d77dso332830eec.1
        for <linux-input@vger.kernel.org>; Tue, 31 Mar 2026 23:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775023457; x=1775628257; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TQzUILBNhy0xYDhWoJSCDW7EjMX4yVft4Z7WIEV2aTE=;
        b=CXm2X+RrRGPUjBVJO8iALkHV3IO+xRCZH8qHyvzdZ3z3hbmUc5Ao//J8jJx2hLyNLq
         DNe/fFwyoMsTdRvTLpSg/h0JC9bnAHDxAVuMedBphfwUZf+JvSXpuOvuuMAHK6iX+lGN
         ccPH+dcdr275hOC+dP4azdJI3W7iQq9bJK4KFUAp5sI6wbVPmR6KPgH1iJrl1kWgXlIT
         32/7HRQcO36okDWsFuvsT4PG511GTBtWHOhPZOkyYhpsCy8wM9vEWECn/C9krVnE/GFu
         9GfM7x9lg5SaHWY8LbEXBaCvP3FGvy/5yN2LRaQyo+RWkOTLsqWkifBWrM4ne5FhS1c3
         u3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775023457; x=1775628257;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQzUILBNhy0xYDhWoJSCDW7EjMX4yVft4Z7WIEV2aTE=;
        b=asY4fIb4E8S5z1wn1mip5kIfNrYmG5UUZfeS6i944xGKpLTPatik+QJ2adfaefzPIb
         u/smFSF7c2UGgO50lamqbf6cy9lozztBy8X/L2iG/JlET34+RB47LaA/ktF3pqJYlbMY
         /AoY7CN/59AgSqdaqpMUJo1gndMx9PcxMWTAia5X0t5GsrGgQ9jYkh7EYQKqIEOb5JqN
         /3t8falGcI3OAZZ7IYTxIDMYl6zLtknpMm0UETD5BPyneC3FXOaJkmakGzAA757HO9T5
         UgQ1Q8dg5tp2wsEqFWUROfK5pb9rzkUZrMKisWs21nFPTSpFOwLtvwEndS1o2lIG2CZ5
         /w/A==
X-Forwarded-Encrypted: i=1; AJvYcCXLVLRGeiCuNxle43E+eF9yVffhAzbdvrR0kkCxjT+zgaz/Nn8FzUXD9MxgmjI2U8zX+9MmAwZhWrCW+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfgiC49HHRroaw+Rp5HVMpXD7gs+gmU0p3Q43iLQh8iXOgn7Nm
	uFv3KyctrKvrop0fMHEa8QxPPSb3Bhuu8+Fp5+LtFPn0s/ICetTA8iQB
X-Gm-Gg: ATEYQzzb/Dmoofmg9tebHNfWOqCh7BRQ75/iWq36mRueglQqLpwctLDeBxaqfzkHWxe
	YmTBYgj9P5lLEObZZf9AMYAKBC2bHgV4B91N3rRAG4ZS30uMejrKUEO9ZEBeXUx2EZ9J6cPsAVC
	qAmJ8JT9lZNtJZ8/x4Ziqw1ornphx09V8/JJlwRH9PpXygxcwqtWvnUKGgo8M0PYD7xx+IAo291
	4+qvuOvw0p+8xYpwxlwdYlqOaZELFxrkyNYGaNANvlORwDUAfTYlANm2C3hvD0tJQk2W1jFr3ZK
	CVYOQxLi2Ut9gFSVEMjJhBtsiKgaYxo4waknjKHjo3c24cKrjMyNyvMLpkH5zfPA+a56j7+kr79
	5cYMfGI/J9vaW+FiFmse+8tZjwwoc5KsW083awyKJKlkKaf6UoS7DiGTmx+Yh0Hgt8PviQsmY3a
	sG8QznVef/3FNKqCyA3qDD0ArgbIYPdm94oqX7eP1JHYpbkfkuZC5LTcAXBYYG3G8m
X-Received: by 2002:a05:7300:8185:b0:2be:6693:9b4d with SMTP id 5a478bee46e88-2c7bba67f5emr3321449eec.9.1775023456491;
        Tue, 31 Mar 2026 23:04:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:1dbf:b0e0:8ad0:5a2e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c6e9bd48sm11457498eec.20.2026.03.31.23.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 23:04:15 -0700 (PDT)
Date: Tue, 31 Mar 2026 23:04:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Peter Hutterer <peter.hutterer@who-t.net>, Kees Cook <kees@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: core: do not allow parsing 0-sized reports
Message-ID: <acy1QWcu-yfd_kAu@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit d7db259bd6df ("HID: core: factor out hid_parse_collections()")
reworked collection parsing code and inadvertently allowed returning
"success" when parsing 0-sized reports where old code returned -EINVAL.

Restore the original behavior by doing an explicit check.

Note that the error message now differs from the generic "item fetching
failed at offset %u/%u" that is now used only for non-empty descriptors.

Fixes: d7db259bd6df ("HID: core: factor out hid_parse_collections()")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b40953e0f52e..be9d2b3356c3 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1272,6 +1272,11 @@ static int hid_parse_collections(struct hid_device *device)
 		device->collection[i].parent_idx = -1;
 
 	ret = -EINVAL;
+	if (start == end) {
+		hid_err(device, "rejecting 0-sized report descriptor\n");
+		goto out;
+	}
+
 	while ((next = fetch_item(start, end, &item)) != NULL) {
 		start = next;
 
-- 
2.53.0.1185.g05d4b7b318-goog


-- 
Dmitry
