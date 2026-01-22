Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961835B652
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 15:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097319; cv=none; b=hRisWvqObMTbI82dswOqvmZ4/Z8hXl0Gt++SdIGNC2b3pLSIErH7gy+hEwBfPdDl8vlRvI3sDad8l0ZudTqbEOlcEvKxnQq4heB2eVg4jNqbyLcAyV3cwiKXOTTKohowIUdv2uCMp7B4MTVbCwsqqz+nIjE/oAAjWEfnN2S6Omk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097319; c=relaxed/simple;
	bh=Fv4eY4ZAe/ifk4I9BIo/tRFyO/cE+seyo7xdkN2ocJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLthVAxxF2HncjF9VbXeh5DZw5alY2yLYVa84tQXuWdCqms4nTu0wlyK/oYOj8OTk1TGTY69SSNJOm4qnOJS1SmFYO3t1KIJfaly1G2BHA/MteD7MZj2xeKwbUAVEt/7wa2bZTbdc0h2l523DrEz13XIZoycKct0DmjFOIPb7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgpIKp3R; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgpIKp3R"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b720bb90d0so1066241eec.0
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 07:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097314; x=1769702114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Oz/tfZRKv6Pmtw6Fd2KxgTHXyb+JusOVo4ZtSAS9YU=;
        b=XgpIKp3RyqAtUQnEI1VgojIBbEKGSn1FCmb0nBTEhArp7RPFqcbKvqJB26mL7PiLn9
         ts/pEuqTZHjZHJIzXmOp0Ryo3y7oInx9vYUksdfboWe++0wQDv+Ux9Od7yprE9BtiG9k
         CfQITGotcM6Y6wX6Z98ksCBUGnQ7pAV8oi+AtE5zYDOJ/P86HOQ0jeOB5Aml+oG3Eam6
         t6dNhemOKKxl2GuEdXW/S1TBCwTkmbw5Cr9WvOKdq2+vPezegZPagrKw2BeWpe47eKdy
         23MByUxAP5nAxs8FjEkaAXcFA2BRJc4ZSchN3Fuhds7IVXquhdqdvKQ/bdf1m97LNMas
         Ytcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097314; x=1769702114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Oz/tfZRKv6Pmtw6Fd2KxgTHXyb+JusOVo4ZtSAS9YU=;
        b=b80aTnUJaNvXRD+7oaSmWnAyVRkeL2KWUrbLdGynSsmIjVz9nDpY3+IyxGhZsq22Wr
         2ycerFSE6RfIJM+Hnr0jZ+GS/4+7FUf8eYakL/q/vj+Ic1oVFSQu9qa8E77dokGRLjxQ
         L1U77jMSu0ZZTjA57nK4E3sBnrdNdpv4rDmGxLiF94nQw4gbC3f4SdZ9qZuib7CQlbkO
         ZxvQVbOFjV9+Jty/CwaEZa4H02VXGvLwn27ny38/bkqPArskRtz7NSVX0Zwf8F9NUcMI
         Z7VLD5hzEiwAgJAqNG+zg9nF5i6e+ypSIYdfMbWpMfXevvQmY7o/lnKtwg/yr8GS5cY2
         KaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZxa1OpMWASp5nvb391w91gcaRTWXLfJpBJ3THCq1s4GJ++SnATIbuGoWJVTCKApIvKV5YZprK/lNmvg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8IavOclnTBNqorTSbOWY9Oda2KNoDg7sczxkNWCVAXRnGxXaa
	zlzGJyFbnsePMRWL7RDHkxjWy2HKvoTc6zclqn2vHrO92Ekwe8LeZHcH
X-Gm-Gg: AZuq6aIc8zuhGrBH3cMVhTISDlpXKS1gaRUDZQLG6JWQzGnYggBRHViZnzMjaooPGZf
	swet5dAjQ2VsttK88urHt9w2Fj/moDm9Rg3c66yslWMGymSWVRxHen/miIYFvhHyjW7EoVnlEh5
	x+xn9upZCyIAyEYfbZpRQDiBIsZ04YqbTdHuRQ4KW9NUmUvnUoXX3Sobq/5soLGjUegrfH01r5f
	9lPqdMcDPvcTwvjZY/7xWX++NXLQztvKYhhYuijZzbZGIJIbeUehM9byb4e3HBJxT59Pc/5T5Ri
	QAREJ8D/1UvNoMNJ2q7r47hB1UVS1vGur6gTaKjjhLpKo4V3r3PqH5d3OQH2GE6Uj03bT8s9ekV
	4NAJtCl9xNQrxdOWPtM0i0rB1FgWJWUrupAFc/KpTHVFKKwHTuN81fiCFfjBjxpo1tc2ugcHKdU
	RKzj+4H96b2sex5PKiP/1Tsf9ZP7dLbLmzpB5IFjYKfBkbzVV+4AqDb+Q8ITLvk28HiWCygJMsr
	Q==
X-Received: by 2002:a05:7300:7b86:b0:2ae:582b:db80 with SMTP id 5a478bee46e88-2b6b46d2ffdmr17440533eec.9.1769097313706;
        Thu, 22 Jan 2026 07:55:13 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.90.16.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28935599eec.32.2026.01.22.07.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:55:13 -0800 (PST)
From: gongqi <550230171hxy@gmail.com>
To: rafael@kernel.org,
	dmitry.torokhov@gmail.com,
	Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-acpi@vger.kernel.org,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	550230171hxy@gmail.com
Subject: [PATCH v2 1/4] ACPI: resource: Add IRQ override quirk for MECHREVO Wujie 15X Pro
Date: Thu, 22 Jan 2026 23:54:58 +0800
Message-ID: <20260122155501.376199-2-550230171hxy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122155501.376199-1-550230171hxy@gmail.com>
References: <20260122155501.376199-1-550230171hxy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the MECHREVO Wujie 15X Pro (Board Name: WUJIE Series-X5SP4NAG), the
keyboard does not function properly without an IRQ override. Add a DMI
entry to force IRQ1 to edge_low.

Signed-off-by: gongqi <550230171hxy@gmail.com>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index d16906f46484d..2ec5472aa0763 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -674,6 +674,12 @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
 		},
 	},
+	{
+		/* MECHREVO Wujie 15X Pro */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "WUJIE Series-X5SP4NAG"),
+		},
+	},
 	{
 		/* MACHENIKE L16P/L16P */
 		.matches = {
-- 
2.43.0

