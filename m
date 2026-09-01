Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531BB47D959
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788279863; cv=pass; b=QaoPRz/cM2e8BfXSFYq7lCOhZlqiydnjGDOSGPXu47AEj8054kRItEReZICG87kdafhcDTrP1VV+PAWmZ+7ZlSWEFCrb1OSDwVPumaQquNUcgyuOlq8fMftH1cCmAm+H4y/Q7uvgLvnINu0r10Wx24/UXN+UnvPEBM2zFRdwHoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788279863; c=relaxed/simple;
	bh=fihGLTO3wxvRn1HVgRAq5GXUuflx3ZDlmZRCApsNctc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2JC9IreMWIJTcmNbzvqvt8ktJSaZUBHXPKM8QjFWj2iYlMWknHjDUEkeNZ17emmWH14FJf/tXczHqw6FK6ybuBcJene06BqpEhssAXOej+xvhnBmcSIvkc9UP9OhyPwWQ+VrrZcwWYK7f3q741OrU+aIQLd8/VmSpExmyRGz/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGBTAzoC; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGBTAzoC"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so2118744a12.0
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 09:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788279859; cv=none;
        d=google.com; s=arc-20260327;
        b=bicGa0qShwNHZcIelzRgZ8znIM3xXQ7rLGBydfves242O5Q6Qc4sWisEoCQxZOt/Lg
         sO9TAbdlUo1/MnadURFqHOizZ7b0FxPwz0dbgBdLWQ6kqiO0REspxNPE7OJVtISj/Znh
         8r6aUJdjhzAIxY46GkNTbQAMNOoJQOXgHy4wX3SPibIlJ9ZGvLHxzxpUs3vjD4P+aTlt
         zFgs49Pj/frYOjj2sJTMo8ZOg8OahHSH9/KXUO7vvw7HoElCn1Kn9J5kNHf++19GDR0n
         oFP7TjBSfe8n0+1R46ZYleDnKvbzQ8vGtyHWbBYVWDdftH+wl7HMpSxu3hV+fp6gXKw6
         q2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nd+x62BgvaUKtLsEkKCNcqg4e9OToPZipxYRv5SqDCY=;
        fh=tHSqBcVCCo+Zlsjy/uDL+lhHgzvxunPTD8+0vexpDhM=;
        b=JkMKdvgtA8HfU5o3ytVOtwU8bhcJWMD16jXvsSoDCuOC2G+PHPZazmuRs+1dwSmTI/
         rziVkyficQnDEZafWC36GGtubH/pRt6E4yiQ92LtiYQUMq4oD5cE6D9rlZ0xbpphu1Hb
         Bmmq2rvQ32/DqPn1uoszdfdge1lnHcqwFnpkmfdcr0NGdIlwdFUZ9j+bnQTinv+3HR+f
         etKBTFUIVrmcDG0Mpc+e/yNzpiorcGZ52TJZivWuRDPJ1NNhc9HVJdNnXrxybz1D/BKU
         IQoAoRT8ilhisMFxG6bYE73reQA9FJnQZnwt9BxI7S/PTa8j8eGMLW7Xl4aSIVsm5Efs
         X9uA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788279859; x=1788884659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nd+x62BgvaUKtLsEkKCNcqg4e9OToPZipxYRv5SqDCY=;
        b=YGBTAzoCtXkiiukEmQ9Rz4H0XY9Yg107UCdBhnOHcyEIsweEbkaaE6V49Kz0BMOnc1
         ig29qhGoXx6nrE7Cni8S193t6+yHc6L0cGIHKpP6TKGSdc6Vw5yTTWIoImTRyNDpdliJ
         L436tD+khR29p9PtaKztZQ16INzbB4zm1J8dgBGdL6LhRneY2o7JHmDlmbI9p/2LabJb
         RRq+HFRXKQTgObZbWdw/eSBHqfox80ObeUMiwbj1QiycwczJXLc80hzXSTVzv4kSnW1S
         QHUHCFEUF5T2YjnquUw+n8t6/zHMis4TyMHlMMPBH2I71QSdx1wATCbB3b69w2IzqQ4m
         e/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788279859; x=1788884659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nd+x62BgvaUKtLsEkKCNcqg4e9OToPZipxYRv5SqDCY=;
        b=p21+sHNJmBdC19I9Ci2FP9GdQ4ZO+rpMKThgwW+9uwYpfw5/7/3nffQJC95Kd/rZda
         8AwAQSj5LRHpmlOoYZzScCAepgr+abHhIBJndx6xco0B2W8AnKNzcQ5u0CgKAhmx6RGN
         EVHtgZ6/V1HUr4ZBAvRMI5wfU9L76jBUbe+veIesoV48DXeiiXmDfR8qprBCHeCO/7Gs
         eFhhgYVH+v4QerZ17ZVOVR4QYXRxuIyKkcJZAkct5gieR8KK4IQZIh2qg/5yozJ6p7nK
         o5gfEwElgts8bTQ/haApUsJwzMRC+zZW8feVBmUGSUZyIwjiDnXm2pyQCjNzbqTCBzR+
         D8Eg==
X-Forwarded-Encrypted: i=1; AKwUvBzdiiS2quUW1Hi4hgQ33s9MYZNa9XL5aTlRH5TYZSixyWQQRn+i1Xl6OUWQQk+i581S/1V1HeE8aHto9g==@vger.kernel.org
X-Gm-Message-State: AFuF++lIY2+9ke9QVYfUkxcegOm2/S5E424RJbt31VgedZ2+2OqUySP4
	rOq4QmzDXmCG2n/aJ8YT2VVTEM6YvzUoxnjmHNXDZbac4nMmnoZyDIQIVnPazjf6c6eBxwaqCNz
	6wh6pAcMumLjrZa+vLSm9UqQvODNOnMs=
X-Gm-Gg: AYBFou1JfQ4iU91UcXcVHUB6BUoMLZ65SgBQaYCfb1Dny9c1tmkZ/GXbjY0+sV42ZV3
	LUVKevCXEwF/thIJBaEElq35faQXdCE9GPNapfyAKfPRW/doW9BME9mcoIgSaX8vhdgCA9VxvQl
	VGSUyZEHqJJXucXQSenfhoti/SkH5ClYwRSQVBdojVDEAyahEoR/t8Ja2S5MWyr35/2XwaSkUP5
	gIW4nEKCw+uLHhROVzpvQfMAspxOQYsL38zbKlShAMIuuabwCRrEutDA2aApTgUb3dIlBjtbiFp
	aZki30vrPvq5vECAHa3p21Mzmfdeyg1TMuVcjsv64Zk=
X-Received: by 2002:a05:6402:f04:b0:6a6:7ed8:f11f with SMTP id
 4fb4d7f45d1cf-6a67ed8f1eemr380561a12.0.1788279857823; Tue, 01 Sep 2026
 09:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825151242.576456-1-lee@kernel.org> <CAF8JNhKWr7v7tY-tH_CGeLUQQpidx2_7J49c17TD0bw6xEi9BA@mail.gmail.com>
 <20260901124952.GK2943942@google.com>
In-Reply-To: <20260901124952.GK2943942@google.com>
From: Ping Cheng <pinglinux@gmail.com>
Date: Tue, 1 Sep 2026 09:24:06 -0700
X-Gm-Features: AcwNN1WTLnaD9h4VNCjN-CXQ_kBLgu2eSfzw6ZnrDLAgmDy4-RNWJ6AFprlBCJw
Message-ID: <CAF8JNhKiMMfkkgh9UMW+uib-tUQahwzGfxSr-36r8vrBxZt-aQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] HID: wacom: Use hdev->product in wacom_setup_touch_input_capabilities
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Aaron Skomra <aaron.skomra@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 5:49=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Ping, Jason,
>
> > Thank you for your effort and persistence! We (Wacom and Wacom's
> > customers) are lucky to have people like you working in this
> > community!
>
> Thank you! :)
>
> > In addition to making sure that you know your contribution is greatly
> > appreciated, I am giving you an initial testing feedback so you know
> > you are on the right track.
> >
> > I manually tested a few older and new Wacom tablets. Some of them have
> > touch switches, some don't. They all worked well!
> >
> > Two more details I'd like to share.
> >
> > The first one is about the touch-only tablet. In all the models of
> > Wacom tablets, there was only one model that is touch-only. It was a
> > Bamboo Touch (model CTT-460) released on September 24, 2009. So, it
> > was more than 17 years ago. However, the quality of Wacom tablets are
> > so high, it is possible that some people are still using those ones
> > ;).
> >
> > The second one is about the type of touch on/off switches. There are
> > two types of touch on/off switches: it can be a soft key or hardware
> > switch. The hardware touch switch is easy to understand. The soft key
> > touch switch is actually an on-screen display in the shape of fingers,
> > where the touch on/off is controlled by the driver: [1]. This softkey
> > touch switch, somehow, is not reported to the userland by the existing
> > driver. Your patchset doesn't show it either.
> >
> > I will do more testing to figure out the root cause of the softkey issu=
e.
>
> Is there anything left for me to do?

I guess you'd still need to figure out if Sashiko-bot's infinite-loop
suggestion and other potential issues are real or not.

I have the hardware. I will test the patches when they are updated.
Right now, I am still on the softkey switch issue. The existing driver
works for softkey. It is reported from the kernel driver. The issue is
sometimes it is not showing up in the userland, which we know. The new
patchset moved the logic. I think the sibling_pending routing should
be the one that's responsible for the SW_MUTE_DEVICE recognition. But
the shared structure only knows the pen and touch. It is the pad that
holds the touch switch usage....

I'll share my findings with you when I have a solution.

Cheers,
Ping

> > [1] ttps://github.com/linuxwacom/input-wacom/blob/master/4.18/wacom_wac=
.c#L2063
> >
> > On Tue, Aug 25, 2026 at 10:09=E2=80=AFAM Lee Jones <lee@kernel.org> wro=
te:
> > >
> > > Replace the lookup-dependent 'wacom_wac->shared->touch->product' refe=
rences
> > > with 'hdev->product' inside wacom_setup_touch_input_capabilities() si=
nce
> > > 'hdev' is already available (via container_of) and represents the tou=
ch
> > > device itself.
> > >
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > >
> > > v7 -> v8: New patch
> > >
> > >  drivers/hid/wacom_wac.c | 18 +++++++++---------
> > >  1 file changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > > index a29bf051ada7..4436faf2d2bb 100644
> > > --- a/drivers/hid/wacom_wac.c
> > > +++ b/drivers/hid/wacom_wac.c
> > > @@ -3953,8 +3953,8 @@ int wacom_setup_pen_input_capabilities(struct i=
nput_dev *input_dev,
> > >  int wacom_setup_touch_input_capabilities(struct input_dev *input_dev=
,
> > >                                          struct wacom_wac *wacom_wac)
> > >  {
> > > +       struct hid_device *hdev =3D container_of(wacom_wac, struct wa=
com, wacom_wac)->hdev;
> > >         struct wacom_features *features =3D &wacom_wac->features;
> > > -
> > >         if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
> > >                 return -ENODEV;
> > >
> > > @@ -3963,9 +3963,11 @@ int wacom_setup_touch_input_capabilities(struc=
t input_dev *input_dev,
> > >         else
> > >                 __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> > >
> > > -       if (features->type =3D=3D HID_GENERIC)
> > > +       if (features->type =3D=3D HID_GENERIC) {
> > > +               hid_dbg(hdev, "generic touch setup\n");
> > >                 /* setup has already been done */
> > >                 return 0;
> > > +       }
> > >
> > >         input_dev->evbit[0] |=3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > >         __set_bit(BTN_TOUCH, input_dev->keybit);
> > > @@ -3997,19 +3999,17 @@ int wacom_setup_touch_input_capabilities(stru=
ct input_dev *input_dev,
> > >                 input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> > >                 __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> > >
> > > -               if (wacom_wac->shared->touch->product =3D=3D 0x361) {
> > > +               if (hdev->product =3D=3D 0x361) {
> > >                         input_set_abs_params(input_dev, ABS_MT_POSITI=
ON_X,
> > >                                              0, 12440, 4, 0);
> > >                         input_set_abs_params(input_dev, ABS_MT_POSITI=
ON_Y,
> > >                                              0, 8640, 4, 0);
> > > -               }
> > > -               else if (wacom_wac->shared->touch->product =3D=3D 0x3=
60) {
> > > +               } else if (hdev->product =3D=3D 0x360) {
> > >                         input_set_abs_params(input_dev, ABS_MT_POSITI=
ON_X,
> > >                                              0, 8960, 4, 0);
> > >                         input_set_abs_params(input_dev, ABS_MT_POSITI=
ON_Y,
> > >                                              0, 5920, 4, 0);
> > > -               }
> > > -               else if (wacom_wac->shared->touch->product =3D=3D 0x3=
93) {
> > > +               } else if (hdev->product =3D=3D 0x393) {
> > >                         input_set_abs_params(input_dev, ABS_MT_POSITI=
ON_X,
> > >                                              0, 6400, 4, 0);
> > >                         input_set_abs_params(input_dev, ABS_MT_POSITI=
ON_Y,
> > > @@ -4039,8 +4039,8 @@ int wacom_setup_touch_input_capabilities(struct=
 input_dev *input_dev,
> > >                 fallthrough;
> > >
> > >         case WACOM_27QHDT:
> > > -               if (wacom_wac->shared->touch->product =3D=3D 0x32C ||
> > > -                   wacom_wac->shared->touch->product =3D=3D 0xF6) {
> > > +               if (hdev->product =3D=3D 0x32C ||
> > > +                   hdev->product =3D=3D 0xF6) {
> > >                         input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> > >                         __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> > >                         wacom_wac->has_mute_touch_switch =3D true;
> > > --
> > > 2.55.0.887.g758fc8c411-goog
> > >
> > >
>
> --
> Lee Jones
