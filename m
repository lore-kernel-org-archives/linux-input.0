Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A188394E80
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886710; cv=pass; b=H3aZfdv/rWbHJOU41H5yduV1ZnPG8PvcesqbfgHMo6vdn6/mt80P85zIneoRDCtGMKIPyURJD7iwEnfZ0Wq+0tq+kN2DDTIgNTGfolOl3JQ2CGg1wJvmo5ICfmAFgb1kx5cP8AWKyU1CN2QC0AF6xOj3M6DvykXAa0a42Q+omvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886710; c=relaxed/simple;
	bh=meyU1YugnRxYeRLkXcqB88OhoXFWPWo27DjJ8y0AMj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYONp45/j1IL29b7w1KKvZbwhS5paB6BMP7noqU7Ug5WgWuTvsz8i3+WFQE8DfwHa/MsS050004qTz8O+z/aMmytzVywyNJLOovhDZd1AUWydBjBGrA8/Ln7FDqED2lkVVBVwLKHcf0YS1ykPB5fDNOCLVXVMNeLDyNp5NtdBX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhWwqaTf; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhWwqaTf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caced6038eso5492465ad.0
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 16:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785886708; cv=none;
        d=google.com; s=arc-20260327;
        b=aWzFUJ/4jSwMLcX2IJ5x3+LoMAhnxJLy1W/kPNfuHZSqW3Fbfz0GLNwUGsWxBQx6mK
         KbVtA/P2HUwoE5xr46ah3TsYcSRNUmDtEhf2nc8bi8h5bf61iR2xxQlGkKQQxjXUVtsg
         ugn21lwi2bPKKiDN9KP1vHx2Z+qL1CAEtVAhUY6onFTP88iuK7V5yMYhzisiB2iXEbbC
         CfqYB/xsHrwd/+L7QRXUYQBw/BSyeliunYgSWQlXdGYBrikqs9fg1Ve3sarkImGPD4na
         Um02f0lA+7u3QsEn31wMVOgKM4G9DhuBYwnlNglLfuLXn7+rn20xNJR7LT7Kf0XgGlEK
         U1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vt3N6M6O4cWekc/iSM5RDUsHKKmq9c1umfQomKmQmSY=;
        fh=uUEUB7XsOzd6EtjvUa5XgqmxhRUKQdiFlWMScgW0USo=;
        b=DKQI0L8G5bV9rZGGxKriwod3mGo0O+9Q11vH/JvTzcTGWFOrdJlx0LAzXDl4hS3MO4
         rW6KyTgYUBYinae7PvvhL+K3WZOP1FQhRhsGFa5T3sg8ISgcqdQ5eB+hRfeWlFGJIpoW
         OieClXUwPUejQ8NaJxM8t6tkqLlkque30D4HkHMjXJ28lhcO8iNhJZYriI5GQRAdJiFf
         aGyTGuXoSDRCk+VFdC2CEDPDuBjnrJtzEJkGkf7CpPGEPxn5e3stHTaAa8MobHNhu8gG
         m6OMo1Jg9lGUrMPe3/+66GncAgoJU1t3fkYWPfi/xKIn/xszp4iUZ0Kc1dFV5i6cMYy1
         u18Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785886708; x=1786491508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vt3N6M6O4cWekc/iSM5RDUsHKKmq9c1umfQomKmQmSY=;
        b=fhWwqaTfO80uj0hx4rMqIE04sZuHhkaV1NjBATUvYYVoPjyruwZGu5npXt0gNJ/AUJ
         ayHJkCZZHKGgy2N3T3BnBd8FekNEBkICYWRxk11pAVQJkoZzHFNJyl3wkCKaT1t7yYwT
         5F+AyQAeuZmElQ4trXeiQ8WOCbP9fXE29S2rCFjSd+1aSYOxRYMr5ADqmjsmQivRTiyj
         X5Iqe1ywRgvD0GHR5C8/87yfZP5XwbTQ5gfIgGXsABd4YfE2/hpWB/Qt4vZtpsotIrHM
         /pQnBA9MtDbw67s+1MaGPHuMvwUDJozyLGPemAOGC2ZjAoq0L6VbCkSZ/yEmp25ot3S4
         d3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886708; x=1786491508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vt3N6M6O4cWekc/iSM5RDUsHKKmq9c1umfQomKmQmSY=;
        b=gHgGat/0P1WG6Y5sv/gwDPvhs74xvDU+rH+3Adp9XLK8DqMMQN0RlDMC6iMN20eUST
         4SU4tex7ozR3lV3x0zkPxI5TAAZysyATJVSFW2Xx3OzFGyYhdo4idBJxglmfwaNgtCsc
         WPaGNO50GajKHBwiQGOEOjqxdnWTW52WSPUp66mwWK5IRMbARN51NZ/NoU4gGNWQDTUy
         0kp1nn/RCLe/HBWcXrUPhfRCQC3eO0hARyrimsBp7jXjuz7NfeUrIRCM4CATRzykJGed
         Mup2Nz2HUzHOpT1XbfPQCUWWDKo8QaCtWPJ1LCw2i6U1dFz70EzVxMP7XigiiOGwd8xZ
         lUEA==
X-Forwarded-Encrypted: i=1; AHgh+Rps4828EFzeI8lkr66imert5+KQUygcvE+rQ8KEe3yeUogYSa0xAntuYPS1Byxvf7SDi2f2P9yq/DY6cg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+fAchzIy4PGe2WKV0739sz80D3c7+FPTyBzDIeT5/5GxiAg87
	y5M0QSoJCIWxSHW/l+MbyvYsJKiR6Dm/dq+tJDqEXFXcNl8ioN5+duoyQgUz2dTslYeUXscRs9l
	k0kcS8HT8sfM3GkJGcGBLuJA6sCGmA1o=
X-Gm-Gg: AR+sD12fZVx2VLnKwwQcKdp5nYu2o4hiNcALNZZbwsQ6RTKFltWuT8iO7x8MFkoR7yJ
	dSvvhoGhQaGSXUKycfSiPyvbFpsvfcs1n0bzMseqRvHwUVczaKnljKsJuAyE5ifXRyR3pEBzMAZ
	bcEpk2NFWOxcrIbAiFpOFsunqLfzNQr1hLMGjt6N1SauDha6MuViC+TANcLNudVtgC6OjVWg7KC
	IIAvsKntBXvSrkgMgE8Kj0cb7AMzj/Mn8qwrq/ESUm6Pl+aTZIOuuhDuAqDlYzPsIWKgLV5d/h9
	wpEwCq71XDfOEx4Awxy2ELh1+DDG8AYcxxPoAILfUCF4dpBnzHhMO/uJp11Eycr+672c8X+jSe0
	C2kEDH6CuAu6T4YsdYpoMuLMkIqM7UeNTaZfYvNJFtZxB0DqFE+OaCAQV+P7O
X-Received: by 2002:a17:902:d48f:b0:2cc:841d:cd7e with SMTP id
 d9443c01a7336-2d0c9b86e86mr12538535ad.21.1785886708417; Tue, 04 Aug 2026
 16:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
 <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com> <anIhyHL4Kl-DX2G_@eggarch>
In-Reply-To: <anIhyHL4Kl-DX2G_@eggarch>
From: Jamie Stephens <jamie.stephens@gmail.com>
Date: Tue, 4 Aug 2026 19:38:16 -0400
X-Gm-Features: AUfX_mwIpL4SdSZhVrTWRob8gN-UrqhpzPK2fLzyxy8e8UgeIOn18-toW5_0yT8
Message-ID: <CABWMpWS=-xjdAHEuNKVF0Vs71zqtMG1n0hRBWk0gSn_NhYAeRA@mail.gmail.com>
Subject: Re: [REGRESSION] CyberPower LE1000DG (0764:0501) USB HID regression
 on x86
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, regressions@lists.linux.dev, 
	gregkh@linuxfoundation.org, stern@rowland.harvard.edu, 
	linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lovekesh,

I tested 01-no-lpm.patch separately on Linux 7.1.5 with the
CyberPower device 0764:0501.

The patch did not resolve the problem.

On the first connection, enumeration failed with:

  string descriptor 0 read error: -75
  can't set config #1, error -71

After disconnecting and reconnecting the USB cable, the device did
enumerate and attach to hid-generic, but NUT still could not initialize
it reliably. The service reported:

  Can't initialize data from HID UPS

and later:

  libusb1: Could not open any HID devices: insufficient permissions on
everything
  No matching HID UPS found

Running usbhid-ups directly with debug output showed repeated invalid
HID report descriptor lengths, for example:

  Trying HID descriptor length 2053254698
  HID descriptor too long 2053254698 (max 6144)

It eventually reported:

  Unable to get Report descriptor: Resource temporarily unavailable

The manually run /usr/local usbhid-ups binary then terminated with a
segmentation fault.

I have returned the UPS to the PiAware NUT server, where it is again
working normally with the same UPS and NUT 2.8.1:

  ups.status: OL
  driver.version.data: CyberPower HID 0.8

I will now test 02-resume-reset.patch separately and report the result.

Regards,
Jamie Stephens

On Tue, Aug 4, 2026 at 2:56=E2=80=AFPM Lovekesh Solanki
<lovekeshsolanki00@gmail.com> wrote:
>
> Thanks for the report,
>
> On Thu, Jul 30, 2026 at 03:28:02PM -0400, Jamie Stephens wrote:
> > sudo lsusb -v -d 0764:0501
> >
> > reports:
> >
> > wDescriptorLength     504
> >
> > Warning: can't get report descriptor, LIBUSB_ERROR_PIPE
> >
> > cannot read device status, Resource temporarily unavailable (11)
> >
> > As a result, usbhid-ups is unable to reliably communicate with the
> > device and NUT cannot reliably monitor UPS status.
> The lsusb failure and NUT seem to be seperate, lsusb failure could
> simply be device property.
>
> Few possibilities I can think of worth testing:
> 1) It may be related to LPM, the device may be advertising this but may
> not be handling it properly.
> 2) Commit 8020c41b39f5 (usb: core: allow ACPI-managed hard-wired ports to=
 power off)
> lets acpi managed ports be powered off even if hub does not advertise
> power switching. The UPS may be sitting on such port and its power could
> be cycled out and leave it in a stale state.
>
> I'm attaching two patches to see if they have any effect, please apply
> and test them seperatly and let us know the results.
> And, as per Thorsten's advice above, run git bisection regardless.
>
> Regards,
> Lovekesh
