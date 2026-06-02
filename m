Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30ED314D35
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390319; cv=pass; b=ARzsLR8dhre0F9MtQAShC3b9CQM1qL5vJ4AfIty1BNCfi6R84f6IBK6HsNzmnEPF575jrgjCMIoePxpaAkOvgdH4a19POMy1aYUY5Jsv7TO6cTpYWcog8egdpGpFllF0sukabWq9EJM42fjPoW/ivCx3TxcnfQZFTzpv4X5leoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390319; c=relaxed/simple;
	bh=RxPiCujPxn79Uvms71LClxshs0juU7xj4wlMJ45AAzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeTh95vU44FlLJl2CHLzuwIXBr28W+3OFqMtdo0qR6jqQ5swKFKir2UcC4cCpllkjiNS+1lQx1QH9oNt7VYVM2msym15zc6W65n/BnNz91IgT8p6gRrq32iwlIYa7UopjpsgDAv42YSMYs4nVD+L5dNOEUT6a701NhQLrAlEHwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQCmpBYd; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQCmpBYd"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6886be3d39bso17146905a12.3
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 01:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780390316; cv=none;
        d=google.com; s=arc-20240605;
        b=V60MxAAXbRhp0glebAgNzeRoWrNedLKks7+t2XJy1wfQf4SE74icrsK39749wKsZgg
         BJxLn4KUdhRBIyMSxs5b+jCQfy2mNwvlE/d9ejmYW5ZKCq+IS9sfG2SVrEEruXHVasd8
         edKq41npa//+DkjryqltsT+1QE8FSn7Jd9nWEGmnKUXpTkWGu1Y2GCDhtr+lgFQdC31e
         +IlQlPqvABuNqRzELQUVvJaH0PtaOBG3hW/scqqtIkDD/Iw2dxrugnNYGzeaonQKR71W
         UaTyPyowjG+WLq9Ka6sCtnLh+Iml9GbkMWFaat9pbNPbbLumC2P5kohjcVSkbzEk7R2e
         fYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NiRZYLqdYuU6SFpoVEk8+QM9CW1MlZECjVChvA6J5qk=;
        fh=uV14yPWZraFmmPFozNzeOiE8/6cGW0ct30ZOgA540AQ=;
        b=JsBD85vtMQq3Ik65EhoDyNTjrlFUmj2m/jEuiHn0O63ozFGb2uvlu84spP23ylzcO9
         6KNGX/a5Qvpas+5klGY4qFqsH2k85AEuCv/nZMjrcXMJzit2aQKSb/MiaVmlfSixvYwk
         R/gFnYiQi8Vg1o/oJPZjhmpCYHcaTlJLqc/fnwKa/EgDd7RwizKP1CuF9QhYe1AnLVso
         ddzu8uR8VU67957JLAhXdLVrfFHf24Bk3vTE9Kw5K7h88JNg8Ch2BtN2DR+364cnQUWM
         wwtxEex3KG/i0SczisXNH+zgejoI502vGwuOXUyDPq3b3MuxRDIV8usQ947kIHa+qgId
         PYaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780390316; x=1780995116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiRZYLqdYuU6SFpoVEk8+QM9CW1MlZECjVChvA6J5qk=;
        b=rQCmpBYd9SjvtR8druMhWY57rSUKMyjaC9LMlQZ8JRkG7vZLft+7xfzqq0uIjVRZjr
         btT2RaZLlWrM+kvjpMZqHs2aT7XCoLF87PqD+IQfCCmiXhUfmK6CzeYPNk0leO4h1S4l
         wBpgIi0XxijsuNwBIPuDfAAOwU7OypoN3g8nEKNx7WaYL2+8xIOvl+3UUPPLgZsA39cp
         lr3ZvaZf92WSnKZOeCvPAIyl/XOxOTLcRpVuZDTFZ0HW3/ffbI8SvHaYqR3choFBQDp9
         NABSchg1Q7Dh+YOEoQFsn5UdI6Lmz+C6Nzc+fWBnukcfNL+aGGjRdJtAAdS02uQdPG4i
         Rz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780390316; x=1780995116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NiRZYLqdYuU6SFpoVEk8+QM9CW1MlZECjVChvA6J5qk=;
        b=N1ozl35Z+kDYZ9ptJ7ngAAudpiDu0Qk5YA+QKKPyLoSbTD3ihHO0su5HEGmP/jOz23
         Fzk+OYiLvww+G0NcW9nKiSNtnRcy0vlJm/TbNjktSn1cKirGZXRfGRnsHv4CHEK6Pqu3
         oPOpQZEzG64F4puNT1wQ3wG/kcutI/RUykHljt5/GQxA0iqWgrWNXAJLYDlNtV1ZjBvt
         iATIvtOz2CSfrYeldoboeLeAEThgnci8VtgdBjw1Hucapi5tz2rjhdfgy2Gyzt0qV6S7
         6tFwo9GcPSYYuIvBe9chUJB8vmQypBBsTJV4Mnem5BGCwEyNkNYowlY2wlKJme6NV2rU
         Y+2A==
X-Gm-Message-State: AOJu0YzTThFFoT3ZJ1s+PNyp+KIrhJPgDtHrZ17h0gRV6037D7Xf+vco
	dS3VyoWP6WutD7qv5rk8z1r+DkOI2jZcOca8u5vZa6VQJxGPEEJdeMtJ1+c6WWPmo2UlELBA00w
	KfcbhBc52vHqzaQdXTnMTZx9q5bJA0NY=
X-Gm-Gg: Acq92OEoH9+UdKlkAKyELuykSrnV/KHS2O37Ww9XTpmRsw4UFxuVND8y/KFenN2DQZl
	t/S2wv1Kh/GBEWELuVUlEXe0AOvJkm3z4JwliMxsngzVsv32nYvZ4g4R7TKMEO051+hOo3Yk7NN
	7OmV6DsTfE+5Gy5cDKr+kjmGA3It1CkuOM9QrRs+Jy/DQ12noQYGMsDuuGClDD2XaqJwX7vTD4x
	B8cMyzv7/Et/Jo3W7tFVdnfIfzeLs5KsmwIPT2/kqp5SAG/GdLqbI18bxqmJOHsVOEBRHwujWC+
	+9lTwTUMAxUrMmXKPfQSrPWwy0i0tEpg602THOcq0NfHgUkR7pZYb5EAwBtUDe5Hv0fLSgxhTWy
	FlvP5+w9imnvSR0JKG/kLlpn4XljKQXSVP/ICwOd0o30l5coU/qjGXyfRc2wkC6u7US8y
X-Received: by 2002:a05:6402:2b99:b0:68c:33e9:bf71 with SMTP id
 4fb4d7f45d1cf-68c8ae14309mr7505543a12.11.1780390315907; Tue, 02 Jun 2026
 01:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602035907.623599-1-rosenp@gmail.com> <79ccbd62-9aa3-41a6-a8db-1737672a8aab@amd.com>
 <CAKxU2N-M+vDeDKtYa6=M-4kazOUrGTrwJfHoF6Z+od1OZ-VBpw@mail.gmail.com> <b9e06f81-2b18-4cc3-8974-6df9063b02cf@amd.com>
In-Reply-To: <b9e06f81-2b18-4cc3-8974-6df9063b02cf@amd.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 2 Jun 2026 01:51:43 -0700
X-Gm-Features: AVHnY4IFc2FGJF-yhzYHXra0k2OW5pWoFypg9qZSsndqoXXRhQu8ezFeHabdJu8
Message-ID: <CAKxU2N-PVmXw3ha-W1Gs9SLpfaJea3X2dPGQYhCwEBGNtYAwYA@mail.gmail.com>
Subject: Re: [PATCH] Input: xilinx_ps2 - replace in_be32/out_be32 with ioread32be/iowrite32be
To: Michal Simek <michal.simek@amd.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	chleroy@kernel.org, open list <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 1:34=E2=80=AFAM Michal Simek <michal.simek@amd.com> =
wrote:
>
>
>
> On 6/2/26 10:27, Rosen Penev wrote:
> > On Mon, Jun 1, 2026 at 11:23=E2=80=AFPM Michal Simek <michal.simek@amd.=
com> wrote:
> >>
> >>
> >>
> >> On 6/2/26 05:59, Rosen Penev wrote:
> >>> Mechanical conversion of the ppc4xx-specific accessors to the generic
> >>> portable helpers.
> >>>
> >>> Allows enabling COMPILE_TEST for extra compile coverage.
> >>>
> >>> Assisted-by: opencode:big-pickle
> >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>> ---
> >>>    drivers/input/serio/Kconfig      |  2 +-
> >>>    drivers/input/serio/xilinx_ps2.c | 24 ++++++++++++------------
> >>
> >> I don't think that anybody is really using this driver and would be be=
tter to
> >> just remove it.
> >> If not, no issue with that changes.
> > I have no problem with removing.
>
> Can you please send a patch for it?
Out of curiosity, I made a deep research AI prompt. Last known user it
gave me was from 2012. Github code search however gave me a user from
5 or 6 years ago.

https://github.com/danielkasza/9444/blob/master/firmware/xilinx-fpga/genesy=
s2.dts

Maybe someone knows more.
>
> Thanks,
> Michal
