Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AA135A952;
	Thu, 23 Jul 2026 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784813051; cv=none; b=R4mrGCmWnkwOloatLDo2d1eO/s0QQoasOxFlf1zOXGRbn1ckqHv54Ez5KhyFDW8qD3C/HAq7naCcZWh38abMFLEqQv5sYHbT8Wosh2D5UOWJsmhca1myNPPAr6tYs4d5NcZgh2VUbB5r1QppmZnBFLj9OFskL9K9k4MXQcXClWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784813051; c=relaxed/simple;
	bh=nzTDJQgHB5j6mAyvnaC5rb89aNJoakyr/S0pRsKtOgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qhE+3IxcgpYdNh8r1qPf3WgGGzTHx6UlKWvcc4ZrxjabDmI37dVm81F9c6v5OI2NC58couf9lJiphrStnDamN/btp2E+UGnDovq/CcgQTnvW8xtnXLZYDlOSQ6rVJ2vMYRyiqHHUXUAQ6qGQazZkhtE3U8qC7KswEzShqhjsXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5cagf51; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5cagf51"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19144C2BCC7;
	Thu, 23 Jul 2026 13:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784813050;
	bh=nzTDJQgHB5j6mAyvnaC5rb89aNJoakyr/S0pRsKtOgc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=l5cagf51SQiwgqU9PTNmGvsduRsdZpjensA4UmMq+hwc2M+uvU+KS3iKTMBUBrsdf
	 Q4Bb1B7FtJRH7mUfwkG7t4fqSkTr+4Ji7iksI+c+BJUtuazfwImikJkc2vmIPByaaY
	 nddXxh+fOyYL/nOwKY0iXoYbsRPlv8HuacnyMiFkqPyzHFfPVtPgEIv4DvpffgdsvE
	 6FxjlfXYXnFzsfkYW7IvUZl5K+jcVbFAo4/pdfcxk2COYS/9PXG/s9dyFefgCdioHr
	 aUPps7HpgE1DuxQqdV0LPnxel/vztQugYD0BRkr32o6+JleWOhLWsqvac05VGAT5ur
	 cQQ/IP1Mfvdig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05601C531CF;
	Thu, 23 Jul 2026 13:24:09 +0000 (UTC)
From: Alexandre Hamamdjian via B4 Relay <devnull+azkali.limited.gmail.com@kernel.org>
Date: Thu, 23 Jul 2026 20:24:09 +0700
Subject: [PATCH v2] Input: edt-ft5x06 - ignore contacts with an
 out-of-range slot id
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-b4-ft5426-v2-1-cd2bed168051@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBAAv0L2bE3ZLqic/IfhQMsCawRMi0RD+
 LsFrx4nmcwsENgLByiSBTzPEmQcIuAhAddVQ8tK6siAGnN9QqMsqWbKCHNlLqY+Zykx2Qai//T
 cyHtv3cofh5e9s5u2wGZ0EqbRf/bZnG7ev+6cKq1qssQGLWvCa9tX8ji6sYdyXdcvn8NsEbQAA
 AA=
X-Change-ID: 20260723-b4-ft5426-393d8514e4bf
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Alexandre Hamamdjian <azkali.limited@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784813048; l=2253;
 i=azkali.limited@gmail.com; s=20260510; h=from:subject:message-id;
 bh=6IHuIpjD8BG+tOqYEL/Wqs7fTLnyHV/DC62HqKtwf7Y=;
 b=zELHXbmUBupqxeC4/gqIng4pEA22m699PwwBoiw64dl6u5a0uRSJh+kME/8Ht0pXqKFBDIDUs
 M47Lx7jLRYjAcpbH/vp289DWcy3VTWSVsh+DZGRrNb4eQ34RbZU6gLm
X-Developer-Key: i=azkali.limited@gmail.com; a=ed25519;
 pk=I0Z0IdCdQJqNGX+FQUnXhrHg950u3cM6Xzz3YT6JOyQ=
X-Endpoint-Received: by B4 Relay for azkali.limited@gmail.com/20260510 with
 auth_id=774
X-Original-From: Alexandre Hamamdjian <azkali.limited@gmail.com>
Reply-To: azkali.limited@gmail.com

From: Alexandre Hamamdjian <azkali.limited@gmail.com>

The per-contact slot id is taken from the top nibble of the third
report byte, so it can be any value from 0 to 15. The driver only
allocates max_support_points MT slots (2 to 10 depending on the
variant), so a report that carries an id at or above that count - be it
a genuinely higher-numbered contact or a corrupted byte - is outside the
range the input core was told about.

input_mt_slot() silently ignores an ABS_MT_SLOT beyond num_slots and
leaves the current slot unchanged, so the following
input_mt_report_slot_state()/touchscreen_report_pos() pair is applied to
whichever slot happened to be selected last, reporting the contact at the
wrong position. Skip such entries instead.

Signed-off-by: Alexandre Hamamdjian <azkali.limited@gmail.com>
---
A single generic correctness fix: a report whose contact id is at or
above max_support_points selects an MT slot the input core was never
told about, so input_mt_slot() ignores it and the contact is reported
against the previously-selected slot.

The marginal-i2c-bus mitigations that accompanied this in v1 (the
no-regmap-bulk-read property + driver fallback, and the poll-while-down
recovery) are dropped: reviewers correctly noted the bulk-read quirk is
a property of the i2c controller rather than the touch controller and
does not belong in the touch node's binding, so that work is better
placed in the i2c controller (or kept out of tree) and is not part of
this series.
---
 drivers/input/touchscreen/edt-ft5x06.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d3b1177185a3..d6c3d033b83d 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -331,6 +331,8 @@ static irqreturn_t edt_ft5x06_ts_isr(int irq, void *dev_id)
 			swap(x, y);
 
 		id = (buf[2] >> 4) & 0x0f;
+		if (id >= tsdata->max_support_points)
+			continue;
 
 		input_mt_slot(tsdata->input, id);
 		if (input_mt_report_slot_state(tsdata->input, MT_TOOL_FINGER,

---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260723-b4-ft5426-393d8514e4bf

Best regards,
--  
Alexandre Hamamdjian <azkali.limited@gmail.com>


