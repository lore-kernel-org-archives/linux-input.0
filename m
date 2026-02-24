Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6169347BC9
	for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973086; cv=pass; b=WJcym2cHXAqkgx7QJi1o+NL3MTuivDHq5I1cAHH7p3oN3oMP08TwXJfE1cbdFVP0j4seSMD3cGGaSIV5dN4S8WqFGfs6zsImq3aFDxAJ2VeFWWy9EIS+QOc6z78uTx2rblYIPl18vo+VdTScEX+0heczWDBLf7qSbNaiy+iam54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973086; c=relaxed/simple;
	bh=BK1KasERRSCZAuPPvh8Axu+JC9VYA9Qk8vQNoZETO00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwCBG4/UHzoxXxeunhbMPvZMoOJ3lvXG6hROuJxWiTZKzKG2WBQzZ3c3JCYSJ/MR89Pb/Y/oh74NvIhEnZKxh4Q4QWOAPTx6nuK0g0q7oo3HmgiCuT4zJ6vsaJy9kdp3vXLXBTU/c3da5TbCdmQlMKdIbI0QCC2ImCGQ0SpZpBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HfSIpC8C; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfSIpC8C"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e6b7b11ebso6880913e87.3
        for <linux-input@vger.kernel.org>; Tue, 24 Feb 2026 14:44:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771973083; cv=none;
        d=google.com; s=arc-20240605;
        b=PVgqjUtOn9u+k1BlULkR5798/ImsieN2bCkc2PVLjCFRNazxmxQ0SEW3IVgUnCCc4R
         I2TsSzngvG5ZRKg19P5kFULBZKpU4aYXwtGgBy0hEiSYLAax+O/F0fJUQyxW5dikgS4S
         ZLAJk0KpFy7tIncAeqOYVoRGycq/TtxbMOLvAW3hMiMI5xLsGxzsMJs7TLFAHyUS6r0n
         k6GVWxOjQg3kGlFRYd1XLsRqaSi5hOiQ2+VmtMh5KEiZBkwPTZseBIBuBa0u/+HUyDRD
         agEZ+3YOkInaGxUo3VOWFswjoebnOkxmlbJfmOo+ZWTaH96RAT/6NDEbdjgRmT1pkYeY
         WsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MvH1KXw6rXhNi0FruKZIabYXh1cfxCuvbUHaZHtnwKw=;
        fh=8GmVmXnaDPK9dTMBAxpw3Jmfkyd+KXfb+lzuwU9IRW4=;
        b=jzOetmaewVEWoR2pV6nsKx9xWzHgrvinjF9HwB7+KGdTZDsaDp0xxKUzvXiZ4tTsr4
         jugxauNA4uzuaIHwN4oFEL4kGcZXTOF4R0wX3SdkshMbAawtOXJ7PB/zfqFByP51jNnf
         Eksi/dLFHmeLvWwDyxEyV1j9wI9YeHHheCyfCpN1AWNnFA4vggYu7ICHWs8uTYt9s5v7
         JeazNir5UzWGFqigCCWeNHR5EFdimSEqf0vG3CchBktiBd2atY6Ec/gu4uiqE9QntkBw
         RikxHHCDLDVS+pU9t1frvt6tUVX4jJTobUOUu97tAUOHqBl7KgB5eC5BJXaLL+Q5ZAAv
         hd1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771973083; x=1772577883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvH1KXw6rXhNi0FruKZIabYXh1cfxCuvbUHaZHtnwKw=;
        b=HfSIpC8Cv/eDPqrHuHWyQmLnH90VJAXgLS/7iEbX3eGbIg4oUnaeW93X7GAWqRS27X
         bNpz82K1evQi4FqUVZoRttr4rp5V1CrTBY+/z2lYXEQ6k3WeK/xKJNgpsdHtNUNhAADG
         w0OYl2gNHEjWG5EIF2tlKATbeOIk8O4HEg/O8kwrVfl5Gp22KiTuxDIQBQz6EzvscEte
         Z+lNJnZeMtcYQbOhA7dNu+7wGkWSIxCNmEA5u4tuMWg8n7Y+UGK2dbhusCtD4UVckOao
         i4zdwMlCwf8mUGvrd9LCxWoiEnva/viICCLG/C+tRKJEVHfnLCAh7c7kxQbxL4w2nvKZ
         WbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973083; x=1772577883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvH1KXw6rXhNi0FruKZIabYXh1cfxCuvbUHaZHtnwKw=;
        b=Ocq9YRonIvo5WnySD67M6voL5rcjOO0oR9A5VMgHpSdffSiGnOs5PQkxHq9em85X1Q
         MDSFUMfwTIesyW0b74E3rubJbnmbA+KicvEiXatpxEnuy366QMZtK8NiHxU5WvzdVMDj
         Z72GMCo23cv76e8dyVAbzpWJ+XKpSRPSxLFiF6tbM/30DS789S83Du5JMCrKCZQn3inR
         Na0NMAnp16w5XCEZmSZzCAU0br37KN4h4XRXETZipNHtYHNngLjl3xSIl1D4b4xyQ13z
         +nQzaivLTnsL3fFS6i0EDn+6o6oGGMXRlNfJ8RgwHkGCp4FKnng93jHM6h66Nj6S6BnI
         1z4A==
X-Forwarded-Encrypted: i=1; AJvYcCUbVHOPTMLGarniC55voWtiFc6e6H60m2PgQTqpn13jGBXBfD0ToKXV5xmU8xJLV30R9f/g7UIXB+LBpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyE53BCJgDTS9K8aZY2hPMAXUQZ++3Pd65Arv/gqoJt8IBIWqK5
	xuH+FdcM7JY5v0vxlC5wlZM2hHVuo3AsM0KL5Edec+hIo895yEPGZWbfA3j3u8/Oh+uIoRpnU/s
	wRoGDl31lshS/L5aIENX01tNlpR3CLH0iYQUw7DDa
X-Gm-Gg: ATEYQzxpruSSN+PyhICmDB8fccZcek30e2SksRZvVnlPK8Hic3R9kYOMuDiy2+n45AC
	YGroH1366D99Hx0SnEHw8XC6ZOacz9mO43d/d4tMSQcb9CPM/26VDyv4cyDBd78KRHiXQKlg7Tz
	YVkuR23d2LWs0dMSXgYPDLg1QJKfApIntzA5/969ofJzGkku5HgUYV7wgafl0iPnEUN4hHl06xP
	ZlmkYMovCGRhIr+Mb8BVx9BAEQMN+OTg3IKxzOf1ZX+vqeVBao57P5PSuOhiA/7B0m7s1fPbYkP
	rkMClOzFIUmUtAAbHAsBxBNpOduTqMV2QvPxZZ/fDZTEV2sq
X-Received: by 2002:a05:6512:6488:b0:59e:171d:a68d with SMTP id
 2adb3069b0e04-5a1026e0333mr53923e87.27.1771973082759; Tue, 24 Feb 2026
 14:44:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111234519.369652-1-svv@google.com> <fcaa494a-43ba-410e-ac2b-162f5b4814bc@roeck-us.net>
In-Reply-To: <fcaa494a-43ba-410e-ac2b-162f5b4814bc@roeck-us.net>
From: Siarhei Vishniakou <svv@google.com>
Date: Tue, 24 Feb 2026 14:44:25 -0800
X-Gm-Features: AaiRm50fex57f8iRdePaoKsP5QitLbLcxbXcEGrmSGQo9Feh7yZfo4VRkn9judU
Message-ID: <CAKF84v0eVCSM7L-EvtmoquN87sSS0GA1yX-ewGyzr-hqO7tAGA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: playstation: Center initial joystick axes to
 prevent spurious events
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Roderick Colenbrander <roderick.colenbrander@sony.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 24 =D1=84=D0=B5=D0=B2=D1=80. 2026=E2=80=AF=D0=B3. =D0=B2 13:1=
0, Guenter Roeck <linux@roeck-us.net>:
>
> On Tue, Nov 11, 2025 at 03:45:19PM -0800, Siarhei Vishniakou wrote:
> > When a new PlayStation gamepad (DualShock 4 or DualSense) is initialize=
d,
> > the input subsystem sets the default value for its absolute axes (e.g.,
> > ABS_X, ABS_Y) to 0.
> >
> > However, the hardware's actual neutral/resting state for these joystick=
s
> > is 128 (0x80). This creates a mismatch.
> >
> > When the first HID report arrives from the device, the driver sees the
> > resting value of 128. The kernel compares this to its initial state of =
0
> > and incorrectly interprets this as a delta (0 -> 128). Consequently, it
> > generates EV_ABS events for this initial, non-existent movement.
> >
> > This behavior can fail userspace 'sanity check' tests (e.g., in
> > Android CTS) that correctly assert no motion events should be generated
> > from a device that is already at rest.
> >
> > This patch fixes the issue by explicitly setting the initial value of t=
he
> > main joystick axes (e.g., ABS_X, ABS_Y, ABS_RX, ABS_RY) to 128 (0x80)
> > in the common ps_gamepad_create() function.
> >
> > This aligns the kernel's initial state with the hardware's expected
> > neutral state, ensuring that the first report (at 128) produces no
> > delta and thus, no spurious event.
> >
> > Signed-off-by: Siarhei Vishniakou <svv@google.com>
> > Reviewed-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> >  drivers/hid/hid-playstation.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstatio=
n.c
> > index 1468fb11e39d..a145b5ea4405 100644
> > --- a/drivers/hid/hid-playstation.c
> > +++ b/drivers/hid/hid-playstation.c
> > @@ -718,11 +718,16 @@ static struct input_dev *ps_gamepad_create(struct=
 hid_device *hdev,
> >       if (IS_ERR(gamepad))
> >               return ERR_CAST(gamepad);
> >
> > +     /* Set initial resting state for joysticks to 128 (center) */
> >       input_set_abs_params(gamepad, ABS_X, 0, 255, 0, 0);
> > +     gamepad->absinfo[ABS_X].value =3D 128;
>
> input_set_abs_params() can fail to allocate absinfo. If that happens,
> this will crash. AI suggests setting the value with input_abs_set_val()
> to ensure that the value is checked before dereferencing.
>
> Guenter
>
> >       input_set_abs_params(gamepad, ABS_Y, 0, 255, 0, 0);
> > +     gamepad->absinfo[ABS_Y].value =3D 128;
> >       input_set_abs_params(gamepad, ABS_Z, 0, 255, 0, 0);
> >       input_set_abs_params(gamepad, ABS_RX, 0, 255, 0, 0);
> > +     gamepad->absinfo[ABS_RX].value =3D 128;
> >       input_set_abs_params(gamepad, ABS_RY, 0, 255, 0, 0);
> > +     gamepad->absinfo[ABS_RY].value =3D 128;
> >       input_set_abs_params(gamepad, ABS_RZ, 0, 255, 0, 0);
> >
> >       input_set_abs_params(gamepad, ABS_HAT0X, -1, 1, 0, 0);
> > --
> > 2.51.2.1041.gc1ab5b90ca-goo

The function `input_set_abs_params` is ill-formed. If this call can
fail, then it should return some kind of error result instead of void.
In addition, the function name doesn't suggest that it's going to be
doing any allocations.
So the (short-term) fix should be something like this:

/* Set initial resting state for joysticks to 128 (center) */
input_set_abs_params(gamepad, ABS_X, 0, 255, 0, 0);
+   if (gamepad->absinfo =3D=3D NULL) {
+       // input_set_abs_params allocates "absinfo" struct, which could fai=
l.
+       return ERR_CAST(gamepad);
+   }

A better long-term option would be to change the signature of
input_set_abs_params to return a bool, or to add an explicit
allocation step (looking at code search, there aren't too many places
using this API today, but this might break 3-rd party stuff).

Curious to hear maintainers' opinions on this.
