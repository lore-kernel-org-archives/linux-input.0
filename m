Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211268;
	b=hXNzptjNLg5MALkTvLn81t2Cyih1gTRyYblxT/gzESaUdCr74hjpgU0/6vLhLm2VcXm1
	 6Rjlcg6WWqRdwNr1TIKCJ+QFf+/zXAbAuUpHLmdekuAgt91hU9q6WORaX7ICIuUmucI7U
	 aEfdZRLJOrCGrP7mfJZHh2IRaNelG8bU8eYS2kyn5XEQ9aKptXYvoY6dwPMFLEW1+0VHs
	 nITxgdiImZ0nAQTcR76+MmAZpCNDClhuICKURyV8NM6jDnk+JAA/5sBVNe1qA6ocfcuaK
	 /Gkgg6wXuymHol+NJTFaPLcoILS07swpzwlP+/RmeYQK2sW2UP8fwxHkNpH2fIO4vig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2TayQCSimHrqSkHOQFhNJsIxBzUcw67UawwZgMjp29c=;
	b=k8vlVSpKRenxx9Ja9sxQ4IZjN0LQtQUdFqYkTNn3VdNece0heRtNrT0OfotKfmnMdldz
	 wyJ+r7CYzlHyMB8sOe4PKarvb2kI7bn4lthMDU62S6aNep5BfnC0YBTHRrUz5vJ6ZIq1m
	 LFypEuZJGS75kbPc5m4XRjnBpDjWa4aWpsLRHA07CpV+64jHcgZaA4/FJyvrJl1GjXqzV
	 o5LChf6dGJRUOfNAg9rN2Gf5heyeyA3t49nqkqLmkWBsYQMZs5Jy01KrTL6sW/laUck+q
	 MP5wO13sQswHpHjGD7MVE7oaqdoQAYNEK/cEd2B2Ki+2j2rWOUvGc0zAsd5d1hY0tyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3RmTM2g;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98FC606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 08:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C98FC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B3RmTM2g
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so1134448c88.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 00:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794211267; x=1794816067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2TayQCSimHrqSkHOQFhNJsIxBzUcw67UawwZgMjp29c=;
        b=B3RmTM2gPDg9+47wuPhaPZa9rAFfMx5yuwrYSouFDOMKmyOTAz8tJhjdluh1ngFHdu
         jGMEVIuXnz7SHFeKwZQ4uxRcC+fy+uW9cq2p80lLueqijJEcmpLk8K0bifBhL4DSGCEV
         g3+penvy1egHeXEVHwMehwWaycO+6g+qaQq3o7aIzIjk5jtT6W8cTvGvH0XxM2PuyIRr
         52U+IyAOFpJe2bNUxNmMJSeV9R4fMpub0N2RE0AVdW3RZ4z1ZSL2R/VVQq24P6Vd53J0
         hr5+sSbVXLs6NO9XHMxLUaP5tQDszKNlrzBqY5NAv9Z2X7UIjO+GajvwLBLQ2tr/8doH
         j55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794211267; x=1794816067;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TayQCSimHrqSkHOQFhNJsIxBzUcw67UawwZgMjp29c=;
        b=f8T5MzrLF5nid2pH3X6cOVyRjE58JvNyLQEQQ9uHIkKGy+EpUyU1U19oMHamuX0+FG
         oTqQOeZ+paEgxn0yWgeQQm0LSS5aQGSjMEfTf+OCFs2WfZw3qYq5431AUTiKsQtkeAdV
         AsKKV1jfqiyBvd3ax4Ew/rVYyQ6pvIj1nPZZQGbebyRCN4IrXHKypfJCye/VvIr4Jx6d
         UpnR96p1wT5EjdZ10g+sXF8GFRYobXrfZoPV/pGLB3sT3dlWusl4JgYg/Im/TFPU1p2F
         ZkA1Fx3zC2sv6DVl5Fr2aopip9JLXtEXoFYyO4976AyHMmTxLVPHdQNze4hE2fsVcy5i
         sxFQ==
X-Forwarded-Encrypted: i=1; AL+hErGt1xdTBm0xgC2u9Hzl9v0Gk8P0Z+BnrTySNuzHVkzaD0Lw+Tt7zR1bZiGCS6U0F0LSeOuNCHQ2NaoAKw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Jt9RsizkiLQSiBITRAnWYOsfO7aX+PlTE+/m94lZ/zrCy0USi
	798m0Be/0U/oLUOXaPB0cOfmS8IxrP3jNWg5RTwO6a2m7xiWSUhsujEx
X-Gm-Gg: AYBFou3Bi8eJ7DLYHaXzp+GsewXOatij6TS+/lQKxAcskODcR9WFfTeGDo7cfyKqzWr
	gy53c1uZEklCALA9Bh1uzXVrFpz74zqmqkPm13I5lB5V1R2UurDDdQODR4iuPaQJ2IArB40stUn
	TAyYgsDfY8Kk3fI+X2mpid8BsbcoWnS3ufK5ADbp8e+g1S1IYlEJwWK+Q8/QEYrzKrqI3bl5GCb
	zztKYnZWpDk02xGa1+O7u74Ki90OqVnaignQPXUc44q1DkLWq/CRuWTxMB5pcZv/Wypnj/B3GXP
	5ntBlQEHjuMSX01ww6rtQjIGluj2enrFwFf0eQQU4zZvZwTgU93MpjytPOjy52rp7LAsqAp57Xf
	cfPk+BAmxiDTuVw4D0bEMFe/SE04ihS76Fjop6aXeg2CjzVburPIYcw9DDs8Sv6Rt5/Nu4cYbCw
	PimhmxSpj/Qydcw1CfFQZWgm/RAkSWYvNofRndOrdsLLIdsnEFgBJw4BuYcmVMl/UAXOwWl1YXe
	tSt1GWYJ0LLs8bs606oUq2N48erqIF8TSflXSf3I3IMgU8Kqy2cm8eercC8SD/dR1YKYob2EslP
	FVbcdDgfWxCuFoTcdgL+wCcxvsKjX17CHm7GnH0VQgqIHDrck8/smf4gbDsmsh3e2OWq
X-Received: by 2002:a05:7023:d08:b0:150:c9c5:1ce4 with SMTP id a92af1059eb24-1b39fe2b391mr5601293c88.6.1794211266754;
        Mon, 09 Nov 2026 00:01:06 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3771fa200sm10659178c88.22.2026.11.09.00.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 00:01:06 -0800 (PST)
Date: Mon, 9 Nov 2026 00:01:03 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Hyunjung Ko <hj351016@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: lm8323 - remove driver
Message-ID: <avF9Z29GYy58K53e@google.com>
References: <20261109072950.3474308-1-dmitry.torokhov@gmail.com>
 <20261109072950.3474308-2-dmitry.torokhov@gmail.com>
 <def3815d-d3f6-4032-b7f3-d2b5e48c770f@app.fastmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <def3815d-d3f6-4032-b7f3-d2b5e48c770f@app.fastmail.com>

On Mon, Nov 09, 2026 at 08:53:58AM +0100, Arnd Bergmann wrote:
> On Mon, Nov 9, 2026, at 08:29, Dmitry Torokhov wrote:
> > The LM8323 keypad driver relies exclusively on legacy platform data,
> > has no Device Tree or generic device property support, and has no users
> > in mainline (including the Nokia N810 DTS, which never added support
> > for it). Its PWM/LED handling and unbind lifetime are broken, and after
> > hardware-tested IRQ fixes in 2011 the driver has for over a decade only
> > received mechanical API conversions and static-analysis cleanups
> > without hardware testing.
> >
> > An inquiry on the mailing list asking whether anyone still uses or
> > wishes to keep the driver received no objections. Remove the driver
> > and its platform data header.
> >
> > Link: https://lore.kernel.org/r/Zr6I9RB5mibU_12N@google.com
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I made an identical patch (for both drivers combined) based on the
> same conclusion, but you beat me to posting it.
> 
> I have additional Input driver patches in the same series at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=board-remove-7.4
> 
> It's a mix of three types of changes:
> 
> - drivers that have been unused for years
> - drivers that become unused after I remove the board files
> - drivers that support both DT and platform_data, and I remove the latter
> 
> My plan was to post these after my board removal series is merged,
> and this got delayed until 7.5 now after some back and forth because
> I wanted to make sure they remain in the LTS kernel.
> 
> If you like, I can send more of these earlier.

Please send them to me so I can queue them: this way there's less chance
someone sends cleanup patches for them. And then they will be gone from
7.5.

Thanks.

-- 
Dmitry
