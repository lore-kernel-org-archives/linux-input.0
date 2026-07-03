Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576D3B2FD6
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078001; cv=pass; b=NJsIPxTuW958Fdi+8hWNzw/EzcmLOxDT5MzDSvA3tjKC9wfbBJIVXLvVbKjJCSKKtqyAuVJOnOvx3ura5QjiMoAvCbCSxmkraho9WnHyc9dQi+ZekPfF97RI7pADcWLvqsdyler8E4QrhJDgw1Z71p6DfyvUVVfKDY//D3NRf+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078001; c=relaxed/simple;
	bh=/CAFK4yhODh1yEw20nMKqBWtMNKPIlPR6Gy/WquBXTA=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4+ipky+WCOE56LpWGZPASHmc+Uw/AM0MG64fy1tCCyGF00SqafC09xV/wNYjQSSmeNiV79NZ4hKFz4sluuPthV2KJO8BrUJ0j74ou2cBGTmlBid3MDV72c0StnhyUt863A8kxNP8VVhcXkzzMckseHUQECARZ70ebIdAkmqeUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkHjPHDK; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkHjPHDK"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8114a4542b2so5956127b3.1
        for <linux-input@vger.kernel.org>; Fri, 03 Jul 2026 04:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783077993; cv=none;
        d=google.com; s=arc-20260327;
        b=abUNCHNfJt+0958DABPQ8GJENv66I7T4DHU0nIrlrQGjNU0lwbDWW+iJAWxPD3fDdm
         9aytWdJq0N+dkBHNlaRi5zdwb9lbZqGr1M21F1tVAVNDcuvg/S/Pc2yNhyM1wA4cmVOD
         ykJNOQNPhCMtP9GS6vRFc5OJToyXehEHE0faF2Ah3YoHb86stGfPUybfBli07mdS9ykW
         /9J/AntKQQ10oFA2z4fQQ+l0IYoNJwVJwBLoP0AQcVEwVLC9LJd+MQCgS7xpoKCXb+uC
         8z9hvrUb16K2jnhFNX7aQqntFXZ3/j6d5xRBLrZX1xU+/Ts+RpyjWYbmTtzIuQX1ZERG
         7yaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=IUWcySxxjMkS00aSrMa0juLU5GaJEWe+OlyppKldV1w=;
        fh=SaguKdilmUCqjaGJ1RXqjfUGwx8Fiw6hHSY2z25+ydU=;
        b=WS3tYNBxr8hDDBHNtVXFu+X+i8POpVHa6dcZKqVgcK6SuWe89dgitva3bvV7WjPvyC
         hFK9usCJzuNfPpBEOTLueGumk2f/guQMCQhCKAXpo1W0Xw0rSLKjAHjTwoQQBt+hFK9y
         pdp9qOQc+nf8gK8yFrgJkn/RV8uvGc/IVgJrV4uBdXB9K1h7bc11BH6HtWx2aHuLb7sn
         BWt0dwBo3ks7DIrcti5EpNjyVOE2Ni3TCFd5mXxeH3w7lEACZjHiikKqIioCsoT3J0dI
         G6lYh0WEvM6Jr87xYjpbtebvTxfX+qiqC23hR/hNkrB5qn17cuz0/Lih9aQLj3ntH7yV
         HZXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783077993; x=1783682793; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IUWcySxxjMkS00aSrMa0juLU5GaJEWe+OlyppKldV1w=;
        b=BkHjPHDKsE5ocjVF4YkGNj1ZTVIldSh3EgS9+NMnat+X+251hCf3v4CiTEfhhkx1nq
         NUgxfiHmk5XyKneNNPqi6mXA4Pez9nNT48WGMOOFXIPWjAW5Q4JLXdZejeP9nnNdTCsB
         n+Bt6n+2sPdyomOeG76vOk+3B7/ovejhG0kYNQb3MMH55C9dNntHYL7XWuR7mgNMs/Go
         kJqQbKL+MXSkL0JhrD6isB/AIfRqSquYf9x9pkiYVKR37jbttK1IHDTiO12XpIhQjcjJ
         CpMUJ48tS22kMQs6Fti/d6tSGM8gxApM+woc7GNJg0whjf+rWF860NE+K4jnYHCWtfcf
         d/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783077993; x=1783682793;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IUWcySxxjMkS00aSrMa0juLU5GaJEWe+OlyppKldV1w=;
        b=Wyonj46jJBA6EJLv+BV/9XQnCjLtwEqwMglsyGyx4kBT6A5E5vvxwXjx5BduKk+wAu
         63+1RDCcys0FRUiXUjyFm5yJ/9ZExpxMB3aJ9j6Buam1XmB+DGc/e8cqB8VL7j8mGpkt
         m1Tpm7ZseniJqsERjjuyIN1cu9dWwbVMd/L950rw4j6b9talq4RldHDCIsgtNK3aduUP
         aOnNZ569JCG7x3xuSablzrlj8r/kJub+SS1E70sS2IXScaTs+lsWmIJLVk6/Vg0pUg40
         HwPqlrbFWXuc2XALV3Nf0ZbFPvgT6lE/eObREKEksy6rRU1wyjoKo89cFRx0DmUG7IVX
         kmkw==
X-Forwarded-Encrypted: i=1; AHgh+Rpl1Bv7n8H4eULZDKcdbzA5R3W8bWKEM7yXYfCpp32avkOltigfpSHQswwpJOpIDsW21nnNR2LOKJHu4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQj/zJu3iygR2umVMg2yZ5t0+xytNI5bzy7YjG2VWmJM6GOdEn
	xYaovYgxCI2WP58jJjhI02kBkW5WtcXR6lZpgBNnqJBDfZwTeWIcm6Q5iJ1sN+PhNaMqpp3J1zu
	ISpV0r9ci8xSKXZiDyz3ivIln9KDRpst1jZyK
X-Gm-Gg: AfdE7cn1tf1v/k54AstCtG+qlp5lKIYjU/d5LefMCOq8QEAHm9U/FO7WhydxlizJcxR
	1VSzBaOvVXsPdaFFulzFIU7Vp9vlTJfdRo66yxC/L8K4WqhheOdxfaIEWw7HWpCQT4SX/q/07Wp
	dEnllJSiW8aNEJ4+7FJFJV0/nf5t0+J9EiPD3u+BhHMHWxZLHA0PTNJDjMsvH9S6tG2NsdD8BE3
	cbu4qKgzP2ORm/WbCUFCKXfyghJJEd2e3R70j2Ija4jNRSMfq7YLQOuTAcA41xRx8V1ec3ndA==
X-Received: by 2002:a05:690c:c6c2:b0:814:3d8f:7ae3 with SMTP id
 00721157ae682-8143d8fd391mr67070857b3.39.1783077993494; Fri, 03 Jul 2026
 04:26:33 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 3 Jul 2026 04:26:31 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 3 Jul 2026 04:26:31 -0700
In-Reply-To: <20260702222145.1863104-9-vi@endrift.com>
References: <20260702222145.1863104-1-vi@endrift.com> <20260702222145.1863104-9-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Fri, 3 Jul 2026 04:26:31 -0700
X-Gm-Features: AVVi8Cc3cljdn3PT8-lHy-9Ib0ceJ3WskpQPZkP9pJp2g64DvzlwUrTqDF3zoD0
Message-ID: <CAMuQ4bVSA-Ca8RKaCeRASO=HJV=hkPDNOPyfdg6TZm7BQURnSA@mail.gmail.com>
Subject: Re: [PATCH 09/10] HID: steam: Reject short reads
To: vi@endrift.com
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Vicki,

I think the length comparison is reversed here.

hid_hw_raw_request() includes the report-ID byte in ret, while
steam_recv_report() strips that byte before copying, so only ret - 1
bytes are present in data. The encoded report body is data[1] + 2
bytes (command, length, and payload). A short report therefore
satisfies:

	ret - 1 < data[1] + 2

or equivalently:

	ret < data[1] + 3

The current data[1] > ret + 2 test will miss the usual short-read
cases. Also, when ret == 2, only data[0] was copied, so reading
data[1] is itself uninitialized despite the ret >= 2 guard.

Perhaps the check could be structured as:

	if (ret > 0 && (ret < 3 || ret < data[1] + 3))
		return -EPROTO;

with the diagnostic adjusted depending on whether the two-byte header
was present.

Thanks,
Yousef

On Thu,  2 Jul 2026 15:21:42 -0700, Vicki Pfau <vi@endrift.com> wrote:
> Steam Controller FEATURE reports encode the size of the message in the
> message itself. Previously we were trusting that the size reported matched
> the size we actually read, leading to a potential issue with short reads.
> Instead, we should actually verify the length of the read.
>
> Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
> Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=75f3f9bff8c510602d36
>
> Signed-off-by: Vicki Pfau <vi@endrift.com>
> ---
> drivers/hid/hid-steam.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 593151709cf1..e97431bc2828 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -389,6 +389,12 @@ static int steam_recv_report(struct steam_device *steam,
> hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
> else
> hid_dbg(steam->hdev, "Received report %*ph\n", ret, data);
> +
> + if (ret >= 2 && data[1] > ret + 2) {
> + hid_err(steam->hdev, "%s: expected %u bytes, read %i\n",
> + __func__, data[1] + 2, ret);
> + return -EPROTO;
> + }
> return ret;
> }
>
> --
> 2.54.0
