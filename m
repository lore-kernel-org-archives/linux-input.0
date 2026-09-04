Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2F37A83D
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 20:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553193; cv=none; b=PybDQyn+8g8RR+85o9XAdmRQI+hXI47V3eV7P+2jT8tvDxtfb/bsP5a5s557B2kjez56N3z6HB7D/I2Wa5sKS2T6piNeIhTF3xv4FdaelZe3711N8gOK6cwmJlhvkPoscGjRWbc2FknK1RZPaiIoKNhccn88BvYeFMTA9FDM3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553193; c=relaxed/simple;
	bh=NsfYCftcctJ1Cv53g83ogV5vHHW837Te/hcqiSPmv+M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=bTvEsrUZAhy20BLz1Dy7IIGVSuULlYtH/Z+wJGPCCY7ED1lwoEDt2R47aWQNah3VuDfwT9NWluNi58y4ffqYnfmzxEsZnDoCnnBHTPfDeFn25nyOpxavIzepABNd6WgrED2Nfn4MB/Jt9em1+Qn7xobRVMeTvLVf2PndZFb0BNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=rcpassos.me; dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=V2KieAQu; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=l+itfhgs; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="V2KieAQu";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="l+itfhgs"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=V2KieAQu9Ni3bAxU3S/ICgujMImNxvXstQUMKKQaYkR1zZJcnLmvbS1tuNRbpv7EaYoCVDJBjzWfJ11qvGG14/tvauoknnSabrJ6/83kJWQFJva/vnIGZR66zev1uIz3c9qA69lNwqxeqvRcgSNM0rpjUFWy6nKI0VwJQWhcr9b1xlDGGE7MChISCSTieOKSryQiRgmadrMFO5KN4ffX0qNeBFonqeSy2yo6I275CyhCiS13+uB3t8CRPL3x3Oap9bVPVpqo5GsL0by9wUg7zoLCAP8Xipc2qUTae6jbTcm2C26JEAJM43SR1dHEEahwXJJ2yu7PdhheMUlDPf2m2g==; s=purelymail3; d=rcpassos.me; v=1; bh=NsfYCftcctJ1Cv53g83ogV5vHHW837Te/hcqiSPmv+M=; h=Received:Date:Subject:From:To;
DKIM-Signature: a=rsa-sha256; b=l+itfhgsaSC6rfcCzNX2gHMMxDyDC2hh5VrEQQaCnQPfVq2fzJPEVZfxOQ+g5+hxfEmtkzeQJEmM4fmGiVQBUKl4nR5t479NVt+T+62aZ7c13y+7KeEPUzj845INHQiwRtjIlAZKxf2sgOwXQ5YzHsC1Z/DrhziFvYDp3JoXSMDjFditdgqayX4TyQBOmxd23rLQPd5xZIdiXvqJyACz7a6nWYeg9J+UwlVCPTkbFQTqnTR6wWr0uRjh+B3vcUETqyPbxaeK/vpSHzeMq7/DFRQynwRXBCnGWikTVujlGqzvGnpilqLXMOixcUFLTK0jro3j8LaeYOvH6J9ei/g+Eg==; s=purelymail3; d=purelymail.com; v=1; bh=NsfYCftcctJ1Cv53g83ogV5vHHW837Te/hcqiSPmv+M=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 45355:7809:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1869614076;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Sep 2026 20:19:17 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 17:21:22 -0300
Message-Id: <DL6T82VA1NU5.1R1U7FE0CF6H@rcpassos.me>
Subject: Re: [PATCH] HID: logitech-hidpp: fix hi-res scroll for
 Bolt-connected MX Master
Cc: "Shuah Khan" <skhan@linuxfoundation.org>, "Brigham Campbell"
 <me@brighamcampbell.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 <linux-input@vger.kernel.org>
From: "Rafael Passos" <rafael@rcpassos.me>
To: "Alexey Zagorodnikov" <xglooom@gmail.com>,
 =?utf-8?q?Erik_H=C3=A5kansson?= <erikhakan@gmail.com>, "Rafael Passos"
 <rafael@rcpassos.me>, <lains@riseup.net>, <hadess@hadess.net>,
 <jikos@kernel.org>, <bentiss@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260904034843.1340846-1-rafael@rcpassos.me>
 <96cd3161-3a6c-455e-a63c-f3226b27f74f@gmail.com>
 <119cd005-ece9-4e2a-aded-0d6d66c5bcfc@gmail.com>
 <3fca5207-198d-4dc8-956e-7b196f71b934@gmail.com>
In-Reply-To: <3fca5207-198d-4dc8-956e-7b196f71b934@gmail.com>

Hi Erik,

On Fri Sep 4, 2026 at 3:17 PM -03, Alexey Zagorodnikov wrote:
> I've tried your patch, and MX Master 4 + Bolt goes crazy, it moves on=20
> vertical with very high speed, and very very slow on horizontal.
>
> On 9/4/26 21:34, Erik H=C3=A5kansson wrote:
>> Hi!
>> Is this the same issue as in
>> https://lore.kernel.org/linux-input/20260901-bolt-scroll-fix-v1-1-58bca7=
ae487f@protonmail.com/=20

I tested this patch and had the same behavior as Alexey in
my MX Master 3S. It affects the mouse movement, not the wheel.

If I coud ask, could you test my patch in your system too?

Thanks,
Rafael Passos
