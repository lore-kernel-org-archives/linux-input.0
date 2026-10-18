Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B48367B63
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792321294; cv=pass; b=RkEywAQa0hbQOSJV3ThZC57cl5Y4tR8lrpWEgZH1NLwA8P+gF1WIaShVqCRRF1H0ChmU7BFyGR1NwrfHP++JVqPeWU8ZcjDZDLRPGlp3K1GyBbr+QcuXrn/Z1rnVJ5EqcLh7KYabh1KXGVKosoe0NTLw9yniiE+aFGMOlnWG2as=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792321294; c=relaxed/simple;
	bh=yfqpp8WYOenmjb3oYHuHBnzp/XrvWdHp+mrIFBFp1P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Krb40Sp8UhqmQKU/UAEfCWl9DeBAtSCu1Urw8KE+tnsOjRGJLNyYaXZxNUVZd+WCmzlB571vKvhBawZg4k8w1AolMCktF7+Q+OaUqhrEp7LVt+0XA2SOdsqy2/tCkq2Yy29Y8f5TqSUK/YAd4i0ROQaEE5402ggq1Rq6ousmkCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4TAq7QJ; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4TAq7QJ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b0dba37a7fso9934667b3.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 04:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792321292; cv=none;
        d=google.com; s=arc-20260327;
        b=jBEiKIJjRapzasZXBOlBToT9RG4uLjFlurHVIh8YEdYcMW2TMheezzwm3I0uSuLrZ3
         URVa8XsiOfomGQLh9jTKi/S/fg1zax6LqcIxyfmqNeXQN0qoYP5epE9qOu54u2I6rr/i
         O+xZ95VREzZj6w6wLEusg5Z/uU7OcfhKQx91QG077Fw/Zi5GUfDdONeNeGjCgIG2Kyuy
         OqZ1vy8fJDGRJ0DaT7cH0FWjw9WfDIbTIpzUR0bVoJL4jrDiiWHMgK1OQacmD8jTwMrE
         PRGyu/B1wGNCbLQYKKFXkV/qJSP9DzQnSXmT9PyFjDL6Th/bFx7j3ls8IT4Ebj2Ax5dI
         83TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ZFmROfgidpQl1un31xXH76vvuzAN+m1uLmNu7y+jkk=;
        fh=fEqz9jEId0Ux76kBUAxmlZW9/ioBn5JTYXpsgKpT7jA=;
        b=aygvjx1Srn2Zwi+ZGUHtkaHhDhy9fl/C4F5+vo6wntZo9myx7rDYSCIYEUWauuzWBV
         9fmCDIpepBClECKKjMzWmSJIvVDNC4T8b/I6Xd5CUHqV/z0jHBMYyCFqnWvU0qMDloC4
         bzftYyirorH6hIIrOe139jv1GQgYijMeJe7aLxuTpL51mpoRxKQ4RiiVmy+8F55m/sJt
         4ZZ1dokOU2rZ6UMHIRyBOlzjjwc2u8hIaJolUvSv/NG1qVLmm2A/wYm7iK8vAqt9zpVP
         KrMtkvVOoW0C7/eQxEtkMsxZD8IL76M+5st6m5p+ANyeygaJicVTGtM0kHrRR5w4L2lP
         CflQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792321292; x=1792926092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ZFmROfgidpQl1un31xXH76vvuzAN+m1uLmNu7y+jkk=;
        b=c4TAq7QJJBL9dlSRrxQCpk9oyce6hB0woIYKJFS9r6rbmd5jjc2heRT2GCc8xySk26
         TmMsIjG734+5YicmvQZbah/HtH+n8dDalk6fXYgwCZl2OLuqIxrhQo23w3LbDhwAWiul
         DUGL3IAda+bMMrTZte8U2ziW7J09qxRO2qXy2YloCOdqaMHILramMN5A6HtfwYKYOHAj
         vJEGsumXH2+mQ1/0EBa619gcJMPSSlepT8uQ91a1SOVingNRFFIuQn4xLGwbDGCPRXGD
         kupctFxlIOZAqM22H1XZeh43/RU48w5CWSLJ7VfCupy6Dmh0t0OopNxBNI8WnG7dVAei
         wRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792321292; x=1792926092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZFmROfgidpQl1un31xXH76vvuzAN+m1uLmNu7y+jkk=;
        b=Mmu7TMmjfLuYT6ZQHiiMM8PuN04ykFYkJ+Fa1F7VFuV4NKVeKdSJrE789pFGv1zDhZ
         F6xLoLtUAdIEJ//Ij7gzTwQlgfYTKfzzyaZ1Rdml6UvsGcDVuvgh4YmBcqskQPysmyNC
         5ufaOmaAS1N6kQCsj/by9CRaA/R7MHbFeF1AOxg5uSBffaxx/2DmR8P6ti0iyY02F49x
         Fc1NujlWQcm+cSO36slgvGormybIpBbzXgkP3Wg9T64G0Tn4U0Ax0w0rcwFPNJuPTf1A
         1QLm0iKUs2Lw/o4Dvp17xPnbaTaQujxVdUc/uSTyl0bOBTw0b+S5AzBBFK81Svm8t3Ch
         N0hg==
X-Forwarded-Encrypted: i=1; AKwUvBwdyQulo+m9nRhuztO2TPusVcQTIHF0tqS1EGNgA/BUVVcJPkHf9Y6YjpL3SWMS5LKmPNjo9n8/iPzJdw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLVrzEaIzyUTNs1Y7ZNhYfDvk7ZBudy+QPFLgmFgBU75WBogEbf
	z0K9J8xFPS3AY5uy/uzP2Pq5saed4yX/fEws3O61IZGJd3mE/Tz851FInn5UamyahxIEWT6LRvQ
	tBybDWMjvtPBfRuswsuMkdHKqgmyh9xM=
X-Gm-Gg: AYBFou2Fanz9Ra2zXN/YyJ2NBnFvK9JcUHoa12jgtbDjB7NH+xoBgeS01rsoxEIlMJ8
	AZm59Ubhxjv8iCzuP/mhXKOtIG6J/KZMavZXudvFhVOyX1Lp47UaF3tWkZ7f0VL8xsRX7EV3bo/
	DUQVQXSULId/I/EpGm87iyAz8fJlZO0VTq8R7AaeZmHiEBBzQbyWnNkmg7U/V+b3Coi8RbFGGap
	sB3Kchzjwc8WmBnUa36F5ulYlG+97chIwPMa11BR4/WAq60KyWWiV+yHRKecWvVIfSM0hnZki5X
	SDFiwDyE/8A4CKFIacyBvbSYvO01vo/vKqc3cCK2/3LATHcf3ysRZlEl0UlWHJ1FEr4Yl8mZ4Eo
	XKEWZmknD8r0OIelkMFeZP9Hh33PwM8qHLbTRlBXAL++a2jXhZX/7UBk=
X-Received: by 2002:a05:690c:d87:b0:8b0:a8f3:bf69 with SMTP id
 00721157ae682-8b0f213a4fdmr14586047b3.12.1792321292329; Sun, 18 Oct 2026
 04:01:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806080018.10050-1-kartikey406@gmail.com>
In-Reply-To: <20260806080018.10050-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 18 Oct 2026 16:31:19 +0530
X-Gm-Features: AclHuK-AoWK7tKNVkf-gKvfJPvt-qsoCPL8hIasuPDqutLeNvQ4YAPBMihpV1tg
Message-ID: <CADhLXY76C=O9x5iecg=tFVonu0dWCDK0QqGbsU4oXo=XA7gK4A@mail.gmail.com>
Subject: Re: [PATCH] Input: sur40 - fix use-after-free in sur40_open()
To: dmitry.torokhov@gmail.com
Cc: kees@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 1:30=E2=80=AFPM Deepanshu Kartikey <kartikey406@gmai=
l.com> wrote:
>
> If any of the registration steps after input_register_device() fail
> (v4l2_device_register(), vb2_queue_init(), ctrl handler setup,
> video_register_device()), the error path frees sur40 via
> input_free_device() + kfree() without ever calling
> input_unregister_device(). Since the input device was already
> registered, it remains live and openable, so a racing open() (e.g.
> from udevd) can dereference the freed sur40 via sur40_open().
>
> Split the unwind so that once input_register_device() has succeeded,
> the failure path properly calls input_unregister_device() before
> freeing sur40 and its buffer.
>
> Fixes: 08b936012964 ("Input: sur40 - switch to using polled mode of input=
 devices")
> Reported-by: syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D683f6c071b5abfc266c1
> Tested-by: syzbot+683f6c071b5abfc266c1@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/input/touchscreen/sur40.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscree=
n/sur40.c
> index fe63d53d56db..b0958422ff76 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -808,6 +808,10 @@ static int sur40_probe(struct usb_interface *interfa=
ce,
>         video_unregister_device(&sur40->vdev);
>  err_unreg_v4l2:
>         v4l2_device_unregister(&sur40->v4l2);
> +       input_unregister_device(input);
> +       kfree(sur40->bulk_in_buffer);
> +       kfree(sur40);
> +       return error;
>  err_free_buffer:
>         kfree(sur40->bulk_in_buffer);
>  err_free_input:
> --
> 2.34.1
>

Gentle Reminder. Please let me know the status of this patch.

Thanks

Deepanshu
