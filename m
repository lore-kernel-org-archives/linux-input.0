Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43EF3A4F23
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225706; cv=none; b=GT/6C61vgJTuoilfkBbuePaCsHC8+lf1ZIqo4qKEMh6peq+elZ5E2Pwq1Qw+kyCMGtHWGt4Y7H4g/6IhRzSC4zQrL4D6jKWfoi2rh1dvtJ//0xzx+unpZS50uYVq8fvBhk7HUYZ+5On7qtL/rKK9Cx2BavOieEeS6PQNmpvDIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225706; c=relaxed/simple;
	bh=2L9AH1fbv3hD2pN30kfeymBpxCP0X38ypHeoTWHMfQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZ4ktAqOOY143+deT7cBwh7kzX474vVhXUYJaWUt715Q2fMeeplk1tL5bDch4A5JgapIn1DPqfDBY+2+FCMydT2Og0Z+KegprTtm4O/BGvrE63WTNhf+JHpJl6FObB3MZhQfvaNNpevV4/Q3f8CKOL34KymFTfq1SwNZ+zKrpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/QrJ1u2; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/QrJ1u2"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64c9ebd1369so2276331d50.1
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 12:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772225705; x=1772830505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpJvwZ8KcD1PIhsz01U1baureuVfvggAoVTmPDUtPPA=;
        b=e/QrJ1u2W/MhQJjfmEUsG6iz1LOsT9moSI/H9mmLsyVM8NM6aHYJbJx3N9uBA2CWBl
         4VgJTzw9DkK6hh0VJBOFxCl+dT6SfFxAFzCOkh9zNbSCUcey7yaJDxQwssqok6lj9Zt7
         AAslvvJcrFdeUyxPjhejE5/hU2Td7Aq7A3SWBOqGnLbcC0BSRJkn9cuus5HuF9qHRY6P
         UKb8RjrhqI4etZLVMpm6zfbScslSdTzmzP1tw1LMLEcfNj+Cvv5mSRkF+kpSUls00CY9
         f8dEhEb/5+ign4WoesE1NyR4bZOAliTTCNQ5PlSD7jeK3+Eaolm92A5A/RCyWBpnlIG3
         0EmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225705; x=1772830505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qpJvwZ8KcD1PIhsz01U1baureuVfvggAoVTmPDUtPPA=;
        b=tMoSz89OL7vjv779bwPj3QGOe1yH/ejqJZmrTrw6TaNGvHLlwe9P6p/3gNzAtRxlSe
         M4+TeTpl5HCXdIse6vo6F4lXLEx3Yh2oe0GTzJbeKhLZulnnb1rhd0ZWJtPTZ4qQQ/Ty
         81aw0195fhUSBS6Q+BzW8pcJ85QVAq2bS+MrRLKCnwiJmkcvcyq6YVrcWdcdLX7qDPn8
         1BcNpGtk5DJhkkRJ7k5e1XtsvkQuZdqGQ8454vQuVBATKXVMJamNpXnfEChGQ5UTy8RX
         tm1HnIF61atT5XrazGiG3Po2/uVsXKoZfP+sOY4VetZFKgd9egV/I9BZEDCRFj9Bb8AZ
         bEeA==
X-Forwarded-Encrypted: i=1; AJvYcCWLiOab0jinAlJsBGV/+x2zxiXNDABJWuwEPHL2FntzENgc4wlOlarP9dIvE9xyxGoZO8+hlaHOnAWH4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcuEpZekRplvje+/o2X5NmHMUAlpcDgPw6yrlJwxIACeMY3yB
	8vA98xvMpbXPJ6G7BLDBQW2DHgqu+vtl8eDd/RE0pBCrVP9Q1D6vUUzWqiZMUGI8XHs=
X-Gm-Gg: ATEYQzy/DqLGpqWgBFCVX/N88dXBDHk3KaAA6b/HM1HaIKvLqqDZqI6PSTinXc2MA3J
	VqsrBmLvav091OXbyOqoDFOJwp/Peu/dB4SvxHnfWu3QqWw/RM6nPRSyajeDb9cwGN6PMLlAwE5
	zEIqvOaiyUu2E/MgJC6DgTDvYsWWXVPymiB3/S4AvNXtUBeqHGRFg6B8n+98gYRz2mdhAqPOJNR
	PEKAsLAIYjMXZJJL5XdJT5HvgadABxh+FMJ6uANMF4ANVG5A7qFgQkMDCXknZU2DbqxuXx5DXfZ
	4wit52njRuCvcQmryiP4RY6Fhb1QnwX/aTaqQBMOyU5FxuHioaaSSlOoeZjfiHQ+JBUwH1Ke1Uo
	JZwA3Al2InWI5ermKV61Pc1aG61YB4PZ27NBu24gdWQWjUc9JUIdkvaGhtK03WW4L+xDMR3YJwl
	Z45dJEfsqG2KGGrx7oy43X0wfyzS+RLZZw8ZYOUvGlCyfBdEIf0Qsf1O9YCbDV61b7sHcZ//2Gu
	p2U/xaA5xvfDZj9oidYpUFs
X-Received: by 2002:a05:690e:150d:b0:64a:ec39:dd64 with SMTP id 956f58d0204a3-64cc22dda60mr3473637d50.43.1772225704974;
        Fri, 27 Feb 2026 12:55:04 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb7571e00sm2805811d50.3.2026.02.27.12.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:55:04 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 1/3] HID: hid-lenovo-go-s: Fix signedness bug
Date: Fri, 27 Feb 2026 14:54:42 -0600
Message-ID: <20260227205444.1083103-2-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227205444.1083103-1-ethantidmore06@gmail.com>
References: <20260227205444.1083103-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function get_endpoint_address() returns type u8 but in its error
path returns -ENODEV. Also, every variable that is assigned from this
function is type int.

Change return type to int from u8.

Detected by Smatch:
drivers/hid/hid-lenovo-go-s.c:391 get_endpoint_address() warn:
signedness bug returning '(-19)'

Fixes: 4325fdab5dbbf ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index cacc5bd5ed2b..0ef98ba68d86 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -377,7 +377,7 @@ static int hid_gos_set_event_return(struct command_report *cmd_rep)
 	return 0;
 }
 
-static u8 get_endpoint_address(struct hid_device *hdev)
+static int get_endpoint_address(struct hid_device *hdev)
 {
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 	struct usb_host_endpoint *ep;
-- 
2.53.0

