Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605754;
	b=CEYSQvETh16T2zqTcy7VNTe3knquWvk0QmCzyA6UPHnWHTR84HK8U4VjBheO8kX+UdK+
	 jz7BZA13NUy/UPHRCPZ/qnGFrl5aAZDIWs9SlTOxbcA5hXZ8/mxqzOqrBOV2k3g0Y4xBz
	 PwwWwKZNzDHHBJuX6mkkMThuIK96KXhf0+cdiZemMISGB64ti2EvJuQljgolPYimXsHnZ
	 Gf0E5fgXRywyOpeNE8O+I5lLlykmF+wsPGherXCyHr5JVpfDonG9GrlLW5OC3wpnJ+kdD
	 po78Su+aMf0AEqaAp1chwJhMzc9A7PSB1quE0vg0MotBgldpPPni4gvU8xZ0jv8kB+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vA0wMpa7bN2265jsFpQUoDPkqDznGZTxm7yt5tOHy8U=;
	b=bR8wtY30dNxvUzNaCg+W4eeP0JBz2kY+WqSVj/KtJx9Ao3Fy109bDrGmBSwMaGiiLy7+
	 +0DCMHYpHbQEqTj1KqBEWGYd/ECyQyR9JBb5xuAnzvGMnM4PCeU1Ajo7B9tzFF1Ytb7U7
	 1xQiAI8DcToEBCdNKj6lGxKiL8KIhYE54rNfyZWvrzyl+AwSXhTIGEKa2l+smVJ5yy329
	 HUT+KiP1kgWvcAPaXeonaV4S8AIcOQOaAcNmizFbr99ojOrYTRnIm7gKRl0cmrShS1WcQ
	 x2mxXHLcKXHdyzsm1HKV15JdzpTFgoT9t8iy/iq1UK9clteXEAwpfgYWqCz1jUCSRow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ba9/rx+1";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A174E606A89A
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 21:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A174E606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ba9/rx+1
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3791619605cso2988832eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 13:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794605749; x=1795210549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vA0wMpa7bN2265jsFpQUoDPkqDznGZTxm7yt5tOHy8U=;
        b=ba9/rx+1ywrJGc2QXYUYzS87esRCsVY+uiAFmgBt4TfVTGFbOb3VzKq6889+4ELVwb
         1JV0cpsoHvz1r/lui+ni0Q+ue8f2V7NcU6P3YDDvgxrLUMj50wIddxWW/VvdDarkzhYJ
         qACgCdFEVzqUuUqjqx6Jo7pV4436Ss6q1kYPr6qJQU4PX/DbNdKUiAAXDu6N0NUvzUE7
         z1KlLvJ93QKV0DU+RTXXVfXlhxnYmvSTWCEjTWlA492Dxq0+odeyIB+ze6HmcRiUEjP5
         JwUwjRuKsBwGa3p5g9inKIKMgJMIwiO7FD9qHNaeNYmwv3AFx6THZz+bsUPJhMpRDAXa
         4HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605749; x=1795210549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vA0wMpa7bN2265jsFpQUoDPkqDznGZTxm7yt5tOHy8U=;
        b=DHD964bhtC1YDAgR1eKQW1iZ4bDfVNkytUOBKXnToJvh3NiWzwj8faYBlpFKvDpfUf
         LC0DLucFviMjhb4KoIDRamoaRpMiBzc3SChDfn8mPGqMIpT46NGShCdokEJiMRy9EUPG
         w1ENxELB3EqRHTfto/h448G+mbnZ45SSA93XMZLckV2l9dHAPo4vC0rOERuzTapIKZfn
         0+dZwpdaPn7JffjjHouN1uAIjQErCPpAmdDxFN2j7P3i1xSXiV/6WQbXS8PWTSi362qs
         TX9OMFD57IxFGf2rIIsugppmyN7qpIsLKbbvKDZt7C8p7rMhpQiskF/cpLN+eV/6Cd4h
         T7fg==
X-Gm-Message-State: APuU4Z+jaigBoQm4y7jjc8LjUv8WCaYf+qsfz4t/M0lIfEG3BAD67Fyd
	Owwe1GbQGV1W72AmLDCB9+6C7wdzORPtggSCtlRORRhQXQR2q0Rm1OjFZn3XSb5O
X-Gm-Gg: AYBFou2kmZjrVexxKCE6IkSqoWVoQyzHa6NzqAzeL+S9mupvjnL9inZP1H/OId1oRZR
	ynwJqga0OB8vHrvZQ6YraQzFBiyENBtkppZCli75AmBLP2iYnnpPXZwa1DICF/STio2GE2RxH+t
	1SkwiTXzOnpYQtUnxTItEcv6jEhoJf2Ypo1uF7rQ7HWY6l07ZoaWhCqfS7cC082HiqfXSbpIcoW
	8PherWaTM6MWvP8wpf7yKocha8nNnkoEYLw+hgZ9mwlco88OYHG9IVSq7+tdQ075TSbaTKhqHX/
	rn6d+SVIJJsaIiQXhGKzwiBxWHNKMkTJT/zV+/xQUBn9oarFdRdGjTec5LGGf37jqKI8/ftItjQ
	3ujOODWmOkZ2rYywmzeIafxRhAJe4vG/bcUFmEhBWowYdGCJYsZWOKDTwgGEJMd9XCvFrWDnoNB
	ptuRp2ecmXLmBJDFjgmgzd3FeozgOy9lMQd+cKSA/l9hYnvtTnm+6yzyJQ0OKqs7O785P3uSgqb
	nKQ7rpVsg7OtXy3TdMCTgrgwzBI8HlyRawe/GRRWpJeVqzl3HmuaOCZzSebYCxL1+aXPHwHrAOp
	Q3TrFMlzL0GfL5ts1khvFKprhKJnZBfZ9Q==
X-Received: by 2002:a05:693c:8816:20b0:36f:350b:3838 with SMTP id 5a478bee46e88-379671247e7mr3231373eec.31.1794605748745;
        Fri, 13 Nov 2026 13:35:48 -0800 (PST)
Received: from archlinux ([182.48.212.144])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378c2fesm10137339eec.1.2026.11.13.13.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:35:48 -0800 (PST)
From: WhiteDoor6767 <gururajnaik166@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	Basavaraj.Natikar@amd.com,
	Sandeep.singh@amd.com,
	Gururaj Naik <gururajnaik166@gmail.com>
Subject: [PATCH 2/4] HID: amd_sfh: Route HID reports using node_type in work handler
Date: Sat, 14 Nov 2026 03:05:31 +0530
Message-ID: <20261113213533.13139-2-gururajnaik166@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113213533.13139-1-gururajnaik166@gmail.com>
References: <20261113213533.13139-1-gururajnaik166@gmail.com>
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

From: Gururaj Naik <gururajnaik166@gmail.com>

In amd_sfh_work(), incoming report requests are processed asynchronously.
The work handler previously passed cli_data->report_type[current_index] to
hid_input_report(). However, cli_data->report_type is uninitialized (0,
corresponding to HID_INPUT_REPORT).

When hid-sensor-hub requested a feature report (HID_FEATURE_REPORT, size 15),
it was mistakenly fed into hid_input_report() as HID_INPUT_REPORT. Because
the accelerometer input report specifies 15 bytes of payload (plus 1 byte
report ID), the HID core found only 14 bytes of payload in the feature
report, emitted "Event data for report 1 was too short (15 vs 14)", and
rejected the packet with -EINVAL, effectively dropping all motion reports.

Pass the actual node_type from the request node to hid_input_report() so
feature and input reports are dispatched with their correct report types.

Signed-off-by: Gururaj Naik <gururajnaik166@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index 1234567..89abcdef 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -95,7 +95,7 @@ void amd_sfh_work(struct work_struct *work)
 						    cli_data->feature_report[current_index]);
 		if (report_size)
 			hid_input_report(cli_data->hid_sensor_hubs[current_index],
-					 cli_data->report_type[current_index],
+					 node_type,
 					 cli_data->feature_report[current_index], report_size, 0);
 		else
 			pr_err("AMDSFH: Invalid report size\n");
@@ -104,7 +104,7 @@ void amd_sfh_work(struct work_struct *work)
 		report_size = mp2_ops->get_in_rep(current_index, sensor_index, report_id, in_data);
 		if (report_size)
 			hid_input_report(cli_data->hid_sensor_hubs[current_index],
-					 cli_data->report_type[current_index],
+					 node_type,
 					 in_data->input_report[current_index], report_size, 0);
 		else
 			pr_err("AMDSFH: Invalid report size\n");
-- 
2.48.1
