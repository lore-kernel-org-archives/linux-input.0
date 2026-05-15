Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073803F99E3
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778867582; cv=none; b=Cd1PZht3CbGypaDgymw3SShyJT+ZHS8oCGvj96b0lsBc3gFEsFsyfDbd3IKlJuRh74k0qkYMkrIh2XoHVJALuePjWTuugLYNUZyGYUDjbIoxs5n5ic+BI7fHRTKdha64rScfNHMLTHoagsdbLhDBR0D/ewevDHv+6j49crTnabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778867582; c=relaxed/simple;
	bh=9IbFdWRbgG00j/vuJuFMHwWqziCFT1z51HBBNF4JMGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lKhs4OMQLYiuo44vZPxnYLXE54jDNSpoIUCM+opF86cjQE8SmneQI1vABYi/PlQN5LqesNXA7+AOa++hLFYAbvuhXmE9ONnlEpbEsod/lgtFVVxONJbyJsWwjVlPRLAfxHnoUGVUaV4uLpCg4yfOfUD9EZgeqS/i61ZQzqhgbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYggGMxh; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYggGMxh"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-9103019f8c4so16490685a.3
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778867580; x=1779472380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tD25Vv+Gk5JIX9+v8rQH7uX7yAIOIf8ZKeFVzF4JIoc=;
        b=kYggGMxhDEwmg18eCsde4Zk4SsHFF2xYnEsmo7tDSb5kYjEEgKkpgEli84Ze8q04UR
         +2cIJ1BvOyYKF4vU9smgJUH7UeKlSdtxV/pGmfiARQ1oXkhYlSDbY0HxcaSDO9NdUBko
         PEGxKjzeKbZJ73oCFF+OgMiTVYuRb3/luWmoSDoMEuctLlwLKzBxZDL7+EBLgxUUbqtQ
         qjXDxovfoCI3WMU/VROvNvY2dmZy1U8jkru4FZNwBRPzHYL1/yOzMdCNeBOoxmcP3jjb
         Cr6O+GbaubkqtmYZ0YkH/1FerO2kJGbdTG72Z5X8VwzWDJ1jECsyA4d6SgrxLLUx/C93
         cadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778867580; x=1779472380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD25Vv+Gk5JIX9+v8rQH7uX7yAIOIf8ZKeFVzF4JIoc=;
        b=Jp2BCmiOOe8zaLkB1Sr28YbXajmOqoDz9CnCYb+XEt3uIuETb1k16PG6vSffE1ke1S
         JFtJ3NCvgeiqYvS+kZb3lCIUzjMA68Q8pN9OMF93Cl8sCZDUbhdg5uQ8AaQT+X3WIhVp
         QIRgqE+l+vaf9+XoiyfGXiSLltaNJGuakPTtt2wQfCbjUli/WKTzztGBtXr9bzAtwcal
         Nw6sJ7IjAomWzCGQHkKhMBFnS+sMlPcXItZuCY6Wzs9vu5XsfBxAqdVQ493s/T1u40Wc
         PIOBySt/fHo/wQJzbg5qja1L/XL9WvJldgof5yF4XQ5Yx6FAbCd+ReaOKDAtLvwtgxtf
         deVw==
X-Gm-Message-State: AOJu0YztpXYlgGCsm/+lbT2jXgfMOkW6XcvZuVG18afZUXH7yOo/GumE
	FlKABBGBA2IV/rS0CS3EqHflPXNFSd+3k51EywLaoKAmTpHUtndsEiOMtqA4Z9c5
X-Gm-Gg: Acq92OHRbnuvSgIj1jMqbfow5LIlMRUnP4HuDDfBN8QgW+t2PxCO8NTAZBUGuvTsRfY
	IBIyIAOu86jjchylwq7wa08XhBKBjWO+tWptiavXhmpkzLR5ffcYa3dlmuus8JrJCeeTWojT4wI
	SV32/Fb3YUYk1CJYBCerEVeUw6+wkGsbrz1GDS8xywk1s+OUoyJxPOmxk3WJAqcDSq6oN7cBi4V
	OsKssfL9qKFpuUnMf/uaUdwOrDokWw86W+P8ShMC08ZjwoOtEz6xehJfPw3DNgWgppaotr/pI12
	XIDSxGuohurtztLJjJFX+MrLtlt4jTtuxMXNSGb+c19C3lJgeyVEfeUREn+cYiFTxcGjn6W2Kj2
	NPFmksqwtO7yejF8mfZiJgptcDN00H6LoanK4r2KBTw5100ocTJFNOBKrLVYcOpMTauTDgEguIe
	6Vkpzsx/d3QYVC75SiZPXkxvHorR0yLS4jzoeNyjx+exH1DUCsNIXdurs1AlU9xMP1O8rMGZ+xo
	VnIycI=
X-Received: by 2002:a05:620a:3714:b0:90c:be8b:3676 with SMTP id af79cd13be357-911cf7e8342mr846950785a.56.1778867579529;
        Fri, 15 May 2026 10:52:59 -0700 (PDT)
Received: from fedora (pool-100-11-178-145.phlapa.fios.verizon.net. [100.11.178.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bab3a207sm599406185a.15.2026.05.15.10.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:52:59 -0700 (PDT)
From: Dave Carey <carvsdriver@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dave Carey <carvsdriver@gmail.com>,
	jikos@kernel.org,
	bentiss@kernel.org
Subject: [PATCH] HID: multitouch: Fix stale MT slots when contact count drops to zero
Date: Fri, 15 May 2026 13:52:53 -0400
Message-ID: <20260515175253.873796-1-carvsdriver@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The INGENIC 17EF:6161 touchscreen (Lenovo Yoga Book 9 14IAH10) reports
HID_DG_CONTACTCOUNT=0 in the frame immediately following the last finger
lift rather than omitting the frame entirely.  In mt_touch_report() the
existing code only updates num_expected when contact_count is non-zero,
so a zero contact count on the first packet of a new frame leaves
num_expected at its previous value (e.g. 2 for a two-finger gesture).
The sync check "num_received >= num_expected" then evaluates "0 >= 2"
and never fires, preventing INPUT_MT_DROP_UNUSED from releasing the
stale slots.  Those slots remain active in the kernel MT layer until the
next touch, at which point they are released in a batch alongside the
new contact — causing the userspace event consumer to miss the intervening
finger-up sequence and corrupt its gesture session state.

Fix by resetting num_expected to 0 when contact_count is zero and
num_received is still 0 (i.e., this is the first and only packet of the
frame, not a continuation packet in a multi-packet sequence).  With
num_expected=0 the sync check "0 >= 0" fires immediately, calling
input_mt_sync_frame() which drops the stale slots via INPUT_MT_DROP_UNUSED.

The num_received==0 guard is critical: continuation packets in a
multi-packet frame arrive after at least one contact has already been
processed (num_received>0), so they are correctly excluded from this
path and the existing multi-packet logic is unaffected.

Signed-off-by: Dave Carey <carvsdriver@gmail.com>
Tested-by: Dave Carey <carvsdriver@gmail.com>
---
This follows commit 108ac841 ("HID: multitouch: Fix Yoga Book 9 14IAH10
touchscreen misclassification"), applied to hid/for-next on 2026-05-12.
That commit established MT_CLS_YOGABOOK9I.

This fix is independent of the companion ghost-contacts patch ("HID:
multitouch: Honor ContactCount for Yoga Book 9 to suppress ghost contacts",
sent 2026-05-14), which adds MT_QUIRK_CONTACT_CNT_ACCURATE to the same
class.  Both apply cleanly on top of 108ac841.

Tested on Lenovo Yoga Book 9 14IAH10 (83KJ).

 drivers/hid/hid-multitouch.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index ec04dba..e91ba89 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1336,6 +1336,18 @@ static void mt_touch_report(struct hid_device *hid,
 		/* A non 0 contact count always indicates a first packet */
 		else if (contact_count)
 			app->num_expected = contact_count;
+		/*
+		 * contact_count == 0 on the first packet of a new frame means
+		 * all contacts have lifted (the firmware sends an explicit zero
+		 * to signal all-up rather than simply omitting the frame).
+		 * Reset num_expected so that the sync check below fires and
+		 * INPUT_MT_DROP_UNUSED releases any stale slots.  This is safe
+		 * for multi-packet continuation frames because those arrive with
+		 * num_received > 0 (at least one contact was already processed
+		 * from the preceding first-packet in the same frame).
+		 */
+		else if (app->num_received == 0)
+			app->num_expected = 0;
 	}
 	app->prev_scantime = scantime;
 
-- 
2.54.0

