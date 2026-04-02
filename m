Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5203002A9
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775094857; cv=pass; b=p4Syvzm4NZqbtWkkA8uXypSZhLSoekd6j4r6UG9d7uBDeu2rJqJXWZeHCd8XEQCArqZaTmGnqMoZHfWP2WJBiuEJVGH4mfkFFeSxWAI6NhEtBY9EVUHLFCRaXaKAgoYsWwb2S+WuYFRK/uyXBUnz2Lbn+MYaHRWg6ZaPFUR8Kzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775094857; c=relaxed/simple;
	bh=ZgdAy4qNSHyKJtotTutzlKM7jv1dqpgGb4Vak3LPpxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFkxJpd0Y4ugDxJv4hGppmhAciA5SuQRua4qCmi01Vd+a7IIEWg7o0f2cUuskdgluKYecHPljvRDyfE2mw9uDvN0QSu8GDCe0GrRJIdH2Cts/zdKPo9BSnfOxbmFi6KluRCGRmhoHoyh53JLuZ4yaqIEjIW/nBLVy19VAEjfrrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ww7PwDxv; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ww7PwDxv"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64937edbc9eso361516d50.2
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 18:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775094855; cv=none;
        d=google.com; s=arc-20240605;
        b=hVFEPGLY7eouV7jMRqRbyBgpwJTB2H2u7TEQKEeBYWIiz+fAM19umDuja8xErKLh/j
         N4MepO7TahZkas/f75S8E/MN/9NdIp3qxaWZ7mklV0ICYrl0EPyAJV0Z/1ojajBsdZkc
         LbAb2lAQT1KegELa9jFfZlXYn9cKdiliug5HivlI3ymqfAYPgaEQ6rMFv0s4xkMg6yCp
         0nw024WnDFYSpxQ/jKLdSd2KpRJIjyhW/fNtd3eDi7G1rhNaCTzpIwWkWyGrIi23cWXl
         uTAjBJoHFNC6Cvrc5Kskd4SjrCi700+bq/eIQXrLd1oYc7BWkgqAGktWo/dFiHSntU3d
         CwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kiceuLyx91rPyzndVsPjUqGeAIHXDkrelSUnbkKBTJU=;
        fh=Sdtbv1ZSzVUqzOgexa5X1LM3Bho91yEZi1EAbBKlU98=;
        b=XnFHoXM96fwYy64+SwqkQzfsPkZ5ipT3YYPcxauaIRWG9CZkXFzyQOu5bucX6wVHyK
         KaCJGO3b1bUYf3j6SdqP4n4uSBmB0mO52M4BBgAiKGhNuTorDr82K/nvX65LVuEPrasB
         YGnzxRaeDzdZimuA8iM/RkVXdLiofiP+pUGtwlQ98To+7BFDslUoHp1shIdTAEJLF9cs
         TsdvOcg8P7nxI/3EMIgSN4O66NJfhZ6+AxbMX1g5AeCUFzk4OiExtkzvqsNtUQ5U0YVP
         91scYEhvxW+mviGRXW3Bs/A9yj5l9/Ipj1BWSRwrIcBYF4wMgKwCOHtYzseIJerlcCJu
         NLrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775094855; x=1775699655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiceuLyx91rPyzndVsPjUqGeAIHXDkrelSUnbkKBTJU=;
        b=Ww7PwDxv5MVp3tsNlTeE3CT0Oz5MhiebXjUc4q6rFMf/GmFYPBDczuil0bH3TBySVW
         cQ7fkOrw3Fs2HWzDJLfsnjY/hZHPdGI6yfTW7uszLmZv0eLNZdu2a/xGZzT5b/Uebxp/
         Dl/sKqbTT84G8zvSDyy7UpAWWhRqTBa6rXzvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775094855; x=1775699655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiceuLyx91rPyzndVsPjUqGeAIHXDkrelSUnbkKBTJU=;
        b=EWpfbuziAkFB13ZH89qw1mGHiv9AnWzWuCiu8ABpCZIxcS5O4BiwrGrMMDx21iAoQj
         e4Wz5a6glcOiZrSFTpjWCnQG/6QBqN41EGh5I2TxOsKVAkIq77bmeBe/Wzbr+Hqag0HG
         zu79iRvt0FHj3DqoQv2oOf0Uh9TqXWRewcmKSMsYfUmiTJbxK/P8u2dFEAvjqCD6YJCk
         qQlAEGqKsdIwW6TY+Vdh1rHDmvCsUrnvX1E8lMv+hHKaCBGlshHL7UPRoMM5LGihPYLa
         HEjGC9aC9opMFLPNTDoLfwl/THjZOJ4r/gvELzaeakw4Ezz7RfXFshc2bBksNGi5idm5
         EWyg==
X-Forwarded-Encrypted: i=1; AJvYcCUGs3bmL1A9OhFzGwj/q1cXTKDxvt5mt/Y+9ryANbMqZKrxHbEmkdElcKjtYPPHft6X/DSoK0CbuzkSbQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl/ky63nz56lfNf4gtw6BapFrqcgXMEeWz0pPkFTIQbuaC6wXm
	v7JdjVTfD45aqly02KNzn1BWEsjw7+huWzASstvF7kIcT5Z0AnJx7joRo/KNbcgt4/F6kykZeuz
	yMLcSAvzCzrZAHxpk7qoDiexhZNf09aK/BcgOXABDhNyXss97VLY=
X-Gm-Gg: AeBDieucDtSqodj8xlekjWVyQaW+tIxZp0tklu7EQUUG1nFVSThw6wl4/fcOL+3ckf9
	u5/iYh7w8piwRqBIxAPAryIjDodEXETTP9Fe39BH/pYaTeDb3aHcebGGTdnX/8Vnrd+zKQXQg9E
	oeiEi/x8nJMkQktzQNr4+zpYFQTa1+clDdhaMS+ZMqsXd0JF8ITs7gwqk4vbN7UJ2N9EFUbiDOk
	09EUsupCnmkc1A+w0FV3afmlyiOxljvWS91ipe/BmAUYEfqISZ3u1JJwXlErKK2CYjnYqCv4Uh1
	oLVEjM4DdsJ0QyJpOYcKFaFDSDAukT6y90746P0T0A==
X-Received: by 2002:a53:df45:0:b0:64e:abca:564a with SMTP id
 956f58d0204a3-6502fdd0ac9mr5063421d50.22.1775094855220; Wed, 01 Apr 2026
 18:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-send-upstream-v2-0-521ce8afff86@chromium.org> <20260325-naughty-hungry-wapiti-658e83@quoll>
In-Reply-To: <20260325-naughty-hungry-wapiti-658e83@quoll>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 1 Apr 2026 18:54:03 -0700
X-Gm-Features: AQROBzDfrwBIaLEV9wnEuLry8lUVCQVrP4uxpF2MQpcY1Q98CokyJ5Vf0yATg4k
Message-ID: <CAEe3GZFWiUG5ET2oQ42+KvO-TMy2Eq02tR0UMaTbACJ0=V8D0A@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Add spi-hid transport driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, hbarnor@chromium.org, tfiga@chromium.org, 
	Jarrett Schultz <jaschultz@microsoft.com>, Dmitry Antipov <dmanti@microsoft.com>, 
	Angela Czubak <acz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 1:49=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Tue, Mar 24, 2026 at 06:39:33AM +0000, Jingyuan Liang wrote:
> > This series picks up the spi-hid driver work originally started by
> > Microsoft. The patch breakdown has been modified and the implementation
> > has been refactored to address upstream feedback and testing issues. We
> > are submitting this as a new series while keeping the original sign-off
> > chain to reflect the history.
> >
> > Same as the original series, there is a change to HID documentation, so=
me
> > HID core changes to support a SPI device, the SPI HID transport driver,
> > and HID over SPI Device Tree binding. We have added the HID over SPI AC=
PI
> > support, power management, panel follower, and quirks for Ilitek touch
> > controllers.
> >
> > Original authors: Jarrett Schultz <jaschultz@microsoft.com>,
> >                 Dmitry Antipov <dmanti@microsoft.com>
> > Link: https://lore.kernel.org/r/86b63b7b-afda-d7f4-7bfa-175085d5a8ef@gm=
ail.com
> >
> > Signed-off-by: Jingyuan Liang <jingyliang@chromium.org>
> > ---
> > Changes in v2:
> > - Fix style problems and remove unnecessary fields from the DT binding =
file
>
> Style and removal? So other comments were skipped?
>
> Please write detailed changelogs, otherwise it feels you just ignore
> parts of the feedback.
>
> Best regards,
> Krzysztof
>

Comments are either resolved or awaiting further confirmation. I will
add more details
to v2 changelog in v3.
