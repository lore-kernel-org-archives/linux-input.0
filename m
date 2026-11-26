Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795661295;
	b=ciHSroOfoue5YmxZTE/VNHpKQjFyAxkg9wPnEImi7Efmd++F68okCzQRlZFJZOzp3T/6
	 Cl8Kn2Dr+qM44xxSgzgfLDpzTHHBsC2kfoVFaUxHewAS8jkpAd46XhaPesQqnTpcOqRwv
	 44nXJY8eFi+SFCx2hFq+xMmLXrYydcb7t6I4EQPmV0bhY7cMthQaD52EPdzSYQAbOk69y
	 I4Kd/zzoOwqzehZ2QUi8kVGyY+K6wVBKAR/WjCQrqdv0zjkK83djpf2FUt7/c62EUhQc4
	 SIPIpNCYF64uwAWfzqlebBxfyuxjeLDMNu4MUj441HDMXINaomCS4+Q9/aFpObywncw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sSFnpqUuUbjElix+JO0v+jouPkVBxE7R6M/+d3k0EDM=;
	b=z0HtcGbCrY0333TiX4Kx6lTxZYs9u3uuYnlBb8KOuN9yWPdumqiy/Rkpy6pPyX6MYx2o
	 Gi8MI6qT0XYr9k5QdX/C4GZRV7HgOexUbJCTLXsYRe6FPwvET0f8GpBgqsktic2TnDVt7
	 hnGTDsRl3SX4OQFp5WdtkLUNqMl0z1orzVbqjCECQ/VpfPZo32/SvFQhupgLtEAjcxHYW
	 I1qnHi3WlSaG0f9iwuSMneRA7z/PCBP4sKFz/JPF9Dtvt15HosH0PAhUitSl+EY2gaKR9
	 2O0vtvc5ioKz6nTiNxDw8wjiwDT3kMJC/CC5ZhYDPF/Rd7xV7HZSxSuuWUV+Vgc4bzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RZStdTq0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94DE606A31E
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 02:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E94DE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RZStdTq0
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be47aa555cso8135605e87.3
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 18:48:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795661293; cv=none;
        d=google.com; s=arc-20260327;
        b=DPCP68gn5rMZCSPEZDdFCMsXjjppXazdUOuId/dxB6VSgFSWJq0x61/AwjdwcvwfhX
         eN4lsg30fv89Q0g2ii5SEMQ6Xsgo8XpfScUj9KwaYmP8oq1pCVhC5Ur0IAEzmouCy6GA
         8cVaZVht9wpQGhL7NLUNM6HOVpQeR0sIP760NqWnYi9JVCxqJu26gDdE9hpBixBWZJMA
         reX/koW7+IoBJ7mVtvOJ3tAxBdpC1eQiHirnFZ1/SyhTbGUs2b2095dcfE20mv2tJout
         /7VijbWE8b8vnBnMjKIyLmAjOWEeKL+AM+PFnMsgqroN5eNt7coTh05SioZaYMboVMyc
         SGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sSFnpqUuUbjElix+JO0v+jouPkVBxE7R6M/+d3k0EDM=;
        fh=+21GHDErytaO+CkF22R3LsXdhOW4g+D5BQYmg/pedTk=;
        b=XEETdzCGHQW+kmykj5APanLI7u3El6gQVjf5AdmsNMJlzhkEN9WJLquDKuXVZWh9jx
         uXe/k2QAC5FcLJ9UqhG9hwYTy1C7E7EuzjGN2iIg0ghGwhBLoRcbVYb5msnSygiVW0X0
         +A+heG4FKIZu2gsHoLT8ETy06k2S5KQA0D9hruyqi7JQNTG/XheCo/3V6ukTukYioKcO
         xlU6hHtbsTZtftkoJTB/kG6M7Szcw48JEO/GZxEW4kmF5Aouwaw2JOvT0WfPrz2RKwP2
         MTe2z8x5mlTsyGII4ZJuBhXtgVQFcYwb79+bXWOfkiK9sVKjN9BZnxq73DaZkI/scxdO
         Yyyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795661293; x=1796266093; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sSFnpqUuUbjElix+JO0v+jouPkVBxE7R6M/+d3k0EDM=;
        b=RZStdTq0/KWhsgaLcWelVgO0rfVN/AIjokPuIYlr09nEwdBHkcFLaFMsdzW7BkHetL
         TrDKVN/cTWJzYk71S7A4+NNtvQoP3fTbfFmvM43PDObmq4e8Xxy6WIJoZkDTK9IIUsIf
         w9JLTG4dof3j4mgJPFctiDJ9T5scHcr4koVZskvs/v6f09ECohStwaZv5MEUwEfP5mnI
         /g3RIu/7a5HYSdLBr9PIQGqSigyBJzfghlOrA1HmzbfehPa0QtlpFJqYU2GgRzZVInO7
         xWFhVUeHQIvyS65EnUyqjeGxAoPMutTqJB8oRMUqZUKtwIB2fYuQluYoAPZrjP7DCQHn
         fVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795661293; x=1796266093;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sSFnpqUuUbjElix+JO0v+jouPkVBxE7R6M/+d3k0EDM=;
        b=RwQID8dLjeHhr0CKQAaNiy94854fI9l6H9GXII0XJliByB1EYhk0/0+b9UZpb4+KkF
         skJyHjMyYmqzwQPYQa3doYBul5x0wfkbCYzhOjWNth5qHubOonOKYfslEFfqmnmtRUEl
         FHdmtzqftpJYIJzWJFbtsi4rCZgJYN+2+xPM7hFWgWdr0LjBBoRR2Fh7Qxy45ihDGUyi
         mOURSV2T3coaMXxFFWH/ngKDm1Oke5fU+6Gr4VP32yXJgMZC71T+Z8VyG8QQuUG5JGJV
         qMmEugSvj3/87KwKqheo8ME3dFs1in8OSfbJvMvYsmHAvsN/ebb6AChZW0Wvq0SeSBC3
         LIgA==
X-Forwarded-Encrypted: i=1; AL+hErEFUaWTVP0K+SrCatdN/0XpdRzNZg2LoZ64debT7WE2XnasJsBB8MUbxGmebA0E5NgiRdf5iB/lWCKozA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+8N4WyEN7sk0N4wnWlzOFNNXuhqA+sRNNRfuOmLCDyrQtbKtUg
	XmbHLrM6WRIkNyToD0TsrZSCgWq1LX9r+iT718PovqBmaFjyWXuvqZMPi2bTXZardtoL/wRzabA
	Br03LQ6vh+fwCbT5ZyhBQGnJVIvoNJNmVBWugy7hY
X-Gm-Gg: AZFdTZdYG4OwpAfvm48h8ohtDcsfCE0tFQz6n0ht21yZSrbZAGkYpxvWQ2rueyBLCPS
	iYC7c8/WAn+jkMD+AcMC/Tn0L5dpySuGB0hKmLMKdDKoibYWCZtH/5/dRTMa4fRyzUEecBA/mhC
	8kd3kWrPyHeo8qCldJ0/VdfzUSmJ7hAc+7pReDw+nuTBvhjfqKSoonJdORVP1yBmZHa4wn8/IQQ
	tu6F+Ou2EMMohSYu8mzD0qRVb1rXvUSLR03OW2ys1afQuriUIYilm5A/lwGEK/Mw+4MgMV3Z4Ev
	usQaxDslwjtCbiN32JQudfdQaNwBpGqSDvJo5iueRZRB2IKW0RNrKc1zYWmL1GaH0yyfiWlAQ06
	az052bPXTDi8H/N7xg8kQ7iuOQGo15mWEndxiZGyCJR5ZL3V5N1oDkQ07n/iTDUnOiEo=
X-Received: by 2002:a05:6512:3d14:b0:5bf:d54c:c189 with SMTP id
 2adb3069b0e04-5c1bc660a0dmr6174968e87.5.1795661292818; Wed, 25 Nov 2026
 18:48:12 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110020632.4003499-1-svv@google.com> <20261110020632.4003499-4-svv@google.com>
 <CANRwn3S63O+WRTGhpcNR__ybSuYUb2uEJavUY3b9Uaa_vEhWXQ@mail.gmail.com> <CANRwn3QjnmnhJP2y7tihZWrvgkdT9PG+qGaNbEW=x=mgUP4OHg@mail.gmail.com>
In-Reply-To: <CANRwn3QjnmnhJP2y7tihZWrvgkdT9PG+qGaNbEW=x=mgUP4OHg@mail.gmail.com>
From: Siarhei Vishniakou <svv@google.com>
Date: Wed, 25 Nov 2026 18:47:56 -0800
X-Gm-Features: Aa3M54rOxoiOvBSclEq7_xDi6e9FQMltiQKQ215JTx5OlREUy9W3b-zaJJ0tzEE
Message-ID: <CAKF84v0trQ5gpW9ceGmjGF-_Sh7vgitoeoqxRNZ-+xScnYU4MQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] HID: wacom: report ABS_TWIST alongside ABS_Z for pen twist
To: Jason Gerecke <killertofu@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, Jonathan Corbet <corbet@lwn.net>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 24 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 11:3=
9, Jason Gerecke <killertofu@gmail.com>:
>
> On Fri, Nov 13, 2026 at 3:29=E2=80=AFPM Jason Gerecke <killertofu@gmail.c=
om> wrote:
> >
> > On Mon, Nov 9, 2026 at 6:21=E2=80=AFPM Siarhei Vishniakou <svv@google.c=
om> wrote:
> > >
> > > Historically, Wacom tablets reported stylus barrel rotation (twist)
> > > via ABS_Z because a dedicated evdev axis did not exist. Now that we
> > > have this axis, report pen twist on ABS_TWIST in addition to ABS_Z.
> > >
> > > Keep reporting ABS_Z to maintain backward compatibility for existing
> > > applications that support Wacom devices.
> > >
> > > Signed-off-by: Siarhei Vishniakou <svv@google.com>
> > > ---
>
> Still waiting for the requested inline comments, but in the meantime
> I've been able to test and verify that the code works as expected:

Thanks Jason for the feedback and for testing this!
I just uploaded a v2 where I had to rework the rotation logic - this
way, reporting "0" would mean that the device is aligned with "North"
direction.

Could you please re-review the patch? Some of the code had to change
significantly.
