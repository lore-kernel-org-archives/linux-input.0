Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CDF35E1AA
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 08:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791707187; cv=none; b=fznrZ21eFY9A0iIiSde8s7S7bjlXxI9vVTfdGIUVmrZ1pT4jgBQhP7Fe1hpIdHYPs2ZU+iyPKrpSn6GBoPBXheugKdBLmPShu9xfHTbBB1UlvuDtX1H3vkwPWTHg3kFJK2u5trJ+cKGO62hms6cCUCdLh0idjdGRrh8YuwpZq8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791707187; c=relaxed/simple;
	bh=y1QwkgceHzfBH6MZ8up+J75RMMDg6/896hgV8nyn0sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAEKnbnxfxZS260zGkL+l3pBRTO+sgq6B9yo+ylq+lBFWrvulz9aN2EDUCLZJcfV2f1+xSJbRH4HUAn+Bj/ccK58E30ev5wx105/vuZGCoctvHueWXBAQyfJjs/N7b/GVyzxCu54AHgUQGjMybmXGvpxJaQnLnxz0WBeRRlpgwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPKv9TRQ; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPKv9TRQ"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-35115b52125so1327102eec.1
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791707185; x=1792311985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8/K6Rj92lKxX9ixsqo45OJ1kJLg7bhafYq1xFabLpUE=;
        b=iPKv9TRQwWEFLkkrUmX7bd9BpBCe0wFbIl6W1J3Xcrg73D5TIAWSqZzDldOrML4kMA
         28HdfSIwMAl3LZ4fBmpPM4f4BYLw/d1hhmvWaJiNarhV+QgU1dB1stFsks3SvEw4bHAp
         xPR7SfrLsqA5j1cKI+/ibJgBlNLRM+grpyPIFVpfSrI3SwS1q4I6HaHIqkmdeN0z+JBR
         mUrk3OzB5cJxCEz+VQW5BlK6PFtIyXmgRFqneKdNILPKn5mH7aFDu8UQkVRS4h3kOvk/
         mwWt+Spvvi9o1MZfB8nY0iVBVJXCH67GhBLDqMtxpMV03z7JKVPLfdh7kCoREhVtyIGy
         SH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791707185; x=1792311985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8/K6Rj92lKxX9ixsqo45OJ1kJLg7bhafYq1xFabLpUE=;
        b=ynkX6JAq6N4V5Qy7bPLWeiUWtm/ImcU/nCM/3uO/vYdSYQSacMb8VJlMK5w573bKRv
         uQAP9Y3m8fTUPlKdFPf7a2SOrO9/1LWYJIZiutCaXsXOt6pIem3Jy/i0Shqazi3OWFAj
         9ryuVKzfFOnyVMy3iJ+An6Cw+4gr/V00sc2f7YFAjCb1Aiap1TcQF0PL92seixq6uRLB
         xgqWM3fcQu+euZvECgD+jtH2n1Y3hlsqiteJ/esrrBxfUb75tAB6v7MzfrFhty3RZzZn
         MPqhyGGYxpskel+ooJKeRplMntgdvJnVwAU3mq2xMvSm37Qj5sqf/6SfWXXDuxeJH5oM
         YIwA==
X-Forwarded-Encrypted: i=1; AKwUvBz98UT2tFxTIkUWf10S2wrOSfKIwB2NF/8J3ckxanzqzmv7RU0X9JfphmRFlZ+3isyLAZPK36XMFP0/BA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKtSt5wLQRWoniyHFuURYRtqI72rYFhEnn2aEuV/QrPin/FPtat
	J0dP58SHVGyyLmx2pn2BbHWZayxyDvO+z0Jl5GMrngaBwQ8Nd5JK4nzQ
X-Gm-Gg: AYBFou0Owr1DqZEfoVw25+2mMn0++mQarHgxb12DVEe41hOi4VvXQamtOPCZe40npe0
	JP6d2UckhDD7QUTCvwgWhVbs7XVmv/P65kQP1FI2RyTcCFDa3ADNeB6G3+CGBCVuji7dompIxwD
	mUEO8NuW61Z+sv9PFwpY/gOp3GN0bXnoknjbbgy3FvlVBpyRr6rl/P3qzCU2uZXXl23yWrf/WbM
	N3eAFdKNJx4K4Qo6Hwy4K87ibJlnsx9QGMpCeya/SSHsrZ75ahNg1bCOUxaqwtxAyylNm8ovGjf
	kxRv4YNrkmT1fD5+M8v+xkIq1l2x4u8tjGGbz2fDkOaYxX+am+CP4oVaBVpCAbQ1EaCgCosS/1D
	QAERhNVEv2NNZGZEgNs/Vn2oKYWAYKxJydqkIeq8slF0qZciFb3rinzHjvzD+8bTp5vYHhcNbTm
	zKtvikgLpCWbk7Rvu/pyAIvNz8WxOxtPuKzm3mcFTPIqSIhH9gX8Rn7Tq8MO6nrnEhgNybbnGsk
	k1WvnE/2ThJc44KwibxLC6vCEkjKkNtPuP95LJ2Vr/0ElHLdxd3jDWgm9dXlL5rBvEBtxxU/3Hz
	Oa2VsA==
X-Received: by 2002:a05:7300:f0ce:b0:34b:b410:9352 with SMTP id 5a478bee46e88-3537de1ce96mr8934868eec.1.1791707185179;
        Sun, 11 Oct 2026 01:26:25 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca67b21sm21731611eec.11.2026.10.11.01.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 01:26:23 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: 98lawweijie@gmail.com,
	aduggan@synaptics.com,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
Date: Sun, 11 Oct 2026 16:26:05 +0800
Message-ID: <20261011082605.220206-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <asm1vCJYVKA5bHnd@google.com>
References: <20260825103123.12216-1-98lawweijie@gmail.com> <20260825103123.12216-2-98lawweijie@gmail.com> <asm1vCJYVKA5bHnd@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

On Fri, Oct 09, 2026 at 08:49:45PM -0700, Dmitry Torokhov wrote:

> Per the Synaptics RMI4 specification (Section "Function Descriptor
> registers"), only values 0 through 6 directly specify an interrupt
> count, while value 7 is reserved to indicate "more than 6 interrupt
> sources" (which is why the comment above RMI_FN_MAX_IRQS states "up
> to 6 interrupt sources in the normal manner").

Thanks for the correction.

> Since the driver does not implement support for functions with more than
> 6 interrupt sources, we should keep RMI_FN_MAX_IRQS as 6 and reject
> functions reporting interrupt_source_count > RMI_FN_MAX_IRQS with
> -EINVAL during PDT scanning in rmi_scan_pdt_page() (after the
> RMI4_END_OF_PDT() check so unpopulated 0xff entries still terminate the
> scan cleanly).

Agreed, I'll be sending a v5 patch that does that.  Tested on v6.12.105 
with an emulated device: a function declaring 7 sources now fails the 
probe with -EINVAL, and a device whose PDT ends in an all-0xff entry 
still probes.  With the check moved before RMI4_END_OF_PDT() that second 
device is rejected, so the ordering does matter.

Thanks,
Wei Jie
