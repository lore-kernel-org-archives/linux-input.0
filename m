Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F0335BA
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769376699; cv=pass; b=S7sRVlbVqpiy90XD5L6DSrogqGw477LVirEFQlmDN9ZbI2bMm3wdmdEckWIoi96jFYKTDijDmqL9ylbFFaXMkhcS669/Ea2ZhZkyOcVapoc90S1UBVZIPvI03KY7HockgH90iFZ52P2Yvs+bUMaepdrxyR9doAvVuA0Ygmt4JPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769376699; c=relaxed/simple;
	bh=kt+A9gkwiv0rVYfc1NFUTFQmmPKMr/qiYHx6z3t964A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFb6H3q3ubmGXCMQtHaPfBTz51spP20hTsUevcBTUMuX5RbYimTakbBRt1oK12u9L/5v+GeMSLYpbRqhjS3v9ufg0E87Irvzo6ytGoEWxvg9TNICWgagDUH661IWiiQWUDzuDU9f8ZkR6lfbsweqelFWJ5Ro4C07bfzoN+kdri8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clPbEdOy; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clPbEdOy"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-941275fece4so835133241.1
        for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 13:31:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769376697; cv=none;
        d=google.com; s=arc-20240605;
        b=a44i6a5HlUatavCl5rkEQznhTzrupsAy0Dp4vC9CqPbhCATAqUQ7uHiA0CSyt612B8
         gOFzzc3z3K1OUwM2pTMbjHXOxBl/AXcI4ltXJeR3IgnQ7RwC/oo4s3rY9DmOSapqy8ai
         qHD4ZEzTlWe1QNTFnat8bxmn1s11pK8eJQH5dowW+cmmS6HIx+iXYB1s3HFVrTk6eK0Q
         iwyG3b017ethXvdPuX2LRXAPSfZKUJ+LCniZyIkdrcXmGdhPXdjgMxzvKPs3DsUpI8/g
         Ntgnc2OfHwg+xTrOjiKfyVEfTepbhljJaTBusDnGUMzlzyCLyHe3UsnkAiLLu2/r4Gkr
         UByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kt+A9gkwiv0rVYfc1NFUTFQmmPKMr/qiYHx6z3t964A=;
        fh=f8H2AG4VvzN1SJh3MWvswpSmPqSJO9zfzdNkZ8ZkGeA=;
        b=W0PajEJAdtAtjCgK8s94LeyyOklRvposuNg1ect+I3isY5N5pWWkA5ca/j9ms6SeY+
         /U2KULlqY+HaHV46ypIscthRH9N5PjBCz4BjqJpOD+5MkfLfF6CEAWK+5m8+ungU/XQX
         UgESWwZOLwn/nmIcRLicNBA/tbt7rkE3ONb6B1qB8R/0DySSsZO6yqYyu3zT946Tuz8b
         o3ubVKlF1s+yLk9HvSDqLGLg7jSUdsinZb1OxdLfCKOv0JoRCTgh3RhrL/+IMWiSz+7M
         8v2U9wu5ZsNqzZ5o9DWI8yUCNP7wfCd9wOKgGJCUtbxRAfOgnFJ/Fo0sPI9VvOt8Migq
         SPUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769376697; x=1769981497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kt+A9gkwiv0rVYfc1NFUTFQmmPKMr/qiYHx6z3t964A=;
        b=clPbEdOyHe0AFVhbINNVlDOQsryDnl4TQPQpDtppWGw2+YLOC9FAgbdzWw+71L750+
         QNGQEBYc71DrilvUbCUQGcl0BcTZn5UnVgs++g7MS1Jel+W2zKutfw7gwYsz89X5gnng
         dKurxO3Xlf7mjYt+lCyB9rPTntkaE6kERYN4b0mbYkQAgXQYlszHtiKl/0XhaxqwqFmM
         lZDCa8lb9fzuI0OSpKEkJEYP+o2zPUTuy336qQ/oBgvCQHqUJN7prsKInpE4RKnH4JMO
         AECRnVgD1EL/1ohJvKbIh4EVX3vSPi370S9AtOUjB6UpTrcGp4WqIEybit+xWed4yXg4
         PPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769376697; x=1769981497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kt+A9gkwiv0rVYfc1NFUTFQmmPKMr/qiYHx6z3t964A=;
        b=ttv090wmNXhBY98QGLUpMu+ApkkWev70aY36t/hgZgTi98tn97SXMIUuMMveE5PtUs
         wft5u/Na0vgElE9Uy3/1Dlq1sHdxuBmqNWhs22uCUNEpcn0kzMv/M16Bo8eFwLtrOzCO
         aQEfpybU6rMLmS7BSul2aVRSj+UdudsaCrpwxwqhB3ybC8JO+Rj5S26IGcFsZxcmFqtG
         Di30UqvYeXyyybr8gCjVIpm1nfvgdvu22Zi34wZHxYT0iiuZiJYSuXsGot1ZNu5oArDe
         Q9AJuNNKG9ixO36JHoHFZ/hVg75TQYGRzpdSySy2/ukrW6Evb+wIYU+YebyeqOxAnbrv
         QWAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTEGvnzcTPhR3XMesJuJ35T4sjnaybxVnPtYTo/AzA01pD6p5SYB45/I9a/C8ZMR4/6AZQleT0adKKQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YydcX+6w+qUHUn7txuqTh0LHfrY+s3J6BOEmndSVAmHgVJrQlnX
	4VW7CxquyOWyD7CJPrBivtMZKXvns+9nXB/z7nt6cD4+FSH0xV5dMusyhgrYxDeGagvqV2QevZh
	eSgYe0o4SBlc/ZTwKf3Xgd70cbqkZSTGNfw==
X-Gm-Gg: AZuq6aL0/c+ygqwPVJv86J+wvyDLB9mgdvlWD6RXcmSft5IRsPxmxPFEB/Zn5/vOpmW
	BySRLZH/0NQYhFcUkTYNqCOqJMdXFRFJG7YhTYVTyeAHKHSP8Fk2l3uHXpg364k7gcx3RqZjReW
	MfwOvLDQdOXsUk+qfiOuvEkuo4O7Wczp7BE0s6FIIViLCk6iOk7Iuqoxbtm3UXpxnmfWxNu/CGv
	H8PbCmYbAoONV2iRX9h7I2dcOGGWp1RXe2bJy4Z1mttkPkUR/j7phQ1g26560hx/VLhpLQP
X-Received: by 2002:a05:6122:16a8:b0:55b:305b:4e37 with SMTP id
 71dfb90a1353d-5665ca04c7emr530562e0c.18.1769376697549; Sun, 25 Jan 2026
 13:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220204811.3539836-1-alex.t.tran@gmail.com>
 <38r99s88-7pp2-6s6n-2148-34s5rrs4s225@xreary.bet> <CAEoswT3Ft=XSeogfob0aitGkUEQY2dqoYcjT1CbeGWwFAsA+KQ@mail.gmail.com>
In-Reply-To: <CAEoswT3Ft=XSeogfob0aitGkUEQY2dqoYcjT1CbeGWwFAsA+KQ@mail.gmail.com>
From: Alex Tran <alex.t.tran@gmail.com>
Date: Mon, 26 Jan 2026 04:31:26 +0700
X-Gm-Features: AZwV_Qi1Kum8pdTw00BH_Rs5VGjGZ1cdeRTWWvPi50NfigQsw5gh_9GVjfVvIL8
Message-ID: <CA+hkOd4fYBapwcPFo3HkoPr-REEZbofzACo+=96C3vtvN16D5Q@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] selftests: hid: tests: test_wacom_generic: add
 tests for display devices and opaque devices
To: Erin Skomra <skomra@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, shuah@kernel.org, 
	linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 24, 2026 at 5:54=E2=80=AFAM Erin Skomra <skomra@gmail.com> wrot=
e:
>
> Hi all and thanks so much to Alex for the patch.
>
> We tested and reviewed the patch and everything looks good with one sugge=
stion.
>
> Since the properties are mutually exclusive we'd like you to add one
> line to each prop test asserting that the opposite property is NOT
> set.
>

Sure, I'll send in a revision v3 with the addition. Thanks for the feedback=
.

--
Yours,
Alex Tran
