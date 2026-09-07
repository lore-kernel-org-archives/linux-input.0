Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A2437852
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773977; cv=pass; b=miJ9b6p3KaTS26h3Yg2Rwzb4PJ286HACTRwr35C3Z42yr2Ep+FYzVE+ZnsIYL1PCk3gyTb07pqVx0Rm8xYuX38do3MHXM+k5ROXGrp5JoZLEhUlXCpk3LfP8qXzJqGLQAGwnUlGsB3i+Kj7uN2hEVGN6V4F+PYU/wv/xEaMfvDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773977; c=relaxed/simple;
	bh=dK4xgf8lo5blvAGZwohVBsdWCH+Y+Im3Vf7MWQMwGCc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8I8b4T6Cr0bMgcNHQSWI+JQAv9qJYH8wbzk3fK5u42IDL95TjHaw+I8JTNorhW6N2d+KehA5vFjflsxHas5CZDtaf5hJUdd04zFZLjbTFyTAF0WB9PstWrxqKW/syrS/RM0wmU/rJqcEOoUBF+DNknwl/C3pCgLyELlgKga+2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6dk+KQ0; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6dk+KQ0"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66d1447e2b1so2344311d50.0
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 02:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788773975; cv=none;
        d=google.com; s=arc-20260327;
        b=iMHfPx3A5kaS9FnRyXCzlzE0MU25a49li+IBbppKOQsNvp0WH79icCzSWJhbIG71ge
         5wRK6bIZJlLdTlRg4AKq9A/pby+Nc8ExAoyseA6T+DLTTKTOboYAGXRmcT52sBtV54hJ
         obnGz8J9BVSBDZLKn7DCfjQzfqrpqMTkFsVHeSOCS0d0QFz+6gOIQ6+Ap3MZ6+IC9Uuq
         9G4YZmK72AXKEn/rDQos4I54bUNcYwxBCaRw89LfcFmk0AGi/zYCzyiQEHtU7atyy6AM
         uRk3DY0YTgsoWyJ6rzNn0VY4gMR+aB6QiUJLmKhRHFXBJXOADOGKIhGbvJkPn5mPBavk
         QIuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=poQhJL8X8eQ0cN8/mTPX5+G3FbDfOheZFDtOSLpZXEg=;
        fh=7riDZnm1eodCAQ6IbiaafSu6qYyYL1ua+W/wERLYOeQ=;
        b=m034fwEhYb0K43bn+rm7VWSK0E+tWj/STL3FaZx4IICifo/qq7vriNOlvJ0stKcS9T
         wOiLbjhknshAsKvcsLN/86qupAHzpPryo0XFyJufN5DaHibDKR0EfoCnf2j1wLXdnyQk
         7jmgct5JuRRaIwNuNVCsrOcxZ/eADLD7Oto8xLVqOvRHnrBqg+oYo4GX9GLB0f5iszuX
         xBnwXdHGRxnITm8sLFnbZ+AaNJ1NC+FBsTePUBuXCMTF+h4HVRhmIw8pKSranSkRs0xm
         Z49dAVLvtOSVDU9S7y3VvELh68oV3Ms17kJZYtHVP5UELJfo6f5lx0we6BqPnN4qNEb4
         SVPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788773975; x=1789378775; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poQhJL8X8eQ0cN8/mTPX5+G3FbDfOheZFDtOSLpZXEg=;
        b=H6dk+KQ0zmqTJ5u+2AhakiZb50ppi3mtEAkcbd+nhDpZGiSiRFhtw5iQYpc+uKkAko
         UsfloI7Iyj1b30+0MalkOfZ1LpRkbxNgc1Z84HWwpiIynRGGmjfaekVVxA7qZMs6E2dZ
         ZPvnDxW4qrYp0AZSNlMPbNbZmFdfTrcZlFit6uYM+5AgDxbsRXpkTPZRRScvwdnqvYwY
         FA9qOFGKDeP7OgjyNna0makKlvbgv09wC7opZ6AGKfkoIG/N28Uy81nJCs+P2khWUYIM
         Nj0OPAaL5i264GOVyGB04ffIfrTVHh/ST6jfA581uVqB+Nbcito+r43F+sSGG0xjCFeH
         k5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773975; x=1789378775;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=poQhJL8X8eQ0cN8/mTPX5+G3FbDfOheZFDtOSLpZXEg=;
        b=WiJjJ/gwAZudCGFxdzDDwIglTMFoLvFDb4FRXrl5R4NOADccsDulSMB61sABpFuxOU
         MT07VFvUGpHjIitmSQjehP8w3tXuAG3hWo4ZF4Kp6NOsi3netXghQSS8rVjH5b4LmKRE
         TjCl3BIjoTNEZSqgtGmB4xPE4VfYRFzJzOzMsxwz/aAKUGepb5mzXgg9CFDtN/NgMUR7
         gcF9OU4fowPwOjFxnbrd+Kogf0AU/iGDgSk+LDj38IIJGmgs+kjkFoUvIJlA7+LJ5Rzs
         VefKd+JUyhgz0CIXRiZbhd8/7a9Uen/J1WlZbvfZa6O8A3MTX7kvhcpYghQUzZZ6/tCE
         oTfA==
X-Forwarded-Encrypted: i=1; AKwUvByKr912hVJ7Km6uieCpYTjyXjku5NIbIr5ADtytpAftlU5AQmQQMGGK2llmwtk4KAgtZqfkYSE0eG/jIw==@vger.kernel.org
X-Gm-Message-State: AFuF++kktCq+cJx2B4VNY9t2EGP8BaBL4h5iaQtf8ERznRGYkOWJ8WjO
	0loJ5QjdEfXAbQuD7LhAB3Y32tb7y0qBAsyCn58YOBJejrmM8x9/xsNgk8BsJAaYRS9R3uekri5
	mEljV/Egzmo5uAVab8Urx9GH5OeKdfN4=
X-Gm-Gg: AYBFou1JDuEsSEFrV9qJiGHjNyPju4dgU8SZ0ui8Rzlk8qPEKY7JeVW3uIk65M7J61l
	Jx3RPlfdKmeqrhvRTiOz1O9dfzyNilLD+qwNyz38yDxn/IJyevjCUhExe38IgLaWDHngvkc2wfV
	04/cY5NIOgnkbhazorEwnL/dkTLJ/WKqSxTtGE5AAMARF6FgJKISegljyHf2grFdsKH44LWmxpY
	gVvaS0UfHus0h1LwOl2qGg2c5uWRgqbQb9nwZRhUAd8Rm9xRXp5g8m3WucJX2mLWHkie/ugndxx
	039LRXP2W5GUntVfFnot4R3PU95G4xKPWaWbUcunnkmV8ZYmKjXuhQvam2vZV3DTttvw/Gyzyon
	7bUTkXwgiOTTVVUNv17uEeNLvZN2EjqquviR7i2sejOWU5VIR/gKIyZ4+H5VHNCoIs4NPlHsqbb
	MePdeKWIdzdVnwTUauWAfRQu0U0O7+UOq4MUxmsvYe1eA=
X-Received: by 2002:a53:c05c:0:10b0:66f:868b:a106 with SMTP id
 956f58d0204a3-66fb6daf633mr3194847d50.24.1788773974949; Mon, 07 Sep 2026
 02:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814031745.17140-1-schmitzmic@gmail.com> <20260814031745.17140-2-schmitzmic@gmail.com>
 <CAMuHMdUDvsqT5t93-ZO413pwS3rPYPB1_uy+5iRHsii8CYTdgA@mail.gmail.com>
 <ef9e0128-6309-546a-715a-3e7eb476910e@gmail.com> <8c7863da-299f-8c77-0727-fb438467a7ba@gmail.com>
In-Reply-To: <8c7863da-299f-8c77-0727-fb438467a7ba@gmail.com>
From: =?UTF-8?B?TWlybyBLcm9ww6HEjWVr?= <miro.kropacek@gmail.com>
Date: Mon, 7 Sep 2026 19:39:18 +1000
X-Gm-Features: AcwNN1WyQipclQxtOGYtsCkb4bcF6SLgTf8pGXaErnj_uA9Ck-Bs8D9nX0NYnP0
Message-ID: <CAN5rfbQMTtcvmcgbDwhTQ-D9AGxP5yGqHc=JWbN7PPJXXKPGHg@mail.gmail.com>
Subject: Re: [PATCH 1/5] m68k: Fix atari mouse movement
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, 
	linux-input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sun, 16 Aug 2026 at 15:04, Michael Schmitz <schmitzmic@gmail.com> wrote:
>
> Hi Geert,
>
> Am 15.08.2026 um 11:15 schrieb Michael Schmitz:
> >>> --- a/drivers/input/mouse/atarimouse.c
> >>> +++ b/drivers/input/mouse/atarimouse.c
> >>> @@ -70,9 +70,12 @@ static void atamouse_interrupt(char *buf)
> >>
> >> Alternative, you could change/restore the function's signature to take a
> >> "signed char *".
> >
> > Agreed, but without a way to test this, I'd rather wait for Miro
> > confirming that change also fixed the issue.
I have just tested it. The new version works equally well,

I have just noticed that if I enable the pointer signedness warnings, I get:

make ARCH=m68k CROSS_COMPILE=m68k-linux-gnu- KCFLAGS=-Wpointer-sign
arch/m68k/atari/atakeyb.o

arch/m68k/atari/atakeyb.c: In function 'atari_keyboard_interrupt':
arch/m68k/atari/atakeyb.c:263:82: warning: pointer targets in
passing argument 1 of 'atari_input_mouse_interrupt_hook' differ in
signedness [-Wpointer-sign]

atari_input_mouse_interrupt_hook(kb_state.buf);
arch/m68k/atari/atakeyb.c:263:82: note: expected 'signed char *' but
argument is of type 'unsigned char *'

I guess this is expected but wanted to mention it just to be on the safe side.

-- 
http://mikro.atari.org
