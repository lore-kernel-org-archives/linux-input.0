Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1753ECBF9
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2026 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204350; cv=none; b=EFAQS1BYje0zy9l3Q+bVwNeSqzydbwL4juMTHSXPQ7+SXDVaf3EpcuaqkGna9r9rHgKp4KmqZHWtedqgwb31jviK5e+HXxkTYyGiyWkZ8nN+4c0JNycbtk4i6Exo+wgZGLfb7VH+PDdlLrAtNN5uZG4ikJVouRCizmArfNQWa78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204350; c=relaxed/simple;
	bh=cHrIGCrLD2E71lxcn6R9T8rwGbDwPkRE47D0XFgJzv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKnTK7Q00/nBgRibqxlnrGIsaVfZzl5O9RB8shfi4zpL90P932smH37nhi5+UnZwY8ds5TzWQphnqnKhe1FyHiKUjUFbkLnB+ACy89m8CCKcxaNFnCtWpjQH/YlPymyxvubzAUuJO+WZvyVzIQ1Unay4LhxzODsrPJXK4k0VD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNXIISo4; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNXIISo4"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1248d27f293so2615901c88.0
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2026 03:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770204349; x=1770809149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYrSGr/bgBDeAZ5X1xIVgbMDj6wzpB8qLVpSIaqJT/s=;
        b=eNXIISo4aQQIBQHdlO4XbwCqot0+VXtRPHNtKHFI+KFB2jiPqVYCUg71ZNyWmtzGgP
         wC4maQro0HfaHDjxJiy4vKxGZffOBxtO7EythNtQfHnuz/bMT8Rojp1Jrebvx8BRudY7
         B+mC6/km06Kx6RUxFlISKqYRNvXpMDgBqWZqqRBv2YOqva7GN53eVsS/KvQU+hfdHXSJ
         rAer8iEs9vYZ2jNTS2TkooAIlfgCQDl8NFToJnG7AHnGBP48rF8mVuPKnkK+27qUSmQ6
         uf1xL/D9/Yli3yanC1RS4+u+K5/5X0i/Fq6Vb5B08QglP9Vg3NkIlgufKhBD+PgzxxwA
         cQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770204349; x=1770809149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYrSGr/bgBDeAZ5X1xIVgbMDj6wzpB8qLVpSIaqJT/s=;
        b=Zx7wARenLejattLgxEr6EdiAXIsRAJmwvZEJ7nnRpQIarBcCN3tjqOqLgqmnkKGEpb
         Nv96VwnEQOAIqNprqIHUrxsmTrBTJXLT33qDQKJl/dECfqW7fkPTS5qgu/ytR0G9l5G6
         VX4IBa8YtMKuThtuSBQOQoyGe7SbRzc6pqAqfw3ct3lmoCEpabRt8lfaPou9eOoq/8nI
         zmXxl4iXYr1P06GxUimxVljFV3iShG/vTGiZF1j40v3C9w11NKZDuXN25X2+5Rq32161
         Uxj69VhZVmvtPBvrSz0x0qu4Wm58FZfJpIzJf6XkQLJxq1PTjxgAA9VTtZ1nAq0DEPvW
         CoDA==
X-Forwarded-Encrypted: i=1; AJvYcCWtGaa+6ouFuQ3tL7XOYK3Bz3qs8wcOm56D+28JlRZtmqsBGQZIWVxyUuhCEhAOoGsCsyeTNNQLwwzzug==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVrN/EJ9jHuuAb7FG6bJY6JWi4sblUsd9F8AWJFVDWId8eAB6a
	TiHF3ZVd6Z2LcXJAPHr8V0DZYHn2XIc9LNpYb65IQ+cj4E3Kj1wLejbn
X-Gm-Gg: AZuq6aITVdYhLGyAX/e0JgRmfs0AlaE61y9XJrsUJmlkLrpVeIG32Rc21t8aC7BGiKg
	A0PEyrz1B3Ih5PAATPJAos/5TRu8D27Ttv7cksmstp5GtPHaXwhIvHfxoNRYutDmcyuL+TGlvJH
	hjMSTkRvaeqxWm44AFfZ749h0ydK9DJuL4x8yP7ghoce6wqDbVxHPX8u9Q+g2vfvyLJoHSCSYqX
	xGIgE+zpTeXGCjgWN3xpvwmhf9HRFttip42QP1JCq/djOcrQXYfNerM3IjkIjFfipKFk1GzoWtu
	P6aBFaO1P0oyudJmgjGmLoILj9Rb7HpWIA0g5SIg3wzbipy0m/c5GIC/lJw8j85t+AXZMnro/fU
	a/YvM9PFnEPSd2thOpx/Wou5GPPKS+jFNLqKkLII4HV09sW5dhCZNSUX71GDFvKaeNnJWNwiGfn
	KJcsSNSixU0hp8f22cMK5ONMhDJS7KtRFhjnrkodjnfsMzE/2SeIKi
X-Received: by 2002:a05:7022:325:b0:11d:e25a:d9ca with SMTP id a92af1059eb24-126f47bd21cmr998880c88.26.1770204349187;
        Wed, 04 Feb 2026 03:25:49 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:b789:f5e2:3597:9114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e111efsm1602698c88.8.2026.02.04.03.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 03:25:48 -0800 (PST)
Date: Wed, 4 Feb 2026 03:25:45 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Raymond Hackley <raymondhackley@protonmail.com>
Cc: linux-kernel@vger.kernel.org, Markuss Broks <markuss.broks@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] dt-bindings: input: touchscreen: imagis: allow
 linux,keycodes for ist3038
Message-ID: <aYMsshqLbX3DfIO2@google.com>
References: <20251224100941.3356201-1-raymondhackley@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224100941.3356201-1-raymondhackley@protonmail.com>

On Wed, Dec 24, 2025 at 10:10:48AM +0000, Raymond Hackley wrote:
> Imagis IST3038 provides touch keys. Allow linux,keycodes for ist3038.
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>

Applied, thank you.

-- 
Dmitry
