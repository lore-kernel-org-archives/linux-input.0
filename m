Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85DB59C97A
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891314; cv=pass; b=r4iZUxpofA9LeFVQLmW5yPtcBwgqSliBRm4IV5l95hv2pINfq77ws0k+Kav75pMwpYWT3FEcVWa1JKPAPW4acVTwP5ZsrntR7ahK4nmLNatnyO4I7pa6zQjCjle25ho5MEKAuS0SV3ELQiKVevvX94PB6mWiW1m7IzuIlDvC/uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891314; c=relaxed/simple;
	bh=I1JWkwexAdECXk7Ri9fH4s02sP9GMsE/7YOTlpBK2Zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N2b57KwdBM4K62ia7n9N6ILnkIb+a0iJTUdo/G8GB5FQGmOfVaXTL8LmuV/u5MtRaX3m4oVaCvCQ0wG4wKEnG+FgvlRRzj78bM3fLK1h2cjUCQ56QSS89XnxGoXzHb0etFHx4MtUzu/O3wRf3NvLe52UBTiqGQpb6qOBI59vEhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSvEsi04; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSvEsi04"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90cc39e06bdso59215436d6.0
        for <linux-input@vger.kernel.org>; Tue, 08 Sep 2026 11:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788891311; cv=none;
        d=google.com; s=arc-20260327;
        b=Iwb+of7vY9SxPsTvkp32E1sHtXR6ORGxrGi05PZXK3KgDY4NkDtHdTGUO+DHQxcXfk
         tHzc0cbzhF3S08I5w0xvv+o4rTTlLXJ8FKDUBxlgZHMAwPSsEv4jO+Y7r41YezisDYsl
         BnXT676TcP2kwaxaBrSFRxQsAMQ2lC8w9SV+Jzqa7RkLSVfBJHINUUi+rqc2Dt3cxcyW
         dqBqkunydw/0jE38pRggurqsYS8GOk7R3gHkGaWe+nsOXu6mfTZtMK5rwLxvEmbf/s1B
         PgXozrcx4aQFOsx/9rIpz2knbwAP1J4t8eO5joeKs2pSnoWywEWH2Jdo4FM/xWmUib26
         YeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MP3apYl6WaB7KiBrxFylQ3CL+F1Ox3GURYmefi8a5u4=;
        fh=jvY6+s1lKvLV2g8UR5LrAdISM5wN6bplPqI/7LNaY/E=;
        b=KbxYEN5xxyhQC0rxb52daowKRYcVf1K7AnxzTKW73NYBigZi2BykRS9jj/GCTYqjJz
         KfKLVV/+Pith1t2nC7hoyGGugn4wunD417BrXIfIoRDlEmq9Fc7R6tnsftrvlwiod+dI
         OYtrguwSdIGPCLAYXBjHu7mC6bOouyWdYf89eWkIqosyYxt2fjqo55JLxYk5Ck31xqbT
         lxoSUhQtQ7sdrXVEUKEbk99lOy/6aQcv59orS30QrcxZE39CPyuuDk1oeadtvYWEygvV
         zleSf4hPjjk6lpYGQQoYzht76FhKzjvYsjB13Vx46gI8/bT0ai95PpgmeljQXY0zwO23
         9wmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788891311; x=1789496111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MP3apYl6WaB7KiBrxFylQ3CL+F1Ox3GURYmefi8a5u4=;
        b=PSvEsi044/VNrr+XO80eXovPHgKTD4gk4DP0jsH5y066JJbWAbjYw/ytoLwzIAgwzn
         +WjzQjjQlimRn6hvbI/9BnueMc6LTpiC4I6ScDju9Ytji4d8N4TgXZJnXRXTAETG3Def
         oLwLSC8lL29A4EqBtaNs2akAoS0H26mP8VU03BPDvP0Bmvd1bIO3AMjzrar/XfntgzBl
         ynU4cPXcqer8s56en5zhmhc2Fusw1dXYiw7TcpHaF7IgocQTdMz3LUpvwsVlLefqofmC
         6AEGk+kk54oSF3JiD4KN6ZoVWucF1NKrJGPRie/qGusYuisSdcXJ1ekqBKwAQqc0kfFn
         pAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788891311; x=1789496111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MP3apYl6WaB7KiBrxFylQ3CL+F1Ox3GURYmefi8a5u4=;
        b=nhpQ2YWfySWelsQK+SmfQdpaG6tIcFykBA057+I3hgQwPmYQ+FYwYfucP/nC00CfUp
         kUbXsrY7EH3GgDTPD9olCVGudh+VozATMK91GZKmKzZC5b05D0wOFV0K95bq6bhPqHjc
         8iOY8gf1DMb5XIeYzxbdsmeAg5qzvhwEMMzeOQOJHi4xmf8jH8nQgdxfrd5qva3vNGK9
         vgYkE9D/HmplVwnsw/islBxocBPjOvZxIkR4ZTtnZkHoK1ok3QKwx14WG/ZYRhArONeb
         RJv/yPUNq1jTfgp7Ck5UILLKTSkE1yx1CqrxOYFCAJqp0AV6Z6wR+qwtMLMdnE0kdNxY
         FHlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxFKmuFWtjENQrpkPseAiuEO1biniRhi2kbb4x50RovFaSyDGVXKyLT7PYPnAtlGSD7rJP0a22JV4StXw==@vger.kernel.org
X-Gm-Message-State: AFuF++lq5fg/jMKzeQ7rh3Mk4+qAaEZV5qVwvHaQP+/t2lD8iC9V5+Zq
	a5ZT0HR9WN5291NbT+qBnwwuwUgVxEq2QqbPGxgJNyXWPE9hWFoaLk5IodOh5YlMXsCxi2CVJMT
	IJ4la+8JgaMTdmNwWinHNZmhBuASXESY=
X-Gm-Gg: AYBFou2SrLKzQfJV4TpWlFNKBaO8seGyXOIOLM6P5Z9wD4w9SQd78yuwzSxbRy8s8Uj
	EElBNgcxKYjO4wBf7thNUweOM2tnKnL9VAT78HhMc4CeR5El6Ew69iS6ZG5JeuJbfrNaC/8ZftO
	48ZSnuzXgR98ZRbz2ngrw0GY/tOdtsuJcxZp1KhoaInVJtA1nrnR+SQ1UhxGD9N5U1dqdzbU3CP
	8T2Hr3Zk7PviorKQ94pHeppJtq25Py7H7/f/aaAJjrNcAD1MKWiMPHBAvU18+4uvSrg+vXCIsoe
	HnKON00Sg+kUXyurpUD0WHDsx8DO6VOoHFb13IYl0+MYmvH95lEtYKk=
X-Received: by 2002:a05:6214:6354:b0:90e:8a84:f5b8 with SMTP id
 6a1803df08f44-9103efac50fmr274978446d6.28.1788891311145; Tue, 08 Sep 2026
 11:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
 <20260904020235.8227-1-98lawweijie@gmail.com>
In-Reply-To: <20260904020235.8227-1-98lawweijie@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Tue, 8 Sep 2026 11:14:59 -0700
X-Gm-Features: AcwNN1UywzU7cqy163imiuwCDI-OJo3UKdSrETVCLN-wYAoD9DpBSTsnKrDgB1Y
Message-ID: <CANRwn3RqPvR7g3riuKSg11TCm+Yt9MTd6r0tF4tqSK3rcRp_gA@mail.gmail.com>
Subject: Re: [PATCH v3] HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()
To: Wei Jie LAW <98lawweijie@gmail.com>
Cc: bentiss@kernel.org, jason.gerecke@wacom.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ping.cheng@wacom.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 7:02=E2=80=AFPM Wei Jie LAW <98lawweijie@gmail.com> =
wrote:
>
>
> On Thu, Sep 3, 2026 at 3:36 PM Jason Gerecke <killertofu@gmail.com> wrote=
:
> >
> > I'm still finding the above paragraph kinda hard to understand. What
> > do you think of something like the following instead?
>
> Your version is definitely easier to understand. I'm good with it!
>
> > Other than the above language issue:
> > Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com
>
> Thanks. Should I submit a v4 patch with your "Reviewed-by" and the
> updated language, or is leaving it as-is (here) just fine?
>
> Regards,
> Wei Jie

I suspect Benjamin would prefer a v4 with my Reviewed-by attached so
that he doesn't have to make the edits himself.

Thanks for your work on this!

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
