Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085592FE56F
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827171; cv=pass; b=HptsiZvIo+ZEu0b+UVTD9mmneW9dk3oLuV+h1UvlEF/M7h8d9AnYsZylUocoVdZoP1E3SxvkKdW/X5dTY+D+tWwS5RtptgxLPptEIUYkYjQtfkh6zH+M1uB9o6Zs5drKj+xAeeu6hyS+IBTMCrD6fCRMA5l3EhaESAmfPOJFA5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827171; c=relaxed/simple;
	bh=niywOdzhojN/SlE0OircIR7xoFGK9onF6ItkQOW0fZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbaprW2lSBtcI/U+xcKcjloHejPpnPktSQ29YRYoNbZ9fjXfWhw2gOXh2UCnAcd3WSdJj9dbcrISpm7poHdBfW9cHlg/Lzqu6hfLVQNdRzqdSSdklxB0rQTiGI35tLuxPVY812IKKIxTVxYjfM0fI5HlVelq3GWqu8MvSZ+agf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c18gkent; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c18gkent"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b159850b16so3492721e87.3
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 00:06:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785827168; cv=none;
        d=google.com; s=arc-20260327;
        b=PzyN6tkCXpKmcwpkhMzS/QW2VQW08nNzx/7jxXTRhrLoeDK/f05gFqXHiDiVSCeqmW
         TI3K42FLQ3i2dHK4tTM/6IW2ao0yMNUpKzdz2bCque7WMqk7GJ6g1098n8al1YB5r8L5
         SjFpT+Ylh9P5A6EN2gMS5osyLrR/GOVKuOx9omuVV+oKnI8QHXa/BIDKPgwLO7mVQAiz
         o/I/hBfUhjVs4u2BuJXBJdZov+GzIy/a3v+vqDX1JLmLRxsk6Wh9unkBvVYknaQulh2K
         maveuiMXtr98aiEI6kJCcZZ55aOUl8ZgH/T//tyGWCufxD1Q8Gfdvb3/gGnPvmSzdc8Z
         07Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=niywOdzhojN/SlE0OircIR7xoFGK9onF6ItkQOW0fZw=;
        fh=VWb7UJOBgmxF5rKH0FYFoC4lOTJBdIAcvtQ/HNnkEok=;
        b=qtZlETTARn5CHT+BmEEkahp55MWSsuhjGCJOOATvN42nziF6cQsj6p3HyET8Ew7D77
         DVk2KE1S5RJSRzWni3CRZiOCmwXjLtnbU15j6U6Q0yL4ctvvZhorrygrs3Ns2TTtoarX
         fw6/AC+Gy3akR03kuZDJmwm56Imwi67jS34NTXd1oFnBdpgqp78+cf8mba7ibLN91bVe
         YloW5IpyKKVlBLb0T3J7Jswqhoh4JdtkHQbD9KRdHWKxPOiym08BXrpNrSXxT2PWFarL
         mlVwHxuciIXP/zLwqMMjO9lMpHV8Ko6+dHozMWS87xQs+5aNI/l/8h78zzeZG2t/lyLZ
         joMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785827168; x=1786431968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=niywOdzhojN/SlE0OircIR7xoFGK9onF6ItkQOW0fZw=;
        b=c18gkentSx7zmNqXWwcsMSNT/arSyB2o6vk2cJggZsRnIyUaqb6gFonesPCKqnwSs2
         a34HXZ3yF+uaAOVrviExT9K7QWy60FSTQnbPWjHWiTuy9f3OgqyxH2uniFE8PBgLhqP4
         s5MjsY+qOLZV6LQEoqbu0ThGi83GP8KFk2LOHlkpwZ+DOFajokc9imvxWgy8xSP3Jd/h
         2EypGmiexw6zU3nghd0xtbBSADnFx/K1tp1erD2FyV9gLCy3dLDJHExgmSHpK6bIChz6
         NnfyOC35Uc6MAPlrLjjRV6+ozIISqfnLphD1a0AgOYnzAvttf6fccgXn1A3YHWdH/qTv
         hnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827168; x=1786431968;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niywOdzhojN/SlE0OircIR7xoFGK9onF6ItkQOW0fZw=;
        b=LAumbcVs5cTkaIbESk9dtSTY/Jzml6G+IW6PrkIUvwxTQjHWm3siSd/oJsqC26CPFm
         nDKHy60q++KjYJix7ghoSiLuWeYaFMvbVA/viCG5WJbpb3cYWPoURTBYdKy0Mkc9oOFu
         Nc/03zJRJbSti/RfrnLYY1S4NrcnkHi98+lmRxVh2GIPjy6XAm7ikZiV54/TcqGQKb/q
         nAnoe+PDWo+qz3II8Dd5kqyV+u1Z9vV4skdk/SU5OxAMQJvGmYbqvHdwvquHsHXTU4Hd
         71Xll0U+0AhDDktdqSsbJg1mSeL1hP39ipBraZdgEFf6re6ORDKAcxf7/Ozb2As6mHKC
         scag==
X-Forwarded-Encrypted: i=1; AHgh+RosZYD2/QEaPU2I01qLyTS7howHhFMLF6kojoSV9pcWnMdsyiHmvcTXD4TqSSNKZg19X195R3J83ejEcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywib/6LfUiDJZZ9Y/z18NyEIzj3XeLBCvXGUQ5tTvMBrsw25Hzt
	sShSJJrqOvIcsyBfx0dazGMcdUevMx/KA139SM/F/36n9axqrTfV5uUW9122K+v7Au/eGh0sWIC
	3zJP8x0F3Uha6PMe08GJjX+OIJySNZ4aoCLtHy97WmTOkXvqEyArcwE4=
X-Gm-Gg: AR+sD10FK8+XFizqpQoeWqmulDzoqHESJQrUhHC9p3avRwz2zWHJcPYPaWn27FUR7B0
	7mMaMCRoUAAr/hqwH2AvK21lKakplM8i91ga3ey7Z4eExy+15gC14ht+07VRP0vLfBVRQ6qqlrT
	i7x1V2dQKZwQDBod5iNkeIKq0ZE11uqV0YBSmU/IVRLkvDW+FhoMvwOLeC5yCBK+WATu/P6/+rf
	XV1N40nlofiiD78rA9vr3PU0pgerSJ5P4d2L+x+a66TRPul0NvCnOqPPL1vTg5Ws39FVGisj5uU
	HRNqMuMOZ426hq0hclALn1Ps2hg/5IwWEg12a1R+plUCnsdOe7PN6ZJuTgY1h6TDCnZEe9vbfwL
	X8g==
X-Received: by 2002:ac2:5a45:0:b0:5b0:1433:13b9 with SMTP id
 2adb3069b0e04-5b2e4f34619mr1753330e87.25.1785827168026; Tue, 04 Aug 2026
 00:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707145327.313292-1-marco.crivellari@suse.com> <93161p47-3sn5-r588-o6o5-6n895365387o@xreary.bet>
In-Reply-To: <93161p47-3sn5-r588-o6o5-6n895365387o@xreary.bet>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 4 Aug 2026 09:05:57 +0200
X-Gm-Features: AUfX_mxrcFeuu4oiuifQhlyMnyL7h-iga7xuwuWzDYm2yWLJG8sL6IY7TBfBVdc
Message-ID: <CAAofZF6a66b64FE-nRqvZ7YxxHvCa4nUMxZwhboJnNuUTjTTsw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] HID: Replace system_wq with system_dfl_wq
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 9:04=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrote=
:
> [...]
> > Since the workqueue work doesn't rely on per-cpu variables, there is no
> > obvious reason that justify the use of a per-cpu workqueue. So change t=
he
> > workqueue with system_dfl_wq, so that the used workqueue is now unbound
> > and can benefit from scheduler task placement.
>
> This definitely is a step in a right direction, thanks! Now applied (and
> sorry for the delay).

Thanks Jiri!

--=20

Marco Crivellari

SUSE Labs
