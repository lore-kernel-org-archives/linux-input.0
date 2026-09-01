Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9E23A6EF1;
	Tue,  1 Sep 2026 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788266999; cv=none; b=AaimCSAV85KJP8QqwD1sJtqC5+ioA6qYNBjQdu91VGTpxgGUUPtTrn1lwEBaCdUfaKbpsbkrG4OupiStTUY9JWZ2zeEhLSJiy7k1jAcWduxBZxIzQw4tuHFa8Ul9oSK6QpbBIezgYr2qUMDFGeWU8nA9OBisTEMF1rWjnEqKZWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788266999; c=relaxed/simple;
	bh=0y/J+ZrGVGMj9MZbwWSpoeWcdu9a6xHt/2v43+J8Qjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0VgUSbRMpO8beU/uRg9I+lTxL0U1RUejkfsZTn0nSCF1GxLPlMylIuNYIXk33abc04fsKxyQJAaFp+K3YLYS2zlWbte/KufeOKTxfHuKk7oeJnHeJxjvGaE4AblP+6Rp8h9v3/KPjHFqw6X1dsIYlJY6rZFqBHgz6Il/rx1zqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcxiLZWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcxiLZWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD3A1F000E9;
	Tue,  1 Sep 2026 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788266997;
	bh=3TBUnZS2wZlydfWZ9SQNfEhIEqbNu72wtUedh0Vl0VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LcxiLZWgDzGROdU3Th8y8ahBPmE+fPR9Eg+Pgy1M/KbnzUOmSMbU42Y06Rb0T65t+
	 HiS/svZU7vGrV7NFR1QFspK0qbEIxzl3WzUgpphdmgYvNjdke0yxnIlM9Tir28IS9o
	 EsZDH6Hol1k8e9WmoiHs7vyRL8VDLnECIsFIGA8FpXwtj+a67kpLZg5mdftwzf0GnE
	 xvsAQ1twoPLWZiVOuYRgti9Ba+IKw3DNzOJPhpwT0L0Wwv8+G2xF2P8lg4U03NL2Cm
	 q0alWaA2U71rP3KY8TPL8MKBbcpS7gHSc7KAShKF2cSgL7mGJOmhY8WZrV7Mhvlzr1
	 jGee60sH+qx5A==
Date: Tue, 1 Sep 2026 13:49:52 +0100
From: Lee Jones <lee@kernel.org>
To: Ping Cheng <pinglinux@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] HID: wacom: Use hdev->product in
 wacom_setup_touch_input_capabilities
Message-ID: <20260901124952.GK2943942@google.com>
References: <20260825151242.576456-1-lee@kernel.org>
 <CAF8JNhKWr7v7tY-tH_CGeLUQQpidx2_7J49c17TD0bw6xEi9BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF8JNhKWr7v7tY-tH_CGeLUQQpidx2_7J49c17TD0bw6xEi9BA@mail.gmail.com>

Ping, Jason,

> Thank you for your effort and persistence! We (Wacom and Wacom's
> customers) are lucky to have people like you working in this
> community!

Thank you! :)

> In addition to making sure that you know your contribution is greatly
> appreciated, I am giving you an initial testing feedback so you know
> you are on the right track.
> 
> I manually tested a few older and new Wacom tablets. Some of them have
> touch switches, some don't. They all worked well!
> 
> Two more details I'd like to share.
> 
> The first one is about the touch-only tablet. In all the models of
> Wacom tablets, there was only one model that is touch-only. It was a
> Bamboo Touch (model CTT-460) released on September 24, 2009. So, it
> was more than 17 years ago. However, the quality of Wacom tablets are
> so high, it is possible that some people are still using those ones
> ;).
> 
> The second one is about the type of touch on/off switches. There are
> two types of touch on/off switches: it can be a soft key or hardware
> switch. The hardware touch switch is easy to understand. The soft key
> touch switch is actually an on-screen display in the shape of fingers,
> where the touch on/off is controlled by the driver: [1]. This softkey
> touch switch, somehow, is not reported to the userland by the existing
> driver. Your patchset doesn't show it either.
> 
> I will do more testing to figure out the root cause of the softkey issue.

Is there anything left for me to do?

> [1] ttps://github.com/linuxwacom/input-wacom/blob/master/4.18/wacom_wac.c#L2063
> 
> On Tue, Aug 25, 2026 at 10:09 AM Lee Jones <lee@kernel.org> wrote:
> >
> > Replace the lookup-dependent 'wacom_wac->shared->touch->product' references
> > with 'hdev->product' inside wacom_setup_touch_input_capabilities() since
> > 'hdev' is already available (via container_of) and represents the touch
> > device itself.
> >
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > ---
> >
> > v7 -> v8: New patch
> >
> >  drivers/hid/wacom_wac.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index a29bf051ada7..4436faf2d2bb 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> > @@ -3953,8 +3953,8 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
> >  int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> >                                          struct wacom_wac *wacom_wac)
> >  {
> > +       struct hid_device *hdev = container_of(wacom_wac, struct wacom, wacom_wac)->hdev;
> >         struct wacom_features *features = &wacom_wac->features;
> > -
> >         if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
> >                 return -ENODEV;
> >
> > @@ -3963,9 +3963,11 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> >         else
> >                 __set_bit(INPUT_PROP_POINTER, input_dev->propbit);
> >
> > -       if (features->type == HID_GENERIC)
> > +       if (features->type == HID_GENERIC) {
> > +               hid_dbg(hdev, "generic touch setup\n");
> >                 /* setup has already been done */
> >                 return 0;
> > +       }
> >
> >         input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> >         __set_bit(BTN_TOUCH, input_dev->keybit);
> > @@ -3997,19 +3999,17 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> >                 input_dev->evbit[0] |= BIT_MASK(EV_SW);
> >                 __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> >
> > -               if (wacom_wac->shared->touch->product == 0x361) {
> > +               if (hdev->product == 0x361) {
> >                         input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> >                                              0, 12440, 4, 0);
> >                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> >                                              0, 8640, 4, 0);
> > -               }
> > -               else if (wacom_wac->shared->touch->product == 0x360) {
> > +               } else if (hdev->product == 0x360) {
> >                         input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> >                                              0, 8960, 4, 0);
> >                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> >                                              0, 5920, 4, 0);
> > -               }
> > -               else if (wacom_wac->shared->touch->product == 0x393) {
> > +               } else if (hdev->product == 0x393) {
> >                         input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> >                                              0, 6400, 4, 0);
> >                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> > @@ -4039,8 +4039,8 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
> >                 fallthrough;
> >
> >         case WACOM_27QHDT:
> > -               if (wacom_wac->shared->touch->product == 0x32C ||
> > -                   wacom_wac->shared->touch->product == 0xF6) {
> > +               if (hdev->product == 0x32C ||
> > +                   hdev->product == 0xF6) {
> >                         input_dev->evbit[0] |= BIT_MASK(EV_SW);
> >                         __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> >                         wacom_wac->has_mute_touch_switch = true;
> > --
> > 2.55.0.887.g758fc8c411-goog
> >
> >

-- 
Lee Jones
