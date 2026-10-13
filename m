Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020F54CF4D
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930517; cv=pass; b=GTpPQ3wRY4DKAL7ytPm0Srctmz9jldyzNb58ad80uSz47PR1tH9cDE6IpzCMPArqWKTILPaexwwO91EWNwqM9bcgg/MoCfQ88W0G4j5hIu1fjPJ2KGSuOuMMni4ryjci6XyoHhSEBNEJPJijJy4gry8/uo6PEmL2Ib6zP3uICIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930517; c=relaxed/simple;
	bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qliRskJBKKNMZAoqlxTy/KwcWnVA20zhJ8LeWqeFSF1NlN+i5eLhk97lCbZIw54VGnpMPrwErmh/Yfc/vtawpuETUdDnZXD1tcOxvDoNDeeqzaA4kBFZceGwvkim1k3lD25Ru5n7jJmmla5LXB4GsnS4rirnc7ifLo8mghL8Ui8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DUSXHq6a; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DUSXHq6a"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b056d58f2aso3698887b3.2
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 15:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791930513; cv=none;
        d=google.com; s=arc-20260327;
        b=KkssiBQkIuR0KeI3hJPqy/EB5fJMvnmEl6+wyoWk7eXNASBK5JaMWGscHwGH6wKwvt
         0ogrSuRVoJ7w87gGY/9ZQsQzsCyI8DES6uHDcrSdv27O0zNynQV1UEDN6Yb3Prax1QDj
         82Hy0ae7tq1ZWlM5CDFV6C7rRYPWCugHWH3PR8yNAutbHhfSD8bnvV3h+pGn0x3vGA1w
         DPJxq9Mt2/AEV3VD96NOCv7KhWmoiiazYcB+vxXIa1wyfVISnRWTu+QpX3GyKX3K2W+L
         t1KIiHkuUzQk7urDNrnLIKJ+UEV1SZcG97pu1QJFMkb1QBQaxVWdEPvaQayJm5OdaYMZ
         bPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
        fh=qfgfLdO2t8ZULc6GEM0Ne6tW348ErQ/oZeq0GHpD7RU=;
        b=L0MMsNZd3VKhiW287bsTDZG40STAb2MjkoRHlQSBJnqaqHE5qe/devRlQvn2Di3wPT
         LKCEHxGLGFvL1L15TWWYpJR/eFlhJXwaRuD5H+N6gRFvT9fbsYfyyiMLaGzdEf3NO8Sf
         GjmlAmAGNVjHDUBLGtlPCw6dfNu1jP2rD49NfPe88Gv7Mj+m6FaWpIgzrnNxVE7Lf/Lx
         qV+i3oE+0ia4c9pXL6YKAlQAOgh2Gy5wO7sXKUF/7uIysK0i0vfYKpqBXohPvThTggu+
         ggQKe/w4OIUwN4u0BTCEjcnBOobZSTCGHS0CQygUHrx4v/y/b+577K/qgafU6diXP8g/
         orrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791930513; x=1792535313; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
        b=DUSXHq6awOXCzmeM9lLEMtkMS1ys4ectWQNADf/Wr89M6R/5Ao9JRiZUqGyXDjy5T2
         JOT088ik4rp9/uXTDrLqf6AkzM5NhYBRpFSq6CIRt5rO/4hPnJUQfk3MHN3eJIe9KuAR
         U8PSiCTpeTfIdCGG8YfydaxD3paJQX36Q3vqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930513; x=1792535313;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbWPDwQYb1MNttmrZiIyG9Roqv9R3ER6b8JaxbDgP4I=;
        b=zBtN7RbpzKKXAzlzxpz+RTK0CERm0x/na9QO56sFl+y/4LNfvBfj7ir9SiDooqTB8B
         TyACV5mX/HJode7PqmRsXkomR+VGDOSfqJvKCnxk/4b33zwpo3SekHRB5zWAx/QXh9Vp
         z4TQMeyVkq3XMR95jx2/uwtFb0h58uqL77qgnim7gcakTXdWyUEKhK7Ag4vLPShC7F7Q
         lXNujnIIz9+ZrjPq1fdI74BCfDM5O/Dl8JrmMx7Q9TC+OIiSi4kQh4tpAJ63WOxMS9e7
         5qU/dAeLJHAyao73f2xANK4F8/XjAaiX7ntGcum9+I2I6R1KanCBUl01FftIXFQlZHlc
         qznQ==
X-Forwarded-Encrypted: i=1; AKwUvBxhZvu66DdxrgRIxjKgL1kuAJft4x7JbOr39a90qGwdqSGB8wS/cjDsy6y+S0zP+mMPu8cfp4xFfUFZgg==@vger.kernel.org
X-Gm-Message-State: AFq9FYILpJV/AyNq9bdkUuGUiDJUe6N4y1rAd1teZ+j9Mo71sntiKNsW
	NmyL7G2SK6TU9EL87ETsThS/xEnbjBrFMql1VRUdKQLnbb1t06TJN/gTmSgMiKKd6xDLGFb8jH6
	H3eLkGk7gM4qq22XS+M/hx2i031f0toBiJrhJtL+O
X-Gm-Gg: AYBFou1z1Bf2akssTDBN7ItGOuZXiaVojNNmtG3QAzrhmxMYT2eCiFpGhGEOM5vHCnx
	LGrcFMJ9QS7rv8kWuWwRc8/D++WGiJSnDt5QATmBWYB/yQ5AuobVZ1VRopZYwiBOE13sY6CuNj2
	XIj+tTG83GyIbqj0nAR2flSzC6HYwiMHsE4Pp+e5T75w7ODRlUU6MS3idTPmQIgLNPPhhX57uFK
	azGsu1QN4eSkXa87oFDF+bXmIoAoUkVURIp0Ez8Ei0X0JvFrb/GIBRM+E2n/hxmZTe/KvYW0fzR
	5vH7Ho5/WEleFFM08BwQCPaojM30haGMD99wvcsNsTybzQ+OsIG+jufNxLYCylLcjINjpenaJTv
	PyptdErYFhiGnd6ZXMqBI
X-Received: by 2002:a05:690c:6603:b0:8a5:1570:a298 with SMTP id
 00721157ae682-8b07edfeff1mr40474577b3.50.1791930513249; Tue, 13 Oct 2026
 15:28:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-send-upstream-v5-0-384af01da3ee@chromium.org>
 <20261009-send-upstream-v5-9-384af01da3ee@chromium.org> <998a8c7b-82e3-4370-b0f4-765deccdb348@kernel.org>
In-Reply-To: <998a8c7b-82e3-4370-b0f4-765deccdb348@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Tue, 13 Oct 2026 15:28:22 -0700
X-Gm-Features: AclHuK9UE5fFXMlu7KAnmwYM6JrldO8UdUyYtEVe8VXlPWtvlfdV-v2OaGNZ5vI
Message-ID: <CAEe3GZEuB+i2XS-GnGsmHaaULzThPL2wKT4j6QdMYbCCz47q8w@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] dt-bindings: input: Document hid-over-spi DT schema
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
	fqwqf@fqwqf.xyz, daleyo@gmail.com, Dmitry Antipov <dmanti@microsoft.com>, 
	Jarrett Schultz <jaschultz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 11:05=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 10/10/2026 00:25, Jingyuan Liang wrote:
> > Documentation describes the required and optional properties for
> > implementing Device Tree for a Microsoft G6 Touch Digitizer that
> > supports HID over SPI Protocol 1.0 specification.
> >
> > The properties are common to HID over SPI.
> >
> > Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
> > Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> > Tested-by: Dale Whinham <daleyo@gmail.com>
>
> No, fake test.

Will drop the tested-by tag in v6, thanks.

>
> Best regards,
> Krzysztof
