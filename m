Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795476845;
	b=pLu/HKxgH/DYEO/efSA3hbD/ex8HcxuH/TI3X1atcm6ekIspwiKdC16+b2vsDvQl5wtw
	 msBTo355A7uFLgjBGXJBSj12OGbM0KkSu56/WjXHn4hgULt2C9qV8Py2Tnjrqv9akjPbe
	 ebNgEUUtNUt4k/QcgZWtuPedwQJyAKnotLIT1Swmu+vxm+6kT1kYRDLNrH4QItJUdEOoQ
	 uo5qZNPJXM00A/wm48myd6iXjZz5NP1STn9ChTALZ8eQRMpDUvcOuvGowyZV8ypjbWdyc
	 TDBR9AAISOmqgFT1GWHbPl69xXS+1YMzD2ll42o4rCTlh1U8EkCij+5X6r5nUUdb27g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=7IcPjHhXTKgcJV03DulR1iJZw4+6JP27TqhtQDjZqv0=;
	b=THTXYEsL4qmIN7eeaoXttQf5bC8CMeQQmp/AGtpfC4JaYbGfXxFwGl43OLOAGIVVtK6s
	 ctxjnn1qOiwwi9QtSFEU3i+0+GrvejHsOmFuiEnvZzDNF4EcGJrAvUcs3T0u2OipBdoP7
	 8OyOhHhbUhKB5P8taYCq16LG2E20tV76SV1ORTTxNihmI+xxrJzX7Aca88yYYXxhGKKUG
	 fUDyimZHvAkZ8gd/OKWNlEsBbRl8MzL2WssU5IxVQoid+DZ3s8E5CGqN9oUn6PBthWaqU
	 jrr9h5ey/YTkzOz3DmXBQ3Nfic5XLVHm2w76HK1T9Km5r9NsfnNX+OSte+gEMo0mnog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="YN6bU/nl";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2695606A321
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 23:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2695606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YN6bU/nl
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1a2af4c8d00so499172c88.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 15:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795476844; x=1796081644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7IcPjHhXTKgcJV03DulR1iJZw4+6JP27TqhtQDjZqv0=;
        b=YN6bU/nltpD1xwu/Qd9NYjrVRFb0k2cJwke9ul+mK1BCcleQioDj9AR/C0s4c7BIoJ
         ew7gbesA3mNrTgTtc17FzwLrLVe40CtHlE1xS3y2EoQQPgIUgkUGq1kY6tmcr4NDwkyK
         619PYDPFWDC7jEVK4gUdsRqSHK1GzylbfeuP62GS80KYMCrPcTsIZryAPVIV1Jp2019z
         CnxcOx+l/Vz+1WQskHbW+hmBVm3gcfULXmavtkpG/6hUP81jNvEaUr4uW9Ms3IikJcvp
         YL9dUIPsl4mblyDjDgVKMcmsVj7EagB+MI3hJvuiNCJ5E4xfd2LLN7y+eYwr2oNdgZi2
         AdfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476844; x=1796081644;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7IcPjHhXTKgcJV03DulR1iJZw4+6JP27TqhtQDjZqv0=;
        b=Z0dZJfSB4TgOfrhtlnl7D0CiYdjxAbpB0Gsq9yL+J1o+2Y3KKsKXl6+C2Jjbj6KitK
         0UzvA3CzanmgtuNWbudj0o9fWWwJWNuEF8nmoCjNyZg3rKg5bRfy6Bsz9fdOlhbOhDic
         EAu1dJDMqTDknZy6frr7Pv4j4FJGjpuyMEquA3pDGSXNl2uchCTM8Qqkh4pA62gI67hu
         H2GVyJ82jbGKejNKAqtdlQCxRaaJK7wo30Ts7bMFZlbbSlhPpy+tMrtBDewklOW8Jrqq
         W/D+1IsL1pLPf4N8pAqEjuLDz9c+mliOAvr/4SyNJyv7/OU92S31RfUY37NRFzxZrXTS
         hCXg==
X-Forwarded-Encrypted: i=1; AL+hErHk26KoXFwRqFeO6difK/CgqTTxgmWwpK4VigsTAqeoLIg2ueGdVQbfuSI2ZcepjD7RePfHf9gYB/4mDQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+rGDRbrtL66tYP3zZwVIKRN7sLMfVSMw6IOkGlQzOE2PEL9gFQ
	FV+Nnlo0UtTH2PV4zTVq8YSFp/zlbjk5bsZwtvZTcZLdGsq4kf0Zfxim
X-Gm-Gg: AZFdTZdLAT/Z2Uwh8zt8TNy1Cv/Rg7xUpK7cniK2AlcP4gqDHcNaVyRsp+vfL9sgssN
	nYT6leJxvTlot0ZlC+g4sEUPeW7p9rOv6Uwj9k13nmIzxYFqRPoymeaaeGzMpCWVZEThp3r8lHk
	+f/61xxmn7GnOOUDWubCBAeSc4lN13DowiS/7iOoTGJa04+r0fqGc4GZiKCx15NHAE2hRZejKQ1
	PDn4lmh20bzvoGAF44Qdg+YisQ+NKyB9y/E/aL90W3qmpSHLe5KvLoANGdh1smWv78TzWz7fScD
	o9ztr++G5rQWQzh2mgx9QEpcsKRhbOo4ARTph46lqRtRUTWmzHJSvhZSx/upKuHDBEOkDahBCQ9
	pOM5gAYU2XSpxoTgIVE86W+4HGHqWOTo2L1qV/o2PGhWSnq9pLoLkA08AhpBnay6pd+Mdk8mWRK
	fcO+/2oCijIlIdw1MJd+DDZRSYIZB1ugMisvqyeBRQ4Sj0Owb1J4rV+jFN+zLiEvF5hVA173Z7V
	AoDE/7nhlJEiyJvKjiBFxoeUL3gOfhtmSj31GdOxslUH3viVMMQzABRbrqitkRAjLECwZzaqvNS
	wOrOjnpvyDE3GMJMnJ4vKRYuq2l06TvtGmeGAzXdQC5dpP7DcFFQemc3MQ/WOejFbNXoHoE=
X-Received: by 2002:a05:7022:ec17:b0:166:862b:9bcc with SMTP id a92af1059eb24-1b55689ad7amr16499755c88.18.1795476843673;
        Mon, 23 Nov 2026 15:34:03 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b562a82b3fsm32516558c88.5.2026.11.23.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 15:34:02 -0800 (PST)
Date: Mon, 23 Nov 2026 15:33:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Dudley Du <dudl@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 02/10] Input: cyapa - validate firmware image size in
 cyapa_pip_check_fw()
Message-ID: <awTNTSz5mxJ_AaME@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-3-lee@kernel.org>
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
In-Reply-To: <20261123183200.3900004-3-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:08PM +0000, Lee Jones wrote:
> cyapa_pip_check_fw() parses the firmware header, the trailing
> application integrity record, and the application rows without verifying
> that the supplied firmware buffer is large enough to hold them.
> 
> A truncated firmware image smaller than struct cyapa_tsg_bin_image_head
> causes an out-of-bounds read in cyapa_pip_fw_head_check() and can
> underflow the unsigned size subtraction in
> cyapa_get_image_record_data_num().  An image containing a valid header
> but zero complete flash records causes image_records[flash_records_count
> - 1] to read before the start of fw->data.  Finally, an image whose
> metadata specifies an app_len exceeding the available application
> records reads past the end of fw->data while computing app_crc.
> 
> Validate the header size, ensure at least one flash record is present,
> and bound the application row count against the non-integrity record
> count before dereferencing image_records.
> 
> Fixes: 5812d3067294 ("Input: cyapa - add gen5 trackpad firmware update support")
> Closes: https://sashiko.dev/#/bug/linux-cc76de59-950f-4e64-b49e-7605164e02a9
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied with some minor edits, thank you.

-- 
Dmitry
