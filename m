Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0A62E5429
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786854430; cv=none; b=fNiitswMPhoBs3HMMS22ndckcikcGd8l7WIBNWbAgVEANepNckQ8GD6nN6x0QLCxD8GjI2vaWSbl3ca/6/DVrXTVNO/G51qFBMnIRybO9kvYBOSbQ2lcEwwNBXFEiqakmZemS37g8/4JCSpnYpmE9bJOYBzPxMm9apStWSRAGDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786854430; c=relaxed/simple;
	bh=wCYrc4CHq/2LzuBjTB5wfum2McVICBHejaWJUWPeQ+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhSDbyM4GDmOBIryvClpI7Le0r5COH5hfYIB9k1jCyORrBoBXQXKET8Gz9whEfHaWB/5B35ouXFAgzwuGz7irMXTH0O26qKc+MrrsAweYGSzMrq9aJrc4RKmDUlgP0oLdZLjGkSVMX6Y2sJZFZWYElEwQVp2MOufp1lWVhLpZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=schn.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=schn.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc61541f8cso41816155ad.0
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 21:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786854428; x=1787459228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wCYrc4CHq/2LzuBjTB5wfum2McVICBHejaWJUWPeQ+0=;
        b=lJJpSBTm4o54WmDmyhM9NuK3bSwJ7rEess+tDZ8PXWVQu+fKFSnOxPpoF5wT6mjyiu
         VOaTbvUU5VQOr2T5N8iCEd9XHpvnnFzku3n60kdu/XBFG4c63C5x2Agg4yC+5msyR8m5
         OUnuk6SzRdyExigBUUF/akU7zm9U0XXUXBissc5QJTcU2tMimJq0G4c7VgPlcCdZ5Vzw
         GFXFgWbI2+7PY8Ow2SuPiszANKW66DPXExD/dS+TiydQxUxCdTR6jXnkKH4YsnX3SCBD
         sR4ydmL/5N/eqw4Ep0mYXU8EMnn+EJBcDOdYQOnZhJUUtNr5nUPxetqT7mhuU/D8DdZ2
         68vQ==
X-Forwarded-Encrypted: i=1; AHgh+RoocuNM2rW62FvQp0IuJhuM69SP5aFDOzMNrX3eV2hckXSKIi7fUq1VS2CW6BzljkTsVI3HBsitueuEiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyK/3jx+tAfgWf2M0mN49G3QTdvt9ZKPbzvsnkzX3OrkrhCkVmy
	GlcCfsOAtrpgb8To0WBy7/mV9iQkwWXSFw66EuUtSA1V+/0XVYWkVULIFGMJeWdD8iI=
X-Gm-Gg: AR+sD10IHzLpqLwoDVSXPOHQvp3CVAOjaWX4rG0KDaj4in0SNhC59YDtsfcxmMAW8M/
	/x3JC+BCsKRrTrt5abCXISgsbWjeSy1bSNGJHGlTCU7TedS/H4IfA2hfdloZUAG4cZ2i6f2fVEc
	6242dLmhcxMvF/fLU37xgehoqk31pwg5NEXuJHuaqFFEkyUhId207wfIXMUhfp1p5L/Us9h0vPf
	MikcFTAjlfKwHAx+wZO2GE0tRuHtm+f9Lsket0Gh7cxRGWwuQqrR0bRtN1Kognks5yM2Y5Se1Uy
	caKgOF3mPfYOW3WH4xc4UvssiB+WpV6mHTlpbvCkxO7wdALC3OxFbnWXbeLGLA+31tIFEZva3NW
	glDXafHUAVUQ9S2PqC9TNzz2qaB8w0GlGCH1LY7/Tk2wIIGOKbfryTm3Y4LwVlMgxvp60Jhaach
	8XM3qglhbfAhNRJg7Wbv9V/Ty8heql8LR9MkH5rcCsvwSpoBq7ecxZt1g9GufveAIDTOM9k9uim
	/8rMgcx19K1H23kEo7sQauPf0diDIjjbwMN9lYbEBk/I+YzR2MmrA==
X-Received: by 2002:a17:90b:5445:b0:386:ca4b:16a9 with SMTP id 98e67ed59e1d1-3933b0d5e25mr13192751a91.16.1786854428420;
        Sat, 15 Aug 2026 21:27:08 -0700 (PDT)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com. [209.85.214.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39339b1d20dsm3635267a91.0.2026.08.15.21.27.08
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2026 21:27:08 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc61541f8cso41816085ad.0
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 21:27:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrhre3PIssGlHpA6gdjYPB3zd6vzXAQQ1KjApGVN2aF9UOa2c3xsjsek2OKsJRPRz1KjNpYOSRnPNsCwQ==@vger.kernel.org
X-Received: by 2002:a17:902:e806:b0:2cc:80d6:b72 with SMTP id
 d9443c01a7336-2d3b0091b5cmr132280305ad.20.1786854427567; Sat, 15 Aug 2026
 21:27:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804032337.315750-1-sofia@schn.dev> <20260813155312.106584-1-me@idank.dev>
In-Reply-To: <20260813155312.106584-1-me@idank.dev>
From: Sofia Schneider <sofia@schn.dev>
Date: Sun, 16 Aug 2026 01:26:56 -0300
X-Gmail-Original-Message-ID: <CAMoDTWjF6D0PNyf8sa7x3zO5+ZEn3pnvGftH7+HM7NDqNv2G8A@mail.gmail.com>
X-Gm-Features: AcwNN1U4HsSPblmz5ucFIHjtYngB9i-6Wq1lJ1V3h3NbcDONgA-XTwW0jNadIXE
Message-ID: <CAMoDTWjF6D0PNyf8sa7x3zO5+ZEn3pnvGftH7+HM7NDqNv2G8A@mail.gmail.com>
Subject: Re: [PATCH] Add support for HyperX cloud 2 wireless.
To: Idan Koblik <me@idank.dev>
Cc: bentiss@kernel.org, jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 12:53=E2=80=AFPM Idan Koblik <me@idank.dev> wrote:
> Add the device ID for HyperX cloud 2 wireless, which requires
> the same handling as the devices support by this driver.
>
> Tested with HyperX cloud 2 wireless.
>
> Signed-off-by: Idan Koblik <me@idank.dev>

Hi Idan,

Thanks for the patch! The code looks good, but the commit subject and
message need a little editing to match kernel standards:

1. Please add "HID: hp: " as a prefix to the subject and remove the
trailing period:
HID: hp: Add support for HyperX Cloud II Wireless

2. The note in parentheses (about your GitHub repo) should be moved
below the "---" line so it doesn't appear in the permanent git log, or
removed.

With those fixed in v2:

Reviewed-by: Sofia Schneider <sofia@schn.dev>

Note for Jiri/Benjamin: This patch applies on top of my pending v4
driver patch ([PATCH v4] HID: hp: Add support for HyperX headset
devices)
