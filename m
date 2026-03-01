Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F7430B99
	for <linux-input@vger.kernel.org>; Sun,  1 Mar 2026 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393421; cv=pass; b=ebdmXlCyBsEaTURI15Y/+LdGb96MXPMVAejssvOh/elWGHuXzjlJcuch1HnupIAytDvvz4yZFn1OHLV4YOGjsjcdrYul7Sn5JrpPF9vZO2VLApSsLCGbqHNtAiNczj4JxPFuPmvPmYiN4H2zobTKBUub/DxQc291zGnQpCHkekw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393421; c=relaxed/simple;
	bh=OjaoeEXyT4g07zYPZ6AJ82LbciewIaIJsjQGkQRMyWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOTjRY0rnKeZGdNEqrd1BmXYdIvvruFUFWER4G+PV3PWwf/5bKxFUWQ3atKpfM1IreOG3eS2Mtr1y6+vXrdGNanuaNQgpENwGDQL/X+rAYqKtR1bDBx86Zdr+F74uUy9e+T8YY/RNX+qnSgR2BdSuFrHgFbI1i8TtFUpQRIoWrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEEUulqr; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEEUulqr"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d598f4c618so1579040a34.0
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 11:30:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772393418; cv=none;
        d=google.com; s=arc-20240605;
        b=egX5QLOEKOqJ031RRs708/gsROjL9APWNOlUrFKfUkeg4AljNT8MRLT2Gjetic6chk
         czkpLHoc7DkGNp95UI38w25LUynhgWhKMhzcRUKDlsnbgGoOEGG2ktfaqD7vxqgu0WzW
         bU3dQxZ3/78pZEMEnPIy0SiW/dOVqQX3LlZ5G3UMqCZo0Y1kDK19R+9oxugRTmPTyxxY
         7IHPuZJXTbuC583um80dJbPQtgM8WL7UhaeRg8kZ0ROThXr/JXtgJTG6L4bFQP9s9iya
         s/Yg9+DgKZFJ9zZLDxsJ+x2KSzyf8fk+5SsC9Tzo+hY+cPO0ej89+eRKVnKhcj6R0yNW
         0aIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AITXmhhS5ybi+RKE9olk35ACfOtV6KA5LR523g3rBrI=;
        fh=QCF3xesXpFzTn5rSU04ZueReTIuSxF2AMnM2E+QCc68=;
        b=BwD4P43v20Pxb1zMuVRG/6D3zcbkT1h/P4rmRQ4d6rQ/EM+G5o48qF6e/YzAU94nHN
         rYu/cYdvXVCzBHpBpWLjxFkjoco13UhVUJLxgAO6eoexGUZlQguIfNR7KHc7+lwgnc5V
         8WbukUYbWta9+nP8ZQCVfjqUb2IxOq3cVtuQWkvHMF1txzWCfFov76MirN46fcJ5DWmF
         7s6Qv1nKzoQJV7azYswSPTPHpz+I2MdFBPaL/Diw05fJm0iIsvxmItUY6ZQocsfUFgJR
         NWi7v/r2bJZ8sI1vRqQSMr5t005WqQtI69TKSOwFMGYreNIrWqt7tLo1WgOuy3nTaOC4
         Sjcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772393418; x=1772998218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AITXmhhS5ybi+RKE9olk35ACfOtV6KA5LR523g3rBrI=;
        b=nEEUulqrsU4Nw7w8x8ugXwskTsqsywRtP84EueS1FfN7N4tnUoRZ8FcPQbK8RQwRtK
         IKe+N7HN7Y2MvSXlbbovCWY//2DbimIHKjE6+MVThHNAeytsicrwp+rWXuw7dW/F4R84
         lofDkajcTtIEx9LsST90/sPlaiXpZXdS7KO1fkgndEvSrnP16V9kIxEWiIwZhvdRELXk
         7LaBrieowxp3f+Wmb5lz0l1/eCKAyVSzY+mwurQV2hKQqbpVQTRnKd8lPW4fD8M82nG1
         qVtMyj8uHTpus6S4Wu+HxlFzdGh+5Pn6s5de0UlrzUdPaLU5ihH+B59m6zFkZfth0YoH
         Qptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772393418; x=1772998218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AITXmhhS5ybi+RKE9olk35ACfOtV6KA5LR523g3rBrI=;
        b=CzckASgKKuvvWRW2guhdvfHsKuFIZ4yNNKkzBSwnwOZOYTcr45Ey7QdKRic5pXbVEh
         ysRjT72hMOa3NyiAjFAUBxssIAOtKxfq6M38LPVcXVnAWfXecMb+Bdjrcyy60L6VXZK1
         zxSUqNAfFivkLLTga5GQ/FA0xkCOYyTnJzl7yYtkaW3vUxsQ4IdpNaTIu4/qIC3WIwr4
         r8+y8edQbM3ktSOsJiDRpeMvCQOUK/RlhCyWZkI3cY32bP57lEBk9YrRDXBLx6KL6CrM
         dKOg4cQqpdVvJ2wkzzJlMElho3xvj4O9EqPBupIdK5ctFAjkYjv6T0wF2VuRO+Gd+uXu
         v4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCV1AWTPMo4np6718B4l7Vg86epm6Xk5T+5MOFci+2HRnhjRtw7MqNsS2ROZKDayzLd9Esxrck7ad3E1ag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkXuOqByBdcq9DKzTVRkslrEWbx3q7r3lrurU5Wd0434tVMRj
	vYCIUdLoH30IdHIF8iCfOeoUCwA5wfTwUZBlsav7odTbqCwKFuL+aGQmz1Efn97Gos7qoXwZSr0
	VHxrv+dcVLROaFuzXVRjZtt/CR98s6iI=
X-Gm-Gg: ATEYQzwU7qJ3qi63XmdJh43rYGJcNxGGyKdV4/q7mcE1IM2JS5nQI1V5migZ1dRLyCF
	zuoOeVlVF7gYWHzR3PjbwcT7O8PCcp6KGA7PnQf01Ky3v22SXjZCT1QPlQMNAtPvbsXeZjJ9/E2
	vLuQgbjGcMeJn46QIp55JlW6xAZ0F9qbbx+7YNWO/05RPqAtjt00l+GlWnQKhimUNvFsfStOR7L
	1q8e6A0LH/zKFFYagukhXBsUXjXmEGK6zbTZUS2/Fi8sYeGIRGyKPC4oAZuHE+H8vSx2z0eJ1cj
	TBzIvh555VjE3B2OSvnn01gPGHKi3CGgiBaYod0=
X-Received: by 2002:a05:6830:718b:b0:7d1:9da9:c6c with SMTP id
 46e09a7af769-7d591bcdad7mr6622117a34.17.1772393417813; Sun, 01 Mar 2026
 11:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228191400.19244-1-rougueprince47@gmail.com>
 <20260228191400.19244-2-rougueprince47@gmail.com> <20260301114450.17f79213@jic23-huawei>
In-Reply-To: <20260301114450.17f79213@jic23-huawei>
From: Bhargav Joshi <rougueprince47@gmail.com>
Date: Mon, 2 Mar 2026 01:00:06 +0530
X-Gm-Features: AaiRm52kw1wnE8IDel-K5c3NBDoj7DLWgIYMU_GQ7TIXPDj-_JL_JT4-UcGgRP8
Message-ID: <CAPC4XCRom4ri1QKw_mTnZGc9np5XFD1LskQnd=ssDAKBdOkGmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: hid-sensor-gyro-3d: move iio_device_register()
 to end of probe()
To: Jonathan Cameron <jic23@kernel.org>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 5:15=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
>
> On Sun,  1 Mar 2026 00:43:59 +0530
> Bhargav Joshi <rougueprince47@gmail.com> wrote:
>
> > Currently, calling iio_device_register() before
> > sensor_hub_register_callback() may create a race condition where the
> > device is exposed to userspace before callbacks are wired.
>
> We needs some more here on 'why' this is a problem.
> Whilst this is an unusual arrangement, I couldn't immediately find
> anything that was actually broken.  It's possible data will turn up
> after we tear down the callbacks and before the userspace interfaces
> are removed, but I think that just results in dropping data. Given it's
> in a race anyway I don't think we care about that. The callbacks
> don't seem to be involved in device configuration which can go on whether
> or not the callbacks are registered.  Maybe there is something that
> won't get acknowledged if they aren't in place in time?
>
> For a fix like this we'd normally want to see a clear flow that
> leads to a bug.
>
> Also a fixes tag so we know how far to backport.
>

Hi Jonathan,

I originally submitted the patch for the driver because calling
iio_device_register() before the callbacks are wired up violates
standard IIO LIFO ordering. I assumed this created a dangerous race
condition with userspace. However, as you correctly pointed out, the
HID sensor hub safely drops those early events without crashing, even
if it is unusual behaviour still won't have a hard crash.

My underlying goal was simply a structural cleanup to align the
probe() and remove() sequences with standard IIO architecture.

Would you like me to send a v2 of this patch with a revised commit
message classifying it purely as a structural cleanup (and without a
Fixes tag), or is the current driver behavior acceptable enough that I
should just drop this patch entirely?

Thanks,
Bhargav

> >
> > Move iio_device_register() to the end of the probe() function to preven=
t
> > race condition.
> >
> > Consequently, update the error handling path in probe() and in remove()
> > ensuring that iio_device_unregister() is called first to cut off
> > userspace access before the hardware callbacks are removed.
> >
> > Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
> > ---
> >  drivers/iio/gyro/hid-sensor-gyro-3d.c | 20 ++++++++++----------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/h=
id-sensor-gyro-3d.c
> > index c43990c518f7..8e3628cd8529 100644
> > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > @@ -333,12 +333,6 @@ static int hid_gyro_3d_probe(struct platform_devic=
e *pdev)
> >               return ret;
> >       }
> >
> > -     ret =3D iio_device_register(indio_dev);
> > -     if (ret) {
> > -             dev_err(&pdev->dev, "device register failed\n");
> > -             goto error_remove_trigger;
> > -     }
> > -
> >       gyro_state->callbacks.send_event =3D gyro_3d_proc_event;
> >       gyro_state->callbacks.capture_sample =3D gyro_3d_capture_sample;
> >       gyro_state->callbacks.pdev =3D pdev;
> > @@ -346,13 +340,19 @@ static int hid_gyro_3d_probe(struct platform_devi=
ce *pdev)
> >                                       &gyro_state->callbacks);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "callback reg failed\n");
> > -             goto error_iio_unreg;
> > +             goto error_remove_trigger;
> > +     }
> > +
> > +     ret =3D iio_device_register(indio_dev);
> > +     if (ret) {
> > +             dev_err(&pdev->dev, "device register failed\n");
> > +             goto error_remove_callback;
> >       }
> >
> >       return ret;
> >
> > -error_iio_unreg:
> > -     iio_device_unregister(indio_dev);
> > +error_remove_callback:
> > +     sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> >  error_remove_trigger:
> >       hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attribut=
es);
> >       return ret;
> > @@ -365,8 +365,8 @@ static void hid_gyro_3d_remove(struct platform_devi=
ce *pdev)
> >       struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> >       struct gyro_3d_state *gyro_state =3D iio_priv(indio_dev);
> >
> > -     sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> >       iio_device_unregister(indio_dev);
> > +     sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> >       hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attribut=
es);
> >  }
> >
>
