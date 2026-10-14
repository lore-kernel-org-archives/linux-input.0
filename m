Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEB568520
	for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792000276; cv=none; b=YiBg3bq9LXitTAShxOe7THip8UaweLkiYTrjbmj6/hsFGaNXDvaIBaETCAvy4whkSp9TE2ZswwqCv0UJ1w2w991PXx/SbPoQ8SqaaBBosgCPRG9o4A/Vg8SiBDay6NgcOLAUMU7RgASF5DpQdf8OejrUEWzD8XmBBKxtpTAnwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792000276; c=relaxed/simple;
	bh=7iGNeJmfcOi2YoNxyNO1yWmrCItQX18NxpfvwkGF9MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcS24LMYWDq3xvBJko01KPC0Ebauug0/sA/LTeLd22sH/szXyMccI1nOj/Bm9hfBuxPglbMnBJk7G2DZTulaaOMYp7LeXMRdRNib2EbJWiBcC4mYhS0PIf0LJUPEITvNcuHinA5/Su7QKPQsw2zvLvboDEkPKUOQbkjxgE69pNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6hb0nMW; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6hb0nMW"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15756f82e8aso568051c88.1
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 10:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792000274; x=1792605074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6nF2QdVqRFSLLz3favTr6+7W+Pw3c0RMBGNFXIbHvjY=;
        b=n6hb0nMW8pWiyj0GtmHiqXijhDEvp+6GtRKBvjiiJvLZD7HwCiETPLsKnq6He+cH/S
         iVZew3J2mKYL2DzdRU6VfjfEZnc2szgBNB3Am1zI4w4LCCwC/NsM8MhjR8iz9/84PhSI
         6ZuruOcciRflSPPARQE/DS050JY4F6FMlJR62a9Qw5l1SpRWMaEyM6ci8ZOAbK1r4Jt9
         7MNrDaznpiIx/eHS/CaakDVl73CoS75kJ7XknCsoDDoR3rfbIjWr1BVL+DoK1+nlvwc2
         j5oY8WvNbnNvACHVhQLyl8YHne+d/0zoN80EtYELhGruylldpBwfHo7I+ENWRwganJvu
         uTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792000274; x=1792605074;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nF2QdVqRFSLLz3favTr6+7W+Pw3c0RMBGNFXIbHvjY=;
        b=T+wwZuChSgfzqRbAfnOur5X2lyah8fqmFQZVHQnwuwf8zvCSNzIAWMglZcRtqDLbR8
         A6QhSfGi1hVs0LWcA+kMGjouSQihcShVmteE/hUien+rOI/FT8mfUlpRWw965gbPoNmC
         tLRMZUqxwU92Twti2eY217/ivrV4gRkR4QhsNt7SU4QIqFW+Yu39ovbnQlF82IpEdJOX
         o0OyE4bxpSfpU9JJ2roM7q6pZktqo30lNFeHVsHcPj8arXnoadk+FrB1XTvVlV5LTvkN
         coZXuPP9Fv1B71v7AzL3Kh0QUBVNZIa5JZ/Qx9lLStHzUR1akxkoc5qhEILLZR84dgu0
         X9fA==
X-Forwarded-Encrypted: i=1; AKwUvBx2bauXA3rclGywWDp3FJHgDu2LDFvjZR5LmWiIt++i3eHgGhX/3FKnDcsssxjs6Noj7/Fg6Krf7SPw5A==@vger.kernel.org
X-Gm-Message-State: AFq9FYILs2OcQ418qpwj2kmYu+TpU/TgCutc5U1OxyypFNNr4EGR1oL/
	njZB/6JU76netdGs7LuiBbpcUwyOiDbPTb7zZYeMUsPJTJ2PdXzdPh0G
X-Gm-Gg: AYBFou3ehlunDrv41Q9HADwAQ5Pc6hWPrmKXkBPQbOB68rPq3nmhUZMRSml9m4RNwli
	SvESkd0++s1jJls7S/cbDXllImyYC4iCqi50zhcBuKeU3MSadIYmDvFi+3CwYRN6BtvokLjnCDz
	LitJazSxu1AvliTiDFlwiedT1iEx6BPb+9Uk/nSeGpPGCvRjDGfWVr3iUfYvwFX0zDlrdKvrrDC
	i6iN53yT6nu77Uaq1mUNA16CFu62O2ajOJ7X1bcp7k+SL3y0KNKpq6EARsUD7lpvw7Vm+bzXT39
	gIWqpY5Gb7JALw8N7HUy23XMrBbYvbRIbAVaz4VeohBOPoFqnZGs3QK1E0y4I3Oolsf1sWUJpEA
	K5M44RF0GTA7qeXUI3qTVwnRSKK7OpKyK4/4xGBYSq7thW6ADMrzUrJyM5W+tK/HrC/n0NIgW9t
	VhdC4FssIPkIrW+STfOly+qbfn9VzyBZPXwFEX0JoJ+P53F8JXIAsx9acDaSfkJKW4297LqbfZQ
	+umY+5+nsraipZGGAbWwrUZLtUYqTNFg6wksfwh
X-Received: by 2002:a05:7022:e881:b0:14b:1ef8:698d with SMTP id a92af1059eb24-16a5d174c3bmr23967745c88.15.1792000273790;
        Wed, 14 Oct 2026 10:51:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:875a:117f:b9ea:5a08])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16997c21ff3sm48611107c88.2.2026.10.14.10.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:51:13 -0700 (PDT)
Date: Wed, 14 Oct 2026 10:51:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Nick Dyer <nick@shmanahar.org>, Hans de Goede <hansg@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/4] Input: use designated initializers for acpi_device_id
Message-ID: <as_A_l4h24eAtUE8@google.com>
References: <20261013-acpi-input-v1-0-53ad09ba82b7@thegoodpenguin.co.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-acpi-input-v1-0-53ad09ba82b7@thegoodpenguin.co.uk>

On Tue, Oct 13, 2026 at 04:15:21PM +0100, Pawel Zalewski wrote:
> This series is converting lists that contain the acpi_device_id struct,
> which is defined in the include/linux/device-id/acpi.h to make use of named
> initializers (which they do not use currently). This work is part of the on
> going effort in the kernel associated with device-ids [1]
> 
> The plan is to convert acpi_device_id::driver_data to have an anonymous
> union, similarly to what was introduced for PCI and I2C device ID tables.
> The goal is to increase type-safety (most of the existing casts are gone),
> to improve readability and to make use intent a bit more clear:
> 
> ```
> union {
> 	kernel_ulong_t driver_data;
> 	const void *driver_data_ptr;
> }
> ```
> 
> But for that to work all lists containing the structs need to use named
> initializers first to avoid triggering -Wmissing-braces. I already have
> patches that implement this and touching a lot of kernel subsystmes that
> use the acpi_device_id struct and that list keeps on growing. Therefore,
> I have decided to split the series per every subsystem into:
> - pre-clean-ups that convert the lists to use named initializers
>   (which is this series)
> - actual implementations that make some of the modules use the new
>   driver_data_ptr member
> 
> That way the task can be fragmented into manageable and independent chunks
> of work and makes this effort easier to review.
> 
> Tested builds on x86-64 and a64 in Yocto using 7.3-rc7.
> 
> [1] https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> 
> Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>

Applied the lot, thank you.

-- 
Dmitry
