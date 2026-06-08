Received: from mail-vs1-f65.google.com (mail-vs1-f65.google.com [209.85.217.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4A3332EDE
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938845; cv=pass; b=GentV19sbErHczQv+9gaATmjN1NgZg3oYzOrMshT3KVafMLQU2DscbPkfaVEnMV0LdgwLeLWkmBjXd3jbjGabfGRd5PSg0kWdV1nc0OXSOd4mIpw9+T1b5VFKxipVfD/jzJ/uIPU8hEPzcFtK3AwCr/Z/pgMdUCeD2wlEBrPsOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938845; c=relaxed/simple;
	bh=EXY2HhbPtnWWjy9ZRBg6fDZvGucC9w5Mnr26sUiKheY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9Fxmh18/Io7jDMvAlryNGQfnJ7LElLtXMxEWK5mqI7EXqe10o7g60SGN09m1ADjERZnPDfZl2Y0GtAKq3Q2WuhIYNhHor4SabIX+pVhWMOm4SPfO9UvgTV5f71nkzaxmoh95z0F1OkX1OC98qJ7+uMMWTwu6rNLFTam8xaSacw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaLmItV3; arc=pass smtp.client-ip=209.85.217.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaLmItV3"
Received: by mail-vs1-f65.google.com with SMTP id ada2fe7eead31-6cfdcc79789so1707581137.3
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 10:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780938843; cv=none;
        d=google.com; s=arc-20240605;
        b=HJc7q8WwIXgAzlOx46G2/UK3+9pZCwF4i3Z/mdrOUz6VdtuGkQzzCu9eZBZ4GTg5nd
         WOEKV54D/IdxZcEjCHPOVe+uvHI7PflRWG4mK9vGEMxHd0LVwaWZVGD2ylSjONg9L5H5
         q+z+HAjYil5qnWtW6uO01tTILT0h5DXmbdxeErhASQdV30hjaln2zeFxR3Dk2Hn6AK/H
         sMvVxQ88PfShnVHbK3okRyNu5p85ZxZr5/KtSkJs3alzitouaLKRx3DjnDTW7+8a50fH
         3iGmt1SVK50JcWj4vMYf0k206yL6lat9fRfd190n9eQGvSPYGRmp4DKih00Mswvd8zj8
         wFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EXY2HhbPtnWWjy9ZRBg6fDZvGucC9w5Mnr26sUiKheY=;
        fh=daQlDUpDJzaPlgjxG8Z12n8czdNCezgRnqZAbJTrc40=;
        b=hXDrGjKsZpv4dGduMS12HVNSxy0YqHqsgRGL+eTfhHu3LnIwWI+/ZSXp0CiLXZ4Buh
         9/wSL8vRcRjrzSpCAeh0OFiDb6euHhZd0dr67PkOzM8uwlu2amy8Z445y/oxrDgGf/Qq
         eaZSfICDj5z9cJWsNF7o6ST9Mg5P3JnKW4UBdjkaj2umpXbx/vlKKMfhdUjoELk6R1zR
         VCBvpVKo3j0R+M6ExXG3mOJuOtMaatFvnIkeVIq6OmR+PNc+20vEMRcBFlr4UNBu3cia
         46soZBm5Ss8/BSR6Sapw6JBKXWlxFBXM+r2H6CCvrD40vuEC5TiwKnk6MV0Sc1PV+joa
         HKag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780938843; x=1781543643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXY2HhbPtnWWjy9ZRBg6fDZvGucC9w5Mnr26sUiKheY=;
        b=TaLmItV3pzMwr5MpnxgSnNmkPat2OoIab6v6PS6WLQvUvTnuj57+fUZ0qIW1CS0XVK
         ZLdSnvTWci7PbH3SRMMaqMhn2I6hHBe99oyItvzSeasaTBNo22CZB3jSw3kuiWPqId8Z
         y9yk9BIqMZHT187iiuwA0zJeHlN6R6DBFYVCfatL7yxTz9cnTpMTk+LnxLrZTFqydPce
         gWCDrfbey8Qe2BAHQLhLDP89Oq20B1jdeALdbeqCyGWRJXUoXSYrpMI0jBR6s/7ToN4K
         ZnN1tkbWHv2y6gVZ95cQWMzIf7d+JAEgXWyQqsI+Z2hiCl7kDffhB7866iHkZ6VcR+3L
         Rh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938843; x=1781543643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXY2HhbPtnWWjy9ZRBg6fDZvGucC9w5Mnr26sUiKheY=;
        b=H7FDSAZCpdhxw4LiASxkuBdDhgxIE6lZ+n8OWneE+eDyO7+Pd59G+r9leJzhXSR9kE
         u3Us4YAflPbZjSL3JK+HSBQem7uxVebpVvVVJFsQfmtng5D04VhEhN9Wt8qUz+BzGQP5
         FBR+93NumCZv0jWapjky97hSoPERJrCcSVdfDdLDnIiwLe6a/oSTbNSCXJ9uqvy/4tuX
         mqVcoQB9uKReCJr8ePpY1YKfWUTM9SShgTeLkZ8RWcd4NysNf6bDRye6Z9lcY0kNBP3L
         K5GtZbXBd2FD9UWmPmvikXXf4szI82zHcQ+SyJS7IWI8EZx1IFbpWK4g1ZZhJxhl6yE5
         m1yg==
X-Forwarded-Encrypted: i=1; AFNElJ+H91BxxSiM/5xCxVSbLaj4c8bkXNovl03VbCY13Ne05NFvkfSldCkrLE92wMU7DEQ3fCjhrlh7Ql6rig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0tUVZ7Gh+knJReh/IIhZH9wSFU/ojVLp354leiNoKWud6+gr
	xcMG1HFj1B3Fav6/MfkdyYbR7rF1UTRHlyybaak0FFVmNGMmWnvEj4ArjFqRpxKItmoSRY1i1WD
	k9+pdAlYxyh4eOg8M4xELds5VeQ73r5E=
X-Gm-Gg: Acq92OG06yqXiVwqnsqTALJDsu9SQ5mtdNVgbyABVOfHJrKZVAR6PX4pryuOYKhSkN5
	6BsudaMGom9QMaJ1Yjv6AU2iw69/vrRNwztHg0ebf090fVMpE7PlRs5iS3WzCTnqeUg/QxPCMOF
	t7aFw+zbpS4RTDNjB42Aa53q7oIdm2sJbHC+x0gYEOf0K5x9ijpbXRuaW5/8o8Ro7A1+jBE4/4L
	tu+MY2D52NVSeXg+ulSXKvMi/A7oO/gyDRqQezomz5zsNgq72vlUISnEP1QiVN1rShnHu+yQ6+3
	o0nX9Z7pkeDWMseUkiQV47c9o+vbhWJuYWmlTajAwhd+X3QdNMU6fZ9ljdz+7SFbCe7fLTY9KFo
	DmWA=
X-Received: by 2002:a05:6102:8028:b0:659:3ae:e6d1 with SMTP id
 ada2fe7eead31-6fef194813cmr8586356137.9.1780938843197; Mon, 08 Jun 2026
 10:14:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510052107.555825-1-enelsonmoore@gmail.com>
 <aibz3auoiq4CFa9l@google.com> <86765df4-0d2d-435e-85d8-b9bd4f3ea85d@app.fastmail.com>
In-Reply-To: <86765df4-0d2d-435e-85d8-b9bd4f3ea85d@app.fastmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 8 Jun 2026 10:13:50 -0700
X-Gm-Features: AVVi8CcQLZdfGK7GkL8AIz2ceIWRoj45ZqGYOIPBttfj7m0Xg4lz5ZY8Y9K80rk
Message-ID: <CADkSEUhh1NdOMTHVsErhqzyCpDGFA-FkNFaWp94e9LnB3njxqw@mail.gmail.com>
Subject: Re: [PATCH] ARM: footbridge: convert to sparse IRQs
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-input@vger.kernel.org, linux-serial@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, 
	Linus Walleij <linusw@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Arnd,

On Mon, Jun 8, 2026 at 10:11=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
> I think this is correct, as footbridge is the only one that selects
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO and defines I8042_KBD_IRQ on arm.

I came to the same conclusion.

Ethan
