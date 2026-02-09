Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891D29B77C
	for <linux-input@vger.kernel.org>; Mon,  9 Feb 2026 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770620341; cv=pass; b=KWJkQQcZy/nbSVFTaiA3lLswE4f48JiWLD3Ik/lYagSc1NllycjfVn9P8pkLqbKNf00yisvxrv19XiJ4S0n3cr6zSIilLuT9tAfS4WM8cyVgS/elilJnYpfFMx+jah64sBVlpFEdolI1TakowxBdHuWSh6vTaZw+iQ7tDKW2c7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770620341; c=relaxed/simple;
	bh=OdC4gfmtlISlaD/MiPV9jEzCIywYG7Guo4UYuWE7toM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+s9KBqTlvqdxTec8qx6axYkgTf36WWr6nb4qO+lrhv2NR0mOhWUdsa3bu9CYQ3E7Yom4S0788N/7bnGzvsrCXhA/HbnF36hmlrt1P7cpxA9Hd2wosPUWOb9rULQbUWuG3oG8jH6VKH645mVn8gadIVDdeN//8xnz7fMVOokkaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=qITmyBjo; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="qITmyBjo"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7d196a2334fso3511370a34.1
        for <linux-input@vger.kernel.org>; Sun, 08 Feb 2026 22:59:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770620339; cv=none;
        d=google.com; s=arc-20240605;
        b=Ljexxk6MvYcqtl9mQ/ifagd7+nGImOQWsqge3MafexSPOgXiDPppqwcZquoY3r4VXz
         bI8MELQEjapKU1jAZwT8MXGIFaO9vSklG04NRpIFvVxrd23AZhwNUcWMfYz/wSwJpey7
         GPGoGHRFqhsLNnyUDK6kk9tGmL527G+vUFDFeZhbpsyN7MJSgCURL/LAmRCdVyV5YDoa
         nd/tRQoTPv0vbiVr7Chnj3LAI4FZLS+foLbcFGfEEUdnNTrLDjBn7e7r2zowM4K0vzVF
         PH8TNNp9smwbpZkuXT7iH5jpBuq8KytWPVRrELgR3vPSLRjIf4pPr28WlhuVACLYqoJz
         UVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I1SMYdZ8dp/P2Ki/wvhm8E6SrHepASqAtrUKjc0LItc=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=HFaId+IuTyQBfK6tF1QVfDR+3pAczgxepV47yUa9H1lMpPsI4kxm+9COczPXGEEv0t
         9eTBwNCuTzYr1jXbrxBLDGKqWwYW8xHmKQm9s4IsNM5fE4T+g9gFzUozS/ZAbh1tWR8B
         lJIj9PIG6i5Vs2jIGgOcE3YP22/ZJF/vcKiWwhsV8BRu01l5C4W9vgM/Rg3Rs/re8iR+
         Tjfl7rhyilwHiRHBHM6UN6DpErbmpmBZaunz2iMePFz/lU7frPqe8FQ/FSOKNXoi/KOg
         Sb36IbNKRgoqueMecb5Nc6v5KWNfQNA+I+8Eaw7efo0/zyQ+LD8tziF55e9yl74en9ld
         5+pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770620339; x=1771225139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1SMYdZ8dp/P2Ki/wvhm8E6SrHepASqAtrUKjc0LItc=;
        b=qITmyBjopqYL9qJqp855KHrbvLazlVPTFYN8Krv3hjNW37PEV9GITdMuR/rOJxpSCK
         EwbJvfHkt+LdPW3M3+pOLjcDOmCXyLrmjh2oIhElNCVTf3467VUvvf3UCXiWMsktqdWz
         50QqbWisIx1/XPIPJgbe2PcsCUHmiOK2f14JsdciiyWOj5F7RQWPl4paxy/XPT0AI0ak
         Jt0g84XP5CiihX0kTOS+tEF/Nkf3CoG372p6GbKS8ZfDGx5KOhvzQbHKk0nd9Ab3cA9F
         aMYAO/DsoTy+HtkmT7vlNsd8xJ6kTMS8OZNq0v/jQl3LETSUhlvHAPZVxi/27u2Wb1br
         5riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770620339; x=1771225139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I1SMYdZ8dp/P2Ki/wvhm8E6SrHepASqAtrUKjc0LItc=;
        b=KBarCGaRcIIkYvRiypfRMBy05KXbM0JNZ6MBt8zStOH8xCBdGvHiRpnHwuSO0yJRtO
         LK6/rC0Hee18gbKvGAScaE2NZyNlT+t+oSozY5CxI7cQX3bMwArtpCmxPd9BHLQW2IIq
         E4t5YWGkJ7cnKUUrtlL4aKvUrv+VWPAjLJh4PaEaWGK8qTQYfhpvw+ie7QBIQsFEcwaH
         nbSO6WUwMjoIZje364ufN+6U9h6h/X+Dht/9x9VauGcuHIwW/UVLOT1D163GXLT2Fq+0
         BsBvARq6pPz1oqCWxy+W9Y3WUyahjBZDDUsy1xOPomXvtP1vLsq2w978EooVG5YrfooX
         GIjg==
X-Gm-Message-State: AOJu0YweY+x+6N16FbNU/Muo8rSnGqeCFnDamhX7TcFqMDps9X2lP01Y
	q595opVgqm9Rp5K5KfX+M15M7c33MO29QMh5Dgz/2YdGvI6Wfk5ktqXwih5QEhFaOcFtPljWKyf
	2gVNPwiPX6+3eQyWofaMB7MJmxew4brocRi1XacPU5A==
X-Gm-Gg: AZuq6aLr2bFz6xb72p2ATcTtB3s5Ie5/KrVFZeIjDdkNXEweVj+J2YZd1Zfv8Dcr6Lq
	mqFCy0k/tPsvbesd1RX8yX3IAI+lzYQtITGhP7PPduqxgFt4watU5sFbN/1Y/ClESLa66ctK20M
	SlfztwIdSiGYCmDGAYH6uSSuY99W08YqIMNDqEp0x0sw+cQGynrE9AcMSMsGryh2jUxHhqKQ82u
	vC+fhcpywZeBOyc+buujQM3BkSKr5tXFGnQL4qqpAuvvSdbbhng/abRukwV5dkrLVKXcd/QVpuq
	GfhFNHVxFfoOpIovrn5ePXrDqp19eFUQLWSATt4vHKfHWfTVw0M0mM7wZ+xs
X-Received: by 2002:a05:6830:3146:b0:7cf:d075:2674 with SMTP id
 46e09a7af769-7d456acf930mr8094542a34.15.1770620339675; Sun, 08 Feb 2026
 22:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202220223.2471730-1-n7l8m4@u.northwestern.edu> <aYHEzf5nYpA1H5Cj@google.com>
In-Reply-To: <aYHEzf5nYpA1H5Cj@google.com>
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
Date: Mon, 9 Feb 2026 00:58:48 -0600
X-Gm-Features: AZwV_Qj2vKQgPoQ5tFO1HhZLWEW2eCbpjzPllJvZnqYYD5Hu-EqwgQ1BVaaoMkA
Message-ID: <CAMFT1=Y+hNB3-oR2rLPKshd1US_W6gTWbt1o5mvoL8ysH2=nNw@mail.gmail.com>
Subject: Re: [PATCH] Input: cyapa - fix missing input->mutex when calling input_device_enabled()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:52=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The driver requires much more through conversion to handle potential
> races with opening and closing the input device.
>
> Thanks.
>
> --
> Dmitry

Hi Dmitry,

Thank you for your time and comments.

How about we go with an alternative approach, add a bool input_opened
field to struct cyapa, set it in cyapa_open() and clear it in
cyapa_close(), then replace input_device_enabled(input) with
cyapa->input_opened.

I guess this work because

- The input core calls dev->open() exactly when input_device_enabled()
transitions to true (first user open, uninhibit with users), and
dev->close()
   exactly when it transitions to false (last user close, inhibit with
users). So the flag mirrors input_device_enabled().

- cyapa_open() and cyapa_close() both hold state_sync_lock when
setting the flag. All callers of cyapa_enable_irq_for_cmd(),
cyapa_disable_irq_for_cmd(), and cyapa_reinitialize() that can
  reach the flag also hold state_sync_lock, so the check and the
subsequent action (power mode change, IRQ enable/disable) are atomic,
no TOCTOU window.

Thank you again!
