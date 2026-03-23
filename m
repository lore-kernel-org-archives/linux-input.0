Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D11F2BAD
	for <linux-input@vger.kernel.org>; Mon, 23 Mar 2026 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774244383; cv=pass; b=s5u7agB6bBXr/Bw3Gmsy4Kt0OSlpmLFKYEUbCICGANRXegVZM347g9jNuNyfelRMCysnM/2aGPP6BhuugWRSYL3AmtufG6HWfJKA+PmuohO84qHM7+zcSwWkI8WCpxHREcapHpw3UhjfLEph2c3npeT/l1B+8hDx0gddVC3Mx9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774244383; c=relaxed/simple;
	bh=H84eHl6Teed/rAhleOsuBYnCW36yeJCyFzCzcGh9MA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxsS+G3CEI983h/7N1v/K3RYf2vE3u2kJq8I2X3sIyAuWidvYvH5wCGgYO25sNxzzgLxbKG3RmvQjilBESaA1VDexobxOmNP/cbmo4DvJDSGRvVTPDpDzMtHZmXmPGP5ki66kU3yHvwy1LEPlojtZsCpASWg6Ot5wEsOI8Gpc3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3eMmvdA; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3eMmvdA"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d7f8f0d7c9so1971812a34.0
        for <linux-input@vger.kernel.org>; Sun, 22 Mar 2026 22:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774244381; cv=none;
        d=google.com; s=arc-20240605;
        b=cRyPbal8v0Lp/F+ylR+SULJDBLCRVPtm3UXzHD6DYpKFkdrVW176CiKGkwuDVsKXBw
         Tk+/7ST3BLQByvgvr+Qvs2+C9umeb4Y89rhhP9zkGriODohrrdtxf8sVsrwQleMSep0V
         +W6XJVbiL+nW1kjFfl2bN66O5p9KY5q/WeUXOg/tqpDzfZRTo7x31EK9Xy/xGW0JQA5M
         QI4pF1cDsEzSfS+a2D4yJsf8gN92hPy+SHIihCvzOJm90al4msvpVTTgRBAQzpwpEK7q
         FYLlfUetW+2GvkeodnC4GJJ7U4QGsIYWtCd9clC16cf+Ed3m4jMqtnqLTsi1BN0mL23c
         ynfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H84eHl6Teed/rAhleOsuBYnCW36yeJCyFzCzcGh9MA4=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=LMGRVFjs+sXtUze1fZlcEnD1p0NwG+Mr5Bw7xpOj/QWC120jmJFZcCbhJq1bPJRDx1
         hwP4M8kZ8yMeOZ/X0E2vj7r/CJjFqMmWh0+PY3tX232ToF4GtNlyHId8e4ltpzxC0tnt
         Qv/QU+5ccYk1SyCWdV2ndLy9kb/HW5rUqIYa6CmaLiSSJuCBH8SYIzD/tZ1U1A/+391P
         +Ys6kgtS/bo2MAnwu51jDnfUsl5Ycdpm1Yr3kG6xwvcVI5rlFHhB0Isdh3SZWYIS4UQ1
         ervHp8lRTYfRetCpHspfvr634CMIlJsvKkL+gSSp4BV9alLvLsiwWMs+O4JQIK9/HmOJ
         J0JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774244381; x=1774849181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H84eHl6Teed/rAhleOsuBYnCW36yeJCyFzCzcGh9MA4=;
        b=d3eMmvdAtDGMIflH5uRIn2nz3cvzuVJxVqVFmamRP/+0TO4kYcGT8hzYT1+5lKU5+u
         qLwDgYanc66NvLnFQehRc4SjiKofrjcRxEjIFKy9NCN+rH3ejHQrKCRRGsXvLnQIzHkv
         TEPo8umrGoJQZQq5o2kUbL+f2M/Qv7JvyPBg0+d1sT3Ojif7zW2C4GL++uqWuG/IpUUz
         YjFet04CiIN6cwcGd+BeLSBDZ+Mjq6jOAuF1JlA0Gl8kYP4m/ltbqloz/4d3AibdTISl
         9MG5Hxua/MwgsMbp6jycfcrhANk6EWkHn3Jab7HPvZrWPLo/PECmbpsBo0kxzWwKTRPg
         UuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774244381; x=1774849181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H84eHl6Teed/rAhleOsuBYnCW36yeJCyFzCzcGh9MA4=;
        b=N9gm5qt8KYg+aNiRwI0ocub+RqZaIy28HqrvtKuvHq9uskxE4OtNYFYt4cXPhCf18T
         jxhnGKrCRnX1hkm4NTHtTCnd+/tgZWklulGU8uS3lrC48Y21lgf9WlQ5Q+eW5FuTi0LG
         ktgyZglvOynmxkUynExNATEM5NEGa9OpPmBbDCQRSBuYLEk0JDTl00iLQAqkKhqvbzkD
         m9IyOh+avVgSqsO5NdiP7zZZ6p98+MJxm5aLgcM3EUBHBkCxNfS7gu09TfNECDOIVTfU
         Y2yzpnswgoRFzmF89ymjGOyJa6l5mdpntlaeHLGzvc4UWh0xvRKtTPSEHbZR3EDsi+ex
         98cQ==
X-Gm-Message-State: AOJu0YyCQFBhJqL/fWtKO9q08LZjyX4Qfhb9OfV0hBd9tE+nJF5ZvsNu
	WeJ9HJzSot0gEWPMfIxdhjaes/KO1zocowqutrBH6qHzrjiXyNORp+/ekbEl+iZ67uyU5a7ckS6
	Q+i+eR6KKgXV7XIwKbwW08Y+5reeA3+LDA2FiTb8xlgyy
X-Gm-Gg: ATEYQzwxKc7a/5DG4OxUNm8FdLZ7Zc/D8souau8y6YeWIdx6eW6y8Vbs2odhVMD7XNg
	gjbIGMx+C+gjREFlKwrvIS5HQjHsaeQ2CKF7yQ1JHtBH4Nw9WKJhbjqVCfEjNpCE9aqxLZXWGlR
	kI0DiU7KyidfmBOcRU7SMtJAj0qGhn2WUA20Vg7YVX0dOYn7YuAv456vI53x8ZvWDS79NoZdq+g
	hM1d9XI6UgNXYNP5OWKzzZjlqs1VrtgPuXzJlgyQNhG5kbxG4slWGvLedMUgE7j+KbNycFMNhLS
	N+/hYtBXHQ==
X-Received: by 2002:a05:6830:210d:b0:7d7:fbe5:e9be with SMTP id
 46e09a7af769-7d7fbe5fa0fmr5797673a34.20.1774244381092; Sun, 22 Mar 2026
 22:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com>
 <acCpW6McaPOE0Jq5@google.com> <CABXGCsOwJu2dw67bR38MJb5DFvGon=MUCxKcGEQYfT6qrPZU1w@mail.gmail.com>
 <acDPeFpxX57Uu0Mm@google.com>
In-Reply-To: <acDPeFpxX57Uu0Mm@google.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 23 Mar 2026 10:39:29 +0500
X-Gm-Features: AaiRm51QckzytEnrMJHKSFBHMMo8Y2WLryJ5TcGoiBq75kBcFjOA9WE3bJKWxng
Message-ID: <CABXGCsNwLTAKFdRDHnGBdF-h3fnKY0_ysQJevMTv-N7+MNwS1A@mail.gmail.com>
Subject: Re: [PATCH] Input: uinput - fix circular locking dependency with ff-core
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 10:34=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hmm, I am not sure I see the issue. We are not going to change state
> back to UIST_CREATED until after uinput_destroy_device() returns so we
> will not submit more requests...
>
> What am I missing?

You are right, there is no lock ordering issue since the state
transition is one-way.

The reason I reused requests_lock is that uinput_request_send()
needs to atomically check state and access udev->dev. If we use a
separate state_lock and release it before calling
uinput_dev_event(), uinput_destroy_device() could run in between,
unregister the device, and we'd hit a use-after-free on udev->dev.

A separate lock would need to be held across the same scope,
making it functionally equivalent to reusing requests_lock.

--=20
Best Regards,
Mike Gavrilov.
