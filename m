Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794480549;
	b=FeGyFjVC1/FbO8qmqjNbweCjXg6dhaNxKin5L6LFHuGbwoY7jKyTwEQFiStLYhBLJNQe
	 y/Ttiq7qJGvbah4SbaOQo0051mtvHcAHU8++vDnenPG2o85qN5RmthCGdIrH5QexRvnlS
	 gXVl1ThdG0oHoCy7xu4f6ABiZBh4mQ3UttysbpTfKW+RooEG1ygBQpGLMHuMI4I35HlMF
	 7DyjEovVlM1m5Tx3s88qPiYHyscn6S/Hn0QHcA8oUNyqzbS+Ob/jRmMRPer9Fhyzcnw67
	 8XFSPxz+nMeJHswK/Ur85pdvlUwqMI66rZA7yLEIfnYb87isYdrT9m+LSgHCt0NpMQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480549;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=djeywF8NU6JhVA2LA1RCUZwnghPMCvDfZV9losxqGOA=;
	b=x14EOkVE6IlW6QkmON5iohuLsLTE4ny5lP5mfS3U717CcDFRylJlzVqawvBjQ9W1NCOu
	 CY+1JFN3nDetprlPT2tiflFu14d34Vsv+S2ZWAm2LRKu4gkvuu4Dqa7isp4PZEFirVLGr
	 ah7rLx2kYiRETissQMK66UPTpd9eO5Zu8TiOTAvvxlvYOl3zdFYhITTG64wgZpCoZGUQf
	 jaQoTU1/3EvWmEIIZyZFkmYkfAXuawOxONH9rVA2x8aZSc62ezoGmYmpsvgohkoepGmWz
	 PPr5oPbDRPwGB18TBDWJ6J+LP2ka9AD0MSGqSMmUr+SPw0uP4VvBwa6qQkt1tu8piYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoTjQFN6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAD0606A89E
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 10:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BAD0606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FoTjQFN6
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67bee1f693bso3786118d50.1
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 02:49:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794480548; cv=none;
        d=google.com; s=arc-20260327;
        b=EJETVeu3QlQOMZlDmj6iXwF3z8ACO2RGuNlaKIRw+wmeHXGDKaK7apD4jdEV6Ktg8Y
         lm6FWypFRVHm+3JWX8tf14rkdm+FeOmM0U9GfG25GL8QxlpkpZFplabCqRuMUCs30FfL
         k+Q0BsODjtG7el6aGnyLyWuAOWk+6Nr2F/AkdiC7KRzj0cHWzVHZCzjLGpdEK0lpSBKW
         vxe863NntGdTaJ3HWkXcuGeGKZ0UcBc43CgmJEyBN1Tu5V7mRt1NYDLKn4eSgmkq6yjT
         Pyo1F95q4ChuxPxBaE7ObQp4QLjUUSbnzDGXrcSf8yp+KPN1tOascgm0iydrdDM+0Gbi
         8qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=djeywF8NU6JhVA2LA1RCUZwnghPMCvDfZV9losxqGOA=;
        fh=zBOa/RFZ4Fiil7C0P0Tj2jQoxzAGyAjCZcT/2Hdj/nQ=;
        b=A1U0o+di2X49GnRIUuUqzOfhg+NZEOfWUSbqxL8Xj39RwXroxM+z+kcleHLlqwjBW2
         CIoH+N+vTNjgUxNRWqkJCm8RnbKqvvT1fhiOQ+0CMeZVqDVlbtcEXxNRvtC7N2udfmF0
         9TFSHyCUnpb5qrY4WQaYBBOw8zATx79cHH638pBrvcIwM5Qu+VW92pPcDEutXfW9WEYA
         MDCEWqUgJM9Ffpu5y4+72GbvXWY4iNpeXRXtXgW9JRHTXdxUS6Il2q4yexedYyhblvEu
         js+C/U8EWqPGe45pcjhdih7/6rYDnH9v1nJ3wOAmHV3uwBtyO6/1Bkyj9g36n4+kQHts
         8gJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794480548; x=1795085348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=djeywF8NU6JhVA2LA1RCUZwnghPMCvDfZV9losxqGOA=;
        b=FoTjQFN6HKDx5jy184j9d8fpoMU4ig57gFse8f6Zw3tpbWpaNUmen+l8TbMwQBr98F
         K/SiCATGkVA9+PDnMnd6K+vLTL7VHcOGARIWGB8zphm16QHjJZedmPhD3jBD2BF+C9c7
         kNCNCVexmmltKENgVFxOIkw6b8haSD94a6w777S1gmlPmi/CWmymacrjWz+qjgEQ4les
         aWFplqMgHU41kjoCKAVuj2uYEtZRpsbYzOjL+vf3T/6aioIWB3COME6Ddaa9OeTHuLtj
         vfuJmQWzbAqh0KqYRXabp3fdx/m3JZiBIzTE/wMc8SmsU4RrWLnZO9LkGS/ftCdSbSIm
         Fa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480548; x=1795085348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=djeywF8NU6JhVA2LA1RCUZwnghPMCvDfZV9losxqGOA=;
        b=amQulCrE3um7MidjglloCNGZaHeETRaeYbhE2x5NuFafVkExRaem4zXB0eHkutLhuD
         lZ20dMBKFRk3r/B9TAPBJ64SUt8tRmEq4jkjYfGDLaIKMefKGY81wqWYCuEJO9mii8pW
         MZxP95dV6DwoadtK+ec4qgJWioHRi/lm2zF6w7H2i5nNZ0od6ITeLubU68Zb2GUsdtMN
         ciC3bufbRcx8v2VWroGNPLY8X4bmTaQRh1Wo6QxYkTPH8lxC7FwSuzGIE7pm1wIXB0/2
         1M1izGIXT3V4jCMMuq0xIIaaI9kDSlJMLrmJ9cbxKKoAaGHvve4SGI5yAINeSAEXU7Ui
         tFWw==
X-Forwarded-Encrypted: i=1; AL+hErHJ0JTCy8eCWLK/dqGnyag3zSUJWWMswK1vj/UeYu63myjaVdQogtn7ypkO6YngdIKFJvGejrP3sTBRvw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9EFO0PAcg0I3+SJn8+cD9f4Ooa3qs6oaDCBT3iDZSbmI008HUB
	fnCFQnjm6+KknyhpJhiOGPJi3BtMkZpLLau70Uwk1mk32mQR8U7NIYqm9fwpkZ0BoX0KXZrWZmf
	K+GKYCLjVBq+SDRHMgWvGaDY7/1xcdmQ=
X-Gm-Gg: AYBFou18Bxpc0LSi2NrTceTSeGHeYVYwutlymtkKUczLRKo6xFBoYe3oKA0G9/HoIaK
	X5N3vFvjoI7VxnpVTavmKmqQmNrQwo9DiIfom9wB7uLtxm3rpr5nQGBVXuQeRp82skyd3jmQem0
	jlleiOwh+OCPT6xMSdbNhoSz4pMfoxr0SO7nQEXm6UApsXUW1RezRCBICvkdYIXc/AsFS8MnsGY
	ydRaTF8vSXtk/TolEho/n2kFd8eyMekjcNQJduwP/uTfGR1wppgqJrl08t4pXk0lGws72x0vo+R
	ysMKQGtHWFni1sP72mzCOxPvFrnzGOzvP90tjoJllJMDMkFElgq+6FOG2TEz3mwmcvNjOMVVw9L
	3msDFDoaH3hn06EbqGlvbhwF5bwtM43pBew0T1XWcklERmjeT4LBVRy8CtJDbw0KLtKquQEA=
X-Received: by 2002:a05:690e:458a:20b0:679:bad8:7dd0 with SMTP id
 956f58d0204a3-67c67f00246mr2870020d50.27.1794480548052; Thu, 12 Nov 2026
 02:49:08 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <CAPb1+K2BxnfQ7VUQ15td5f9pVhn-ARSM9EjfOU8WuW72o+cvPg@mail.gmail.com> <2f722967b6db0692d4dd4164aff39b62@gmail.com>
In-Reply-To: <2f722967b6db0692d4dd4164aff39b62@gmail.com>
From: Gideon Heinz <gideonheinz02@gmail.com>
Date: Thu, 12 Nov 2026 11:48:56 +0100
X-Gm-Features: AclHuK-kGykkeazgcRdIxLsRXEFTifsTMFIGeK5tG_bdJlYg18i60d5dyzfQ1AM
Message-ID: <CAPb1+K1J2F-=cJF_+Z+RkA+9uLD8-15m3hDv71DSPG47XLJttw@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	=?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, Edwin Velds <e.velds@gmail.com>, 
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

I tested the out-of-tree equivalent you suggested, ff->destroy =3D NULL;
in hidpp_ff_stop(), on top of the 33-patch v2 module (G920 046d:c262,
7.3.1-1-cachyos).

Same reproduction as before: fftest holding the event node at the
effect prompt, rmmod hid_logitech_hidpp from another terminal, then
entering -1 in fftest.
This time fftest exits normally, the machine stays up, and there are
no errors in dmesg.
The only message is the single =E2=80=9CUnloading HID++ force feedback.=E2=
=80=9D at rmmod time.

I=E2=80=99ll try your input core patch on a rebuilt kernel later and report=
 back

Thanks,
Gideon

On Thu, Nov 12, 2026 at 3:43=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Gideon,
>
> On Thu, Nov 12, 2026 at 02:30:39AM +0100, Gideon Heinz wrote:
> > Hi Dmitry,
> >
> > I tested v2 of the series on my G920 (046d:c262). Everything on my
> > list works except one scenario that takes the whole machine down, with
> > and without your series (last item).
> ...
> >  - rmmod with fftest holding the device open: rmmod returned after
> >    2.99 s with "Unloading HID++ force feedback" and nothing else in
> >    dmesg. When I then exited fftest (entering -1), the machine went
> >    down: the first time with a garbled panic screen that I couldn't
> >    read, and on later attempts as a total hang with no output. The
> >    same sequence on stock Arch 7.2.11-arch1-1 with the unpatched
> >    driver also hangs the whole system, so this predates the series.
> >
> >    To reproduce: with the module loaded and the G920 plugged in, start
> >    fftest on its event node and leave it at the effect prompt, run
> >    "rmmod hid_logitech_hidpp" from another terminal, then enter -1 in
> >    fftest.
> >
> >    I could not recover a trace yet and will send one if I manage to.
> >
> >    My guess, from reading the code and not verified by a trace:
> >    hidpp_ff_create() stores hidpp_ff_destroy() and the other FF
> >    callbacks in the ff_device as pointers into the module. With fftest
> >    holding the evdev open, the input_dev outlives the driver, so when
> >    fftest closes, the final input_dev release calls ff->destroy in
> >    module code that rmmod has already freed.
>
> Thank you very much for the thorough testing!
>
> Your diagnosis is spot on. Opening /dev/input/eventX pins the evdev cdev
> (and through it input_dev), but does not hold a module reference on the
> underlying HID driver. When rmmod unloads hid_logitech_hidpp while fftest
> still has the file descriptor open, __input_unregister_device() disconnec=
ts
> evdev (flushing effects, closing the device, and marking evdev dead so al=
l
> subsequent ioctls and writes return -ENODEV) and runs ff->stop(), after
> which rmmod frees the module text. When fftest finally exits and closes t=
he
> file descriptor, input_dev_release() calls input_ff_destroy(), which
> invokes ff->destroy() pointing into the already-unmapped module text.
>
> Rather than working around this in individual drivers with a separate
> ff->stop() callback, input core should call input_ff_destroy() directly i=
n
> __input_unregister_device() once all handlers are disconnected and the
> device is removed from sysfs. At that point nothing touches dev->ff
> anymore, and calling input_ff_destroy() there guarantees ff->destroy()
> always runs while the driver and its module are still loaded (while the
> second input_ff_destroy() call in input_dev_release() becomes a no-op onc=
e
> dev->ff is NULL).
>
> Could you try the input core patch below (with patch 22/33 "HID:
> logitech-hidpp: shut down G920 force feedback on input unregister" droppe=
d
> from the hid-logitech-hidpp series, since ff->stop is removed and
> hidpp_ff_destroy() will now run on input unregistration)?
>
> Alternatively, if you prefer to test with your out-of-tree module build
> without rebuilding the kernel, you can test the equivalent effect by
> setting:
>
>         ff->destroy =3D NULL;
>
> inside hidpp_ff_stop() in hid-logitech-hidpp.c.
>
> Thanks.
>
> ---
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Subject: [PATCH] Input: destroy force-feedback device on input unregistra=
tion
>
> When an input device is unregistered while userspace holds an open file
> descriptor to its event node, input_dev_release() is deferred until the
> last file descriptor is closed. Because input_ff_destroy() was only
> called from input_dev_release(), force-feedback teardown (ff->destroy
> and freeing ff->private) could run after the parent driver had already
> unbound, freed its device state, or even been unloaded via rmmod,
> causing use-after-free errors or page faults in unmapped module text.
>
> Commit ef166ce08801 ("Input: stop force-feedback timer when
> unregistering input devices") added a separate ff->stop callback for
> ff-memless, but left ff->destroy invoked from input_dev_release().
>
> Once __input_unregister_device() has disconnected all input handlers
> (which flushes effects, closes the device, and marks evdev dead) and
> deleted the device from sysfs, nothing accesses dev->ff anymore. Call
> input_ff_destroy() directly in __input_unregister_device() so that
> ff->destroy() always runs synchronously while the driver and its module
> are still active, and remove the now-redundant ff->stop callback. Keep
> input_ff_destroy() in input_dev_release() (where it is a no-op once
> dev->ff is NULL) to handle input_free_device() on devices that were
> never registered.
>
> Fixes: 509ca1a93836 ("Input: implement new force feedback interface")
> Cc: stable@vger.kernel.org
> Reported-by: Gideon Heinz <gideonheinz02@gmail.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/ff-core.c    |  2 +-
>  drivers/input/ff-memless.c | 23 -----------------------
>  drivers/input/input.c      |  5 ++---
>  include/linux/input.h      |  3 ---
>  4 files changed, 3 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/input/ff-core.c b/drivers/input/ff-core.c
> index 0e5d1d1ceb46..133b4622dc49 100644
> --- a/drivers/input/ff-core.c
> +++ b/drivers/input/ff-core.c
> @@ -338,7 +338,7 @@ EXPORT_SYMBOL_GPL(input_ff_create);
>   *
>   * This function is only needed in error path as input core will
>   * automatically free force feedback structures when device is
> - * destroyed.
> + * unregistered or destroyed.
>   */
>  void input_ff_destroy(struct input_dev *dev)
>  {
> diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
> index d1fefd1dfc0d..3069436148ec 100644
> --- a/drivers/input/ff-memless.c
> +++ b/drivers/input/ff-memless.c
> @@ -483,32 +483,10 @@ static void ml_ff_destroy(struct ff_device *ff)
>  {
>         struct ml_device *ml =3D ff->private;
>
> -       /*
> -        * The timer is normally shut down in ml_ff_stop() when the devic=
e
> -        * is unregistered. However, we still shut it down here as a safe=
ty
> -        * net and for cases where the device was never registered (e.g.
> -        * error paths during probe).
> -        */
>         timer_shutdown_sync(&ml->timer);
> -
>         kfree(ml->private);
>  }
>
> -static void ml_ff_stop(struct ff_device *ff)
> -{
> -       struct ml_device *ml =3D ff->private;
> -
> -       /*
> -        * Even though we stop all playing effects when tearing down an
> -        * input device (by the way of evdev calling input_flush_device()
> -        * that calls into input_ff_flush() that stops and erases all
> -        * effects), we do not actually shutdown the timer, and therefore
> -        * we should do it here to prevent it firing after the input
> -        * device is unregistered and its associated resources are freed.
> -        */
> -       timer_shutdown_sync(&ml->timer);
> -}
> -
>  /**
>   * input_ff_create_memless() - create memoryless force-feedback device
>   * @dev: input device supporting force-feedback
> @@ -543,7 +521,6 @@ int input_ff_create_memless(struct input_dev *dev, vo=
id *data,
>         ff->playback =3D ml_ff_playback;
>         ff->set_gain =3D ml_ff_set_gain;
>         ff->destroy =3D ml_ff_destroy;
> -       ff->stop =3D ml_ff_stop;
>
>         /* we can emulate periodic effects with RUMBLE */
>         if (test_bit(FF_RUMBLE, ff->ffbit)) {
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 210635ef147e..7be69deed8eb 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2286,10 +2286,9 @@ static void __input_unregister_device(struct input=
_dev *dev)
>                 input_wakeup_procfs_readers();
>         }
>
> -       if (dev->ff && dev->ff->stop)
> -               dev->ff->stop(dev->ff);
> -
>         device_del(&dev->dev);
> +
> +       input_ff_destroy(dev);
>  }
>
>  static void devm_input_device_unregister(struct device *dev, void *res)
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 3381608127f7..02047cc45d04 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -549,8 +549,6 @@ extern const struct class input_class;
>   * @set_autocenter: Called to auto-center device
>   * @destroy: called by input core when parent input device is being
>   *     destroyed
> - * @stop: called by input core when parent input device is being
> - *     unregistered
>   * @private: driver-specific data, will be freed automatically
>   * @ffbit: bitmap of force feedback capabilities truly supported by
>   *     device (not emulated like ones in input_dev->ffbit)
> @@ -579,7 +577,6 @@ struct ff_device {
>         void (*set_autocenter)(struct input_dev *dev, u16 magnitude);
>
>         void (*destroy)(struct ff_device *);
> -       void (*stop)(struct ff_device *);
>
>         void *private;
>
>
> --
> Dmitry
