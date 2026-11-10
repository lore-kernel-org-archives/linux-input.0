Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794337070;
	b=UBNlm6rdLyHGSJ9ajvcLJKYlTgFj/rqrJY7W+JSL75eXSi3OQHxU00z9dGcWqKQxUafp
	 Z0QXyEE/LJHi9MQG2SsKMR377wTFn84hmU6ey3Z6rCL9EWAW05UI+VFZ3JQLgLAJr+Jvn
	 mMCn0yWutgKHqwg3pSqAmaqei7yviz8ydayJjiPfezGsmSrEjr50TCTu3FOz9wDYoKrxY
	 lfQfLi+Y8VURwVY+KFyI9HErU8xnoFKzoA9Gpfz1NRv6hKyM8/cNCHjN/p4mmxBPigoz6
	 1PuX7Nht+Cbt8gGaIlWp4rEbAvQWnpPuLTHd68J1CMqLXeoJ4ieOjQKxYRnjVzkvFgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jZ2q7zCDeh9+qJcv+PdbfEkMzzuX6IJChiSNXNctPLA=;
	b=A9tYe9o+z+sGOykaby5ErjQl7d/lU5pYhvW055sX1Dn52eBlX63jBRTmkbAC+1hRxVHf
	 8/9u+n2oCJiFkfO0RUFrV/jWZvnGNw0vUy2Pss9MfeuHMPxVjUxH13dfXHUka6+ArIWQx
	 zvJzWjxzRrcO2v+eDP9Ngb+sQk1GjcBXCiO5tasEMn5bL0RIkH3eurBO1kYAldVUIlBdF
	 6AEjmqlIhHyeVxcl6qAE0SjAPKkm5C8JB0mJ22aoeC5mkqUMuX29SskbE0xV9rhw6itMf
	 L7OohrVW5CoXZ48a9XKwD38zIn/0QqUzKgi+aIOhc36dX7QyMgwKKj3mUFJaFMfH9Jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iQtu1cWh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676760A2606
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 18:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1676760A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iQtu1cWh
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c14f7768acso1794654e87.3
        for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 10:57:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794337068; cv=none;
        d=google.com; s=arc-20260327;
        b=hmh0LtIKQ8eYVp3XXPSmlB2NGJ/ADELv927Vs1E+OlXkpscQ+c6xjn9K5oHzTHPCcr
         XzlmnMleM3Dv3XapjnNCzV1sUUx7SDjXk580a7QluVkeQWeHrTbyIeDmHBVVf2DuCMid
         LxDbzfuXszabwo7VJOB5r3cZ22kwPRaQoEahM4PH1E0deYnD2hct082glYGhV/bvU5Ns
         Cohn//TEkAQEfNdSf6Sv4hyHYWkmoJjQjtfQKtnCNRF0t1p8aHm4Z6cyGeW3MSJFp+mw
         x3lttwecWxosadJoMfOwcRqU+4sARwluUP+pyMpYHQF4mr5mDeOMqQ9johgEHC6PBWwa
         NqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jZ2q7zCDeh9+qJcv+PdbfEkMzzuX6IJChiSNXNctPLA=;
        fh=/Jt1ImzeOMu5yZW4PYLAcWnunmvUN54JsWS+s/qFWa0=;
        b=kyh11n/lFRtSNe9e6sliAsgrMQx5fKDdRPyT4LMc7HBU8V/Xom7JG42mhv7Ax2lDGz
         QbuQ6Q7pabZDF/8mpQEsSDixc7psqySOOd7G9wGDbEjUZcN5OvSS1t6N+jUiJ/87YHbm
         0ASoqx/o8ya8hLGU+zgCh2Nnkrayn1QXscoGhHVmI/fgjuAyaDPpL6EMNWOzMAEgN/f+
         MvtSYc/SkD4zWnjkc+9JZS0tAH3ugRi7879UClV22NJcwgpVhF8+Tb5E/2zmMW72bx+9
         F88BCPLWZ4BkZN6p37BIy6lwTbIGabqPD9e2U4uxPKmHdSEyVXPVYPdrNf9uBL8O1ERC
         KkNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794337068; x=1794941868; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jZ2q7zCDeh9+qJcv+PdbfEkMzzuX6IJChiSNXNctPLA=;
        b=iQtu1cWhnOLMlZ4E5YGX7Tg7W/m3OqQiapHg7wYxHLF4F3LmarjWo6O16g6NCVP5/I
         h6lLQXA8mKzDp5HNFA9ezPw+Tk1ftzV65/nweBFK3hRTbq033BeSICNH87SZNvN82II0
         0EeyQkE0DJCwIV0l+fpETv1vCCLzlYomtS/Yu5c6H3KuAUuoIqraEm5UbUjQ+MV51/ap
         jVFX2bWotbz5ty/PLs9cHOlrEqSpBmipZNsED4BQ1rTcPZ5pkNwj+Cl3nmOmqax7QAkn
         Sz1ONCybN7zHEfCjN3TqINbLN0oKsSnEwQCRRXCwiULshPoqjwdcVXaT+s9TW3i96tUN
         U5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794337068; x=1794941868;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZ2q7zCDeh9+qJcv+PdbfEkMzzuX6IJChiSNXNctPLA=;
        b=vlN8fF1gE78YJuking+K5UW71vrX48eV/6kftKqqbEDA7GSA8G8gbKXnX7UelEmumN
         yUgD0ZuAOHwDq/vNlzBNp/mtp3uCOO7IJ+jV63cCOpNrDYgy8Ajl0CUv3u8EweoVvRBM
         6FCYTOfMLHEvdKw0J3qMNzaNmCw8B4dVgRJMc4XBoxg28Bk6yoidUZ3Fi7XzbkgDUZ1u
         fnPSr/lhU2BR+TIEbUN8UL16EMuKXNrduDfYhbF9N4ZtdHQi21yg/UEaSiq47ebvGqKJ
         8VwFP/6qWtEh6ueZfVT9y4XLUkmizAfqdHob0d16H5SxJD9+J1d9NddgXRhK0f21A98T
         oQ0Q==
X-Forwarded-Encrypted: i=1; AL+hErG96RjjyPdGvV3YkQ2FfM7DntB+MFKvisi8S1OqeyF31Fdzg1ocH2+0d80m2T2/kDHXL2IXKXxNAMiqQQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+8kPBqFzgZvWHpjwZuIZkVmX/qcYGAgaT3QaZ04RNrUTzdcv+P
	ObPDKlqsXEh97hf4OVTIfueCj3eZLBle2uwtaV7EYN0o30bX3cav8abeK9EbFkWs2oXISdIwF1B
	4QOcaf6uA2Ds7ZIjOoV9hOG3qF+YUYnMMtQa37J+n
X-Gm-Gg: AYBFou1mNbTy5kMWyByIehFUIf7I2T0NunB51jiBbLBib0b5Mq29QCej9C6dOobLus/
	vaQOU1H5hgHBaZvcXuGzsgVj2qx0OG4vgMsqCNhzp9vIyx53KCBpd6q1W9JYB/xj9bumV2O5oLL
	k7Ww+NFN0dUvDgHpL6bq5uzUP4P/VyLcQDhlKflc7UtqZOv65aQiPdM854akh5RPSGIWIZUfiz+
	AeWRiRJsCJHsnoQI6uSrIg78JTZ0Y2Q0eVT7g3dTK9BB922MjchO6bjC8x1Vq3vZzCnW4vDwKhY
	r3Dgifa1vaQPjoRP+IUZ+vG5lnqAflQWQZ8B6UoZrghCswcJUgoBKT7MhiswI+4MG78rNbaVi+B
	EHHAjqWhHHJmFL42WJy78royGiCnq+OibWXBb+aqU1dZvlHVT0mMvNtSIYIZVvPJgdR0=
X-Received: by 2002:a05:6512:2381:b0:5c0:a80:2837 with SMTP id
 2adb3069b0e04-5c156ea57c8mr1243048e87.45.1794337067799; Tue, 10 Nov 2026
 10:57:47 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110020632.4003499-1-svv@google.com> <avKAaJxlxE8gOYVV@google.com>
In-Reply-To: <avKAaJxlxE8gOYVV@google.com>
From: Siarhei Vishniakou <svv@google.com>
Date: Tue, 10 Nov 2026 10:57:31 -0800
X-Gm-Features: AclHuK_Y7tuYVtqC14Xyd8VRbI_P-1UHcUvd0-bsysWD1j_K221SrIMS6_jP6lg
Message-ID: <CAKF84v00nJ_+2Tf8m66LhGEKvqnHb26YD6p+FRUXK5juYEPQZA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Input: add ABS_TWIST and support it in HID and Wacom
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jonathan Corbet <corbet@lwn.net>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 9 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 18:25=
, Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>
> Hi Siarhei,
>
> On Mon, Nov 09, 2026 at 06:06:29PM -0800, Siarhei Vishniakou wrote:
> > Some styli can report rotation along their long ("barrel") axis,
> > commonly referred to as "twist". While the HID specification defines
> > this usage as HID_DG_TWIST (0x000d0041) in the Digitizers page, there i=
s
> > currently no corresponding evdev axis code to expose it to userspace.
> >
> > Because evdev has no MSC_SCAN equivalent for axes, drivers and OEMs
> > currently work around this by mapping stylus twist onto unrelated axes
> > such as ABS_Z or ABS_RZ. As a result, userspace input stacks must
> > maintain device-specific workarounds to know which axis carries twist.
>
> How is it different from orientation?
>
> Thanks.
>
> --
> Dmitry

ABS_MT_ORIENTATION describes the 2D angle of the contact ellipse (or
tool projection) on the surface of the touchscreen. Looking strictly at tha=
t
initial sentence in multi-touch-protocol.rst, it sounds promising:

> ABS_MT_ORIENTATION ... The value should describe a signed quarter of a
> revolution clockwise around the touch center.

However, the rest of the section clarifies that this is the alignment of
the contact ellipse with the X/Y axes, not the "twist" of the finger
itself. In fact, the docs note that orientation can be omitted if the
contact area is circular - even though a circular finger or stylus tip
could still spin in place, and that rotation would not be conveyed.

For a stylus, orientation is equivalent to the tilt
projected onto the touchscreen plane (which single-tool stylus drivers alre=
ady
capture via ABS_TILT_X / ABS_TILT_Y).
By contrast, the proposed ABS_TWIST can be thought of as keeping the
stylus at a fixed position and tilt angle, and using two fingers to roll
it in place like a pencil.

This also matches the HID Digitizers specification, which defines
Azimuth (0x3f, rotation of the tool projection around the surface Z
axis) separately from Twist (0x41, clockwise rotation of the tool around
its own major axis), and hid-multitouch already maps HID_DG_AZIMUTH to
ABS_MT_ORIENTATION. Since styli can report tilt/azimuth and twist at the
same time (and single-tool pen devices don't use ABS_MT_* events), twist
needs a dedicated axis.
