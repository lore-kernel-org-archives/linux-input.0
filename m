Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E9C38A299
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789935207; cv=none; b=lOyDZsAgR6gggi0hxWmyIxnyedgebVsXKDHLqWpFJodE2FTH6O6eiWy0v4vHqT3I7i/h71A1oDB07Y8V7pSo218GOClo9vSrn36UV8iGO3wpYYHsCkaevIy23CPaFpVm7Byxr7D4JeeKYSshCEgMb1dZuWFJyNrPx3SyTZA1dHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789935207; c=relaxed/simple;
	bh=v3M9yuVNEHFfAOpxuRij9I+SDG3ysu5E3qudWIva/VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSVKLvfLY2n36ZjmN+6HSoPhC1Swj0AuZy1VectmO2BdTel0wbPZcgYUpbGogIgqA0tXR0DQo0LkdBmBP4JtQ9WnUlfou6PqvdtncePa8lKgEfb2SJAdVl5isfik7b9Xsh4iGFSrt8BTkmiVXV3Urf+sah+MP8YRoKOqupv3BBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ai5G+USS; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ai5G+USS"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2dd77300825so23885225ad.1
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 13:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789935204; x=1790540004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TAKC5GCwTerAHXbLUCgzMcXJeFahaz+vZdTOklpw0Y0=;
        b=Ai5G+USSO+ZKK909QY+OZvsAak19TqaEsabSxlI7TEEzCgEi8XugTt6ROK1EF3005G
         X+lA/+RpNBVVQve93PEd2urMo5fdLwEsZ9NZTkdN7S+ardHDpRzRm86r1IhzBGEakksg
         DvBFqJ8ep/KSuAkj6lemR0htxq/irNAh4bHWqOvGkRB5xCq5nSjB5ivMvJ2UBxSD1oxL
         yWNierSpYzh5ihLs2E4bDcuZ6IGs+iueYLBY0E7Ms1BzD0TrZZDGkPqJymxs3WITnKEQ
         jbS+pRiRXdzItinUmzJAGbF+cTGKhczgbjsIzIk4pk3GJk3jn0kRlrzwLKjQe8sCcrI9
         AMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789935204; x=1790540004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TAKC5GCwTerAHXbLUCgzMcXJeFahaz+vZdTOklpw0Y0=;
        b=g3R99eC+1D+3qglWkKYi1TVs54oyexIgLm7puqaFACVS2OpMDo12BwETFuE6AVwVWC
         9/d8wS2AvLSUxx1+eHWdV5bwH6hL+gaXVvCT0lBRhWR1ju6X++MRctC1pAREl5881MCj
         QCFsNup+eYGVS87E7rmVofJFX5HhdAhMpS0OXKzUeJqEpDthIZUWu5eRx5dJ4SxzHd5/
         Q21BuafoW+XbDIe3fxLyz27fBEEUIinporyfxdW88gRx0UD4mVe3q0NvehWl2BnFQUv+
         E6Y7DJtREagsfWRo23ygWhUKwOHxg9KW7HgQU2e2wcx3ideKzEjLd2R6i4IwPVaq18O0
         Fs3A==
X-Forwarded-Encrypted: i=1; AKwUvBzhi6bndDlNNyf0QoJ8NIOozwjyKxCjRqntx8Moft8cFZVfP8duHqWDnN8+9+615SimJ+seqiovd0Fplg==@vger.kernel.org
X-Gm-Message-State: AFuF++lAZ8YtmfTLgwiJy3c2YbYjlV82+IDpBQC54QBdRknaDeU8yuE7
	r6Zu4l7XL45Miwp993G+aKtjZd32deCYLQhVGsYhQA7k/WBjh8+lyjG7mZiQSg==
X-Gm-Gg: AYBFou1twknqs/fKHNuuIz6ufqTHWdZdmatAt1CrO5qWVPs1PHTKcsIfatIiojMHxsI
	i0E6kxM8XlMtLGjjliEuJAQ06+eBrPiR0LT1Zcg/dKtDj5M8UqMu4/fsJgGRMHZNvPTYv9iSVMd
	i+eoU90ZeGKPRwt9PgesOdDPWa5ygW+tFyWISyq2tvHBgzoLPygI9pXpLRpwHqJbuydKqxZALFa
	6aosGFS8GbJbPmrkyht0SsC6mf/ITgtE6XsQW96StlkO7sg+IL8i5xMsoFvUFXaypRnsTzHpA6R
	mqD2yoM8b7J0amRJD6OxzS65zankGVXPqKLO3micXqFERfvxTd7olfDiCpV5H6hhYOw5RuJVry7
	9HI8NcXcXyfXW7Y81yT4oBx6O9eQAx1U/qBvTutgZQKnifexWMVF3L4giY+lbGQyJmMMsJYkpb8
	yPs0ZJJdSVF0/8bgwg+dBi/hoiwlON4REkE95y8B1XK/aTV4uQDEaog/oOQcoQKEoTFlCKjSMeo
	GLIhF+5BUKVyw0iMz5LCSdc8pPVumh8ZiGIKg==
X-Received: by 2002:a17:902:ce84:b0:2d6:e9f3:9305 with SMTP id d9443c01a7336-2ddb1ab3cb1mr143733365ad.5.1789935203814;
        Sun, 20 Sep 2026 13:13:23 -0700 (PDT)
Received: from localhost ([2409:40c4:136:c0b:7911:68d7:f26b:cf67])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331b0d6esm11994571eec.27.2026.09.20.13.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 13:13:23 -0700 (PDT)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: rosencutter@gmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Subject: [PATCH] Input: synaptics - Add LEN205b entry to smbus_pnp_ids for ThinkPad T490
Date: Mon, 21 Sep 2026 01:37:30 +0530
Message-ID: <20260920200730.1836756-1-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAOGuaRh025eKcBf9P8UrvtXNp68vQ0HVF2EbNMp-kpdaC1HNpA@mail.gmail.com>
References: <CAOGuaRh025eKcBf9P8UrvtXNp68vQ0HVF2EbNMp-kpdaC1HNpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo ThinkPad T490 has a Synaptics Touchpad that supports SMBus/RMI4
mode, but is not listed in smbus_pnp_ids table.

Add LEN205b to smbus_pnp_ids[] passlist.

Reported-by: John Rosencutter <rosencutter@gmail.com>
Closes: https://lore.kernel.org/all/CAOGuaRh025eKcBf9P8UrvtXNp68vQ0HVF2EbNMp-kpdaC1HNpA@mail.gmail.com/
Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 2170bbe4c589..14484164f067 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -192,6 +192,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"LEN2058", /* E490 */
+	"LEN205b", /* T490 */
 	"LEN2068", /* T14 Gen 1 */
 	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
 	"SYN3003", /* HP EliteBook 850 G1 */
-- 
2.55.0

