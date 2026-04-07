Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860B93382E8
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551204; cv=pass; b=k/Mk2v0Q9avTMs/tXq6iv7H0rnQobDh60ZZcopDJEpks58+Kgm6va8ZKSkdYpvs1DS16yc9pkAdN+wZ3JkIPV/IMnFc3YH/hQIPagR46lUgdmMHscpYfOXxqfyphwztLdlQ7CgYWIf5S2YRNYi5xH24fKjKxNlBjmtTmxDDhgOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551204; c=relaxed/simple;
	bh=oL1LEvi+swarBNOFxg3pitzGuJ4R9brYJXVb8aoJ1eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giieqoodR+KAMupO3Vb1wLEcehGt21lkLTp73WUfKc4lP8o5VfnUjm3siORYx7M2jGEa8zakITPbH4OHPZBGuMsEGlrEwSk36jnbCWUOsY3p/WsmqUwb+bwN9ds3MAnRH9QuKU04VPyicM63dzVA0/VQZ/1X2CsSf0y4j1+Xp1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHw75yrQ; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHw75yrQ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbcf927395so1403923a34.0
        for <linux-input@vger.kernel.org>; Tue, 07 Apr 2026 01:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775551202; cv=none;
        d=google.com; s=arc-20240605;
        b=e1461cWweDxM6sGF6lWr3cg+efbxALPbcCg3blw6PLx5KhjiqlvasB90m/xbcTJHJb
         IGSQsgXKJGCKh0x6GJp3rW2LTJqq3rteeg286Z1dU78oQT8R1PT/0gPqfam8Sz+3N77L
         mkvNgloq2WruYNUOd1nYq0OKgCbr3pe+6z0OJZyQdYDYLb0cpd78rbcsA2s/08jTBThA
         UEjOFaxOGwDeR0gtFTDHifJiaqmG1Gc9cYyB2HDzWsFRj9R8n4Y+un3QstOBkmX6xI8w
         KxFfPLNnxEWz1CzOyYWlO+J8IR7RUdNSbblSnadJxxHKmB0qC7iQOhoENN3QTKToUtTL
         TGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oL1LEvi+swarBNOFxg3pitzGuJ4R9brYJXVb8aoJ1eY=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=PjbaqJPmKlXXE6ko6c0gUwiCWvJxXP/fZ9VIbAwxrFUYXmwkKU+E+ppupBtYEvH1qY
         24lWXX/LI0FB9RnumaMdlN1+7Lh9Rp/tYJ1763DgPmnc/vx2CoD+smB/3kz6YfrV0wL5
         +nx1bQHb7oUl16CaXNFMdzWjnERmElCkEGH4znG1GhXADejffj9YwSp3bFQto3FGa1KP
         ycNIzrvMZW7pgx3CAeWrWtgpgtvH2S56Fk3csqRIDNqBFv2G8gkJ6dkCqn6KaKB8iHq0
         YdAp0AYzhLmMzlTOtgqZPwseM3xeZ/48GAia88+hctH4blRfOl/9Xo/7PV8/k38mJo0h
         U7Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775551202; x=1776156002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oL1LEvi+swarBNOFxg3pitzGuJ4R9brYJXVb8aoJ1eY=;
        b=WHw75yrQARLWidO8valBg1di6MDRPVtgUCuRKo0QHikx9G43NpDtSkm31zO3xdehPJ
         A4DdRSjsz8KZgAh1yYwHYFN+lThqm5OKa36UMh4pL2WFNFOdm2Qx0lo8LEhFa2X2QjSf
         u5tUHiW6P9bb6JX0RVmvg0bZiOnFFpFgLB+cbxAQjJJkGYpIUQUh4F81qCEjm8HPJY/p
         pI/yVhF7IdF6Jm3tWu0D4kumNMqpEXGB3Dl2HQVaAn9V9DfZNb7HznpYq34kXg0m1Qbj
         imH5qXJXxsojgi776RyUFq6X6aJuKIWGQCZ13EY0TGhhjB0ZETwzSGNDg+uWuPit2Zhv
         uMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551202; x=1776156002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oL1LEvi+swarBNOFxg3pitzGuJ4R9brYJXVb8aoJ1eY=;
        b=YjdAgLbREEBpMCv6EVx8eO8zl2SBx8O72hysuLr/75yYzDm/8RsKUuTUsyIWmrVIEc
         CX0A0xuo1pYOHlTz9jjZddxXHhmG9mUl+L4WivStfHesy+FCY9aw637x3wV9HMuspI8p
         x09kVKYyBbsvUBL57dF6gBIBYNH1g++WOba6eXIYHUeIoXXQatvUWIzefpC1Fx7iBlM1
         9GozMA+DtDmcQRq4/fW1ka+DXvWaJ/SFyfbhvhq6iqZX+sYlxu3GwvK0sKMVIN7EgbmK
         X3lj7uSMEhcy67g4kz17LjtS/MTjp4QUCXfrdW5VPhjD0zbBN1TrigbRm7UQIN9w0HAD
         6aeg==
X-Gm-Message-State: AOJu0Yy+a4N+n/DCMFIopFvomvxrWMbPq2kyuxXE0D3yGyI8w0eMGiH0
	x2PqRmqMSjcJlwzbwI1eQRl+J7sKAdJMahEA7go4iABLwvaUyTMpTpNLMqw8ckX/x+5cax2QbKq
	3QJayolG75wKpjhOOO5P6sJsTnCkTSHs=
X-Gm-Gg: AeBDies8GsR8qLraH8C+1V7fPNAvdyQ8Mnuc0j5/0mbs5gESFr/4vm0DTQaYr4ILhej
	AmZX3vtuUJtrjmDnkw2MR1KvuYuVC/ywp1fANB5fR0Ff50RUG6WupX8CVMQ+8KIS0+NG6gpiud9
	1HNEYN0pcAOhZyNNFCmHqoaq1COqYDRPkia53KoYnmKd6uKMIDzAqesSd4gExTVlmfwZ80bzr5d
	nwoBxp5LtQk0V1Z8vqI2Ykm7KzVIVHcyVCIUdU6UOhVoujttACYHh3cOTstoVSazxzKUxYmcjEp
	+FGQRYfKdOnB+RuQo6CH
X-Received: by 2002:a05:6830:611b:b0:7d7:c96c:c5d6 with SMTP id
 46e09a7af769-7dbb6f1aea6mr9515559a34.1.1775551202385; Tue, 07 Apr 2026
 01:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228223628.472208-1-mikhail.v.gavrilov@gmail.com>
 <acCpW6McaPOE0Jq5@google.com> <CABXGCsOwJu2dw67bR38MJb5DFvGon=MUCxKcGEQYfT6qrPZU1w@mail.gmail.com>
 <acDPeFpxX57Uu0Mm@google.com> <CABXGCsNwLTAKFdRDHnGBdF-h3fnKY0_ysQJevMTv-N7+MNwS1A@mail.gmail.com>
 <adSSoVZBLs8b6I0J@google.com>
In-Reply-To: <adSSoVZBLs8b6I0J@google.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 7 Apr 2026 13:39:51 +0500
X-Gm-Features: AQROBzCJtkPIqc7N9wP6rPRXvkReRBhdOO-IpfQOPFoPiFgNGDd50QdTm0W2VmU
Message-ID: <CABXGCsPToHH27vN2DF2O8Dq+rrbHaxLKPJ+u+GbgS-Rxrq9uVQ@mail.gmail.com>
Subject: Re: [PATCH] Input: uinput - fix circular locking dependency with ff-core
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 10:19=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> I was talking about taking this new lock in both uinput_request_send()
> as well as in uinput_destroy_device() when updating the state. With that
> requests_lock will be taken only in uinput_request_alloc_id(),
> uinput_request_release_slot(), and uinput_flush_requests().

Hi Dmitry,

I've sent v2 as a separate thread with a dedicated state_lock
spinlock as you suggested, along with Fixes and Cc: stable tags.

https://lore.kernel.org/all/20260407075031.38351-1-mikhail.v.gavrilov@gmail=
.com/

--=20
Best Regards,
Mike Gavrilov.
