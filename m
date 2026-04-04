Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502F313E3B
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 05:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775279005; cv=none; b=FDOFAeEzj8SFGahHlOUQFnJPYRSfM7KmUGtqIJQ92v1Mgdb6CIccxpcA4KYbE/QbOPgMLkyLaDIxxFMs+ceY0llCCvMrkU+Zof5pFhftIW+fkkM2sAA0nSbxxCB3qfy152Mh/XsN+eCpl3hTu12WahflY0ijP+tbUsy2CZdGiHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775279005; c=relaxed/simple;
	bh=Id06bL8KAqRgYnB0wvBbwqJ4hRL3XYyS4BozJ4jZ1cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRQNMwci5focmYfn0iniuKIrupetWtsHzJmbjFFvMGIIE2Wjmop3B3otGleULyRkjAYM3Enofzf+a2WboZTycsfJD3YBPHGRhKrR/rczIimSQNBmHlvHJw7ONd72lgZMBzIoPowcRCCeF/XQ1zA3CMzBgLsv+jgguVnrDvH2D3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZnWn98G; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZnWn98G"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2cc4c693d59so2702824eec.1
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 22:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775279003; x=1775883803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3a//nVWssxzHcHgtzqRxbVbtfFF+cFpYppCpsEPItgk=;
        b=ZZnWn98GCJ0SeNG/Z2fXMZncb/vzhEN2MkY8kGt2dUNkXub6JU8T248RRv5+7eR+mG
         xZ3D7zJD9+K/Gma4fmP8bxkAAOOGXdxsydd4NsfQdbyyXqXSBV7wKU+yLmDXyqAMGm5w
         ZG6bqwWGFMqe1DQaTlXkvkl6UkOU0qj2wBOZje4qDvCpjMPyWMyu2+fyREo0vjX9/HwF
         whle4MYUeF1DdE0G3rzOAGnlLHkUvwsewzGcZNJ0uZesINYPEPyraptcKkhlwfCmIx+6
         FmmnwjyeXsT15S8b4d/elOFuGFdzD88LeVjvhRGruyZILvTr1A6zMu8voLIKjFpWreWr
         UQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775279003; x=1775883803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3a//nVWssxzHcHgtzqRxbVbtfFF+cFpYppCpsEPItgk=;
        b=sUi8zv2Z6B///dc6uJEgD5bdELuCvIW5GsNWvjMx3y3a+r0KhM/Y18cJA2nPFwwuFa
         e3Yf6OSyIcdy7vzduewMMtORUW/0Ru/Dc8XNhPvyqPPNKoAmq/q7zUGENb9Yu16Gfk1O
         KZE8Hxttcba+YAZht+5d8vnF0DSHOtHXilPBnZh0+OlPxPjFb6GHkt/HR3qQUYUSqVxu
         RrGWqQPJdp5h5b6ev6AAoMGoPv8dt8EK9M0RJayb9heE9UIFwChZKEpWJl6iArrHH1u1
         4BpdD04Hq9/9oU16hyQAmYwQYoAYupYZfyWaxBx8yJKtm0y90Acdt458Idp//JxG1klk
         IAww==
X-Gm-Message-State: AOJu0YwYIyPFDEvSKBS0cyGTaTERTyBrcp6YMcIf/1ky40oGPo+PL5MJ
	JKnBJ71bLNiro7TOnwunaLmMz0tIlcKd2qAau1mbOMVIOYBX9WR7vm8qYG21XQ==
X-Gm-Gg: AeBDiet7Xv+xpf75oGwRru9+Bk2pND4V1XlfQgdDVhCMVnc2ZzRUwJV/Z8giMQBZhRo
	jb7ReHYDbLiaeDGCScsZy7W1s4J3ElIDjW/d6FNVRyjAHuqyqZqHE6hLheBBcB7fcpu4U2NRyvx
	3up2Ys271/yRyiboHxBx2UKeGpntjeBb8cqnt5zPvPuao0EEd/KfOHDsAuM3VNMr643GKP80Ft6
	EmeZxH/885lwKNbhNp1ntOHXzyCWyKvqYofdkj7Bj3Afw9VwKrZyMk2mdn/t5ONJthAn2PJcpli
	wjyPehCheIMT0TBUoI8ZWBRUgoeGr6qCN1TqLv+6RA5KClTYVow21/Nh7+7wFxnLUILa8vbnGnL
	YFQX8Dnh2/fQ8aP8bRrCSjexKXTdLpEsakZLz42p/QsepH2bHIy/3pw7a9MLXAhNYKgHZMUPu9d
	NthyB5HwtVb2gYlJ3042Qi/E/1BXZPJctIeRPEyuCwj+KBB9rhHQZ8Nq59IfDtVMYm
X-Received: by 2002:a05:7300:b594:b0:2c5:220c:5673 with SMTP id 5a478bee46e88-2cbf99ec1e9mr2782321eec.5.1775279003260;
        Fri, 03 Apr 2026 22:03:23 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:2357:9278:e4dd:85f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca78df8942sm9448144eec.2.2026.04.03.22.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 22:03:22 -0700 (PDT)
Date: Fri, 3 Apr 2026 22:03:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Elliot Tester <elliotctester1@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Elliot Tester <elliotctester@gmail.com>
Subject: Re: [PATCH] xpad: remove stale TODO and changelog header
Message-ID: <adCbfho4hwTpUZiR@google.com>
References: <20260325221618.135833-1-elliotctester1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325221618.135833-1-elliotctester1@gmail.com>

On Wed, Mar 25, 2026 at 11:16:17PM +0100, Elliot Tester wrote:
> From: Elliot Tester <elliotctester@gmail.com>
> 
> All items in the TODO block have since been addressed: axis tuning,
> analog button handling, rumble support, and dance pad USB IDs are all
> implemented. The manual changelog is also removed as history is tracked
> in git.
> 
> Signed-off-by: Elliot Tester <elliotctester1@gmail.com>

Applied, thank you.

-- 
Dmitry
