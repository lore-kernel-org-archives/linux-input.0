Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62F3876CF
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770666804; cv=none; b=d+oGArAhh1xYHKDuHEoAZ66oyAYkQyhpfWWiSvn+w3wHn+IJV0WT0N/oOoFY9YawW6VWN4T3VIbtsjyR2R4dvlaxj4sl2uNdywnhlX6OWp71K82WzW9QiS2W1s359+J57YKkU48WjoR6WhEPpgH5JRxKXz7x0XrjgOkRn2kYETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770666804; c=relaxed/simple;
	bh=qsOoJypqm6WAX+ButUfaboUhpaZ54vhFpFpfnB48kCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2u4bKS2zwQsuzgCGrXVXm8p2RO1bifmsUBtbucLn1ZAEMoJLJpQ2orPhg/fAlBhMJCNs5hkB4XKIAiOuNltAJ/sfSycIRIxvKGHx0YlUJr7NouC3SYgwI0joyq2xV+S71GP5Zg5C893s2mc8dRk9cOhOzHyBf613Oes59pnRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6YKmwQv; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6YKmwQv"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1270be4d125so679433c88.1
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2026 11:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770666804; x=1771271604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BwydA4iUO74qwBfrwUHAcE351+AL9tRs2Ti2OZrDnSI=;
        b=f6YKmwQvSesbnZPs6YxRWF6q2cR8A2629BMg5kOpJqs1tEUmyX2ncchVWCeFB7naJq
         ava9OcIRovOrUY0P5238QfPnEbWpU/WuDGITP7bdv0mlDXFPvRjWAqG4kPjJYtaeRb2c
         1tAKji+FWHL1cfkKYYQc2AOkkPe9+ybMrVqLr5gqetmmUzpXQkqlLpdbIfScpejAdBAT
         fxyasMNRPK9KCXHguzocfNnehet6PylmIluQ966sAI8NybnsMD7rjzd4okQL8YaayLmb
         RskQ+XTAU+MziDnUy8p52/nlx5dlwax5xrxX5id6oy7HopNwK+QdeYSpE1XVhV/troGV
         GRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770666804; x=1771271604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwydA4iUO74qwBfrwUHAcE351+AL9tRs2Ti2OZrDnSI=;
        b=Cy/s4R2xw3oNc94NHqjnGNh1xSY+d5Yi3SAg/7jqNLduJ9YHMBUPaSXjI8stuYIB36
         C+oSjYQ4HimqE9ZP72Qwck+ItHnQfRQlQBrbaKXYNnhvoDlx/mS4gWxgLXw0Y/TbCgjA
         R9U2qPZ0Z6UlOasoZCvJOkQJFMDxu00Vd2BA90OVQFp029CqL59xDkAUevzxxM/CqOxL
         BU4Mu5kgjsVN89NUttCpUqYilOqEhpLw8ZELXofGt5KjADQxnspTCV2QtgFYM4C2037Q
         HwvIeT0yLwmZop6US9G8Ofj3/A2cxBmV/TBWle/844dK5CLo3ofcKLPzwMvCeI+XRkPi
         hg6g==
X-Forwarded-Encrypted: i=1; AJvYcCVhVph0OWW6h2qWpWvMFVdrmyzzXcDkAMTO+9OJhOWuABQ7EB6C+kY5+5KrGInoMiBi/QgAaVtw9rrU5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu7Fq0UBrekqP3vfW8wRF2LBuzFs+LNXMxxOd0y9ryXcXm8uHr
	XkbJhGCLnzSsoJO8txAqx2/lYAz9CgcGlyWORjPBErK3z42Zbahj9g1z
X-Gm-Gg: AZuq6aKUSNz9ksg8+e2QVZSWbJEIQyLw6P2b4HUxmZ3CK48zU9dRtjgUw9y16ShttuF
	GsXI55JuasFcPT0HodDneCJ0U04r+HZekcNQbFUiz1QdbLJQ+iCTK8ROnn9vYT836SAKrZYOXuF
	pCywcO6zhr4P4f6WdpKQ42vpo/6Cc4UUFPyG6+CSHwPtIlMmpnhF59yJ6+LjBbcuiBnbrXO7G2f
	RoMphe9AKiN2ZR6IuJxtjce4BFz5WtbAHLe6UyNA2AAGgBPKSgV93zJxMP1HDkoHfUTqhf3FeAI
	3uQXqZB5wT7ioraKEVz5Rbe2HOgIkWmVrPGouTpNgM4w0ZoSvYGf83XaFggv13VO9OTz+kCym0T
	1lINruwBhO2bLdXREufBYCy6gpENtmUrY2VWZnwk6iU0JxG2EkQ5CQ+dbTy9Q/a0HHVEbdN3KMp
	AqPuP/asKhBFtvMAa9uBu8AROc14fdz0Kk2fbZ8xJQegjrYuvuUFgd
X-Received: by 2002:a05:7301:3d0d:b0:2b6:ffb9:9633 with SMTP id 5a478bee46e88-2b8564a69a5mr5511786eec.15.1770666803737;
        Mon, 09 Feb 2026 11:53:23 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:616e:78a2:cc03:4be3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855c89695sm8073859eec.31.2026.02.09.11.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 11:53:23 -0800 (PST)
Date: Mon, 9 Feb 2026 11:53:17 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Simon Glass <sjg@chromium.org>, linux-input@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] Input: cros_ec_keyb - add function key support
Message-ID: <aYo61iE8OWggDucS@google.com>
References: <20260112093309.240905-1-fabiobaltieri@chromium.org>
 <20260112093309.240905-2-fabiobaltieri@chromium.org>
 <aYYTgxi0mcPVgpTr@google.com>
 <aYoBTEgrirtcW96F@google.com>
 <aYoZEztHrIx5CzwQ@google.com>
 <aYo2cYhd-XCcLa43@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYo2cYhd-XCcLa43@google.com>

On Mon, Feb 09, 2026 at 07:33:05PM +0000, Fabio Baltieri wrote:
> On Mon, Feb 09, 2026 at 10:20:52AM -0800, Dmitry Torokhov wrote:
> > On Mon, Feb 09, 2026 at 03:46:20PM +0000, Fabio Baltieri wrote:
> > > On Fri, Feb 06, 2026 at 08:25:14AM -0800, Dmitry Torokhov wrote:
> > > > 
> > > > I do not believe this flag is needed. Always do FN processing. If there
> > > > is no FN in the keymap it should work just fine.
> > > 
> > > The problem is that if there is an Fn key and a keymap, hence we process
> > > the Fn keys in the kernel, then we don't send the Fn events, but we
> > > currently have devices deployed with an Fn key where the key is handled
> > > by the userspace and they expect KEY_FN events to be emitted, so if I
> > > let the "fn keymap" logic kick in it unconditionally it would cause a
> > > regression for existing devices.
> > 
> > Hmm, I see. Then I think we really need to have it as a device property,
> > because keymap can be manipulated at runtime, so depending on it to
> > switch processing seems weird.
> > 
> > It is like autorepeat, either device configuration asks for it, or it
> > does not...
> 
> Ok, the DT folks were fairly explicit about not wanting anything that
> even remotely looks like configuration into dt. Right now the behavior
> changes based on what's in the keymap, which I think is fine.
> 
> I see the keymap can be manipulated in runtime but then I guess I could
> just install a custom hook to idev->setkeycode, recompute
> cros_ec_keyb_has_fn_map() and then call input_default_getkeycode()?
> I'd have to make that function public but then it'd automatically change
> the behavior in runtime as keycodes are defined/undefined.
> 
> Would that be acceptable?

OK, let's see how it will look like. Exporting
input_default_setkeycode() should be fine, we just need to stick
lockdep_assert_held() there to make sure it is not called without event
lock being held.

Thanks.

-- 
Dmitry
