Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDA151991D
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949743; cv=pass; b=sl1vVspj7Vbi2/gBuKyodmVKjSa8yEB0tPX41s0Sy3ZqZTMocminJicnWI4bO5nZAioUNapPMQ/c+/cZXz8Cgq/NdEzJadQ75jHYXpPldDNCUwYUZch3pT6G3Z8ech/Pbza+jQ00s8ivBp9R2SK4tiJuOh/pdrOkfaHneiTPC5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949743; c=relaxed/simple;
	bh=dm74D+wMkQNMy0+W2SboKeYAs865/zwpAubEwT5yoPw=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpbf96pO6SgToD2DvjJ4vOXHI1BJ00f+//RyxecBzMbuwmCT3Arhp2uglNbXUaScSeYGg/ZWYTD7idhE805Yj/fWbcoRb5ivfhwTZ4W7GiF9NNaXRb4FOZWZKFaTakn2Jza0LWJXw4ApjKJAX9gqtxVMk759IeZPO/h1c917tEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbfn5/vD; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbfn5/vD"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b74e58ba8cso400911e87.3
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 03:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788949740; cv=none;
        d=google.com; s=arc-20260327;
        b=iXaBA4C9rxjMRvSR9ZU4qqR+kqG1hOPt2eK03cNr7pUMc6oe65RkzutHdQcQsgdYhi
         FoRaa6UzmXvDrgV6elKUN/r5oscatn1C/aldTo+VaSze3Vp5zKWPLzGs/Terw2deW5WE
         iumAOLBNYNbFvYaP0u703H3VJGspmbh/ypZLOuV+6TmGC41RPuDL3e87wo+2f2Si3Btu
         hlO8jSPvis4rUEIKTiZY2QYM8nNk+PcDFgFWm8MUOUuOKWAtSoCgDGA3iQNfFo5mN+Ev
         CyXl6kqqIwtrgOGF7aL3Y1v/FOc1HXZ3yKwBrNoa2C+Nfs9aECej5eDVwaVVuQLzJm40
         Oy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=dm74D+wMkQNMy0+W2SboKeYAs865/zwpAubEwT5yoPw=;
        fh=p+ury1sMJdejKw0WseE8JPQGyDQESxqBgte6sA2k+/c=;
        b=F1NPSHGh2C+8hTlHeOanCTWwjagyw9bcpsc0y9b/IOfxB9zxljhkpZ3nQ2WnFB7/jQ
         nYYSehlegeWVPqS4QuxpLpbhdAbJxc+Le5GCTmiA/+nYRKJgY8i7eBhLJtvgM5MBAt55
         HFobwbIJO4hQMGj2Yjhoz4U4xWLwfrQzttm9hkhvQs8PGRc3Fou3HOj1RdRyzc7VfDX5
         Dmuo8O9V74vgkUlMX63OZo/wKwgMB7hByRg34K2h+aiFyDByoJftf9RTtJvxPD2zOLen
         5XB0HN8S+uSJxWK+HiBQC5UHD0Toaa5bAj2+UhSc0/ClzE6VsRyY0Um6Rr6GgIFaIhHc
         EerQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788949740; x=1789554540; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dm74D+wMkQNMy0+W2SboKeYAs865/zwpAubEwT5yoPw=;
        b=kbfn5/vD52Xx0hHWdVYALiX6tNDHW5L6a3+TNfOu3g7/1LdbJZa6d11WY5eWQUSSij
         ygZQElfol1WVcqMFY7DMBi6kyxAAo+BBFf9w3iXxzLWZPPXAEFVKqmff2PWZEI5dT3W/
         ZD0ic1MRhB4lT+MYsd4yJXmWz/EZeSzUIvtHd9SOKJyT88MEze0K9YlZuM/TMfB4GnWw
         NZ36N2Gn8tFGai4azk2a8KqF6wm53szTwIC48wifFfse1hZ0Hwu+T8o9eIRw0UEDRgnA
         2I1oEbY53yLMTNftcyJlBosUv97h5+zjX72w6nlp7VtnbLtCXDYyMZMURTqlP3xmU5Bf
         ld2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949740; x=1789554540;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dm74D+wMkQNMy0+W2SboKeYAs865/zwpAubEwT5yoPw=;
        b=WvzT64jlkkJGH7q4A2cjF40AOxC7MOy4qKbtDQjs9DXFGSB2poCMDaG1KvAvkYQ1Jf
         H7ZdWK1Qy+Tzcs9UEj+QpoOm8ibHjw20h+hddwa+zIHk07AA2SRKttGIJ0PxLkR2Sndj
         mLmjbrHb/eP2qLO7K4d7DSEvt/zIocpdo+oj9te4tjwD/4u4m7YXWtjEh0UhCuA5/wTw
         RSzr+BRW8i9p3TukdN5oAsmnVVeEFXtVLY2o5PfpM5SQN7cQMpEIcwwCsxFO5O8tyAkE
         HoVIYtbkTfdLYJpcb7W9EIsBkJ9hYlrhUumaAebtxGMAbuCfhOV3rKlPuc47XWPb4QBf
         9a1w==
X-Forwarded-Encrypted: i=1; AKwUvBxBlUjaNaddxzqUUUyV2ODzF93otl7dhOd/R+Cxmud/8xWF9nsvMkjQGqjKMJM8tbFMwTaocFincmI88w==@vger.kernel.org
X-Gm-Message-State: AFuF++lC1D02CpTp6M5O1iQeShdiPraEI1yBVoTUBNNXUYULXGz2wiGc
	Or5i8MZLCXrYVXjGp1GTJeC/KgLq5tBnEjD1ZE8ychlNogWQFApGl6bzmblBn/AirwxnaQbA9u8
	DaM31vqAYOLcGySem06Gl1chbXPbIY1I=
X-Gm-Gg: AYBFou3aZ2A/Ac/q5oyisCaDpgKjddsgxV8e3hqcsmw8wSCrz6kSOjosKNsYbpI7lmY
	egSmWH0m+/B3N/AMNaU/7nAuJF8hqN6ZPwRgmA08DWcd1tFMoNg34Hhq0DafOdATTeCTXb6Xwb0
	XkPfVGVYSLY+1hJIf3jaC4fDHBFcJw1HdPwQLdkIIFUbiiP3TI8locIQyB18xuPvkz5fOBMp5c5
	uQva8zx5XUhzMvq4oDCQWFOFNSMGszFzCPIb4xpqferOcFhoDciPqsg0IZAM0wCZdYZsPJXWzFc
	AvamUvRsIr74y4Z7nLeQjVLEqYQVANJNxWlmY4XeO0P9brKReKKRWftd/9AOA3klM6BZ6Hq6an4
	Xac9HOCVhC39ZlIeLKc2VaKU+F32bUjZ0OWx7XP29DiNudHnfZ+4=
X-Received: by 2002:a05:6512:1329:b0:5b6:1913:8d38 with SMTP id
 2adb3069b0e04-5b74d53007amr4421132e87.6.1788949739610; Wed, 09 Sep 2026
 03:28:59 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 05:28:55 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 05:28:55 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2026090833-mutt-whiny-242e@gregkh>
References: <20260907185001.1567957-1-miguelgarciaroman8@gmail.com> <2026090833-mutt-whiny-242e@gregkh>
From: =?UTF-8?B?TWlndWVsIEdhcmPDrWEgUm9tw6Fu?= <miguelgarciaroman8@gmail.com>
Date: Wed, 9 Sep 2026 05:28:55 -0500
X-Gm-Features: AcwNN1VIuW5R1C4C30YvVizM9RLgpK4zIRN-8f2fSAOShJPErBt4yMIadb0ME_E
Message-ID: <CABKbRoKwKz+01bBMU_tq55aUQd5ao613v5n=M4zRjcc+j6=HkA@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Input: aiptek - validate raw macro indices before
 updating state
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, dmitry.torokhov@gmail.com, pengpeng@iscas.ac.cn, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

You are right, 6.12.y and 6.18.y need the fix too. I missed those branches
in the initial submission. I am sending the two backports as follow-ups.

Both apply without code changes from upstream commit
95dffe32a66cbed07fbfa7afed39d56d5014e04f. I built
drivers/input/tablet/aiptek.o with W=1 on 6.12.109 and 6.18.50;
both builds passed without warnings.

Both patched kernels also booted under QEMU/KVM with UBSAN enabled
and passed 20 module load/unload cycles. This was a module lifecycle
smoke test, not a test of tablet reports or reproduction of the bug.

Thanks,
Miguel
