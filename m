Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24C1DED49
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276866; cv=pass; b=ZuDXkyfW0ktV+8PQo4568WXtGRzgtNQ5WloJ+LutrTGwtIssaO+vGefiYYtbF6Ug5joM7dbegEqm3gW3hQe0i7gjh3BQxMzZVM/VEPp0VHESYqxXdcO1N+ngf7df/Nrt2xRzE8I8rdyoJ8kHzMIvOd5EE4peCNQlO1HKDKi6Gac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276866; c=relaxed/simple;
	bh=yfqpp8WYOenmjb3oYHuHBnzp/XrvWdHp+mrIFBFp1P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WU0jPJnNYCSzXfZZhgC9BmAhwEWf7I8bXqeYnZIbEtIk7Zrh503ZndIWi/wzgMu1BgcAAZokzBf09pAmgGZe1jmmrNDL7SLtCbkY5xlpoV9PbEGlzTprma5jv1KBDCfLJfYTPESyhzuHyNkDwVNSYdwaQ7VQzRCNRCiEjPkndSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rxHA+/XN; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxHA+/XN"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66c7e3a2332so344861d50.2
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 18:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787276864; cv=none;
        d=google.com; s=arc-20260327;
        b=ddM9Hw43idhtmuW1mU6BRuZ2DRl4v/nFv6u84Y/v5Tm8v78myxss3/jf5LMOlkKlkL
         z6klmJKcD9E9ZVdqXFNawV78vS6Qkq3E0NVqOe6JNCvE5vro9aR62HixpIYm7i7yRS7x
         +9WREJajN/Ki/vBF3BNQCOyA+peBSoJuXdoZH/iLDK6jHssC2l8YjHxRdusFoYRivKsC
         TR4fyOk4upQj84w0El3NI2OzqVDKWudKa9qE0smb90q9R5SLDLIBfBQfXXiEqcss45jp
         XC3PtBCtpwRrghxyuft3jEf/K/PchYtzINXly6MAS3bZ8x9DgVe07Ki1HoPDk4lOi/tB
         +/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ZFmROfgidpQl1un31xXH76vvuzAN+m1uLmNu7y+jkk=;
        fh=rdCKpnYc8WSZGspiLQIJv/rFdqR231X493DDrY7HM9A=;
        b=oJXt0r4OQmhP5vWBATXGEBxUdYquCD7hFEChXHpCe3tGYPv3JLVTr0hDYaaUCq/+Yc
         ucQT/M9lk0lfyGYCJKMCnoiohyDsjf1k2wel+FOo0hlSXrYHAw6WjG2xuRBVJvBwJZqR
         NSY8yzQYMpJ37HIwWB0DlQWKcepQ8MXs6AWPFYjEspVgPfXGNixe4eLmVo9rTLbDoqb9
         alN9veCXfnckDOeYGJXnBdOvQ6Bq8Ct19tTWKfpoSCzP6ss9oKRGZ12VpyLVr/eeS8Ke
         PhjeD6kdX3nxB08NgVHoTAAnV/vmjJDBjlVXDjp/m3whkPLSdi4Ix2Y2B7rMn1kBGmxl
         tgoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787276864; x=1787881664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ZFmROfgidpQl1un31xXH76vvuzAN+m1uLmNu7y+jkk=;
        b=rxHA+/XNu8cPhtkFcca2wllB5wbx6FTGBEm6B4u18fyoIu/7K2ht1X3NUU3yWH1qYq
         /uQUje3lVTY/85CbxORrzH4wWa1aMYvQAt3fNaehxe8kbZTmpFpc4P8XXplFNaL4DpGU
         grTyXTyQP79XPHrH1aA7c9OAtByxOvfDl8v12A8X/kxuchFx7GgHs1NI2A5WiEkaqstQ
         TK8ocE4Wb9VYgKEM5drRCghfMkXV+KYMZAj7wqzdUdTPow9LhLRW0iw+LzOLEC+DLqcV
         KJ3gRh7fMz3/51s5q3742eRBk7O6klD8Kr2ZTnvxlD7/cTO/toCdAxLEnUvPs2fkxC2e
         8KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787276864; x=1787881664;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZFmROfgidpQl1un31xXH76vvuzAN+m1uLmNu7y+jkk=;
        b=JHLhmmu9uOQxsi7SmCjfdhv4ZjQ85EVXjnK6bebkTJDOctoJYhdg4/kWLf36ZP9oEM
         JfiE2Y0lp/pK/r5v+UMQaOC1EKF+aeuLIWk57Jy+YqvIbLxpBCipSaU+ZbgAmAHePxrE
         4mfUqSkNexWd6Unhn+wfSuT0tfzXigU2kjqs71Gcg5D95zR7228LOPLzPh1MbhOvQ+5R
         BZl94ssqGlXuY+gZF/CzrjWw3OmmtRfNcFPj/kKypSTidmrVumMXeusxqiEGcjRqHaeU
         +pSfcXCy/+ZdMaYgdNHfUSnh1L9tLMoxVyYcwwkP54XBebzT0sgfBI1RGropzlG8PX8/
         uD+A==
X-Forwarded-Encrypted: i=1; AHgh+RrmteL5BRol0dfjNL4156PK/nfHdyPM4JPbAVoAcyNQJ8zTrAxYZYWiFwcf8qj6AHZRFrWxZzFJSDu8rA==@vger.kernel.org
X-Gm-Message-State: AFuF++mN3IW+aDodgpJQXCAUnvs3pCkhcQRbKBKW8K8qCB+73m1ww/Rb
	b4cB94tqGuOM2WU4f65dCcfkimoUk68YBBN4Zkgrl99L4rzFo+vdimrjC8fgwaW7DhdJhCLbBpd
	me9mFweGEDs+sG0SrT/9aWamohgdsETQ=
X-Gm-Gg: AR+sD1130Jf30W4otX9kuSVYfHul+Q/VnVcSu9YK2tngYGQKTXa1w9UD3/PEdi4uAse
	gStvvefPqmtXMuEJr7zw5mgJKNd2WPFum/o1N3fpHXoF7OFg+dZ/wieITjkrZcbYGQZ/ySVfS3z
	UwtQQwJDEpsVzbywr1THJoyrBTpSroDj89ndQyn5/aLap2vegx1WEIYv6r6DMRJ/DG2n+3tsapy
	/btzv/StHu2BCqSqTy+KLVO7gcjO5UrOwz5+m3u37RJwfyqDGaGMa6ah/IV8JkEsONhldEH3kNk
	R9Bh7PkpnIJi2t4dZ14srfp6HlEaYx24kUlo5Pqu9V0KJGtf8vcyvU6YUikdWCzFyT3NF4+VOcS
	IJCRBB2gBQPPQjkR0GqXvfdX0j7qb1u5qBQ==
X-Received: by 2002:a53:e802:0:b0:667:c09c:4a34 with SMTP id
 956f58d0204a3-66ce49d2cc6mr953128d50.11.1787276863699; Thu, 20 Aug 2026
 18:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806080018.10050-1-kartikey406@gmail.com>
In-Reply-To: <20260806080018.10050-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Aug 2026 07:17:31 +0530
X-Gm-Features: AcwNN1VtUTnT0LM6-lm_L91h0rAyWrWm1NnstzY-gesmi9HDGZ9mFJ_v1j42w9Q
Message-ID: <CADhLXY597=_kdYj+cJvYR25BgCyCcHgSVVoY22kWZcHuV0zh4Q@mail.gmail.com>
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
