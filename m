Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780725A642
	for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 14:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350809; cv=pass; b=uOII9e36NfYYsh1KIHx2tY0CktiNZB0jYo1CTYBPQFnouYIGAnELwjImxe01wiecEVRfSLAlr0RuYdb6+e7f/5T4hAJPw9Inpdg25XAbBv2znQxaSbTmdWFp0P5iKGwjuU/s/65uXM47cflFeuGSaD+v0zbvVjLeJqcmOGkGqa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350809; c=relaxed/simple;
	bh=DZCLn5MJ4r3soQbNgHCA3buradW5el48yuJ9ZXDcTfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kRz76x5q1cGbrE7mI7Hdc5/d/mHw0lyaeSjxciC522zaBCFZifb/1eUhEjbTjhyQoyBpoEVlN2yme/Iww+aXqfBlUDgbnc2s1dOdnngPUtcR0S5st06U7AW5bfDocIcmyHaqg0NWM308WPeMUCeJBSkDVF9aqM6Gquk72FwZL3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=geiMWKBZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kBKn6vB3; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geiMWKBZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kBKn6vB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776350807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdVxqyAXKoeqrj2cGnO5r3z+/z3A0QdARs5q1LcXUQY=;
	b=geiMWKBZUUMg2kqBLn1yVu52h3jiTFoNjKl3Og4vMLk+zwj8JGOBzyoXw8oqgvE55zL0jn
	EU7xZxTHDTzDF4c8Egj6RbzL79Th/Pu2uogaPPqay3GJhUSp6v3KHFeb+FnEI0cKB0PS9J
	XnC+SXm2rUQJawQD7r3QDdNL/roFNz4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-tWiGYGQXNoKeqScVWgUUqw-1; Thu, 16 Apr 2026 10:46:44 -0400
X-MC-Unique: tWiGYGQXNoKeqScVWgUUqw-1
X-Mimecast-MFC-AGG-ID: tWiGYGQXNoKeqScVWgUUqw_1776350804
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35e59791605so5190664a91.1
        for <linux-input@vger.kernel.org>; Thu, 16 Apr 2026 07:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776350804; cv=none;
        d=google.com; s=arc-20240605;
        b=PBHoWyFqH8isFHg+TO1gxdzaCWaN/UKmKWM+QxTJqHPOk4GVpkv23ul+jeJp30ris4
         qOCyAoiecidqDmDpQmf8D35nRQZqa7ZI9zvfmgPMCtStdXQjGmWg/wJVd102ZLyrYLPk
         o4w7+OnDuGidbgI8mJtsMuByxzHxcbOpq7Zc4q7eRJHmZ1F2wxBUIm5NgSjN4FF0Q76I
         bUcnDyHg9ogae7Aiz0Imy/05G9cXLVDYps1+nt4Dex4QVvkMR6Vhjq6wM3U8Z/pjRUcQ
         9vmOvo5aXv6lnVXUaayTlu5qm9bmjefMDvFTCi5WdqJ9qBbsu0FQkXL1a+FKiIfU9au7
         EMwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QdVxqyAXKoeqrj2cGnO5r3z+/z3A0QdARs5q1LcXUQY=;
        fh=qzCiIG7zun79yHbu6spaaH7zKBmkL+WXTcoT0LMT4jQ=;
        b=Ae6snfBQRPv6bOLlRgs9d1/3yirWBkEDsjeh/RM4lBYpjBfRcruyytdkugvA3l2p4p
         dW/oXv1g9H5GyUslapg57qWad/QSezs/MwHYkmM5KGLdIeZ9Gvkj7yGWa408/aonyK4s
         +GT4rMgZt4K7RSDbjEEc6ZEerjDzEXvICsE7bY85PeFTRoX2fpLzSriaLbbsU3qeZmjR
         lmQGeRgL0z0YR4hTIJoQwiDHUCD+RdT+WlUfxCGOzG1I17yu7/x7TRSs8brgaESaPj4b
         vmHk5EPiUaeAxGhg6Qcqzqp1btSbkd1zN8GXv4vf9mkmC9tHsCcFCGxetgsfqe4KtSUW
         5KJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776350804; x=1776955604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdVxqyAXKoeqrj2cGnO5r3z+/z3A0QdARs5q1LcXUQY=;
        b=kBKn6vB3BtmaV4xRfMOSDUubFfkj5/Zd+Xnl23CqpXQo2ZJCuPCArjNTXId8/SeQOa
         TPGNmOZAMzFQ6VEN3iXc0yzs/P52Zat+3ABcYe93mDR3GtxalYQyX6JKr7mA2Sx3wwjd
         KfUFbkyHveSOfNyktw+Cj8qEfMkf2DXI9kqK8vHsrYFphvfJUxA/3xs3OoE9Hf0z23dU
         dQJMyls42Snq+M1lzCNZvfBmXfjQ5lrc1QU3YJ38dZ4Sfw+XL7qoByaHyHkbQCz62UNi
         cSDn9StuoYBgdMLFe/gO3TuOktgp5jUFNlR4cpNRqtHrG6XquE9fjumZnrGqnqgmUTke
         DIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350804; x=1776955604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QdVxqyAXKoeqrj2cGnO5r3z+/z3A0QdARs5q1LcXUQY=;
        b=hSOcUdKwkl+hIJTyJyjjBmWn0NoEO43yNpDk7VERkI5wl2tF/b7efAZsCvm4FuOzNy
         70o4dS/fxsgoNDwjRtuuNKAzePsCi9/hbqxazElKCR7FrdlXBOW7ZO8JsQaansA9K7qd
         s3B7OFqDuYP3s98asmtszgEVQUt5Dj0yjyfJnDLZQazbB33q1bvTrW64H68Ly41uOshj
         pIxSPqymHT+Uquvtyr0GhPldYilur3Ck+vjcqshXxpJQUm9cJqNj825cAPtPmQpcQLIu
         +KsO2SnzVjpPDbIOh5pExWwybUapxC8/opWVfwx8/Hvp6nR4I4WnC4VB91A3adDypzHA
         /6/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8yIb7iiksZiXghHBsQaJl9L0TEal2rafltCWdoK6hymtB+A+xe4/LVbOTI/lG2dhq9sd2jAlyKCJE0aA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKxw0ZRhSOAU2IQ8u9YTLoo30frbHfV29D0PxVSaZ5WWNhdF6
	runSwpgsZn6CXah8SI3Xk8VNW1jM9q1jkXwvy4uUyvbheAOntrR4wUl4732lKmHBYgsftzZZRDM
	ItCG+yXOdKYcaaD1T5VSmn7vUtxNrt7C75lObxHMYAdl0/GrET/IV0ufM62nmMwoqA3InUaRhqP
	Ud7N9TUjNPS/MomSXPSIz3v9fBqpnBc8NNqFNBJ2k=
X-Gm-Gg: AeBDiet4QVYIgeZtsL7496rogxXjli1pmOmD38kQclq8VIMSkKbLDWNyeOYaZ9vbq0f
	S19F79y65cwjdInjdWkVM4Jj/ELxDmIL1R1vm5uZqScv8AQ0R7Ni20zKADFa9KR+s5s8whJUZ8L
	7l3iDU2EUqbAE1mGpEQDvjNvFH6k2kgEnSAy56D/Q68TsSq50+lbCzfKNQEbeZox8FGWuRckcMh
	ag=
X-Received: by 2002:a05:6a20:4312:b0:398:8d38:c60c with SMTP id adf61e73a8af0-39fe40aac53mr28231787637.55.1776350803577;
        Thu, 16 Apr 2026 07:46:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:4312:b0:398:8d38:c60c with SMTP id
 adf61e73a8af0-39fe40aac53mr28231742637.55.1776350803080; Thu, 16 Apr 2026
 07:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415-wip-fix-core-v1-0-ed3c4c823175@kernel.org>
 <20260415-wip-fix-core-v1-2-ed3c4c823175@kernel.org> <8fedad8e9caecd379f2296562cd6abd37f7cee46.camel@hadess.net>
In-Reply-To: <8fedad8e9caecd379f2296562cd6abd37f7cee46.camel@hadess.net>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Thu, 16 Apr 2026 16:46:28 +0200
X-Gm-Features: AQROBzD-vVFl_065x6nZIK1IjlDiUy9P4QSkjgjIaaL4c8szdqTSf21JUcEoXr8
Message-ID: <CAO-hwJ+EgC0pM6L6vGFEaRFt2Nwj5b-CCf_5e5VkvrXgdHrjNg@mail.gmail.com>
Subject: Re: [PATCH 2/4] HID: core: introduce hid_safe_input_report()
To: Bastien Nocera <hadess@hadess.net>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	=?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 11:41=E2=80=AFAM Bastien Nocera <hadess@hadess.net>=
 wrote:
>
> On Wed, 2026-04-15 at 11:38 +0200, Benjamin Tissoires wrote:
> > hid_input_report() is used in too many places to have a commit that
> > doesn't cross subsystem borders. Instead of changing the API,
> > introduce
> > a new one when things matters in the transport layers:
> > - usbhid
> > - i2chid
> >
> > This effectively revert to the old behavior for those two transport
> > layers.
> >
> > Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
> > bogus memset()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >  drivers/hid/hid-core.c             | 21 +++++++++++++++++++++
> >  drivers/hid/i2c-hid/i2c-hid-core.c |  7 ++++---
> >  drivers/hid/usbhid/hid-core.c      | 11 ++++++-----
> >  include/linux/hid.h                |  2 ++
> >  4 files changed, 33 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index a806820df7e5..cb0ad99e7a0a 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2191,6 +2191,27 @@ int hid_input_report(struct hid_device *hid,
> > enum hid_report_type type, u8 *data
> >  }
> >  EXPORT_SYMBOL_GPL(hid_input_report);
> >
> > +/**
> > + * hid_safe_input_report - report data from lower layer (usb, bt...)
> > + *
> > + * @hid: hid device
> > + * @type: HID report type (HID_*_REPORT)
> > + * @data: report contents
> > + * @bufsize: allocated size of the data buffer
> > + * @size: useful size of data parameter
> > + * @interrupt: distinguish between interrupt and control transfers
> > + *
> > + * This is data entry for lower layers.
>
> You probably want to explain why it should be used instead of
> hid_input_report() in this doc blurb, and modify the hid_input_report()
> docs to mention that this should be used.

Good point. Sending v2 ASAP.

>
> Maybe hid_input_report() should also be marked as deprecated somehow,
> to avoid new users?

Well, it's not entirely deprecated because, for instance, in uhid we
only have the buffer with the provided size around. So we can't be
less restrictive in that precise case, and then switching to _safe
will not change a bit.

Cheers,
Benjamin

>
> Cheers
>
> > + */
> > +int hid_safe_input_report(struct hid_device *hid, enum
> > hid_report_type type, u8 *data,
> > +                       size_t bufsize, u32 size, int interrupt)
> > +{
> > +     return __hid_input_report(hid, type, data, bufsize, size,
> > interrupt, 0,
> > +                               false, /* from_bpf */
> > +                               false /* lock_already_taken */);
> > +}
> > +EXPORT_SYMBOL_GPL(hid_safe_input_report);
> > +
> >  bool hid_match_one_id(const struct hid_device *hdev,
> >                     const struct hid_device_id *id)
> >  {
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-
> > hid/i2c-hid-core.c
> > index 5a183af3d5c6..e0a302544cef 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> > @@ -574,9 +574,10 @@ static void i2c_hid_get_input(struct i2c_hid
> > *ihid)
> >               if (ihid->hid->group !=3D HID_GROUP_RMI)
> >                       pm_wakeup_event(&ihid->client->dev, 0);
> >
> > -             hid_input_report(ihid->hid, HID_INPUT_REPORT,
> > -                             ihid->inbuf + sizeof(__le16),
> > -                             ret_size - sizeof(__le16), 1);
> > +             hid_safe_input_report(ihid->hid, HID_INPUT_REPORT,
> > +                                   ihid->inbuf + sizeof(__le16),
> > +                                   ihid->bufsize -
> > sizeof(__le16),
> > +                                   ret_size - sizeof(__le16), 1);
> >       }
> >
> >       return;
> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-
> > core.c
> > index fbbfc0f60829..5af93b9b1fb5 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -283,9 +283,9 @@ static void hid_irq_in(struct urb *urb)
> >                       break;
> >               usbhid_mark_busy(usbhid);
> >               if (!test_bit(HID_RESUME_RUNNING, &usbhid->iofl)) {
> > -                     hid_input_report(urb->context,
> > HID_INPUT_REPORT,
> > -                                      urb->transfer_buffer,
> > -                                      urb->actual_length, 1);
> > +                     hid_safe_input_report(urb->context,
> > HID_INPUT_REPORT,
> > +                                           urb->transfer_buffer,
> > urb->transfer_buffer_length,
> > +                                           urb->actual_length,
> > 1);
> >                       /*
> >                        * autosuspend refused while keys are
> > pressed
> >                        * because most keyboards don't wake up when
> > @@ -482,9 +482,10 @@ static void hid_ctrl(struct urb *urb)
> >       switch (status) {
> >       case 0:                 /* success */
> >               if (usbhid->ctrl[usbhid->ctrltail].dir =3D=3D
> > USB_DIR_IN)
> > -                     hid_input_report(urb->context,
> > +                     hid_safe_input_report(urb->context,
> >                               usbhid->ctrl[usbhid-
> > >ctrltail].report->type,
> > -                             urb->transfer_buffer, urb-
> > >actual_length, 0);
> > +                             urb->transfer_buffer, urb-
> > >transfer_buffer_length,
> > +                             urb->actual_length, 0);
> >               break;
> >       case -ESHUTDOWN:        /* unplug */
> >               unplug =3D 1;
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index ac432a2ef415..bfb9859f391e 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -1030,6 +1030,8 @@ struct hid_field *hid_find_field(struct
> > hid_device *hdev, unsigned int report_ty
> >  int hid_set_field(struct hid_field *, unsigned, __s32);
> >  int hid_input_report(struct hid_device *hid, enum hid_report_type
> > type, u8 *data, u32 size,
> >                    int interrupt);
> > +int hid_safe_input_report(struct hid_device *hid, enum
> > hid_report_type type, u8 *data,
> > +                       size_t bufsize, u32 size, int interrupt);
> >  struct hid_field *hidinput_get_led_field(struct hid_device *hid);
> >  unsigned int hidinput_count_leds(struct hid_device *hid);
> >  __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16
> > code);
>

