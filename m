Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794525393;
	b=WPwmt3pWchJ7MN+oNu9XL2Zwf19gHF6GZpZ9cMwdf5zereCVxg8xa/nSaq2GFOE/y5nD
	 j5JTNBjXTs1PUPclr1n6OkpYwehspeJ88sxi3CYarN8mWFvsIeGpm1V8Uoq7z+Ld3vYGW
	 D1vgWhk4Uq/KrOM7t4+cfwA3RJwcmnZf0lKwnwkFAriSLdY9jpy3Y8VDCxZq8S53exQmf
	 XGheSmJDv79zKqevUu6QMMGIdc2laSHYMsxGSQ6vVTLBjN18pRikAAGqnNOxhKI6irWoW
	 rfcMlP7WeKeaNJOhCpIooxBFXic4wSxZOv6iRA2Igt5MbIgRuMJryydu3smdupoZqZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YCt6YKhP3iRu11RrkHzPffGw1/WrazJq8WC9GVsXVNQ=;
	b=bvO96WBqQkqHinG3yOf6mve+W91Sm0cjCDFnu95Sm0jecIDISzkVVK03JsiHvCPiecxm
	 58cp28O93mRuCWiL7jFjgF4owwra+QJ01yokxOnGAlaJ3YMpxLV91B9p2pnASXtblBxj8
	 MwQ7PamMj7oV3WB3/5Jx8ZZBPNhDgveLwvXO2pGeLfXtYqMfs/qj49a/3mtDyYbjleYX3
	 zgbIr2pY4Fh3KYMNezrTxOXaTH/jK7G42x7KcouGkf/J82OdQxExzezxSEkpvILnJ2tLO
	 nHJzAooNjLY48ZbEHuuSLYX6IwKG1RJmxcQTr/g+Ohh9fxQbctah/xXjIXdeJRf0MnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PcqGLabY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA8606A327
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 23:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EFA8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PcqGLabY
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdd9d0c9bbdso431067a12.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 15:16:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794525392; cv=none;
        d=google.com; s=arc-20260327;
        b=PLTrHU08D+E6aaI8lpMjrfPid/oV3AzhWoUoukfodblm323xV0Wq5Khy70w5ymFMS5
         VXlhZHnkJbvybIllLiezrQSZulsVow1/97oFAUvGzSFgFdJcIWfDzS/LbUWePf5ALGin
         8Czle1ldSId/d7LMv0Hm9pOWo3nj3Gm/V5xak841c4HKRW6qmPed9LOs99hzDMr2klVu
         5TyxXxes+Umdz3NsOGtUC7P00gnksMroFyLOZCV/Bjr/P9cKuWUgc7UiGiFSF/nOnnt+
         LPZ1x2VWV/Y5YOY9o/oTqfkYUs2HlD4PUuUzqqVtD+DfSbQTmpxDz4nvliVYUEZQKPys
         eqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YCt6YKhP3iRu11RrkHzPffGw1/WrazJq8WC9GVsXVNQ=;
        fh=SMgAV+MsBNWYltyXHK5CZ+E0Y4TTIOq1DA1Yjy9Nm0A=;
        b=dGHqpXJdb+5hCaBy8rSqtrkVZemOpRHX8zUPgEQvX75xAtkmd7/HJTCdF+Qd8sABRA
         NIoBfDQib1ztfwPpzovp9SuiBxYykiVhvPHY8TM0GEpKhz1vjPkpaxbB7dVrW0ozsIOj
         IyPx4qhMbCesnI3/ZeUKtu/+VNl6myreBFPsucdIJ3+/i28Hh0cjaU2h1iLSpvjUNr65
         dDPfIc1zyTvkTrmVhby1NQJucnNi1ms+ZDfCG/WJDdx9THmegk+z6hn5zT/wHYnj5WA/
         Q0fMbsm+usxWpGD7dyb5ZQxIY/ac2KlMM/InIlCTw1BeqgoNpZrgoFI0PAvwwKxx1EMD
         jIWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794525392; x=1795130192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YCt6YKhP3iRu11RrkHzPffGw1/WrazJq8WC9GVsXVNQ=;
        b=PcqGLabY0qbX789utrbySNOrwQkNq2cB4pnsRIKpK69t12rvdji70sLBSBoeWWVn2s
         4wnlfOP61C6XJ3rRbulB4DxM+EKEpAsxUQSo2JA+aAxYWOoz1mPZUVZ7hYAoMjCqdJ+Z
         YlyR+c9G5ag0Zg2wP6Nd9y5zd2mDpQKWmwjvn5+gtyobt8SMhU21EB+Kqx+vQWXNATGA
         hG1zf6G5Ug69yuzP41e4rRz/RSKQwhpyqDt89pV90Qf0CvqQ79O/x2glhFYtrJhRgsyV
         dsgoM6sFjo04BhvOVgBFhX80gl5mDmtlPjqNuMYlfNz80/eO6cLtmjg1rj1qtj+qOvm9
         Un7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794525392; x=1795130192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YCt6YKhP3iRu11RrkHzPffGw1/WrazJq8WC9GVsXVNQ=;
        b=wqNWaWLZmaRZf5e06dtwGwGK/saC8YrrBqAn74XYjlKRbU87SgwP5jYaMy9PghGSh6
         vQpOqn+ntlwYXCmAMtBxxTcQTogmumacWO6p68e9lyyBORu2AmP/CJifT7KiONhf2oy8
         TAU7aRqjG8sY4ZdBxQo2IoP7QNrGtIfOBscTJMy78aD4h2JFiolqdq+eEhOzzcd190Ay
         zqsspRBzI6W4GmUdYU7JCfKsuoTodcOC+9bPIDiiFEjhRqpHD8V1UlFU2CjneZLN2kUY
         vpyRgaM0H5YnA7gd17+CGFbbY7AortSz75zosEQwZxUxh8uJBqwvXWPvkVpzJcNhU8wW
         gsyQ==
X-Forwarded-Encrypted: i=1; AL+hErG/tewiVm/FLgdzDot2TzXcDgWZzdWeJfyEUCnNLw5FSgKCSpq9aqLFOxAofyNb8v7eiEZvyzy6N4/AHQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z90YzZlnP+BtbDIXoVoQgm1TRlw945eK0NchNrt8oRppmXZcqsc
	XW6tk3Ej2kRyJ6MVP3ar05v+XhOdrc1GD/bdFOKPV3mTNbTT5dgx1CithAmjgJJ5OhT2f4Pc5ea
	3t/nKfZIVMFYv4aEq6LRstIDlp+6QNnM=
X-Gm-Gg: AYBFou1cHjD+PdcPa1c9rc0oIhSsuUv6qYNhgSTN4CTBxy23V82XZi3yFiiltfV9bPr
	UJQu+t7zCvkAwD3y75qqA0PzrmaAY7IDSYj5oehAAMapfrzfZvJ9N4UNwbQ366t2qbAhd0liAXi
	bnntijkN4y3snBJoY1vxp/9iGg9NcAXQdCH0dTc3kyIsCOqnUEgijVzDmIuw84cPBzEU92TL8oh
	teQGgOiVT3/VdSUI+7L10Eae4gBHahSQhxhsQDgubtlZLUhSRCkXwzsDdl7LFwB///wiRXBk4XC
	5rLYfU5u/4o0cUFlvt9Em12JqTs3twdo+Z3LVniLAFyE1KlTfnzIYRB83kQlmXV4Lrzm9gbZN8+
	4bJpzN0MS9iHmIFvMzXnTj5a0G1zWdvBS3yVAnQ1GUUCYC3jjnd2lRmOiGnAdhDZqzPGeCsGsFy
	tHAqiglm+wdcobgpl7Tg2Acts7tukk1iRDewjjvayLFU8x/5EyzG3LYg8GWWJmIWaSMRLx3NWQT
	1orfLz4ZPQifE9xDcGLyrcRWYkn7bFEieQvIgCh00/Pr9E3ZMxigxPtdCvq
X-Received: by 2002:a05:7022:2584:b0:196:d6e1:108b with SMTP id
 a92af1059eb24-1b5030e32e2mr1199073c88.10.1794525391639; Thu, 12 Nov 2026
 15:16:31 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021000338.2160223-1-miro.kropacek@gmail.com>
 <20261021022336.2232886-1-miro.kropacek@gmail.com> <c77944ee-f170-ce57-9065-d7d49fcfed6e@gmail.com>
 <CAMuHMdXWHXjbCNojoukGq4OWvLSibk-goJo4quLdbOj01neOew@mail.gmail.com>
 <atqTLxkEusWSS-wf@google.com> <CAN5rfbQWDTXZVyh8fDjxqRVO_HEKvWLC7Q_i-7aTtSxi9sWuSg@mail.gmail.com>
In-Reply-To: <CAN5rfbQWDTXZVyh8fDjxqRVO_HEKvWLC7Q_i-7aTtSxi9sWuSg@mail.gmail.com>
From: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Date: Fri, 13 Nov 2026 09:16:15 +1000
X-Gm-Features: AclHuK9omy7qW74EtahCV4gmD-m_X0i6pDAOWe6bsljrf0RlmsCYb8yPkvkcYRk
Message-ID: <CAN5rfbQr9wjnAZN4fitmCyZs_CGd0A37omicP3hfiH3+_SWahA@mail.gmail.com>
Subject: Re: [PATCH v5] m68k: Fix atari mouse movement
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitzmic@gmail.com>, 
	linux-m68k@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Just wondering if there is anything I can do to get this merged? Geert
gave his Reviewed-by on v5, plus his Acked-by for the arch/m68k files,
and Michael is fine with adding his Reviewed-by.

Would you take v5 as it is through the input tree, or would you rather
I re-send it as a standalone patch with the tags collected?

It is basically the last patch to be merged from my "atari stream".

On Fri, 23 Oct 2026 at 10:21, Miro Krop=C3=A1=C4=8Dek <miro.kropacek@gmail.=
com> wrote:
>
> Hi Dmitry,
>
> On Fri, 23 Oct 2026 at 08:51, Dmitry Torokhov <dmitry.torokhov@gmail.com>=
 wrote:
> > Could you please re-post v1? Can't seem to find it.
>
> v1 went to linux-m68k only, without linux-input:
> https://lore.kernel.org/linux-m68k/20260814031745.17140-2-schmitzmic@gmai=
l.com/
>
> It touched only atarimouse.c, keeping char * and casting the two
> deltas to s8. v5 is the same two casts with u8 instead of char. The u8
> can't stay in input alone though: a char * hook doesn't accept a u8 *
> handler (-Werror=3Dincompatible-pointer-types), so the arch side has to
> follow.
>
> --
> http://mikro.atari.org



--=20
http://mikro.atari.org
