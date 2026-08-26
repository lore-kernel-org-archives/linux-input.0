Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D9B3AD52A
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731888; cv=pass; b=ZLR3Qoslbqfv02pLz0uaIczTnQtuQQPJexmhf6xzXAGX2yVPCi3B+IU6CpYWjggYdSMgdxOkrhgrIjISDK9WwU+CNq1Mnc6fjPnBaES/JzsId0nDAX190tqVfzS5HaPKY3VSXB3BYQWjoKkICh2u8sT7hlLs7YXZFXrHXImvsIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731888; c=relaxed/simple;
	bh=mXxLXyr21mdwImm9P7kpToLiwlq+gHr9hLXXNi9rmnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/WcvMKYMnGJfOPa+o9TkUr2KqrH+n5IBeryzNhUT88cmz36gd/zws26MbQIYa4khyQaZ+WXY7K5vEhRXZpiDsPBEJ+gIORFi9Tmxfn9lbeAL4dTXYNsYfdsdx2fY/aXy+ITh38rup5MeIU4K44R286lr9ukYdVpwACgEnL5X6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMiVLDMm; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMiVLDMm"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66d146f04cfso556298d50.0
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 01:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731886; cv=none;
        d=google.com; s=arc-20260327;
        b=XHpH9QEcrWS/0vpdRlXjSw3NqGmJGyRGMgtiJ13tGultwy1r/g6Uuc+z1nQSYFs+ZM
         nlpPQUHL4NP00OJduCX2zuRKn4RzuSrwfi0mc3hGGryyoFiIvyphROOc0AstSzoAD+Wp
         91A2vVFp7fksrcZFICAR3b6I4feeRa4gzSa47LnHzASg/YGfsWjZuvFoX8PzFa6h8uzQ
         aTXEhmI8vMaCirxfQ3Qo5uDM7BznEJG6NzjT/kP7N1FqwnOl7SC+94Y0eoTTiR6JVMIm
         lzVAUg3c0X6rmEsFGMrqBNhyd4mTvNrQAoLQ/1aSHzUsFeLfDzdJ1mdL+YrG1SZjNDiH
         riPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mXxLXyr21mdwImm9P7kpToLiwlq+gHr9hLXXNi9rmnI=;
        fh=u6dcgWTRN8zDPNIktQb+Z575OZZSFl6JBlFX1dL2jKc=;
        b=aF5Les3vcxqvdTXSYQKlpSeyuyyuh+BfQmTQI8OIgyzzQnSpJBmqeMpoWPI0KUO5pG
         ynnFSL1Hxh9x9kRNT9cUbTlmxce5hndlh503QRQEAsSCghLPGvSr5Zy80lsAU0bjOH9Y
         clJ0WPhbxuDqV6RFyjFtgQCZJ+TbrN8sT95w8MdNceinshOZ9fbQ3N8CpIEfLy+WXfVa
         gOxP4V94MVSbJpsGCEJ9SP8u/diB3N+UiMEyy/8LfGdGptYK7IWIjEkPucR5hCJ9J5Nx
         giMOTtdbY2wO6xEW+7SHpojlcnP24RNU/JHhhMBV6k1xb65WUz61bOfb1VSZHvK/XoLJ
         TZaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731886; x=1788336686; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mXxLXyr21mdwImm9P7kpToLiwlq+gHr9hLXXNi9rmnI=;
        b=mMiVLDMmwbb6Qlsi9CZduOsXPgJsF6H1Uj8j0tv0PiLmvLtVs6pFNTXJrnQfzU7xEr
         V9YtRBFvEEnkv1l7kaC8RidmhmLiS5Muh61UZ8tIuxlUIqo6iI/huUjiAHJXnfzw6TuD
         X5jUcgkNusovlDXnjn7SpNL6Qd3bj+qH41jZxouLN3O8SZj+Q7AjZ63GlKBeGa8JjCQR
         /CdY5joLpje6yQKkDuyI4GYKicovdX4iDGh8j5HGs1RqRXBnOZIu2KT5JP8rw93qyPaf
         MZLa3rp9hRHKlYIO0ylKonXv97wKiShbWTME3uIjM3LlBId374OxX/H3w4ckENgbCSZp
         GM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731886; x=1788336686;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mXxLXyr21mdwImm9P7kpToLiwlq+gHr9hLXXNi9rmnI=;
        b=E2Kag8WLM9zKeunG4VMxAhs/WSkclXlTXiM0nskriKjPbrQCBlRQrPS6eXZJ0vmxcX
         dGBXGX8IP4wFD21o8L8ev5elYkUeb9h/dJgT6TbHghKqSTKGwvKi+L82f4nCKjDRBHCV
         UFgxMxx+9m8jicpF2/R5S4yfiZZ6RmAg4wkNKkHYEJH7qKxTK1e6EdO/SPfnhiH2DNkJ
         9MPexIYaJUXQpOTXrKHkZUeiS9AoOiLajVfZhYRkM2lAIw5DUu9i+WlK+v/CLH3SDCzb
         omB0rvysED+YIysllA6vqQ5pgRoWXzPf2e3uKM6DrqkiQQ7SxFJ+HgU2yqBuhLtfX8eU
         QeQg==
X-Forwarded-Encrypted: i=1; AHgh+RoWc3r09BN5FQZceGQ1tDjaMeFd9E7qJ3CadmQX7ZkK6j7CHeN7ADr7twEH/jku1Wb7efNEqiqE1nQabw==@vger.kernel.org
X-Gm-Message-State: AFuF++nAfXq8AGKsf+hmf7CU4Bg/8YTYV0Sx0vT4vUvHK5oZfQeg+DRw
	YCAGRfX8wYPBOferlR/wc787FbqsZhiGpPw9fuE7HIBMZNZiKVv63Lk+F/vGV+KDgGrLkEm0GgD
	ocma2NNJvNAhR08GdtwBvddWY53ukuh0=
X-Gm-Gg: AR+sD11/FB6/MiqoSNNNn4A/Gr1MMtRTLIah1MosMo+ne7lMohLrrWOu4frm2+5bg7a
	hF9G9JgQhdmlpGeuqDhfdbFKMirkxawHAbiqnkFJ1bTh4YHPLpH7cQ0GxlPxFHcxhAV6nMMpSvp
	Ndkd01SFpitjNl4H9jTmxWhDT2PpxrVHmyEDQg8R/aVnmLMBvnYDbDLfZ1whOt6DqRLWYJcoKub
	MwzfH6wpsFUELmTWuxJC2y6xqHfZu+fZ3/xskYfiTodIChpH0rIA231bS1X2RetnELP9AmuQFwR
	jffAFRbf2FttZHi5AmtWqUneAVH7myBJJVRaUssazq7UcV0=
X-Received: by 2002:a53:e9c6:0:b0:66d:273e:1196 with SMTP id
 956f58d0204a3-66d273e1c3fmr963616d50.42.1787731886356; Wed, 26 Aug 2026
 01:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808151736.2934050-1-lgs201920130244@gmail.com> <e2b658d5-e846-4ce3-a42f-16f86acbf3e3@kernel.org>
In-Reply-To: <e2b658d5-e846-4ce3-a42f-16f86acbf3e3@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:11:14 +0800
X-Gm-Features: AcwNN1UKGI8R9J607Eo1-mfi7Ht697aKEM3_-BNKkot6vLunRSNsSea1sgiMWBk
Message-ID: <CANUHTR-PqW=7k5HmC=qb4LA19qM90OBgnTx_r-p21Lva3zzO=w@mail.gmail.com>
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: fix autosuspend
 cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Danny D." <d3z.the.dev@gmail.com>, 
	Abhishek Tamboli <abhishektamboli9@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 17:17, Guangshuo Li wrote:
> > quickspi_probe() calls pm_runtime_use_autosuspend(), but
> > quickspi_remove() does not call the matching
> > pm_runtime_dont_use_autosuspend() during teardown.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped.
> >
> > The documentation for pm_runtime_use_autosuspend() also notes that it
> > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > driver exit time, unless runtime PM was initially enabled with
> > devm_pm_runtime_enable().
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> > remove path.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 6912aaf3fd24 ("HID: intel-thc-hid: intel-quickspi: Add PM implementation")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
