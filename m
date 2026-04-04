Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5AD327C09
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775284551; cv=pass; b=ZFcq04bQXlDjct/uTLVufPnEz6aDB3a4oDzHiy9DC4g0gtGsgvix09tCzR/ylQYfjdsdSY48pYEar+kjp0Ya4PUKXOHwA8bb4Lz07+xkD9Te8L6lt+PZUfBCQWWJHSEeYsFCw3p1REq6ofBXOQfXNVhMmiEXCI7qXRDI6u6HpF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775284551; c=relaxed/simple;
	bh=uVzym6+krh/LgTBrpskVv5luYvR9/FZD00nHLAFGwoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqejXTCtheczGdnYj21bmzWPuPP7pjNURYjBtGR0qxP/UNRpL/NvhYL75cgZ/c0NH4FqFiUaLm8TogBmGwnJNAiJHojwmZ/UJ5sN7Neo54vzi81PBeueddcZWYbQshDsvVY/G+uIveYdTcf/gRGRjbbhA3ucAZj2WzM5Fs/M7FA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgqyxEy4; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgqyxEy4"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a2c77c62d7so2151147e87.0
        for <linux-input@vger.kernel.org>; Fri, 03 Apr 2026 23:35:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775284548; cv=none;
        d=google.com; s=arc-20240605;
        b=Slar8TxXUBI60tDke8+GTtkcLpwmIpZjRTTkbgWZUs+QW/YbpkDddDYNoSWa7l+SZ7
         3vUJ8hhfQvgLfW2eDzW2YDJ9fUsQihmwJbKS0C7Z+hlfCvdRv1mxdwzfH0OLHfV23ZeB
         wSO2OTOrpZQcHdLJyKGBAJl9PlW+0ge+gXf9ZTNiKBudhYdb+LTYvaD3gcTH2kU1GRTY
         q7oDPo7qrjrjit156uAv0Hf+BNerLEuIu6Qq67AnIHTykK9ljUebGNUacweUoXGHrhRk
         1CrO+uisOJGAypYJFwpKm04wOqtmC3jwFdR2eskehSS3BnWfYtPB5M5LonbD3vak03Wh
         FRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WqmiWU2XtdFSsfny1VWVIlsyGUTOxWwYStNu5opN0/g=;
        fh=aYc1YHr0aHTLlJDQ/u1Hj/W+PL7WlhNetwNQ9BqX6o8=;
        b=Jdpa9nKZkaW/tIgLGhOSP3bdCqp3cLWO4twDHy3mB0GBuqSNYd8LSpJmomf6w/c8hO
         npxyCG8XsjTkYHNxox0V1zN/dyZn4er7dkdptACuYeeNwzx/wApL5z0FZicajEJ8zF65
         Tag+dHP3wq3nAWhEDIlZmxHTKneBZk7+9piOFYLenyqM59tcQmRmeXMb4h0/EUQq3RHm
         3adOZ3uBH8VgCSnbrCcxKUaXI1kH11BH2Wvq50yrOX9VU/81m+VyoIgi8aT/l1wm7Pzs
         JBkpnzWadkIIstG8w2++Jsp8ydAJgy+417sCzNaO1cRodLoZrnLE5mQHiIKkFLEZfvRD
         cOyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775284548; x=1775889348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WqmiWU2XtdFSsfny1VWVIlsyGUTOxWwYStNu5opN0/g=;
        b=lgqyxEy4etEBN4JCUfnAGDY6QIkC9xqCYzz8Qm7SzIly4WhjX7ojqg0weQQHg677iA
         uAqb9+p1FGUjfIGsQsj/s/3FZ+5feFLnyWB3darhcmEQHi9+644aG09QfKUyUUM8Ufrg
         E5vBV/3xyh1pqN0sg4IXQmoCYpGMZW29XttZc7ZPWA3HWwhk50mwuXyizor4EdydDBEm
         KJpxnmxeqMMDLKJz1o55RrCGvOj4hNfkunWMI0UgBmUbAsHatZP4xuMqwkbHJKwxJFbM
         Q7jxZRz17Wfd69zyfIl5YGd7TPYDOVfwbNlj/KFvgLtKWp51A41FGBGMWmo+kqpgGGkv
         ji2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775284548; x=1775889348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqmiWU2XtdFSsfny1VWVIlsyGUTOxWwYStNu5opN0/g=;
        b=cWtTRDYf04HBJS+lq0ifQhkysdPhAq9BDDgdxTJ9L9P87VMhAk0moi+g2fB55g3LME
         wYw7N19NG499AHnmW5uVift6TVYatkLRa5MlN6NcSp8NVNTpwV3IPgHX1KiPLHUgwo/O
         tMUDV9HcWm/jZlBS+Tus5Qccqo8g4UCrY71PvPxvKCsWP8NvuBqm57DDfCXy3uuyfcw7
         zCEo0AY10Lw7+IpMYD4YpWVv9fwV2OT9N65BDVpNUug1uxQvMLV9roJWyVhM/+Ibe9wr
         jGhw23DmbnF9X7z4ochFM8px/HBTJ2S4hHJlHnAvBjTL2uh6q59m8aUXggRbvVyBiGbS
         1NVA==
X-Forwarded-Encrypted: i=1; AJvYcCWlAswxnPp3LR04PB2+lMQehlelRYKEj/yrhrWJQFrJFVjQVk99kv4uM5twlQh5q/bhi7jwC41wKCpb8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7FWWZ6JqOtiFP2ExwgYpbjBxEhKzzZ40czT82P8EAiGpQyVh
	WsgdQYn1hwPUSqARl91e/iPE/U5Nwo8GPV3XjunAgmziNC7QSN9ddZuwRhHJzYKbqhVnos0+ju3
	f8BADCNv3nT+mYhkMWJxG9cb8Z08yDB8=
X-Gm-Gg: AeBDiestNOtFMHj99qe9z6zV7piSpNI16wTUfBkhVlhL7Fyh68KT0h4qJjTTSKaQAVL
	zymvvJ2OJioHOXk3aWFHoimX/Mwk92WnctR76mnKB+oaX2AvfjSY5UeVNI/GM6WTWNGV6rpfHe0
	gQ6+vB3rIjv7LbnUpSyFlQNx2EP/KVh/kXnAMnARY+oRBZ2rMLf4pVrZceEGYukfgEGFCGTlOIQ
	/Rk6lFk9lBsdWF4YDUOCLUepCSN+Hw7C7XNGpYdhxI1lIS/j4gUEqFPAg92EYsdvQDcye9R/XJQ
	zptPYE0qQsCq9YbcpRGjxkVoMyM5GMjWAyoDZmxxMoaki44mgVMjReHTdjQKuFDQmdcpaBifzz0
	GSr5bOpg=
X-Received: by 2002:a05:6512:1096:b0:5a2:bc66:b4a5 with SMTP id
 2adb3069b0e04-5a3375561d0mr1634961e87.9.1775284547392; Fri, 03 Apr 2026
 23:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314075034.1488655-2-sanjay.govind9@gmail.com> <adCc8OuHm7wwkysq@google.com>
In-Reply-To: <adCc8OuHm7wwkysq@google.com>
From: Sanjay Govind <sanjay.govind9@gmail.com>
Date: Sat, 4 Apr 2026 19:35:35 +1300
X-Gm-Features: AQROBzCQUpmGZNxvfs1hK2d45MePXE1jEwfQynOKmEyFonRgRRy572pwa35uL_A
Message-ID: <CALQgdA1soGo6U2_pKS0RZ6smOSS9Zd-g+eMD7KjwUwz-_pAK_w@mail.gmail.com>
Subject: Re: [PATCH] xpad: Overhaul device data for wireless devices
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vicki Pfau <vi@endrift.com>, Nilton Perim Neto <niltonperimneto@gmail.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Antheas Kapenekakis <lkml@antheas.dev>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> However you should not change product and version once input device is
> registered. So you should delay not until after link packet is received,
> but until after the capabilities packet.
Yeah i wanted to do that originally, but the main issue with that is
some gamepads don't actually send the capabilities data at all. An
Easy solution I could think of is to just start a timer and continue
the init if it expires and we haven't gotten the capabilities data.

> Another option is to use version field...
Yeah that is reasonable, I had just gone with putting it in the
product id like that as it made things easier for SDL, and microsoft
had done that for the wheel subtype already, so some apps already have
the 0x02a2 pid.
Happy to change that though if you'd prefer i use the version field.

> Maybe have an array of
>
>   [type] = "Name"
>
> instead of this switch?
The main problem is there's a lot of gaps in the list of subtypes, and
this also isn't an exhaustive list, there are a few other subtypes out
there that were used for some bespoke controllers, and so using switch
at least means they can keep a generic name if they are used.
