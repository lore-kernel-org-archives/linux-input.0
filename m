Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12FB3D3D06
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669020; cv=none; b=XHo+snc8W2ZXfaO7YEIRpWidvIcVuNGCrPVWPnDbH/pBJeORQ3+S7KJVtiodmKUia4QC6grwGYV4qXupv28iD0mm8LNaLDQVLXwWxk9bJEGyyLsa61tJ2jeXMBtShG0WHONZ8UQzF7nRXlLBqSrHBHhgdfpMvbwmtlRK4tO8OOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669020; c=relaxed/simple;
	bh=RTbLhkhaBejIuEkJARpEiuDCP8K6mIalCvZyNgaquTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6x6kUsRYYvKewu2wKXj8dU5HLVyl8b3CMiyKvscgPNnmDSTjp7aSjwal+alnGh0v0lOyfRFk8Bmnm6cJ/ZMtGO4Ym7FR0WJiqstdazOLZP6TdbpKGbCHKsuQw+ihoUJ87SdBFcqCg37cdotHn7ILw7zpipB8y4cop9f0mTYqec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXHdzfgv; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXHdzfgv"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso90714a12.1
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775669019; x=1776273819; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AT6B8NYC432IDQyByzB2HxtyFZqyMNPP7ngONKK/AVk=;
        b=dXHdzfgvrlHLa02Kn68DBHsI73kEpxJIVaVCZKHr7PBuoksYqErOimj+QPPkoaJg5w
         vR0ZDaHHGGtVA61JH3woq3UsdFVEf+j474//Q90f501V6YcGBedekGssMcqk5AEosOlE
         aLbKCD5ud5hZzhmggyr/HcwT9Ln/XqFySSHyuP+RgBNBw+inSlZzSY9ln+5ja4awzlYK
         lpmYfpacDGPs0IDbF+YHq8TIpa4C0h/khEwOLX6F/V5/3rWq9+RQikVY/iVEDRyVk0l8
         lYTedRgUxZJwcyvaZLuilszKGisjauXzCRvkPtY/TrRH5YZ+K80W8hxNlgTrp6cMmKoK
         jAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669019; x=1776273819;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AT6B8NYC432IDQyByzB2HxtyFZqyMNPP7ngONKK/AVk=;
        b=asm+0wvmz6hBxQVgc8KICItwzNFqztt1h25M1A/dnIHN+COwmK043hu4ho5ftszlts
         DLHNrt7Fc1Frkq6UyW7TEQdHJkR4k20pe6RU8vTg+VA1I8bZLT7dLDtWHX2+gaaOeyHp
         ThN3gbApA4HJbKfCnqYdNpjrkMOcMMwPfBl8VG+b+oDh+wnewIuWP2uAkh0aEdAQuXx7
         ek66vr+d8L/eN4p8vVMAWnXsRxCAsrW+ruO8bodHcUxtHwT2x++DV0iqp8AcBoKNj0EN
         QRdMeG+AbphrnSf7g/+I6XAsi7K1E2ykxbbvH53ymz9LgI7VyvWQdiCxoAqTpi7PSUGF
         hQgA==
X-Forwarded-Encrypted: i=1; AJvYcCVTglKOpAJNOWFwrEqpbKke9zSaGgUDuSJ3tZqF91BeeOqlk8jPCBNErmB4hEGMtoVvtAPrHfJ/qOb5mg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VjRnnw/V0g3073w+xIkj6O+KIAIQM7hmxgWmqhe/Rh0e4AS6
	3SJ1pUiOjPM37wTbPf2A4Ls4afiuuZb7B61mXMeiLI96ustK++9vvWQYQvAehw==
X-Gm-Gg: AeBDiesWGZ7PISDEDluIk/GpP26X7em4DGZeoIu7zbqwQjVZuQoo/vAe3ouBu2IazQg
	7S0LtgVSvdQ2lC9luj1FPGOcP2UAXETS33XlU2RKWSMzn7oQYoJbxhcmF+aG84mInRBIpelE9tx
	0gVg9q6K83wlsv2q5RpiTPkipYMOc+u5Sj5jRH7/xWQuLDnmZ4V/kAq2WZDl109t3mUVfZVujE1
	NYNAXIVZrt4etIe2x+uYB69r/TjZKr5bNQL7ZLO+Tu/1TqHBM4pUvXuUBWYCgbICv7sBF6hWZnq
	kcFdogCcuRq2l1MT56E5/iX6iK5pi+34HSm6volw3yLYwaJmt0D6IRLSwxzzRK/hEh5frobF1x8
	YN7aQf1x3es8U7PwzQWZDI2Xgf/Ey9ZAwfOeAdhM27g22is4BcsGT+uppkWCZ0HJnsG9HEXmN9d
	myisIXsGZjZaGNyvchwAmQ2QLMujtk9sfIUeX8XvZxDfrW0EiJdAozwS+drYNsYOy5
X-Received: by 2002:a05:7022:fe09:b0:11b:f056:a19b with SMTP id a92af1059eb24-12c28bf9ee0mr191421c88.18.1775669018691;
        Wed, 08 Apr 2026 10:23:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f3cf:7538:b120:7924])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede545e8sm19029716c88.11.2026.04.08.10.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:23:38 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:23:35 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: Sanjay Govind <sanjay.govind9@gmail.com>, Vicki Pfau <vi@endrift.com>, 
	Nilton Perim Neto <niltonperimneto@gmail.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xpad: Overhaul device data for wireless devices
Message-ID: <adaOmEQNXXPhxmmx@google.com>
References: <20260404083928.489966-3-sanjay.govind9@gmail.com>
 <adSJp5U47g1JnImj@google.com>
 <CALQgdA0oYzWqFtyG2eZKgwKr-QLYz5dLbsFbpY8qDrpxK7vj8Q@mail.gmail.com>
 <CALQgdA0UpJb7Lztkts3LrFtWrAP3V3CivFv3NKJDFg1VY_q_0A@mail.gmail.com>
 <adXe452989A6k2PJ@google.com>
 <CALQgdA04mczQoJ4HyjSwgeXMHwLT+Rv0AEoArpwBohzL9oa1nw@mail.gmail.com>
 <CAGwozwEoFWG-sQAbT8zxqEg8Q=+=xULj-a9y7yoEqu3ehZtSUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGwozwEoFWG-sQAbT8zxqEg8Q=+=xULj-a9y7yoEqu3ehZtSUw@mail.gmail.com>

On Wed, Apr 08, 2026 at 05:47:06PM +0200, Antheas Kapenekakis wrote:
> On Wed, 8 Apr 2026 at 07:04, Sanjay Govind <sanjay.govind9@gmail.com> wrote:
> >
> > On Wed, Apr 8, 2026 at 4:52 PM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > I think you'd have to spin up your own instance for that...
> >
> > makes sense
> >
> 
> Hi Sanjay,
> I have a workflow for running an llm and getting reviews locally.
> Perhaps I will post it to the mailing list soon. I can cc you. I have
> been out for the Easter holidays
> 
> Of course, you will need your own LLM and harness for that, Claude
> code/Antigravity/Copilot/Opencode, etc. I know they aren't
> particularly cheap.
> 
> Dmitry, sashiko looks great, I left a star. I could also cc you. I
> will also reference the prompts used in that as it claims some
> subsystem specific ones. From a quick glance it seems to might suffer
> from context bloat though. There are a lot of guideline files that
> could have higher information density.

I am just a happy user of sashiko, I'll leave it to Roman to comment on
the potential bloat concerns.

Thanks.

-- 
Dmitry
