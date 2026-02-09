Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A61738F223
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665589; cv=none; b=YW2bvkqRvAq+cy/IW3CgibhK2ls2lNvlQGIDnzz/40x+ebh2h0vlZnuddQW7n8YWahai61OEW2mrF9+LpMwdv5UySlvtOJLPYN8uPliq40X9zwGCnftp1931rs0FVn+nX5fS7egUopQLpRqKAjBXorPKRVhd8AtamGso1xwcrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665589; c=relaxed/simple;
	bh=y4/WL8DraOGgFsWhKFSg+J7rQqnclmJ+j8KLygZoKww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axE09XhxqeA3fiv4q/EWzh9C4yIt01VgU68uBf4MT0Af2cEUBasUdV5ar+Zku+5c1lX6xdHP6+f7zcYg4YqgvoSC3dAFYs6wfDl8Aq4WZ3GGYZpzf7YHecrQsJRxCsDwI/nR/0CSU0ueSpH5HSbF0v68wZJFTqH3aY5ALGJVYEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ob8b76U+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ob8b76U+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso852305e9.0
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 11:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770665588; x=1771270388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bQq96nnOOaZZumZQZN40bit2z1YPrLWrmhauKMPeMdY=;
        b=Ob8b76U+poby8/iYxLJrSdwBjM1q4u9PLBHnDRDcbvyDFDO3G9p1heRBWp8gEgB64N
         SOpPfF3Yxjdd1auVXLe9pqxIF3WIMZg+HXVzXa3pul96H71OH6VaR8dRXk6RwdLjaNVo
         Sfwxt2tBCvBAIgoILmiFjb7O+IuGUC/wYiCik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770665588; x=1771270388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQq96nnOOaZZumZQZN40bit2z1YPrLWrmhauKMPeMdY=;
        b=CoIeSrJPweyrYoC0cHKnqHL6Z2OtbYF9TsY2IE19miGB2z1st44OCazcmZ/+g9modb
         KerPsRAxzAf6Ukpwcp1dPYE1OoOx/hja9imbjWnqCOaLBiQg0TbuiLETLXGxXu13DScG
         OUPht48bQp4Oqa/voPOGozYU6jANps7BbHr3C29fhdTDkcYO6MFAhta16TY5PLApJYnd
         X8mBZuCrn1XtaPWArNGOJghTe9UCJ3g42kDK6yRS6h0zp+8R+kuZOGqiYEUy7LpNwK8O
         xZvT6v5tbbFFpErbUo+FZ1cNZLnsDkKd2AtVJ+usor2s/sg5xcUCgOUMIQRRdOEqIW/u
         Opfg==
X-Forwarded-Encrypted: i=1; AJvYcCVTQToetf6hbK9bnsuTy3MjurjWhoVJl+enTkTn/ewXl42spVOKv212+RLhfFNDQJgQYt7qrggChjtenQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfiAUU7ALKW0L0AUAY9AqFnQJ8m0ug4WXIbfAGkxBanKororog
	gSikjnRth+4fACvlUciXBNHqf9LRtBnTUTnXO1WPZyfsjO6eFKZymSj0tWQtTMXBCcqV61iXoME
	XoSA=
X-Gm-Gg: AZuq6aJovuUpvB6ii5gqF0nSMxK1qrPTLxeCRrXPqqM37eH+RTZSlKucv8ulMl3rar8
	cTdOcyy0OiMcYVPiwedztWWbvZ2YhvfGzNgQ7PUmvg0AUjcJ2XrAhmWE0KXn+9TgZfArQeUBQXI
	eajK4SKYjpDGIliQ4XjyrDnnTjAJ4GxGrZIcoQnpxawFb5RrecTJXqt0vnkDjoeVuEe/MeLnbQc
	Mn4a9OngLr5uYt2soJvYWTj80T+nR7ST4aQW8dtJOdz+VvdUBcUcYjzB6i6Q6RjoTSFCZaMXqYF
	TUn9hvIyRu+7nCZ0ieehTMovfzXpaATp0IKFpXSJhN4WYR9uJhFjm++G/4ZlAQImP8Yimj562fE
	r4A4x33XWmN5Ja3WW7t0jJx6LRjX1fvhXy4N5AF86Is2b4rBFsTAGc/cmAglpl++hRVaBz7PzzW
	U+q14fK7TlB3NdpHRCtw==
X-Received: by 2002:a05:600c:3b23:b0:47f:8c05:786b with SMTP id 5b1f17b1804b1-4832021eae9mr177212155e9.28.1770665587652;
        Mon, 09 Feb 2026 11:33:07 -0800 (PST)
Received: from google.com ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d77f9sm9355785e9.3.2026.02.09.11.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 11:33:07 -0800 (PST)
Date: Mon, 9 Feb 2026 19:33:05 +0000
From: Fabio Baltieri <fabiobaltieri@chromium.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] Input: cros_ec_keyb - add function key support
Message-ID: <aYo2cYhd-XCcLa43@google.com>
References: <20260112093309.240905-1-fabiobaltieri@chromium.org>
 <20260112093309.240905-2-fabiobaltieri@chromium.org>
 <aYYTgxi0mcPVgpTr@google.com>
 <aYoBTEgrirtcW96F@google.com>
 <aYoZEztHrIx5CzwQ@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoZEztHrIx5CzwQ@google.com>

On Mon, Feb 09, 2026 at 10:20:52AM -0800, Dmitry Torokhov wrote:
> On Mon, Feb 09, 2026 at 03:46:20PM +0000, Fabio Baltieri wrote:
> > On Fri, Feb 06, 2026 at 08:25:14AM -0800, Dmitry Torokhov wrote:
> > > 
> > > I do not believe this flag is needed. Always do FN processing. If there
> > > is no FN in the keymap it should work just fine.
> > 
> > The problem is that if there is an Fn key and a keymap, hence we process
> > the Fn keys in the kernel, then we don't send the Fn events, but we
> > currently have devices deployed with an Fn key where the key is handled
> > by the userspace and they expect KEY_FN events to be emitted, so if I
> > let the "fn keymap" logic kick in it unconditionally it would cause a
> > regression for existing devices.
> 
> Hmm, I see. Then I think we really need to have it as a device property,
> because keymap can be manipulated at runtime, so depending on it to
> switch processing seems weird.
> 
> It is like autorepeat, either device configuration asks for it, or it
> does not...

Ok, the DT folks were fairly explicit about not wanting anything that
even remotely looks like configuration into dt. Right now the behavior
changes based on what's in the keymap, which I think is fine.

I see the keymap can be manipulated in runtime but then I guess I could
just install a custom hook to idev->setkeycode, recompute
cros_ec_keyb_has_fn_map() and then call input_default_getkeycode()?
I'd have to make that function public but then it'd automatically change
the behavior in runtime as keycodes are defined/undefined.

Would that be acceptable?
