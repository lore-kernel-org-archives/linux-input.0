Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0FA23EA84
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596233; cv=pass; b=IwyFlBpcUoelsy2dekjGaJ+BzDSnyb1EIzPECOk0AhMOi/MI4GE1zhKflhekZFzhWwhoCbIhs1Zip7nx393LG3NtUKcF3xHtGg3IhiRqVDzynROdxkxPWV7GfGt3RtZUnuPnPFdJO6t2b6GUze8A0nEvujair6Pv1BNrIfRd/hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596233; c=relaxed/simple;
	bh=RST7OJIugtSUWo+ozG3/grygRyhdb/xLZkeeWD+dCrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7IqWFLIenKTcixDnMDxU59r28CPgv2Jum0N+mbkz95aLWHSJneS0eh4wYuNi5SsFp5CAIWsASLg4JF43wNzvFgWv7WRxL8RaOPhSed3O2Wdd7f3sildt1QRxWyaxN0DuXHzJKNRKfk65K4OEpYP7X31Q778VYg/QRMf795dSrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckgejS0s; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckgejS0s"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so7272702a12.1
        for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 11:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787596230; cv=none;
        d=google.com; s=arc-20260327;
        b=cGb/KORZMlsjoe4/TGLPv1Za1E4HigJGwt9YMYYD8eGwvE85G+VbEVv+YSGVNYnxCW
         AqhqnDnObv1f6kLbjlm+Semq4Dc+figWkMRPlOxpBIkljxNUK3APEie2WLPeynmL1rCj
         BToxAELqtCypYquewll7Wiuv25k24TkpcpXNhsA0c+WYcK0iM/u24JTOXFwgdVITWskV
         b8rmh+He6UkGIPs1/pIBIOIDMX9eQqyXo/6M5JoJPnl9b2yYBM2v/3YmObxSzXMFfOxa
         oMutAMqeLxDVR0GhQwmoAp3j2KtLm5pyz3xpPwzRRE36tUMeCEcdj9+qiT6ao5K0HcyA
         HTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3k4KmedfE0nehHboMbrcm+Gl7Ls8rJ6N6t3GI+gy/JI=;
        fh=wc4qPO6qLR7qFHYkXJ7Bgk5GkhnPR5Ga/CEgQXmpfFY=;
        b=Uoymk7lmFzU21b4IZEuo/pGhYzl/NpkFTvhqVNQ3WWyE5D8kTzueBEbH4aHY3iD0s0
         ZWn3SqmVgZC0/0IBtFTiCPX3uKReexMy3tX9fXytnYbZ8Mi/vhHL/bR8hMPcknDxG3e1
         gCuPHgNKEMUiLFziJSJ8nFnKjk44+7ui7xb5JBiclKk0Dtrz9FAyEG1tkvRSuMSR9TBb
         nEggYBsqsvETy/3yr4itOfMGrqLjwa31KpAJqPL+CxgQQz/SM5XnEXkSYgMzvIF95WkZ
         UwO5CF37ebbOyXW29IA6DFtKLHAWyrQdof72RIV2Gig4OqrfAnUooECuXjHge1o2R9XO
         b+1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787596230; x=1788201030; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3k4KmedfE0nehHboMbrcm+Gl7Ls8rJ6N6t3GI+gy/JI=;
        b=ckgejS0snIjkANQnG/l29eOR5o4txTnfZQvVOazf0u65Dujn8nyoGxbMRZaJ5WH8VO
         zJnV7NefAI/rOWewzf+FgjQgPr30q3UdkJb1QZV8I+wSwW6Sm38Xlv/mtdCXUf8RtJlA
         HoD/ZBUPPUpNJuL51X6zWs7hIsLlXDB5BStTDLFp4HHiWbX1OO45EJcPn3FWCba8jGAk
         woguoMk3jN9ltzDsKxosOe/d6makDjd8eRinbuk8nGc0fZXiaD+1RXlD3TR8HY9pFxKW
         DCPRVvXDZ1PeNg47Clu13lTArAn4t1g8tuvuiVqXZQHhXE1ifjkG07fbcUg0ThJbVzbk
         HrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596230; x=1788201030;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3k4KmedfE0nehHboMbrcm+Gl7Ls8rJ6N6t3GI+gy/JI=;
        b=ByPA1wawHOVlPyM2Q63sUuDOtUpABxdEP0Hf0r4XhUPZUcRGTKPaUJvVTAatRtAAXy
         kmaQFeD40xU6aCbUcBDmOK4luWplFr/rQ+x+m/CyN/0ubsrdDpNjl3jgV+BA2o0lnUmk
         kYbPALDcszZ2sryhyd165oIlFRXmeCtA7hQ08MXXAMa2NA0PHzJR1sYXymZN7hwyMlsF
         AFHG5lsfDQQai5HxTHTYd+DnwRygRSbbyFIjMMM/ARSX0zUCutCkzzMqpMRFuq97yJoy
         di08gYxXsBgTQMERnTyAkWLfDHEPG1O0N2bQlRyI1aCIF7Qr8k9NrInbug7R0juXFnE7
         qGkQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrl1NFYOgbdonQ1QAM2ecD+N3I0ecbi0M98lPEQ+wd7/6oiTUHSr8MjBaZi/MAdI8r7IZpM1ZOuYmnwAw==@vger.kernel.org
X-Gm-Message-State: AFuF++mZSYI8uheQ2iDZH0U0OZyXdZWtNdqnFS1Myou3kGBWZ+QRPLyQ
	rArzRrMdHXWLxFxVJ6ZK3MLzVt81YNHMmBMNcCicpxE/60ZDnS6tXtCJSSiqWciXOzBAFfm0TmF
	n/RASQO4G1y3tbJbKMt/jObpntPMrbnM=
X-Gm-Gg: AR+sD11guGj6lkliz9ACjH4OmBeOvCtUuL3iuIHIBWuROkTkvVr0LtquWUz/yvMHKzl
	Jl6sgm5wIR+TrXpQVxF6p6Qs9OA4VZPIyMLCcA78fcIaWotYy5OrWFGzDgo0JmR7xVwxFXq79l8
	Sez+22+8gaKMMHQOyQKOcBa/1wXR4gTyMCW8H35odPQclDGMN3W+pggrJHV5HlowGEK+cBb4mcR
	q+uY+1N47UKbROT/YYYYsvOoxy9b7IGzNLsZ9WCvPBOVdylduovv3V5UBU/xMm+6oL0A1U7xg8L
	DqdSnA8WAO2DCsKJCBXAt82+62MsW8I8W3cZtqg3by9oJA==
X-Received: by 2002:a05:6402:23c1:b0:6a3:efe6:3ef3 with SMTP id
 4fb4d7f45d1cf-6a42f169960mr31023980a12.7.1787596229966; Mon, 24 Aug 2026
 11:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523105545.68079-1-technoboy85@gmail.com> <9no2pr1r-5277-5765-9q79-on37sn09qn4n@xreary.bet>
 <20260824102552.GA813380@google.com>
In-Reply-To: <20260824102552.GA813380@google.com>
From: Matteo Croce <technoboy85@gmail.com>
Date: Mon, 24 Aug 2026 20:29:53 +0200
X-Gm-Features: AcwNN1XFGXgfXfJUe8pxjz7rRW96oF9sJsM_E3uV95OPyf26ckZIiq9D0xkfgbQ
Message-ID: <CAFnufp1pvgqvQqa_L+XFAsVd=rds4L9L14tg7B5kHtRdKFwViw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: core: demote warning to debug level
To: Lee Jones <lee@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 24 ago 2026 alle ore 12:25 Lee Jones <lee@kernel.org> ha scritto:
>
> On Wed, 10 Jun 2026, Jiri Kosina wrote:
>
> > On Sat, 23 May 2026, Matteo Croce wrote:
> >
> > > From: Matteo Croce <teknoraver@meta.com>
> > >
> > > The log level for short  messages was changed from debug to warning,
> > > flooding syslog on systems with devices that regularly send
> > > short reports, in my case an UPS:
> > >
> > >     $ dmesg |grep -c 'Event data for report .* was too short'
> > >     35
> > >
> > > Demote it back to debug level.
> > >
> > > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> > > Signed-off-by: Matteo Croce <teknoraver@meta.com>
> >
> > Applied, thanks.
>
> FWIW, I'd like to contest this patch.
>
> The warning is real.  It means that the HID report was rejected and as
> such something on the system will be now be non-functional.  Silencing
> the warning is not helpful.  It does not fix the issue, and now the user
> / admin has no idea that its even happening.
>
> This warning has caught a bunch of genuine issues related to testing
> infrastructure and incorrectly coded firmware that have subsequently
> been rectified.
>
> Please don't hide this issue.  Fix the root cause instead.
>
> --
> Lee Jones

Hi,

the message was debug long before and was promoted to warning during a refactor.
With my patch I just restored the previous priority.

Regards,
-- 
per aspera ad upstream
