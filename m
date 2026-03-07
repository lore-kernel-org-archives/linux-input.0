Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719103921C8;
	Sat,  7 Mar 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772893323; cv=none; b=oNZHnQpUjuiq9L45npGyIot0edwM7tkVY35oOjd26gVUTHnh9SBqfyTfUzAOYkGgPyqMw+WhIX2WmWdnxU3WEg9CS63r2mHGAhEStuDH8QWrXpgK4rJEGgDYxnYVfZq0FR/7Y3u7gtCilFtuBzlgrAHujkDiVlNCSGkASt/tj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772893323; c=relaxed/simple;
	bh=FRXNGoH9VPCjKjelFZ/fekAYJZtNO/11PzBFs2rLJU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2Nrv23vOMBJp/5fOMFVw5qmmT3aZLqEqWsQIUZA38xLBRY+WYLiI9CBi+e4hn2b7HfXcD4cE1Ac8lO72SjCbYjd6x/qB8+g8TmRTWR6z7bl+u1C3u5ortYXZGt3pPlEj4sveVd9paU5sS4fSXRjRWomhdL8zDIqNhRQWXwhvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qU/ggGNK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qU/ggGNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F1CC19422;
	Sat,  7 Mar 2026 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772893323;
	bh=FRXNGoH9VPCjKjelFZ/fekAYJZtNO/11PzBFs2rLJU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qU/ggGNK001qBsFbEuAa9bFUv3x9G7y+NmWDrqz3fPyLU81n/IFIkRpqHD1+y2t4n
	 R5OJmnscF76JtN+6zbucHlZPkzDWTF1Lcu8sW4BxRgyEkRW+1ZgZJXf6LYVGzoW7dy
	 ghx5xyDGWN+EcKQfzUD01U5RVZU1OVKXC/r4PNW0Pduy1nA9vKewn8SCShZy11ESfc
	 wkEOdo37FGxO+HxwT3S+PixywtFeRHvmOXPZbwoqg/L/wGNiLLXadYMas85trLXGqb
	 yzngfBgu5t+Ydg8J+SFgz4Km127cZqxbc62AlrAMWOES/9fyn8xoLoiboWVVBC5aVD
	 A5umhaBUwfiJg==
Date: Sat, 7 Mar 2026 14:21:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: hid-sensor-gyro-3d: move iio_device_register()
 to end of probe()
Message-ID: <20260307142153.26bab5b0@jic23-huawei>
In-Reply-To: <CAPC4XCRom4ri1QKw_mTnZGc9np5XFD1LskQnd=ssDAKBdOkGmQ@mail.gmail.com>
References: <20260228191400.19244-1-rougueprince47@gmail.com>
	<20260228191400.19244-2-rougueprince47@gmail.com>
	<20260301114450.17f79213@jic23-huawei>
	<CAPC4XCRom4ri1QKw_mTnZGc9np5XFD1LskQnd=ssDAKBdOkGmQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2026 01:00:06 +0530
Bhargav Joshi <rougueprince47@gmail.com> wrote:

> On Sun, Mar 1, 2026 at 5:15=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Sun,  1 Mar 2026 00:43:59 +0530
> > Bhargav Joshi <rougueprince47@gmail.com> wrote:
> > =20
> > > Currently, calling iio_device_register() before
> > > sensor_hub_register_callback() may create a race condition where the
> > > device is exposed to userspace before callbacks are wired. =20
> >
> > We needs some more here on 'why' this is a problem.
> > Whilst this is an unusual arrangement, I couldn't immediately find
> > anything that was actually broken.  It's possible data will turn up
> > after we tear down the callbacks and before the userspace interfaces
> > are removed, but I think that just results in dropping data. Given it's
> > in a race anyway I don't think we care about that. The callbacks
> > don't seem to be involved in device configuration which can go on wheth=
er
> > or not the callbacks are registered.  Maybe there is something that
> > won't get acknowledged if they aren't in place in time?
> >
> > For a fix like this we'd normally want to see a clear flow that
> > leads to a bug.
> >
> > Also a fixes tag so we know how far to backport.
> > =20
>=20
> Hi Jonathan,
>=20
> I originally submitted the patch for the driver because calling
> iio_device_register() before the callbacks are wired up violates
> standard IIO LIFO ordering. I assumed this created a dangerous race
> condition with userspace. However, as you correctly pointed out, the
> HID sensor hub safely drops those early events without crashing, even
> if it is unusual behaviour still won't have a hard crash.
>=20
> My underlying goal was simply a structural cleanup to align the
> probe() and remove() sequences with standard IIO architecture.
>=20
> Would you like me to send a v2 of this patch with a revised commit
> message classifying it purely as a structural cleanup (and without a
> Fixes tag), or is the current driver behavior acceptable enough that I
> should just drop this patch entirely?

My gut is leave this one alone. It's a rather unusual driver in lots
of ways, so I don't really mind one more ;)

Lets see if anyone else has strong views one way or the other.

Srinivas?

>=20
> Thanks,
> Bhargav
>=20
> > >
> > > Move iio_device_register() to the end of the probe() function to prev=
ent
> > > race condition.
> > >
> > > Consequently, update the error handling path in probe() and in remove=
()
> > > ensuring that iio_device_unregister() is called first to cut off
> > > userspace access before the hardware callbacks are removed.
> > >
> > > Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
> > > ---
> > >  drivers/iio/gyro/hid-sensor-gyro-3d.c | 20 ++++++++++----------
> > >  1 file changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro=
/hid-sensor-gyro-3d.c
> > > index c43990c518f7..8e3628cd8529 100644
> > > --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> > > @@ -333,12 +333,6 @@ static int hid_gyro_3d_probe(struct platform_dev=
ice *pdev)
> > >               return ret;
> > >       }
> > >
> > > -     ret =3D iio_device_register(indio_dev);
> > > -     if (ret) {
> > > -             dev_err(&pdev->dev, "device register failed\n");
> > > -             goto error_remove_trigger;
> > > -     }
> > > -
> > >       gyro_state->callbacks.send_event =3D gyro_3d_proc_event;
> > >       gyro_state->callbacks.capture_sample =3D gyro_3d_capture_sample;
> > >       gyro_state->callbacks.pdev =3D pdev;
> > > @@ -346,13 +340,19 @@ static int hid_gyro_3d_probe(struct platform_de=
vice *pdev)
> > >                                       &gyro_state->callbacks);
> > >       if (ret < 0) {
> > >               dev_err(&pdev->dev, "callback reg failed\n");
> > > -             goto error_iio_unreg;
> > > +             goto error_remove_trigger;
> > > +     }
> > > +
> > > +     ret =3D iio_device_register(indio_dev);
> > > +     if (ret) {
> > > +             dev_err(&pdev->dev, "device register failed\n");
> > > +             goto error_remove_callback;
> > >       }
> > >
> > >       return ret;
> > >
> > > -error_iio_unreg:
> > > -     iio_device_unregister(indio_dev);
> > > +error_remove_callback:
> > > +     sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> > >  error_remove_trigger:
> > >       hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attrib=
utes);
> > >       return ret;
> > > @@ -365,8 +365,8 @@ static void hid_gyro_3d_remove(struct platform_de=
vice *pdev)
> > >       struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> > >       struct gyro_3d_state *gyro_state =3D iio_priv(indio_dev);
> > >
> > > -     sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> > >       iio_device_unregister(indio_dev);
> > > +     sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
> > >       hid_sensor_remove_trigger(indio_dev, &gyro_state->common_attrib=
utes);
> > >  }
> > > =20
> > =20

