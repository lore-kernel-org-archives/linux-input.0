Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794617132;
	b=hDbKmqgSu3G8WmDy06h0V4W3N1EekcTvCWdnYdcpBUFVZvlybj8RGHQh6zdABUSNm3LR
	 GD/GFjaBK8ogetQuytPS5YvT7iOoVZCCQAThCe7bwJPsRFCsPx10XVYFhAUROYCn+qSLN
	 V9Zy2FfXAIpi8ah893ARsV5e2zPQKp/GOpAwoXceK1py4tGi9C+O3rPqdbiL0fjEsGQNV
	 ODacygJumyfC2sWkp9Jr7/5x4lPCaOkE3drBh5UGiDFAfues5MntOmFefWHJKVeZRaNMB
	 bZrW9L6FfpxU7WYE0QvPUYmUsnhdBfCYnd/AFNnywM+Vls7MpjroVQbxJGY7CKltq6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i5jYtLz5EBj5XfHsrNl0LrZsplW7Xpq9cdHzn4aoCIQ=;
	b=nth3PfuMb0fiCZwRZ/JlXYpfnixE5zEsw2NQtd/1m94XohCLJpDLPqKH7pHv8rQ9Iz+q
	 ZWWEZUhstsmd5yD6Mi3FNcH+oTKRMJxSOY6wrUnJBJnD3ojvLpB857hk4h//DqvhFGxdb
	 tspAevYjM3VbtMlPIzPffrjvlRQLq2iWx1rRWltXFQn4RhaapsmrrILvrFDR8F21fMQ8z
	 VnaNxEdjatuFSk5aeSOwN1BViMEMDKinCGmq4DmiF/LbZ4BtdgBlyBvQgYuoTmaauw3qa
	 zcF1uJhXBW/LW7g77cFuhxqsrt5fpANfxfFLrriDmiuIsnowyu3sRs5uZRUxBdLvoGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="GOA/WNj7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC88606A33A
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 00:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABC88606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOA/WNj7
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b30cbfa628so15990057b3.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 16:45:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794617131; cv=none;
        d=google.com; s=arc-20260327;
        b=h72/nHnOMStOtqpN5sbjm3hOdixZX8kMwoQ+hJX2UnWWa/3OsmeOdqyrABrBs3c7BU
         PDb3c7Q9imFR03xY9FSHLVHr6PjOrW35R1/RYG+AkCymEaz6jyN7Iz3cbI6tMzwchujo
         YPIm5YemIEFUE3RjX4roySmEENh7hwHEd2y9sDxHp9mdUbFD4jZz/y6qpEaqjQRZXvqa
         0SzJmm1Auyn9E9Fr44A4/WKGSz24Mj3o9el6MpJHRZQO+3YjX66aX4s5osUzkqH5BBjR
         d6V0cAyF27ubGMaBp79S6LMhpSI4qnFC0WMNHwCxyO/WVdTpAdKZMpUThZGG+EorPcrA
         KnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i5jYtLz5EBj5XfHsrNl0LrZsplW7Xpq9cdHzn4aoCIQ=;
        fh=Qmz7KGg4cqMpNqlgYX7rTGcQAabzvybCZhl2pglLLZA=;
        b=fnF14llS9lD6JLXe3gMKV0Pa+1ji8NXSPOisDc4dEvvppKLQZTSR1fFuLch4Kn/FjB
         F2JPoGfCOvalBbnaz+mKN2HI5chx2k1B+EMRjLoOBmQTGMp+4Rs6IoYg3FtW9jeMU9AI
         hqERiXFeOG5Xec2X0j5+i+nXG6ByxoZqcxrv+RJN91ja814GBVONf7K6XfvEUWseU/eJ
         X4sgxgr1YZiogdCV/okRKmWN9ZZYKVbQ9Y8QIehHQGodBOU4VOFGsSBQLxpzok/+My/z
         4/iL7xFVSYXmUhmp5VEq413Jb28JkbFA2wPlsQnPQM1aK/0xOQAe62BW5C9sCIjFl27u
         kziQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794617131; x=1795221931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i5jYtLz5EBj5XfHsrNl0LrZsplW7Xpq9cdHzn4aoCIQ=;
        b=GOA/WNj7w/JT45QzYtoARc89RrvP5ZCI/wwvBqtGf2fu/rxWRJ7X5x/sHTvZbi25WT
         avhh4eYeVoPbPNDp3Qq8EySeFQb3gDzMUtsS1VUYcIp88SRxtd7uqftoKo4hUgWEcU2s
         HFkXVS4UpOILhxd6nfsi+MV74S1CocKYhxu7/DVuFONisMwe7zAaeCWns32TTSDX4HLg
         QC4Y91LbudDlZ/KcHCsoKOH54PGT2rOR1sYzujNhoz7C+yEoHsHMK6rF0ZjqYS9qXX03
         NWS7txN0mId9xKm3e5dFeFlE7XbNNDA7nn7IeBTTFCdC4SxR1N3ZTrmRrSL+hYqckeua
         jILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794617131; x=1795221931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i5jYtLz5EBj5XfHsrNl0LrZsplW7Xpq9cdHzn4aoCIQ=;
        b=18FNcLnE8SZGhDUmrP7q7JFECxYFMJ8Y+jvu5o5qvs/zR68xIhymd2S3XUGZq0NjVm
         BdAN6q2xYdzhz/imOFPgAu1n200PFc+ePBVF1vNj/aCf7RhTYS86Wz4PIXrn0WXnnl+6
         nSFIbcGs2VKuB9PO9Mz/skC/hxyT8o9W1+LUEqFRA8cDDXCg0Hz4PbWbcoZ8LvLqRCJ2
         Ey4H6iW/cbCETMkBaFMkk+wOVYosTIsLCxOE0EszJ16qIW1YexfVc+6Falua/2U5+nA9
         gb92QM4XYN5qptHwPZaIkx84gAyICKXWYKMIvaIAdVcw7zBmaloL/A3MOEStEWR6HLAG
         lvew==
X-Forwarded-Encrypted: i=1; AL+hErGaYYPuXtnfRn91UvVzT4kCxoI24eK2TZK/Xwa36sfvjXeB8AlOW/ROwMBAFPY8uQkCHHYrvy6jpTeMLw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8xlHsRyvFVMi6/r617+eSdOeZ+MqI0sQxWUn5QmQKbFOVCBZoe
	vfkSyIIPxHVYwurJFG9pYor49r6+KSolOyv+9pJRVloJbeLEA9Yrp/4QLmMOQnhHaf+i9NhvxHx
	HgmselaBYhD8wXOCoz2OhjYWSv1vGGtE=
X-Gm-Gg: AYBFou1z9fOvPTjddhe0uUsj6UYEuG195rSbQFUCsJWObel0yjqsIETgI5c/mZBmq+6
	DUFOqVP+u98O2Q+GGMrWoDQa8Sg/RrGkJLpDjcLRvg2RgMEIGxbyBoQ44R4Y3IaiOWWAYXa+i+U
	yerMCURGxSAL6B7jLpb4/ei4+8v1U1Voll1KkRb6g1EDM6UruFTAIyW46RXH5wdPjyv+/KaRJpt
	uwKAuW+3h4lsRQHaiyahFrEOW9pr9rC+QSF3jHfmpHTj3a8lFlDsTc1PeF4ECUFnzPVklH9LVX3
	aC8CW747c7zGkxJYBB83mtRaYHRpCYdSeI7N/e9uLD4UxDekYT1Px9chVDMObrKToQZWsV+E0rG
	j+SFhA7Nw9NCn4lAWmUrbl1f6ad89WZzqCnCCuYugQkTW0BDaqCq1qGoOlaKMf0nolxgxHkkZ7D
	P1N30hI/PPE+vp2DwQl7wSfLi5rJokdIil5/nqBHmhSkSa6XKTIxn28S5ZgW34FvOQ1CoYcEbAD
	Spx1NRWMwVfuvuahGVLvawxqXTHQX2D5VLx9IXKaRecxNWThwIMtrAow1RLN+57bK24PHPPa+if
	uByVscg=
X-Received: by 2002:a05:690c:d8f:b0:8b3:28c4:c82e with SMTP id
 00721157ae682-8b4aa2ff46amr26715857b3.55.1794617130642; Fri, 13 Nov 2026
 16:45:30 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114000220.1280581-1-dmitry.torokhov@gmail.com> <20261114000220.1280581-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20261114000220.1280581-3-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 14 Nov 2026 02:44:54 +0200
X-Gm-Features: Aa3M54rWFVWDht0ocpch524jevHvN8U4TTKxRlmMBhgMm5WOyOBcGYqyIC0dFbM
Message-ID: <CAHp75Vej3sbeT5dJ2ZWnu7mzZLJHmRwW++shCdMAiK9Szh3PFA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Input: tsc2007 - drop redundant error message on IRQ
 request failure
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
	"H . Nikolaus Schaller" <hns@goldelico.com>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 2:02=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> devm_request_threaded_irq() already logs an error message when
> requesting the interrupt fails, so the additional dev_err() call in
> tsc2007_input_configure() is redundant. Remove it.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
