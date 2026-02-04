Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C93F0776
	for <linux-input@vger.kernel.org>; Wed,  4 Feb 2026 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208856; cv=pass; b=gc5doNXC+npZmpx/1kZieN+IL+PpjjkEwiiU0Rqvee2nEuluqwaDvXgyFjewMHaCNOEHMkAbs/ldMT0Yv7vdka1np5m2STlv7/3jJa7CIuZ7G7Rvfz/96M67JpkRWIaLKu3/r0hDqs8+v3JxV2ZhBflNhjzyV3KEQ0EPKOGaJr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208856; c=relaxed/simple;
	bh=VVoqN1cbo7saKNRizaznTRjcFiDowh+PjgHqkK04EXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMjgyLBvYhvICc8QtOpRWrZGHo1GmsyBxaPALhImlHdKNRwpHS0JqpABqGY+kMpbD6ItpPXxRn8RF3dTAOn0DY+kBUF+aTQN2oPbO+5tOMOuRJxZ+Dt+fKMbgi5AdoG1YdpY4cjFX+6N+mdABNFG9oJHDzJJ8TGFemoUQfOZOIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgxOCnFp; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgxOCnFp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359a16a400so5990259f8f.1
        for <linux-input@vger.kernel.org>; Wed, 04 Feb 2026 04:40:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770208855; cv=none;
        d=google.com; s=arc-20240605;
        b=XzDOBN0krPAU16UhPWEiTM9hWDFcxvEL/ZFu0nrbSg9PtKD0r1WylR40XOe5/egroE
         n5BhMB39zb7wyrAK/PZe8tCk4Zz5/NbcAFs7hKsLLpH8sdsJCTvSiYLEakG/qs++Av3p
         /lxzJTWPAbOeg3dVACrv43v9G+1FO7q/gNtKclGH9UmuxKMyEmpVhYjMs7UrtgVjY9qB
         roDjoDwU0cmsUqjCJl1ZWmKG087WNsMTxo5Cpwmo9lSB2EfbRs3khBl1x57EYu8vyHLk
         6RvCisNEdfZi+Nas1a6Xc3Fupuvrzv4jDbtDb6aLUQUuboGe+k4NRkJ5pfS6uA9nFLh0
         /eZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m/zIsfoECBdgIZPuFNRz333Sc6yOkWK7EWk2qzyAS08=;
        fh=B67DTaHyCTH6DyWgz2IgIEXz0qSj/zoCrCs7R3t21dE=;
        b=EbKkbQ2N65H/plCtyw0tT8MHVRl3jKINU6yr/eCuC1fWInKMgMo4hFdoRMu8kXKUTx
         kHR7Af8qz2x7TGrJFMJn6VBKV7FCBxgvp+gv4o1ixphbIsz6c2WGpK1PHMQZ4y/ocMOc
         KHM+GYOXJVCpo7+yzrr10GVg8rhBo+MCZrlpKMJQ1nDOxHqqLr5/QLkbf2lWJb/CcNDf
         MgbJgXEQVxwH84hFv8Rv7ObBP1A3rPjthbN82BopB4Xc9qJpTvJ4zI7xmo/a2KBh+SD9
         TUOShFgcUBOAjZ+71l6Br+6asxJYzKyXISz5zpiyln9X4TCh08QLB5sWuVf3+UpPPatf
         xd5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770208855; x=1770813655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/zIsfoECBdgIZPuFNRz333Sc6yOkWK7EWk2qzyAS08=;
        b=XgxOCnFpLIcB14A1aqEtxqTxGYRcjFq2R+iF1g/G5VUZLLl4achDnCyhdFu/2VotNv
         LY9MiT9k8Wicu+tPAzFZyowDFRtmAbjsOAcqM66SIJZhT4kJEd29ilyOsreQ/H5f6XQs
         /cc3ApU/IfhiZYMgbwF7uCnjd9/t5aA43XjucmuSNE6UkG+Gy8ClfhS4JX0CADP/YNP2
         uXEd6w/MNVVlDGqklHl/H5uCrmyGfGJHw4ETON6HTPIbv2OjvZVm1xaiXmsYs31a5XTU
         IPDe0+IG98N/866vOVNahnRtXxTavtQxwwO+xalzKfes4S37JBAiS6WdbUj++rcS9CaS
         pRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770208855; x=1770813655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m/zIsfoECBdgIZPuFNRz333Sc6yOkWK7EWk2qzyAS08=;
        b=We9j5s0eN2FAQd8zx0O+Ss6V+d5h6X8tUcP++E17GyvYa5JqoLyQR5uhMZaLxBzbyX
         1VqwCchcRwMqkfYGPB04d65Bh4YiIsRkX1Aso2dplGFbVQ+emm4vl2pLjaCfRgQJNWCK
         HyFTDHIoY7xGWe92iPWKV4lAqKMuNc6p0LZIkBEXmLracPdT5q8OlZJQEq1hTyhdf4v/
         J447kb7ImiI6gupKHXIbJA4uxOzGrynFmUeQnjTS/+7GpzgqD6v95BOVC1Bj9PlQwMhf
         78sxdtCKC1Jys2XKLzRD69rBbPb8zXmis0Milo2V1YXnrhImj27keUHE+YyT0Iyw39kf
         4XmA==
X-Forwarded-Encrypted: i=1; AJvYcCVhe70qpkMgs4eJ6fRe1sWhnjHwgT3eaMg0LAhyk7jtl+6xGOU4RcbGXsopxymoNznjUOiuICf1M4iLmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQBY0JbevYYIjrMDubHxRCXap2+db7sMZXSEzn1ibLqjTY+/6+
	PycbMDZxk9jQQ/cuwnU6YPfPBVzf8S888/I26GPAM42lxjtnKuzkoLw7X0Ugj4TOaciQ67E2eF8
	9GEDxgRm2n08hfSJq5PcAH/OPqKquu1ufCg==
X-Gm-Gg: AZuq6aLej6TnlhoQDiH352XIANu/NdegsJ1OVGKslEpLq+pAOHLAYRMU0eWXF6OvUNW
	r3jhAgpMyDGBeKuOdZSmXzkRpnyKixZO/Z2+3wcDEvdKlcs6G12OU95ylmkj2kfytB7W2QdqHCQ
	19JYFd/UyJ2MWVzveLefI4O9cxQKRRndIcIH9ER+nhRBIuUWfz5f8pd0xWq9iiFA8k3B86ehAxQ
	Oz2S61Dbpk6l7Y76/g70Sv0rzMeLKNrZhrNhjIqTpnzm2Wfo3CTkm6P0mfBHDDfxaQCs9sv
X-Received: by 2002:a05:6000:238a:b0:431:38f:8bc4 with SMTP id
 ffacd0b85a97d-4361805fbf4mr4039864f8f.61.1770208854743; Wed, 04 Feb 2026
 04:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201104343.79231-1-clamor95@gmail.com> <20260201104343.79231-3-clamor95@gmail.com>
 <2026020350-unrevised-humming-7a42@gregkh> <CAPVz0n35NkEXjur-oJhW6Yxwme_KMLdYCnRAtjHEWSPEVrSUXQ@mail.gmail.com>
 <2026020346-ashamed-campfire-b483@gregkh> <CAPVz0n2HmLwdif5ry+y56LB8Gpwh2o9_gJ7K2jhcZVR=rPgfPA@mail.gmail.com>
 <2026020314-humbling-mobility-c24a@gregkh> <CAPVz0n0TMOCYnMiVUZ7xx-1SqrXuaVCOY-o4-x9L=f-xSMDj8g@mail.gmail.com>
 <2026020347-mushy-lunar-d12d@gregkh>
In-Reply-To: <2026020347-mushy-lunar-d12d@gregkh>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 4 Feb 2026 14:40:43 +0200
X-Gm-Features: AZwV_Qgnx8Hqpc3gLtz5e76GzgExX_xLHyQNYXgz5FpI0RojQ_lqa8cEDXcBX9o
Message-ID: <CAPVz0n0jrRxPQD-g7Pq-koDTW1Wr_FxNZc-SmY2-eE71dfei+Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/9] misc: Support Asus Transformer's EC access device
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 3 =D0=BB=D1=8E=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 18:58 Greg =
Kroah-Hartman <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 03, 2026 at 06:50:01PM +0200, Svyatoslav Ryhel wrote:
> > > debugfs allows you to do much much more than simple stuff like
> > > BIN_ATTR_RW().  Go wild there, but don't put debugging stuff in sysfs=
,
> > > that is NOT what it is there for at all, but rather, that is exactly
> > > what debugfs is for.
> > >
> >
> > I am removing said stuff from sysfs, that is not what I am asking.
> > Debugs does not allow to upload register values in a form of binary
> > block. It allows only dumping via debugfs_create_blob or
> > debugfs_create_regset32 but not writing. If you know examples of
> > reading and writing register sets as binary data, please point me to
> > it.
>
> You can easily write your own given that debugfs allows you to use what
> ever file operations you want to use for a file.  Why not just use that?
>
> > I am asking if it is possible only to preserve dockram_read/write
> > functions in the code, without exposing it to sysfs.
>
> Why would you want to do that?
>

Nevermind, everything is good. I have figured it out hopefully.

> confused,
>
> greg k-h
