Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7086A217659
	for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781132430; cv=pass; b=pesxkXjIQ7Bu/5UmRaQilAuQC6+AKoC8+XSTgbvYsziA3XTfSbcALAuD/DyU4gqrPJmP62Hl81g/BtJL1BXKc4Wt0WHZwZlbNxKHNwE8g0dJ2pqjQrvibQnVm0bU8xqNzp2EAIWz6V1/ySvJ5/fAF5BwHy8zl7Sgng2Bs9E11d4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781132430; c=relaxed/simple;
	bh=da6DME8KN70p2igO4lifzeoHUukwvHlGZTU5j+Pe8pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7oRad6b4bQAM0q+TnrmKjt7zqbPv59RlTxlLyjLdTH0ZbOOzmq+p2XtCuPoEYovSbF0kOO87w0pyhg43pUcgWOvWz8HY/qZVeGtnrANgwXX6UhSfZYJSxe8HK/mGmjA8i9bghWIpEUXsAvNVaaup6SFpsepMTv5F3tLdFTdLqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OswYaYnU; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OswYaYnU"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39677c80386so73661691fa.3
        for <linux-input@vger.kernel.org>; Wed, 10 Jun 2026 16:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781132428; cv=none;
        d=google.com; s=arc-20240605;
        b=E9ciYM/tncY+1DDwhyymPa9bq+ApI4kLGH4aogGaVve+gnJe3hOBG4ZbIWn3VEVfGl
         rVBOs+JctN6PerD4yA1qYuNUaLuAe8+kltmeBvSQ8w8jMd87K2w+Q/fpvA9gSwDX3Van
         9tPIRzl/Z99Iol3W0LHuNyriG9yIe6cGUn7ueb//7nWRTYP4Q86ijIdJNZC6itIrWifo
         VHGvEOR5ya7TmaxsbpObkCOmXQSeDtuHOYSGLXgYPM0w9dKJaeirdBSoniqTMuxFMjxV
         I7VScjproJHN1Ce+AR4S5skvNQ3jeKMZqxZmW/L/rNBwLPmPMfW+d51zDjUaQQNkKvB2
         MYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7/1EYrFgPdRRRbFnHeUoi//T12GwW21L7HHozs2Fh90=;
        fh=Gnj5odFv3xVlTpjCksn/bXe83LrwwgzjInAahotwHFQ=;
        b=aVMnQ3ZXJULevFBW3uLYaI11MzaCE1bahOO5wwA0b+TAJWe1u3QKQYhnOohLie70LK
         5KeUn3y9BEmiubgugMZsPDFFW/egvXKGcY9TSH3CoDH6qx9yO8806ztbz4pLF6GoLoOC
         NGoJuvV4RN9uVCcY3kPxJ5N5N5UUH4MEIUBnSupdckZ/0KcBKPvfx+Wi8QE2OP+Pi+Xl
         mzBHDPlBCzd5uSUvLHMleJl8KL8dEreaK/KilcTZ4CYBLPtlG4GXLyGhOLLw2Ux0ecpD
         0WKgKpLqAk3YnnI4Gowdhx02DdmFumeec4BWcgXvLv7QymMQ/pKjLvr697YExBVbp5Lm
         ILpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781132428; x=1781737228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/1EYrFgPdRRRbFnHeUoi//T12GwW21L7HHozs2Fh90=;
        b=OswYaYnUeqYgTyiBZ5aQyPQCSrPHveeRhC02JJNdSNs0GdeKvBjmEJSlcC+Ay1EFDB
         Ac9rjz7NSwV5x9hZ7uams5oycnU/BkOcfRtd7hlgx/uFmEQlu1n0/SoBevh1fXK5my9z
         8/8mlBHWrPSKi6SjgmKeoOY3HPm0N6VLwSA04WmYuhpSN1hHdMx7HXSpsWorJ2p1ex1/
         31OFwKlooo09DYP1AsmZPwyjHRwIGPzaxYZm3dMMA1sTvsnWwEJDw/8X9lEf9m2KcByT
         YNd8cPQq5QyylJrQPhu0UFArkE1wskOTnVidLKptv3rc4BF1mK/2pk/nxTzlw8eImRU6
         YWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132428; x=1781737228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7/1EYrFgPdRRRbFnHeUoi//T12GwW21L7HHozs2Fh90=;
        b=mukjApIvx6uPc6BN5s11SHyBXrf/Y6Sy8vJzt+fQi6UZbI/BjhwvuIXZsqnQ8+vzn3
         odMS7QkQOfYxjLiRRhDe9wWB6ON2QnqXMk4PZKnyCZG2RSALwZQl9R+6bE40W7RBc5jZ
         FophlbLts1MZlWe0r18fL+Ly0JZvySJNzTHWfjJ2OiPz+bA1SiEWaNngoDKVlfr/3yti
         MX+RFM3Bxq7RKfPnsnmdIcFmrDmYC/ASoKanWm5LTM8PWYdVa3E2X9DM4ZEEJSWOUZMR
         bH50qyFWBPFuN42uID8ElropXsBar75H9XOwr15v7Xnn9DIhgThF/kz2Qooa+qnBRzfq
         IeZw==
X-Forwarded-Encrypted: i=1; AFNElJ+a/DUVWH/jhm690jdNsDFoUH789WWnW25/9QKrEjU4erShyccjsJlFc/T+GCPn6BBAjeBiUFOPtBWg4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjU23b6UyBrjXbOSLZt2H1WOoTx/4BXwqjRTch7caLKKcShZP
	P0+HvkhwJJcqutnMwBw7wXRdE7H+xH8r1T42kSN/zm+s8bxChvV/TLtXE4U57DDLZ2zHONMbXJ0
	KG8TKg2m9DcUGLrpiVdd19JYS0akK600=
X-Gm-Gg: Acq92OEL0gAHpvDqujHgsi85wp6ce7P8EPVRt5+gtkqPYeaXBTNWZdPsfYIo1Ca2u3M
	X+puA1cDjE4aiiLFnYxSFawNKopNfA4KAsOqWKQhFjYNFymfZLfmhH8fh4RInHIWbus9zzM/D7E
	wMVjajKX+EWDacsqP+WynpBxzT0kk8XIBf2y07mpfx37uduppAbG+KhySN3r1e68oHS0uZXRQMh
	hmZzjYN6gkZOQ5PJQ40eNuR9bT/NjkasB4EuUipbJ/Duk+46B1L3EFXZ9y0610MWXwlD8t0DC5j
	cUSJiKVjsAjaku824Q==
X-Received: by 2002:a2e:ad93:0:b0:396:5ea3:46e2 with SMTP id
 38308e7fff4ca-3991a1136b4mr14461fa.17.1781132427343; Wed, 10 Jun 2026
 16:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522050632.8079-1-vishnuocv@gmail.com> <CABxCQKtr1g8xEg_EYEQhjsgAR7QtSQ0dDQhOAByuxvHBeHK5iA@mail.gmail.com>
 <09prqp54-684n-r4q1-02or-1nqr1s4516on@xreary.bet>
In-Reply-To: <09prqp54-684n-r4q1-02or-1nqr1s4516on@xreary.bet>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Thu, 11 Jun 2026 07:59:50 +0900
X-Gm-Features: AVVi8CfjhFNX83SvokZronjbpLZnNtBfAWWPIo6sDFXgqhcP7_d6IudiPVanri4
Message-ID: <CABxCQKucLynqgvUHCmoy-=xAY+AfCAR910ySj57yx5PcuSP1bQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: lenovo: Add support for ThinkPad X13 Folio keyboard
To: Jiri Kosina <jikos@kernel.org>
Cc: bentiss@kernel.org, derekjohn.clark@gmail.com, mpearson-lenovo@squebb.ca, 
	vsankar@lenovo.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

Thank you so much.

On Thu, Jun 11, 2026 at 12:39=E2=80=AFAM Jiri Kosina <jikos@kernel.org> wro=
te:
>
> On Wed, 10 Jun 2026, Vishnu Sankar wrote:
>
> > Hi Jiri / Benjamin,
> >
> > Gently pinging on this series.
> > Is there anything blocking acceptance or any changes needed from my sid=
e?
> > The series has been tested on physical hardware.
>
> Sorry for the delay. Now applied to hid.git#for-7.1/upstream-fixes.
>
> --
> Jiri Kosina
> SUSE Labs
>


--=20

Regards,

      Vishnu Sankar
