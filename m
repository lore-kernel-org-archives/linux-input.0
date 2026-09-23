Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D649B210
	for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162851; cv=pass; b=s/fkA/ElaKFilQ8Onxz6eMB38XaEvj3Tcpcmj/uQLnbRWx5Eshu1dzjTK6EpgGdY5opwWp65ZrIQtp9Ndtk/vEVILKfUc+DU3v6gyKon9PmSuj9jSBvYP/gS4IZqY5rM06ceyV8BYnyuUnZoO+t+SoafwEPnWeG/ZFzU9SXxapA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162851; c=relaxed/simple;
	bh=vvqH2hMZEJwHoLtSUckBQaIVNuafjtZTn5EFVGWbHec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uhy+5rKwRHUPCd6EdmiRidYuAJiuyPtFL1zDpK0LnIfVx1EA9ny2Xt4jnTGfszlwLxytC7VVkhRg12XGKTJRGAHVo3z9q/URezyjpuiPvhcK+d/jPj9So+HWSZTlOGStHfcLW1lAKs6cEwLoOo+dlVi6ILotIiJ4Q5Qb2FLpqqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4mfNrap; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4mfNrap"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93bef17c191so62942085a.2
        for <linux-input@vger.kernel.org>; Wed, 23 Sep 2026 04:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790162843; cv=none;
        d=google.com; s=arc-20260327;
        b=pdhkSblojWyeVAhETK/237I53A6tbatY5OFQBBIzMzXL4UFk7la/6L8upzzhWZ+pJ7
         RQPgcu7vxqJkHSAE2kL/OEhtzhtPHiJHfYabcGqjP4UiF1u/dovdvLRn4whhce+uqou1
         T5FomFU0u237EnyNXW7iz6rREaYMe+9hbX1CQI74/o6NjGZeeVnfti87JUqR5WkJ+0pn
         pL4EDmrnyqK1uMwQsuw5IqbUksa9NlARYt+XnpFxcI0Tz0ZbrmwfKUNBlXDnRaUnoGpP
         JJRKgM2Ui8AAVYHH5SIzpbRz0lADx+LkeNOjmHDa380KblST/hgqpkAMzfer5UE4a82e
         nmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vvqH2hMZEJwHoLtSUckBQaIVNuafjtZTn5EFVGWbHec=;
        fh=i0J7Vrf1Dtak+VezafgJcq22zN+YUptv8kxlFHMB4U0=;
        b=q6WUkmvB5PIy5nXfNIncNbI9A6GiQQO/K+Mt+rO7Qu59kHuTcxc4UhjY5Ybp+ZP/ws
         mh7Ob/J8oCWW7SKaIwkDSHW7t5zZ49mQM0bA3a2WGB1luSeeUIzy7QAy/HQEfGDNv078
         I0oxIDMtVG1rVx7eMlHl4V8PRbcIMjoDywOKCWA7RNIkA2zX0iiHFaB19dhq80NekVTS
         6sW5uPCpKQWy0cnuCawU8A2NPBVXWxBTfLMNNkZNPc20wfqfgoNMKGSb9AxVhr3bGAtJ
         KQwOi+GWhsyXA4NRyjmSiRhd9NpAhx4+l/HqcSBCL/lJaWpRvN5UUK0t89Vgo0UaLcOJ
         a1hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790162843; x=1790767643; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vvqH2hMZEJwHoLtSUckBQaIVNuafjtZTn5EFVGWbHec=;
        b=Z4mfNrapqJ9wRanZYXqAb8A99Yv1ZJGN8N+k0ni3mF3vClHWzeFwdackyt1IG0tu8e
         CtH24Xs7T2MGpo2WXSJkhHxqnTuCUJKVU5Q+L4xdjO6LlmUHZ9d81HP7xtHElCpj6nFf
         ictghZ83gUBGa12U4gxiH+Gv3OOxGWZE96mSwj8oC0uIXvnb1vySOo6zUqxYa99L2S3p
         /PyMruZBGbNVjLMIDLYGysXgYP/FE8+NF4IH6j9+9/cTuwkqQ3OjF+63HktzJoqBgZWc
         iC0G83LdqVQ2kvWByITI3iCfocuQILTxHuxhpGBzn9eYb5gvT56Uyw5/XF90sCY1obwC
         kldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790162843; x=1790767643;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vvqH2hMZEJwHoLtSUckBQaIVNuafjtZTn5EFVGWbHec=;
        b=E8u+WAiAJO282ESlU7kjip9GDxuIwpiRSVfg2MNJTCh10DzjpGd7rR8+o++nMLRf15
         YaJkMtSkTaak5/1fbMtWj9u9N0P4x1zELx6lt8FXKAS4SWDaRh1Z6rPxMReaaj+foo7f
         aOo2szULmWKGMave8XP/skd5I4XPJagjQV09bttHvReTIsBKEcOY5zGyTNq6EUGo5E/H
         6Su7Olz+/f8KYCIf29a3kGxOmoYSYi/8vLscqj/582ROBfT/wDDNSg71a4iNy3tII6qa
         BqmKE3OPGYRqep6+i3ipMthLEJy1e4FTzyzBQbzVzAZmgGeaGgjCAKcbJmdQa3o/41rA
         SwBQ==
X-Gm-Message-State: AFuF++lsnpaK7HqWYiPrCLnIoCh599YfFIQHy3V8yCWP4gnzNskl1Tt5
	VZ242y/fDdwi5ZSEeQHuMgrrj/UwerPRnhK0y8F44zubHCjtI8iYI9m6tUPeEi/zYCqZAxDTbSh
	IQnU9TYP5SiXTJVBjAZBhyR09BP3CcXY=
X-Gm-Gg: AYBFou1whA95aRSSupUskkm9Oww8RQ8kemt/QjvYWu+F4KqXD0Ddw/+VV7P1PD0gSt0
	P1iMNGUwI8z95lRPeLJBfxtbCSNpnMKY38yjyoxPghU5Rd19C+xOhlz2PuIlcEVBYGUryeTLqhz
	N+7CZ2RFlzcjE0sHASFHP6FPh5SkJ2l3a0pY9JFoMWaHV+lAD2QjQw7+rQrfPHvHDUFc00xpc1r
	+JRql5AxfIBRJFcSEol+Ry2zGxmBXorXON22EJ0YUL6gk2vjJqTQYkZhc7owrg7IORl3crFMI9L
	BqYYAbqMocCVW7lAWllf6L/DL0f/AVAfV7r5XnvsJcuqMafeeAyWTWIxLA==
X-Received: by 2002:a05:620a:2a07:b0:937:2d64:57ae with SMTP id
 af79cd13be357-93c24f0fcafmr343702985a.0.1790162842832; Wed, 23 Sep 2026
 04:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923105757.260-1-anykey196@gmail.com> <20260923110700.C331F1F00898@smtp.kernel.org>
In-Reply-To: <20260923110700.C331F1F00898@smtp.kernel.org>
From: =?UTF-8?B?0JLQu9Cw0LQg0KHQktCd?= <anykey196@gmail.com>
Date: Wed, 23 Sep 2026 16:27:11 +0500
X-Gm-Features: AclHuK_8X2-F2vjZ_B5cnOVtrt17GVI8L-zKCbR7jOO-TwWiv5aNx_f1whnBR8g
Message-ID: <CANHPwATb77aewMK=_twoPkUcWy44M-=jcAN9XfeZwetJY=nbTw@mail.gmail.com>
Subject: Re: [PATCH] Input: axp20x-pek - add AXP313a support
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, 
	linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is already addressed in v2 [1]: the AXP313a no longer reuses
axp20x_info. It has its own axp313a_info without start-up/shutdown
times, and the startup/shutdown attributes are hidden through
is_visible(), so they are not created and no out-of-range access to
AXP20X_PEK_KEY happens.
