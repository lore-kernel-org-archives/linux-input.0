Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337FF46D559
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189944; cv=pass; b=FNg9mNUMSUpDbwOrDw3+RGKDMJ793nmlIlnhHOrbqqNAZuott9Gp7Xk9qSWQQFxaAg4CW7XALptuCpPJhwOKxx0AcyE1kNvqUlvVe7NYPRHw/fqmxTOPmpr+Lwea/zGKopSMUB8l8ExEGkk9drKngUb0174j1+5vzzEJ5Ug5+tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189944; c=relaxed/simple;
	bh=5r5lIWIE05yql962Lu66IpUSpOLRAbYoczG3Qe81sGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prU4vagqwW9R2rj9qkv4mz7hXOOD9HRzwwhYwk0wvfuVaxsrXWz4WQ94DVFPNl+zaUCgPOQj4fGpfi11x0Q9A5XgbJC0qGRW3tCmEf+wJ/85nwMqYRLPWVYEiF+2T6yIdwFkbjJ8fVoWDC5nc+aAc84eHi+GVcDsDcnTwwJE/Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6osjXU+; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6osjXU+"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66d23c88af0so1540842d50.1
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 08:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788189942; cv=none;
        d=google.com; s=arc-20260327;
        b=tChqxXsBXi/rC5mv+unvsnTYP51Wq3Lo6Cd75Ue/eCrQSxSJgO8SZeh3eLEPOYZVKU
         1NJT8oY8eXv/YXZNWQ8+u3lrTUmWZoSuOZrE9QIhtg05TBnUwgOFclrZnZSiUDBpbumk
         r0nl/YLMGof8K6H6SVYe/zcvzxcq/0VFzKPq0YF8WX4aqfXZQrCvqg2cUFD/S94P/x58
         a0Zt/RJzUbB5CNZfdpTMCS150Xr1nl7ttNvtjznF7nzy+SBtnc3szI+q7ONDvvi2hOzW
         QZ+Swm36taQ5zrfo8lF/GuVgH8l+gBEQtElzatr71LuB79zxviP10fGRFq2ACethew3+
         8rcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2lfcBfmQY62Vm348mWM4CEGfElAKI7bW/B4d2+TFnBY=;
        fh=bFdQ5lVOXzz1MWEyqC6tTecX55nGor8rCZ9ho+R1J4E=;
        b=Q8Gds0HlOuxaJ2O/06PcvxTzmmcueD31EHqiqxcBDT9yCtDnuI4Ra2WxJtOFXDFSDb
         EjANZScrCWXsCZbOADVenzRKYaY3cutiWSVWCfy7dvLp7Vo4tRjkXu8HimtDxbZn0b1y
         IYuM6SR6KzyhRzbf/SmG5iC20/tEhCbToXM153WSodUskZHyJtD+EtQ/KuvSGhEEix7o
         fEnoEO0iJF9biAOlWunLmyV+QQKpHtMQv+mPbfcR1qA5iy1/2nfptboBQdCBA02Lbv7b
         xUzHv1pHFfQ26bgpzQ3xuvCRpZVs6heHHVysB2XmGI+MokE/hzp31+75tvyba4oKX8bv
         UdQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189942; x=1788794742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2lfcBfmQY62Vm348mWM4CEGfElAKI7bW/B4d2+TFnBY=;
        b=Y6osjXU+kW6Jam4k1IzXYyj3nNibFhcTM+I5jK2qbm9mDMGLIx1hPxjDBoFcNCY3Ec
         DAii1KiqmZyrUsr9JN2gVDNeyqCrHhp7ppAXrD3VGfMSDGE+NlVW7hnC/HL2RdaEqmlB
         /CzW3lzSC43kheUmPJOK9NGmjyaziTpAJD/wtE2Yrtiqg3t6Dqj6DKoTcHpZ0inIA+C3
         mJLg0xbTa5j8x3pRPmt1tG70FqySbqsYXXiIHCn7XWhPArKfZ0/aVxMdNYqukd6XlHMS
         I5mSMCjOcM2g77EFw1hAE5CV8UUIBhzqXuWtKSnsNtvAGGm1FhjU2Spe/7fqtRiQV/tL
         J9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189942; x=1788794742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lfcBfmQY62Vm348mWM4CEGfElAKI7bW/B4d2+TFnBY=;
        b=YYRtRNRoa/T6Bxqy54mFDcSKogMFXvo5UZPV7SsnVjyWSsvH8eH4bUWrMwGHzbX4v1
         TNbkopDDNhBjfS07i/BALjoYDyDJwk7jmjSLTDPDYXbbwkCOzvjxqjPMcFE3VYAkb10w
         /p98o7OG/LC9+gUBVgopBv90IaBlSAvDV3OTKLPWiJPCXayi8BJaXhVarypUKWhILLtb
         UntDN1tw1+t6+BPeqf3nh1O3p/yFkoz01Jh5tf7grLDDxNFqbjADbwXPE21wuS5o7z8p
         tG7trv8ri0mG0bGJOvFmZOyplmvwQGtej2OwZRbrzaWne7lPldwPfLj2b/Z1jidfrFEN
         DM2g==
X-Forwarded-Encrypted: i=1; AKwUvBwTlGJFe2gcfllI4sD2NXxsdZuJzGXR9MYAON8DZyF3/5YFs5kmEBXFcJhI7qRv89ib0vU8yC6nmRuHfw==@vger.kernel.org
X-Gm-Message-State: AFuF++lWkPdhmTP1K/pfjS3q2Ma8hky7lrCiBO83tEsEKQPaCo4QdQ4J
	s06aNtod/66O3FM8ewsamYuXSIPsCTqsl0hNBaAHRBKd6fbAxPGlyHTIcv2Cql8Fh5unwUUyNKP
	x6QWMaGu65ObyfbV4S3siRNw/4CDaij4=
X-Gm-Gg: AYBFou1lNS5QaMgjv8Z/OQvrFG5YvRCDmXZ/GeU29GaLjw78DOPk41lBZOQ2fIBS8xV
	t6QJ6XaJxJ6aiaJ5ts39w7jNTkwBBe4bQbAR/oOjuPLgvjVpriYzsOr1ORz7V8DB8fm5lQDj++q
	/SIUxm49rKtT0kQM+GcBPKmQWe6Z4pan7ATbmD58+9Bf7+k86QYuKdCZw3S4z7XWUeXP1r7rqHO
	8/HjEIO27hFsPBoiXgXEJYnjmXUkw8ObeSlgIDNutWIZSBDfZRdEPWvmURwE/gFpRMoXzWFBB3p
	41nfOZ2LXcTi/4wsk1xQFn5MqaKC7EHvsSDhFsREPcrzdFyJpereLP1HznxNL5FxQYbZPqkSA6e
	V1H2k7bdX
X-Received: by 2002:a05:690e:480d:b0:66d:132a:875f with SMTP id
 956f58d0204a3-66f87615f57mr469041d50.47.1788189942058; Mon, 31 Aug 2026
 08:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
 <20260710022854.3739558-3-michael.bommarito@gmail.com> <20260831134023.7784374a@pumpkin>
In-Reply-To: <20260831134023.7784374a@pumpkin>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 31 Aug 2026 11:25:29 -0400
X-Gm-Features: AcwNN1XCy_2Zo6asUAI6Mo_MrE5tR1bf4Mf0i1abV1r9A7R-zlEGvrG8uEVg748
Message-ID: <CAJJ9bXzmVKLQopUHTNh7-C4WggMcBJ3s9KShA05piwm9VTMTOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: hyperv: add KUnit coverage for device info bounds
To: David Laight <david.laight.linux@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, kys@microsoft.com, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-input@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 8:40=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:

> This has landed in rc1 and fails to build (with gcc 12.2) because the tes=
ts
> in fortify-string.h detect that is it writing beyond the end of the
> structure.
>  module_exit(mousevsc_exit);

I think Juergen and Jiri already found and fixed this, but it probably
needs to get bumped up to for-linus sooner.  Sorry again for missing
this on the original series.

Thanks,
Mike
