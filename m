Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9672264A7
	for <linux-input@vger.kernel.org>; Sat,  5 Sep 2026 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626719; cv=none; b=DwOnRQrPYiShLGar2lMxNLhCwa0351M3gN8B7Vxr2pBA+CLMSGTDv2Dm5ATDGMQJk9Q9b1ngPJ4MJ4ZNv4N4ZfTvLE0XUHry8VFUM4ju6xkGP9UUVX5ZW/lnbku/PTgbjUubQ9fNWenKKncNRPg8Tmg8UhgJlZTklmHzLHAhkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626719; c=relaxed/simple;
	bh=HdBAdLzSTzujbllvsJF4/4Myx4fdLg2P7yqQlusvX+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB2BRckBYIi48JwXRq5G1h/fV0L3jQFmp/BI8VAkr9gDHFBOWCEQlZppHaOsnD31DxPLH9S1/DqITVNwaXMtPL2Hiux4mblZIkCbRiUVDe6HvKo43vvBNrle8UYfcbqP1I/xVEhr0SqknT25nVEpntyFD2qzXh0rA3llaaVUzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoMJbhFu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoMJbhFu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so25652265e9.2
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2026 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788626711; x=1789231511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UXpqHFV2712rxC5fNse5LJiD7+paksBxEi1NQ+E0D5U=;
        b=QoMJbhFuOuG8l6M9kcfrHVchJ1sA3K8VcXX9sHvf4KV64ui0dqZaQxiP13c4DzV+y3
         fdHxrGqh+HvShOHBkUze9iFVPZc2XZ0BKvKC3w0bpzibmln+KdCt+djAvjhwwQok7KAJ
         QVCTXS0NY4sc/v3wkWMIJzk4gEIQZyCOIJtwiQ0NZAee3iof4zmjyV6zsT3oenkz+aoi
         2BA2sFly81BjCJIDe85e7qMbYebz0rDi6vAV6KtZlZFNimptRUva7tLy7K2CZw5WMXVt
         KeItXUCqt+TkAcCYntxr7XUou0LJ+WeVB4M/xSiJAUhgmTr+D3KsPffqZi76r06NH+b9
         pEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788626711; x=1789231511;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UXpqHFV2712rxC5fNse5LJiD7+paksBxEi1NQ+E0D5U=;
        b=UbCORzPc//gmNkiW8HpkcgqCDs9VeE4Q7QSQekE5EMxUDEqJYoC6sXpU852SxlwHCr
         y6knKiYW7M0X3VCBlsvCFKOBfJ2h4npoZcfmsRtHbNXmm4yO/CoKPjxdNUtR/XfaspRM
         CJ4UdYwFl4g3ZXutwGmHhnjzh/vwADx5SUaGzSWHcYJAF+dsJYEf9PXDtBV/6zCeSwb6
         dVqxEu7MQ0hu2kQxqsogJU2uM9qpVZSc3p8WdZvBo6sAkhAIxj1ON/5uiW6k6eqJ/0mK
         TbSFaKRemnHSqymLUJJ6Vp13Ik6E9sFXyEH2Xxv2EpFY5/dDOAWuveWk6wDaY3OYPiQd
         92Jg==
X-Forwarded-Encrypted: i=1; AKwUvByBcaugQyaElU1uRNE7aFg8n2xr/CpZhVnPymSnjbUF0sQHKKse8LwC719tOlD5AGjuSBSwtLAx/6oQ4A==@vger.kernel.org
X-Gm-Message-State: AFuF++lQM0iQKShxvk5gnRGcfGLtRPsyF9uHdGrM7C67jefaS0pHPR5o
	fwwQiyVFCNiedrYVWyJRBVEDOa1ls7LPwEMdxD11qKk1vspBtlRNL2e7
X-Gm-Gg: AYBFou2yGI/xhSoTvCrehYSj5lHcy6KXD3hck41Dz2FdGp2FI6AKP+im8c1AJO47omk
	wVzJJW8zPQ1Npx9sguiiriGCzRSvEHp3OB8letG6nkvSyugJrlgsTWtVLSpQEb3EMUWhmtNk3W9
	xuWZIm61WQ47NISpI5XsTuB+CkjYRTPG+H/9lLKx7IGfGT7e+BtouxU7YleNEfpeRI9uvYTErv0
	EktQLZbA+e0dq9xAxDbWL4eShho/c1jVMpAYrc0eY2CKOzvzIIzzuaeAp7Iymsy+LcETFmEDe3N
	aHlmhBL4LCKeAxEXJj7e9acR4FzKTZeWn1t8IukrVNThgot/E+UPCDffw8lE4umfQm5n01JCDUQ
	CXua7skL2pvDQfzKM0By3qxHFjXbrgdWJp2mhbfCovoDPtzOAbCaNLG99eArMG16lHyuqY27rno
	oz4Tymyi0jiPEhK5BtUIirNFBuQjZ26pqKbrVOxrMcmarPbMFsbqfGcyQIdpFbk4WuUeCzYsTre
	Dll393Ip93dwGxxvnqKqjf1BK6TqHCvnkntz/U3niuPDF47SUn63g9Qz9S+UJ3QMaVXYoAG1Utk
	wA8Mh2XEbfe6VQcSD5GX8HHL9AZyBIwx7KTe4dggSAzV1bGXnY7RO2ovzBn7l3Fu
X-Received: by 2002:a05:600c:4e46:b0:49c:fc6e:8cb4 with SMTP id 5b1f17b1804b1-49cfc6e8e51mr106151725e9.24.1788626711320;
        Sat, 05 Sep 2026 09:45:11 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf75ce49esm276714495e9.1.2026.09.05.09.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 09:45:10 -0700 (PDT)
Date: Sat, 5 Sep 2026 18:45:07 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Mike Travis <mike.travis@hpe.com>, 
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, 
	Kevin Hilman <khilman@baylibre.com>, linux-omap@vger.kernel.org, 
	Dominik Brodowski <linux@dominikbrodowski.net>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, linux-ide@vger.kernel.org, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Michael Schmitz <schmitzmic@gmail.com>, 
	Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 3/9] docs: kernel-parameters: Drop the edac_report=
 entry
Message-ID: <apxDtqM8UMN5KNjs@gmail.com>
References: <20260905094649.41996-1-kmehltretter@gmail.com>
 <20260905094649.41996-4-kmehltretter@gmail.com>
 <20260905151345.GAapwxqT93wPWHF7u4@fat_crate.local>
 <apwzmSr6b0WEkW86@gmail.com>
 <20260905153336.GBapw2UFa7Sdc0ve_A@fat_crate.local>
 <871pb7zn36.fsf@trenco.lwn.net>
 <20260905162742.GCapxC_ra7hJd27LDR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905162742.GCapxC_ra7hJd27LDR@fat_crate.local>

On Sat, Sep 05, 2026 at 09:27:42AM +0100, Borislav Petkov wrote:
> On Sat, Sep 05, 2026 at 10:20:45AM -0600, Jonathan Corbet wrote:
> > I would like to emphasize this - slow down a bit and maybe you won't
> > overwhelm the system entirely.

Got it.

> 
> I find myself telling more and more new submitters to slow down. Sounds like
> they don't read our documentation before submitting patches. Especially if the
> file is even called submitting-patches:
> 
> From: Documentation/process/submitting-patches.rst
> 
> Don't get discouraged - or impatient
> ------------------------------------
> 
> After you have submitted your change, be patient and wait.  Reviewers are
> busy people and may not get to your patch right away.
> 
> Once upon a time, patches used to disappear into the void without comment,
> but the development process works more smoothly than that now.  You should
> receive comments within a week or so; if that does not happen, make sure
> that you have sent your patches to the right place.  Wait for a minimum of
> 						     ^^^^^^^^^^^^^^^^^^^^^
> 
> one week before resubmitting or pinging reviewers - possibly longer during
> ^^^^^^^^

That's for "not getting any answers" which is not the case here.

Sending a vX update sometimes feels more urgent because you don't want other 
people to read your buggy old version. But yes, some patience is also good
there. 

Thanks,
Karl
