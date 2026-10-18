Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0737949BB41
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792327684; cv=none; b=tPYwPmJPEExYA8xUBVvs7IdD2iEcG5Cy5UW2OXHO9JwDbNxvEQ0ecKnKmP+p11m5Cl+oaJ0NAWr6m1jjAkV8YPAYEmWDjXlVPeeb7766SuKMPvU+VTJzm4bJ6Is/RPLlGFHS8t4VGrD7PbHER79SxIioDiCmpVe7k+b5ZrJtau4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792327684; c=relaxed/simple;
	bh=ffuWOOzNvVkfnwWk6AFrnQVEF35/KGyRLJ4wSYHI0d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnkgGjJ5jXWYFi5hrDu25wL2GmGIR1WPnbuFdQeUfWs6IL6t44GL+SDjrDHGpQRQmtXdXbPRqKsRBl0psHE2jxxwh3j8hn6YhSh6wlgfPBFUq4986dB6Gb4LzZa2sAN4/uPqlEJSCtbgD/EJbFZMw9BpYo1sWAJ8UBjJfZt03eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flwetaym; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flwetaym"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ccce6d9abfeso914891a12.1
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792327680; x=1792932480; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9DXWZWGt3/ehx4k1EsItpkNjOPNH8RuGkAm3vDqpKI=;
        b=flwetaymbf3AxzugGCOov9VNEhCs/xbe2Nw7PWqTroVJGqVe24kPWFo99X8LFWl/UM
         CUMTc5wjLH8aLw6I5K+G0+TtO+dkQQyJbf5SbvBF1XXV46zQvGDI9pILwrA/BTx6nX0E
         F6GSSsb5l8ZPVUcktlUieolqukgkpVgMrJZMC4HYG3OEwRtb2DMX5o5PoCxkAnDwV9g1
         Qbjz9OlVfP5ASUJRYwSN/BSc2KX2yqcurikplivJK+P5BDaiXvIZJRHT/NRvJcVs39gj
         Nd+8AKj70zj8P4INIp+FxXOHfbjJXcPoOPV/y30fJEYmyRIoqLTAW2pZ4Ps/e8hpjAhT
         86CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792327680; x=1792932480;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9DXWZWGt3/ehx4k1EsItpkNjOPNH8RuGkAm3vDqpKI=;
        b=2LnVbouQhSQQjnSa0Qo6qOEcXQ6qiyhrZAaXbKzxRWGcWSEdFtLlG5qKtolWHsb53H
         /FZaYkVLWat24ZmdhaCCDU/d2lJzD4ZR9tftNATSl5KfUNWBHtlCYuR8943U01Mo29jq
         RQEKrqF6lYiU4iGaBrj/J9s8m30NVkeI7eJQic9mRkVu43QM9FKKdE7FVIyu06woJHuw
         HVsHQPSuRR4F/y75qx+BOwnrh6mPV3Q+qLj7DcpKrgQhErOaq2SniULqqHofIthI/IMa
         u/zECQX/FK7AD+EIGEdhRWWROJrN/PH0Hu9byw33iz8nbjFYUa6GoDUBenLontPXtaDS
         cN4w==
X-Forwarded-Encrypted: i=1; AKwUvBxrxfL0szpKUHz3c/QjKNuyw19pHy3OVClZK+WVgka+lb/til2nNu9w+vSgU9/JtKrLlfDw9h31hfkjwA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3WzGAmsoHiSG6THjUY9PzgKRcJtDrPVO0wSsLobi2GOkEEK1T
	DcHJajlVtvDH2kM6086ljuVtPiKjSA87kgNFsCoJGLeV8/QjC8/HDMPY
X-Gm-Gg: AYBFou24z+w0Q2xmh4QJ+WGjq8ULsoReJLbOgJoH9nmTG9oid3WiYvJHzlp48VvMoDE
	jwV6XpjMOnV6PtG1GGtITKR/Le4EFuJv6ohFLfBaDfWm/7ochrLZTJapnc4HvCpaewryGxtIr0N
	J4rooLHoyg7jo7vy289eewl7LM8aM4BAVxj3fnlwuRKIytX0af+LiaTn6dpCfhPOYXcuS4EV5pc
	85rsWXe6ZYTGh4sHUNEmaXDEooWnQmWpV5WlOec78yVXy0KZJR+Vo7sStH8xTbjZZOGHKVI7WBG
	Q7RmHM9+6QU+7pG4nIHmnPOUStd6QeGK91dstR8ButhvihRN+HkwtsH65IHsGxHa+SNGw0j57tA
	7tF/xWz/S/LoPq8BL4x5WT4VeHUXqNmrwadfuOzMjDYHYGV9BAsU+iIiGt1pFUYl9cSmFeN5dEb
	99wOs2xiNdd2AV6sv52tnwFRyPKvH41KrbowvhiQgCT5Bal6fwpGzPArsglfRzEB35Pfe1cCcip
	MhaUAKw7vEU0hCv77lOcHo=
X-Received: by 2002:a05:6a21:6f89:b0:3d3:aec2:4dcd with SMTP id adf61e73a8af0-3e225fe0385mr4135819637.25.1792327680056;
        Sun, 18 Oct 2026 05:48:00 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6549ee946sm2804669a12.20.2026.10.18.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:47:59 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v3 0/6] HID: wacom: guard against NULL input devices on successful probe
Date: Sun, 18 Oct 2026 21:47:49 +0900
Message-ID: <20261018124755.850888-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
References: <20260927041138.4112920-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When wacom_setup_{pen,touch,pad}_input_capabilities() returns -ENODEV,
the corresponding input pointer is set to NULL but probe still succeeds.
Subsequent irq handlers dereference those pointers unconditionally,
causing NULL-pointer dereferences reachable from a spoofed HID device.

This series adds per-function NULL guards across all affected handlers.

Changes in v3:
  - wacom_dtus_irq(): DTUSX is pen-only (no pad), so the pad_input
    requirement now has a type != DTUSX exception, matching the existing
    GRAPHIRE exception in wacom_graphire_irq(). Also guards the DTUSPAD
    branch for spoofed reports (sashiko-bot).
  - New patch 6: guards wacom_24hdt_irq() (also covers WACOM_27QHDT),
    wacom_intuos_pro2_bt_touch(), and wacom_bamboo_pad_touch_event(),
    which were identified as unguarded during review (sashiko-bot).

Changes in v2:
  - Restructured per Jason Gerecke's review: replaced per-branch checks
    with per-function checks for dtus_irq, graphire_irq, and the Bamboo
    handlers — simpler and matches what each function actually requires.
  - wacom_intuos_pad() now returns 1 (not 0) when pad_input is NULL, so
    the report is consumed and does not fall through to
    wacom_intuos_inout() which would misparse a pad packet as a pen
    event (sashiko-bot).
  - wacom_intuos_bt_irq() now guards both pen_input and pad_input, since
    INTUOS4WL always has both on a single interface.
  - Added dev_warn_once at every guard (Jason).
  - Dropped the cp2112 patch (Benjamin prefers Dmitry's series).

Tested with uhid across 27 Wacom device types (spoofed bus):
                   unpatched  patched
  KASAN crashes          17        0
  probe failures          0        0
  hidraw nodes           26       26
  input registrations    25       25

Jinmo Yang (6):
  HID: wacom: check the input device in the shared report helpers
  HID: wacom: check the input devices in the legacy irq handlers
  HID: wacom: add NULL pad_input guard to wacom_intuos_pad()
  HID: wacom: add NULL input guards to wacom_intuos_bt_irq()
  HID: wacom: add NULL input guards to Bamboo touch/button handlers
  HID: wacom: add NULL touch_input guards to remaining touch handlers

 drivers/hid/wacom_wac.c | 111 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 108 insertions(+), 3 deletions(-)


base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
-- 
2.53.0

