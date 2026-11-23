Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416481;
	b=S+ndALsJUr0HcYthSMWNezhat6x4gmCtH4VFb7l0W2sNvFy5Mg6lodWexeolwh0Ekw/e
	 JrnSm2jP5AK1ScfiQ8CDiIOaRLBjjtSY5a62KDNWgu06gxmN5dVXL5X2xrKy/d+mKb0xU
	 rG58GNTgHIIdRU0Iuh/Sv86uRufGIoGNU8YJ2msNUg/oTgrg7U14+6gsvK5qI+DcS4kT3
	 t9WRLrhWG+v8lJXC06orTYhbo9tTvlIzQXh6JmnvU6ML5fceyphBiGkP9aI4qIoj3/K2j
	 5Zt3joX9+7fOKKQqLjp8OsyeUDNLpCJyRhNO5EXmVpj3F+1bUyYeQsh6LyMripIMTdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
	b=iJIqH2gToHmcwByw7RqMRWgijluIC3tUsT8ws5XXULuDSxivjg3Z82ZSVMhwE2v2XMN4
	 ky/FaGovQuGUifB1NIua2RdOQXfgCt/LJ4D+Rh59Jp4cMNGR6sCXnM9KCBZNyyci5w5Q+
	 B3HmzCTKE5xsyiayKLAk9JX6WEAT+Q1L6PVWNMbc2EYaQDmskLTMKmEAIz8WcEdl6n4PO
	 bz7eQFebtVM11b/Y3RTlx/ERcWA1Un+NAywloneOLfVINYLStKS8/oUaePbhqCIRnNFX7
	 zaOWPVe5cBwVncawXPpfwQwH3JxTTZ2l35jZaDPY8tXUwInIVJZC2vqzkDEMOj9cmjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtcT5jHJ;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B6FAB606A333
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6FAB606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtcT5jHJ
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f02f04a426so23852145ad.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 22:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416480; x=1796021280; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
        b=QtcT5jHJqWm1+yYAA4VFMUP9cS+spmeKwR5RDKEV3n+c3ftxMf2A+S0r6XtwhfzSkA
         i89BXqck7v1ltIBc4g+zcm6rPOPLJn/WoTGr6fWujJ5HHX37VCCqn+5hkt4UpvPDAyK/
         DzuOh0Appm/d4BWAtNs5xZba9MLv+lEZJLKeuv9+JAAyKr9eFkW+rOMsNjggp1sksr5X
         B2JKTwP7urRGyQVRlhafyhdA2ffZMnmFgkniU7mpAO/qkc49LYqaFAX5hYEglksH7mef
         k7TEeU43ML1MTVqG7C5tNuJ/CESrvVz2mPnzpvEBeefrauZymIXXWJIHNRH3mUgbvMWa
         6S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416480; x=1796021280;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
        b=gj1oEIIMDgS9ZW5tM2BGBFIjKOAsrvpWExU0R9XNvi976/CLHw1tBdvFw85bJi0POE
         ycmDnJeV4NoCpzkk3hmM6yub0ermpWzAtQgShdJgxueIuuS1Ju45bcglQ16XfJfompdE
         99GdR8dBKQOrFkWa9rCpKUOhZvN/ja6OnSfxxPAh42nlN2bK1PkNxivXmrdR1odqGlwV
         pj7kmLU5LxsX6R21GayHKoYDk1YBoqyoHCyRJkGoiVa0biwVbyFP2LZzzQD0yDgXdKVv
         FwO3919yBOSYKlaryfL2JLW5f26sikfPy2TyYQfkDqLHWwpIEvgyONIU1SHEdFTwn3nJ
         0lag==
X-Forwarded-Encrypted: i=1; AL+hErHikrxr0wucbPAQj2q9zW8DwMtU2fzgPZsCd7d4mSCEpftLt6pdodbV6XWioBE8VkBriy6pG67FiwYr/g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/dfXXMIa3QcgA6ofdRrMm1RhYN/btJaYR7jErOBB8ehrDcb5Qw
	QcU12mF3NCA8DBpIxtdCvm0ZKZVLsiHbFjZzbMhxqkC/FRZJ9JdGMyr8
X-Gm-Gg: AZFdTZdrCnvlcQXZhRJVkT4L4O3bmaKHTcoP1giYnGFIb8eYVeTjIG06k0tpAxcYxSe
	Va5D0u3SIG/TStKosQ51eu1hUg471jD2KACaG+vA57r6kknRwDqR0IwYLgVvs/v8iFH0Y/0jZ7I
	eIR+4xv14LKTnCtYM1HGvC8fapjwqjzGio9iz7MF1vp0t11k/e3813sIgDlZ0juFASyJmgB7zRh
	7wnQjgKR9+xn4UF/aB5QpZAe+CvSEp1Ct5Yzep1MnoKURbvF4U0wroqD92ww4tKq24kyY25qmpg
	EdfU8DUqHuVBPPnLgIE1MCAtrPjCOt0UqJMq7cUA/1Sxg4JXcLfgsIDlBfnzinqtCVSwrAt4ar2
	0AsmxGBIBx8gV4sHWjSZBj3Cdg70LBaJ0/rpob6OU8b2rzbgKhmLmfz8knUBCzLhDwSc7AZY0We
	USHQtG9WzaUcrfYFSxdtfuamkQCSSgmV/svCrvS3jS93WBZWUD8AraIvj2wMbY3BqjNPhyRiim2
	PwnMzTuKUQMH549jeAPh8Vs2uv2EZ+UQyklg+OzRuG7oKP2xxV9HKOC54ucymLkVSgxWnxLwSd1
	MRkwf2jlsAbpvrNd1nvvGHrwY7ev6C7zU950h4bWRdFgGgSYfvYtmTfstpq7DCveFTSddA==
X-Received: by 2002:a17:902:ce82:b0:2ef:e9df:2422 with SMTP id d9443c01a7336-2f03f1cf4e6mr103786255ad.16.1795416479999;
        Sun, 22 Nov 2026 22:47:59 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84364sm48678155ad.5.2026.11.22.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:47:59 -0800 (PST)
Date: Sun, 22 Nov 2026 22:47:58 -0800
Message-ID: <8ee0713aa3e3cb1e54c0a60f1b32cb86@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/8] power: supply: sbs-battery: use 4-argument i2c_smbus_read_block_data()
In-Reply-To: <avELD9tlEfl9Uth7@venus>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com> <20261024-i2c-smbus-read-block-data-v1-8-19bb97467982@gmail.com> <avELD9tlEfl9Uth7@venus>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sebastian,

On Mon, Nov 09, 2026 at 12:52:18AM +0100, Sebastian Reichel wrote:
> On Sat, Oct 24, 2026 at 07:48:48PM -0700, Dmitry Torokhov wrote:
> > Pass the destination buffer size to sbs_read_string_data(), and pass
> > the buffer capacity reserving space for a trailing NUL terminator to
> > i2c_smbus_read_block_data().
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thank you for the ack. Will you be applying this patch to your tree, or
do you expect me to queue it through mine?

Thanks.

-- 
Dmitry
