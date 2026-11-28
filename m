Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795847565;
	b=ueq3VnkiTj2bxIKMsHDysXdT/OngxmhZSuvfa14oFDrLGm+DGs5h0cCYOuT99BYetC8N
	 JJYLNrayyTcDKkw3w8lT9FMkppvuTHhSOmPSkrAaSkE0ivoo3cj9xi+vkBZJW6t5KgHi2
	 2T1Rn7aGhvlGrkgk2d71aNFIRkaMiMfeLAUHYSElfcj9b+IJShv+okE803ySx3Tt9flIU
	 T70sbmD0eXOwR4+eJ+eaC9KgCNH6xOb0f8Ac5uo3GodMlOMF5mdSlcK3P14BSFlLTG6QQ
	 7BY4+GtZvB0rou6BPtJdUITz7h4j9xYR+mFZuXMYQ0Ujfvoo8ZDK1f+iqI3znxVa1Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795847565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=G/9/xCXzLq9nfKwGAL0dNahckVdBItuM5SsizE2GR1o=;
	b=bnr3Wr+8oF+Tvl1CZKHU+B60OcXsMmsa+LVR8TpBdr6/p9KqxfuaCcRPWsP53TSDkkwO
	 xaLkWO4X8SCwVenJcVVbj4NdtmKee+n1BM6P8139gU+qx9jHr+5TqLDgMVNJ6BhqRoEmJ
	 zsoHeRQ7Y2VXZl+I2J1SxNOWb7sgHelhIzOmocrfWdZw5xay3m45A+gvl6z04FaDbt1rk
	 GIBDBD3Hy876bmoqAjdUgIHiZepKZ75kMQs8thTgdDLUeUWNCz3JgdrlMElQ8fL9psdXS
	 sJ7o7hLipXHSEEAV3c2qIab9G8v/GdAL9PiFkJhAVnSkrvxtvG/RJP9O6MdLNtO6oZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yfUqxV2c;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12680606A31E
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 06:32:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12680606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yfUqxV2c
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3282db206d3so7304614eec.0
        for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 22:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795847564; x=1796452364; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G/9/xCXzLq9nfKwGAL0dNahckVdBItuM5SsizE2GR1o=;
        b=yfUqxV2cZ62OLs4s+VB5qKkMOt8vhpmppUzoJNxqzUEv2jQLQu7LNP1eReCS1+scMl
         y1p90SiR8V4T+JtZfzocYxpQQZ33M8M3KaDAPL2Xgu22vGk5Yo0AhuWwUi/zfecSyszG
         u+X70pyIbR2p2DfoJ2LgCe4LVmfOfF7UfkkT+0wFFaExiaNdSXTNQT02vq0afSroGnkQ
         Cezta8AXUB0f/2RjdGmlPbxWi/9tVmpiAIqU3KyvQQWvGkXC4VDQUBBTUnZzt3B5VYGv
         SVNz8bhT2Gim7kTZNYoZDDxHtlc6qVp+Xq9SToyPYr5JYsrje/oC4s2tTWCKFEQ/uDHV
         GEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795847564; x=1796452364;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G/9/xCXzLq9nfKwGAL0dNahckVdBItuM5SsizE2GR1o=;
        b=YOA6kWmWU2krM8vOfTuru/MGFp17OeLoUrT6SMc5bPWMapNIsb90xVH1HEYSGqNVks
         rBRdw7v+YxSHx+g5F3BKeYs4ct3COLoGWc2aQGmnnvS+a4y5PxsBZoDgtXYKG/g5TVhP
         4ORJkG71OmGNUpdMUcabOGmbTNgysTRcsJnKlnvcwQylbbYp6Z27Ix+LllcTEtGgmQ4K
         TC42geFqVIrBtj5JGvWaLhs4gyhQ87PXy8vr8bPtp4BIh7crnAgoQDu2GDsVOl5wY/rt
         lStkhO++y790ywnDda8fdD0WiP92Bz1gto7SiKbL3+26/qsINFxaGZF12LhAwZEjvAwA
         caXA==
X-Forwarded-Encrypted: i=1; AL+hErGo3v34ouZpXG8af2HeY8l9Oi23uXxjHTmCfbXNGAG/x5HieSRzauhlZgyeUBXK4YZqrRGBFS0dsVXeNA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/+d2J2XSzh/5qR2eDJaqUgvDjL1e/C+ER5hdWQnW5K3Yh6zrlp
	uyOIMw/arRPSkSzOMOW7QesQ4hSZJzftXXxQsUlSpP2HRP5ssyVyXjub
X-Gm-Gg: AZFdTZeV90pgVEiP+DoOHh0rEyQtSCjToYjMGThVD8fhpIx5dfFuYfC59ahHt0Fz7Gk
	hLKvt06c8Bgc6MtA8r5i4ocyf+MwmohxklOXczGHT6oaEU8IcdoHMQ2NZO/BT04w89fsLoW/0VS
	jGiZZUB0UwyqOPubvLyOQyHxwnyscLEr/IIU43+59gEtP/qNQzJuHbz8wI1ci4DMTbyjU1F/Gu9
	tIrVh8wY4kPoRc9gS1xuEv+1fOu6UUkTGYevhtK6BnhOPVEXP87d0HuYID+rT+vjRA5kEmfpFWc
	z0n98RAfrsqrh/Z46Aa4W+GgLnOF4jvSyhwF8I7HBFVuGRKixtXI1E6HvTPREfJFzs8GSrVF70V
	cpvS52JLvKjxxiW824dogn6Mn45GFoeXKF5YXowdCSSXljFrftbv6C75buDeklOcU7nPJx/Ubq7
	b6Y7Ky81nRuFB/rv0BBSmweXhPA4yDMhuZheobyvJh4RpxkLdrh9wj4+GQ/M7rD2C55W6mLQtg1
	WnQ08YIwYIJIDNfKPEMNwXjyAkbC1V5vEICaVDRYdBBYnE7sBhMfFBsPsqLsuqvg3AG8L/oSLhT
	muw2Rduo9Olfxo9mmz7zMEnJx4JECqgisLeZGiMyvFNBpGWfVi5TJddZl1ezl6qy4jDwZA==
X-Received: by 2002:a05:693c:80cd:b0:385:b8f4:756a with SMTP id 5a478bee46e88-385b8f47b36mr27236869eec.12.1795847564106;
        Fri, 27 Nov 2026 22:32:44 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:aaa:5a07:6335:86c8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386f676c3ccsm4242369eec.12.2026.11.27.22.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 22:32:43 -0800 (PST)
Date: Fri, 27 Nov 2026 22:32:40 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	Ronald =?utf-8?B?VHNjaGFsw6Ry?= <ronald@innovation.ch>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, Eric Miao <eric.y.miao@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, 
	Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Russell King <linux@arm.linux.org.uk>, Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH v2 0/3] Input: Fix GPIO bounds, work teardown, and
 suspend bugs
Message-ID: <awp1fzBA40znp66K@google.com>
References: <20261127145209.2884170-1-lee@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261127145209.2884170-1-lee@kernel.org>

On Fri, Nov 27, 2026 at 02:51:53PM +0000, Lee Jones wrote:
> These issues were reported by Sashiko.
> 
> This v2 series contains the remaining three patches from the initial
> Input Sashiko bug-fix set, rebased onto input/next now that the other
> seven patches have been applied.
> 
> v1 => v2:
>  - Drop the seven patches already applied to input/next.
>  - Drop the redundant zero GPIO count check and stable tag on matrix_keypad GPIO bounds validation, per Dmitry Torokhov's review.
>  - Switch applespi removal from cancel_work_sync() to disable_work_sync(), per Dmitry Torokhov's review.
>  - Update the Fixes tag on the matrix_keypad sleep fix.
> 
> Cc: "Ronald Tschalär" <ronald@innovation.ch>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: linux-input@vger.kernel.org
> Cc: Marek Vasut <marek.vasut@gmail.com>
> Cc: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Trilok Soni <soni.trilok@gmail.com>
> 
> Lee Jones (3):
>   Input: matrix_keypad - validate GPIO counts against matrix limits
>   Input: applespi - disable touchpad registration work on removal
>   Input: matrix_keypad - only stop and start active device across sleep

Applied the lot, thank you.

-- 
Dmitry
