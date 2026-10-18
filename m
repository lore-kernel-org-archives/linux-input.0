Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FEA38F25F
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 23:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792366293; cv=pass; b=ubOdZqdgkzQBGlD+3KpWkvSG6/GvYCjJABd5n7ZevZMuw6Cp2FY1PURhScvc8xREHAeXsLHthVjA/tThxIA8p7LiAkVUzrZQxbiAQMuaJEG/mk9Ub3/E8FO6P/lbspftEB6+NX8mhzxqmjQgkels6zMmOB7eJp5Obw7QwpDKrEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792366293; c=relaxed/simple;
	bh=Xg38Z07jNwHN1F4uO1K2Lyf/YBRj7zFPK1BqVTeQ5ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agGFa3qtbfyDTGpqQUwyAkvmHpuQjq5fFM5UbsIro32ovloUJ6PTGRZW9UZtXyG3o364UQXYzaMve74r5Q7owwqGvk8j57NtWKbEIfP8ntOJyY88Py5DQ1UdfPg5kFzppA0DE5upc7x5SBuc3cL1yuPKJwv1/bk4I2MXNZQWpKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSw29dl+; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSw29dl+"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-745497ac8fcso659423137.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 16:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792366291; cv=none;
        d=google.com; s=arc-20260327;
        b=BdmaaemxvxMnyS7kUQfjXEQkYs8I3thlBA+iBmG1SeDpRin3mnNuedg/ijRnz025Jy
         bCHP2kSNogzuUXWGKONarxENVd1ifDH6aXuDdYPvGHnlhQ7675yuoCW5LDQuCNrr8xMs
         oNGXt9dik9GsIue34ghC4g0+QYa5A1taSB76K642suvAnW0wB+hVoTRefGcYyHmiT7mv
         6FpbjzfhXHvEMvLW+FZgGDiufJLPgWWrjHW/7fvt6xt9fruELyBq4gGQi8cRkYgj9J8+
         wd9IRd9SgZMhWjwVWsMMTwP2OH/yWIW0wntpV/cBnTXRcvOnhqhILX/q0MPp+ZbFAYja
         OwfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Xg38Z07jNwHN1F4uO1K2Lyf/YBRj7zFPK1BqVTeQ5ks=;
        fh=dfvPRi+t5KvUF1qpgNVmacxvd83mvku6fE8K+/2kbH8=;
        b=aJHjBvVVaJnvcOYvE76qi2mQWT1/mtHMHYjvKuI5pX+RkOlQp28zVdsdUr2tScGN5E
         x4EVgTn/EBBaZdY5Sl1nEMGIiMby24UzCjfayHMjbeH42JhLMGzAYn5l/6EY7tnc1u1H
         rQbOMPdnqEKoAs2AvOvI1jVRuxKBITjh4tA7pmv2QEjskYkj+HAz+OJ1jFgAALVqWraS
         8U3RRjITKcoZwB4WzwTZiFHFq3eIjTtGvIVt2/wpLEvrJbGHE8ZMBzniviVqJjk8gs9v
         FdzLU6Rhunc+X1kVKNGZGDaVxlTg+JAIr3rM/TTojEbenWwcg7xro64fDQ5DUWY58HYH
         qSiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792366291; x=1792971091; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xg38Z07jNwHN1F4uO1K2Lyf/YBRj7zFPK1BqVTeQ5ks=;
        b=cSw29dl+YSslsENFo64iNMj52zXp3NYDB1/jGuYYme/GYYWHJapZaa2fOh+2TMIRTw
         NYzaqrKGDlDwPJzSjRCW32yXGNKIwdOZC0KTR4gS1eNO0+l7QNxFQL8RHeyrbgFzhbpu
         opwjrjl0tEOeGPtIOhI4kQaJLuLsZBxI9PIaRQ7dezjSPD3xDLQARKd7/jLZax5P/7Px
         ix018CJoAymwhEadh/IxElboXPnPmyBqL2/Shv27V4+AKFjrqRM8nPLoNzSPmvE0oyGc
         DL+pdYYc+LgMoI/iLHSlSptyu98Q43Pfq3BraBVD6EP9okX5Zkid9XmLp6q5F7czBcEI
         izog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792366291; x=1792971091;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Xg38Z07jNwHN1F4uO1K2Lyf/YBRj7zFPK1BqVTeQ5ks=;
        b=gvN+GlmN0Jl/YDmN6iEA1zHmM+61Vsh/7YvVal33QkHVniY44ymwhK+pR/31qeisQY
         IDx9kJomzThY/Zy+KSqi0nwCmB+cqSpKj3qrY2cEnJIULmo9O7vupzblXbs6VoHgONKB
         x03aIVPyw7UtNh1z6JxkzLNxwDhXAtzw20cc3VMttFq9AKkR+GXfkOMhMWK/EaBVjTpK
         w/F4cLI1SxUaYlLf9QDlnApdUJUXMJP9rbGVBcG6ro0EP+tWfOn4H3lTLUe4jtFh+Fq5
         AWqXe3mY4Ltp+vee9Hd0eSlIYYJcjRWuPYE6kEYhaDGkfMtZ0fCXlkBn0MWBR/6n3ZJt
         HDuQ==
X-Gm-Message-State: AFq9FYLErQiy2rFZmfWbQjXATCFkwEcaZuEjQ7vYD5xAuyfwvpCKkekz
	Lpqj7mUSFANzy6L1V7zhslt1ZUQcv1mYplShcKZ95tbf92iR8OieZziLY7ZQHR2+4GZR+Bm1Aaq
	/AzF/L7yIeeaz8oiY7AG5YttW/VnvbZk=
X-Gm-Gg: AYBFou2Y3HRqya/AwFy7DsMMo2+o14HitKgHf6a7Ps2mS6RR5TIYgW04cSkbWiEbI+8
	pkKUU9xF0aeqFMiGTcKjXOGZe4V7xY/3BYXFioN9e+WV2SSm3LVvRxcNH7O8lydEwyQHyhRINRR
	KDPkqwTXs1m6dpZypea614UOWkjNsB1YifgGFY8XgCST/D9Gx4jd8RpUEhl98jxQ6f3FCG6180J
	QrOHafsdus2b4ICu/zGLPcK30Fi0BQv4N9bDfnAQpTFrC31MN9jA5U4VQEHGoSfsXPFnX3TZEWF
	C7Q770nhvmCXqfchXQp0niV9HaHk55vBYzecPPacLLf9cbi+9xgh3yEBmA==
X-Received: by 2002:a05:6102:3c92:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-7cc36494a62mr1577333137.0.1792366291163; Sun, 18 Oct 2026
 16:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018224627.60328-1-markpariente@gmail.com> <sashiko-outbox-176440@kernel.org>
In-Reply-To: <sashiko-outbox-176440@kernel.org>
From: "Mark R. Pariente" <markpariente@gmail.com>
Date: Sun, 18 Oct 2026 16:31:19 -0700
X-Gm-Features: AclHuK9fAUVSx0HILj3AwYV2CMv6TDhde-IMbLTUz1PFT4ZZ37tovEoqYzIwRVo
Message-ID: <CAEFveFzbaDrjALGQ4kABdpGe3+JmYjGBHpNhP9HCUZd+vsspRA@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-dj: Re-announce connected devices on reset-resume
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Can calling logi_dj_recv_query_hidpp_devices() unconditionally here break
> Unifying (recvr_type_dj) device enumeration when a slot in
> djrcv_dev->paired_dj_devices[] is still NULL during logi_dj_reset_resume()?

Yes, thanks. For a slot without a known device, logi_dj_hidpp_event()
passes the HID++ 0x41 notification to logi_hidpp_recv_queue_notif(),
which adds the device with reports guessed from the device type, and
the correct DJ pairing notification is then ignored.

This predates this patch: since commit 74808f9115ce ("HID: logitech-dj:
add support for non unifying receivers") the same happens on Unifying
receivers whenever a 0x41 arrives for an unknown slot, e.g. when Solaar
sends the same fake-arrival request on startup or when a device
reconnects. v2 adds a separate patch so that on Unifying receivers such
notifications queue the unknown-device work instead, which enumerates
the devices through DJ notifications, and makes this patch depend on it:

https://lore.kernel.org/linux-input/20261018232654.70571-1-markpariente@gmail.com/T/#u
