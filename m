Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFAB43B49B;
	Thu, 23 Jul 2026 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806030; cv=none; b=TyK6VzuDtH1OwKG2x/cZKsjFRaLH87OeinnjhFtd/CVXs3A9Ii3ew/ROoscZ3L1ilgt8NQJvXbEp/tIYN6cCJoKLYs9OHvy8Kkk8PMXQiljg/kCRSUl29DujA6mXBGkKLbgbcaVgxvuhLnNXaoTR2rlsrHLjlsSFXuQ4nw6OdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806030; c=relaxed/simple;
	bh=hzHKgZ4D+jeJoYuFb7yM5jGzuM70NqWd6XTX2mLqxlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJJovd6uwpH8TN3qWfD9G+xSsAcTFu3wEqGbVC3Ao9ntbUUvWCqSFREeVpmLeIB0YLxG5w0KGckvf8LZxtyvhXJja0F98X1xhWcIDpicESC4XwrvZXGosJiaKsKDbtfsZiK+gn5suTszjLJ0anVg9vcUwSpVG17b5agWUOemNyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTljDhYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTljDhYS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6EB0C2BCC7;
	Thu, 23 Jul 2026 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784806029;
	bh=hzHKgZ4D+jeJoYuFb7yM5jGzuM70NqWd6XTX2mLqxlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QTljDhYSwgFzeA/1TwD7zB+WurAqS8b/Yd8JXWzxOFnTwfQG0ZRRrIOGkwNFl212I
	 7+IsZBlw87YdFO/opC+HqtcAjPeIttipFNW36CrCKttNeDCOeuFPhAgjFxHneA/ssY
	 nxnF1uSJJignVecafquspEqItcCEbvau+MWc9DwuyZb3RqQzi+YVQmvfh1ZCray+qI
	 Rc9knNPDvQ7oYwHu8KHU4eeBaXey9InjiEOy+GVJOeMp5puIzDYGxs54enFFb9GRN8
	 B6DyLbQWLY8U1YbMc5rKloS57diKNKEh9HxHYg8tqL2At3+pFUFKuyXcRi6QLNWs8S
	 jPui0cv8WduFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A6CC531CF;
	Thu, 23 Jul 2026 11:27:09 +0000 (UTC)
From: Alexandre Hamamdjian via B4 Relay <devnull+azkali.limited.gmail.com@kernel.org>
Date: Thu, 23 Jul 2026 18:27:08 +0700
Subject: [PATCH 1/4] Input: edt-ft5x06 - ignore contacts with an
 out-of-range slot id
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-b4-ft5426-v1-1-d4b4e32be042@gmail.com>
References: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
In-Reply-To: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Alexandre Hamamdjian <azkali.limited@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784806028; l=1395;
 i=azkali.limited@gmail.com; s=20260510; h=from:subject:message-id;
 bh=D0XuFOboekFyulaNFU7MxXVtoV8b4Kp9OM9aoWYiFTo=;
 b=oso77UFU2tWgwp7TRwwFdKsBZiu0lKjhhcLPJNm0fpO3hsaHh+HTKbV8LSrOdbE2Q3op2RQu1
 6OwLQ8qvABnD13r3CHrfXX2JWjVBjZF531nfbvGbgHss0RKGNsql16+
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

-- 
2.55.0


