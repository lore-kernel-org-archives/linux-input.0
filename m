Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8187C380FC3
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785822709; cv=pass; b=seeqadS6iteJ+VJ3w5ElTKbRBkVOuE4VQhVUaXdsALLL6F76OKgSykFEG6vOtaTZu6XwADuxMSqpQw0obLm60ICy6KQm47c9Y3f92kbGXctEs+b32E81SysxLojzR68YgKIZNNc5go7F0DRAnhVHQ6HfMFJW/99SFIIIZaiHerU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785822709; c=relaxed/simple;
	bh=WDf824U2xsDWh+g9mjzcBbcDiCTfCVOWztCK8BOJw18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZV+SB6CG68LTv6+RhE4MUenxkFBz0t4d/lLTxXzBl54/wqeNaaqbKw/jIQulqWYXfnR4eVl/uKq12EZ6QGinRNUsVwmQ85kf0rXrmdL44EZxOWgXxeY9hug+4sOdrLSTZJW8o9muh+DaNU44rcfZ46fVkjWzE/fDqQoBbyU7oT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKIiC9cT; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKIiC9cT"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8487214ad2bso5894205b3a.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 22:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785822707; cv=none;
        d=google.com; s=arc-20260327;
        b=el7Xi4nNd7LiW61h5u6B4cmUONXbNN/ZMKlWk7X2FSMem4uFQU3/dCJCsA27SZ4vAv
         bGkWCJEyEbFIed/S/24fGtxTCKgZ4rebuMHFqtjxs3IaluyLptpclUTVioTxT0xar86M
         D94paMiYctsUtif4E+x6zWfRR2BwVSCu9w9bulHnOSHKCV2eBi4eAxK3J7gWp3Wz8k9E
         hIWtizLfWaA6lc7NB3pZJ1n6PUHyceiG3Wu8rs0GaJpqi6Mq15ce69nhwqW1Qf7KHhOf
         jaP5MQBL0T0rBiGkhNYneq/QUcv0H3qMRuuIGA6wMfRUR7tmB5jmqBeJe6C2lX7w/pKg
         bdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YbSrywpWPl9l/WB4sN4GQ7+YbQ8bmN71lrzXFRNMDcM=;
        fh=8Q4MPaufHYyTqkRBbYSgcRTsh76qnTM5kPeEn3clURM=;
        b=K+Ea8oCzJ2k0OmYCJRM1YbJLfZ0bV2bjA7TdsbZ2d7klnkgwIqWjgS3piqI8zCa6bY
         dMpBW9KMeT7glAlZQEEgJIv+dIEgcg0fq8ruRWR6o3jX99jxWF92JPGq4rLIS+c1IDFQ
         JtnRIRFDzPmofT4PDEd69QuRKCRclUWJUWL4UfzwH78a5FN040002ABmzRYHVW3N9pTa
         oFjKn7EaCBKLi7XHiNtLnZH7tu9XNPlwsy6SAP5eGRKjK1DQOYK7syvGOFA4hR2mWIXs
         0MNLOuIqT6A9ORp0ubaWOJlk0lbIIkS9EgAmemgfHGlRRnZJ6W1vy07dIjdoJnpJxEyb
         F+9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785822707; x=1786427507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YbSrywpWPl9l/WB4sN4GQ7+YbQ8bmN71lrzXFRNMDcM=;
        b=JKIiC9cTT12PXBnZIYQEo/u9Fk8Eww9SPfiO/tlce4BMopDJ8LQcpLJolM9qr//YaJ
         IF3iMWPv+3h7E2ZEybGPXbuqpEUY4OKBj6iLu+MREULcgH3MH5XgKaaPcVICCpn2tk6+
         cTIA1QhzdR47Od6bZpCMN2x0YKTZGuUzzP7G2upWWFRCMopd5SyjEoRuqtd37uVrIrcz
         LIXfFOEtAWb8DyXXdc3DPsxrS/GKy+LXmJZQ5BQ++XqKhqLC5Ch4vIrWll0txfUgmxLu
         aKFzt0DEPUUODNeKfkz+bKiq7Et5L0pjwbaSMX2Xy7h4neSJsJBel9VUXf6DBM0jd5RO
         m3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785822707; x=1786427507;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbSrywpWPl9l/WB4sN4GQ7+YbQ8bmN71lrzXFRNMDcM=;
        b=JpU26kjU5yHBFthhx+FJjhoYS/glrDgq04pxetSnHw2sa3zHhi2a2EtGB4onsiZW1E
         8vfiubWjriS8ei7tv8wjYex6S+wfpon0E8L969XNrDbTCIDfpdO5BsakrGVQY/YrbiVm
         3ZEx+qzgGWQj2ByeQ/eM+sRIaMFdD+IXC6DBeaCC/d0FKsdwt+hNEu6hQnjNlH1RCSUV
         pHl5l5xVMi6/0/K8EHOMxNARbGa7121IokM7UPjOCrjdMZvV43Cb2UrIA3yh+0aR8lCI
         /RPA5FtJuWu7s1dmtd7I3S0haXBe75anwYYZe0YdMfLYPb10zA6gNZiQVHh8tBcJ9M4H
         QhKg==
X-Forwarded-Encrypted: i=1; AHgh+RpIWz6FzoEdC/UYX84TwsnEdBiokR8zG+JAYdCwDiXykl7xVcTshl0yZXpY5kR5kXob/rD53Fe0OuFVvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqjS8+X+6bgTGHjNMDi5yO7tRW+MNfbB1+j4nOu37zm/Pdsrx
	x7e7OwgcK6Z01fjI3RoLR3/uzuQpN6eYy5Kr+oHMLgpz4x9KYB09cZqyTg3F0jCR8KZDn8BbcwW
	NTK33woIfvn+i3kBY5I4mDnDS+kpP8Mk=
X-Gm-Gg: AR+sD10XNckup079/AhyZQTZnyLBHUEdpBGgXFSOwWr52YdcIOc/UJTlYpvwVsX5808
	bYnc92OthyCZr0I6dtH0JuMyW2ARmXg/uS6u9Vjbx0MZvLPOY1CcW4CBZgO62FdYTPIzTzp3dt+
	VkzWUAdy56yt1uF/xUtw6xHy4WNyw1MlQg50z6R5rQ/62L5MwsC4xq+/bYSL4aXbmOEaXOQ4QQ4
	d5a6kt9biPcVxeO3DP8wWfoeED4V6XbDznkhob6hJoYDB1BQ+EGehbdB9ScmkIpHP35YqEOqDqo
	QEsmu7T1f+9q+7o4WWgAW2vONSEItRhSc0sokTtV4qUYCKawmo7mGCE=
X-Received: by 2002:a05:6a00:a112:b0:845:d284:9e10 with SMTP id
 d2e1a72fcca58-84ee495540fmr11496936b3a.55.1785822706726; Mon, 03 Aug 2026
 22:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801075623.2769601-1-mapengyu@gmail.com> <TY4PR01MB14432E24FD0D38D1FB84F99AC98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <CALSz7m0x_sgJU_A3dnM59vefSwvu_XC2QT7WdHJhVx6ZszKCzA@mail.gmail.com> <TY4PR01MB14432E89E86246C0DDC8B816F98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
In-Reply-To: <TY4PR01MB14432E89E86246C0DDC8B816F98D52@TY4PR01MB14432.jpnprd01.prod.outlook.com>
From: Pengyu Ma <mapengyu@gmail.com>
Date: Tue, 4 Aug 2026 13:51:35 +0800
X-Gm-Features: AUfX_mzfEivQUJ3tjTSJ1_W6p21ZX4yuaBtWyRTQpzvAN4g6bFIeNdgWWbJIjK4
Message-ID: <CALSz7m1BeZqraipNv46skaLQCnSCV3qiKoou=0QFJEGt4hn1Xw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for BTP-KP20D
To: Shengyu Qu <wiagn233@outlook.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Sanjay Govind <sanjay.govind9@gmail.com>, Kees Cook <kees@kernel.org>, 
	Zoltan Illes <zoliviragh@gmail.com>, Qbeliw Tanaka <q.tanaka@gmx.com>, 
	Elliot Tester <elliotctester@gmail.com>, Dmitriy Zharov <contact@zharov.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 1:32=E2=80=AFAM Shengyu Qu <wiagn233@outlook.com> wr=
ote:
>
>
> =E5=9C=A8 2026/8/3 20:13, Pengyu Ma =E5=86=99=E9=81=93:
> > On Mon, Aug 3, 2026 at 5:40=E2=80=AFPM Shengyu Qu <wiagn233@outlook.com=
> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2026/8/1 15:56, Aaron Ma =E5=86=99=E9=81=93:
> >>
> >>> @@ -334,6 +335,7 @@ static const struct xpad_device {
> >>>        { 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
> >>>        { 0x20bc, 0x5134, "BETOP BTP-KP50B Xinput Dongle", 0, XTYPE_XB=
OX360 },
> >>>        { 0x20bc, 0x514a, "BETOP BTP-KP50C Xinput Dongle", 0, XTYPE_XB=
OX360 },
> >>> +     { 0x20bc, 0x5159, "Beitong BTP-KP20D Controller", 0, XTYPE_XBOX=
360, FLAG_MS_OS_DESC },
> >>
> >> I think using dongle instead of controller is more clear? Since
> >> controller itself use a different VID.
> >>
> >
> > This is the controller VID.
> > The controller is idVendor=3D20bc
> > The dongle ID is idVendor=3D20dd.
> >
> > Aaron
>
> It's not consistent with your patch description. Also interestingly,
> this seems not working on KP50B/C.

Please provide KP50B/C IDs.
How did you tested?
Could you attach the dmesg?

Aaron

>
> Shengyu
