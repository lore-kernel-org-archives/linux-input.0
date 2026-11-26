Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702170;
	b=Fk3gqHyF6NJqQ9Oi5pTmLyeQMSidLA+YcIln2vqVjxypzxc8yY89P9vhIo8DciLirJbm
	 jDVCAR/LPx9QMn0/XhlfRd2TS2z/t5DhHx03A0GVIs13sl9zanmi8vcdMtkF/LvqxawyM
	 r0PJ0QhgqHVCxd60sYPHLe8cx8ulgiqgvFMfPMMAKZbeHO/XFJ9JRv0o7itAY3HfbM3uE
	 dftPfj7Mbt2/c9a9pXs+3ZLMDqnuOlf5mB0olE61jiR8BJGMkPSBGTrsqMKLvH7e0mbS9
	 kfbLRSv4vwAPP8+lw54ELOm51HWG09LG2Lm3fKY08UCjrrgTyfkDCe4yiVNHIHv/Ktw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702170;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7838JVCVIFZHpChcKzHUN7ifBcuei9XazkkD9p8QNFU=;
	b=hVbqfymdMqPgazhkiKWhbeRruuKGocdqZIMrAhQXaiAtdHCFbCc5Owogb6d1PFrg0tf0
	 x1lsXwvbNTIWPKdWMkqvcpt90KCcQuUm1ImtK4UR84S9deolbIlP+8NOkFypUCh9wIqw4
	 RPkOfT+m7P2iXnT6ujlgDuKtq5chPVbKsOX6ez0laHt+hl8LhpP++y1PeuHghdDNHi26a
	 SfgbedZMNIcDi4t4tpGg97ujyaIxswfNohMDdKmce/LnPDdShGNP2i0Rd1RHwJ88wDU7x
	 GEBrWuMVfZ6FftwIiqt7dLvwYI3QhMnzuwb77rjDfQBIz6+RA5t9AAYuTr9bmHYL5Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=d17URzsq;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B55606A321
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 14:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5B55606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=d17URzsq
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cde827b7b95so2236437a12.0
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 06:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795702169; x=1796306969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7838JVCVIFZHpChcKzHUN7ifBcuei9XazkkD9p8QNFU=;
        b=d17URzsqjWioo2PfC+RopqBDvb9xyjHmxFcKjHWIro7dm6NbcxMmmXlubr2cgTEkXB
         OfihcCG9CbfADY6zZIChr14Lsls1UnnntuCfozzSDdqm2xfpx3LeOonsleuI36T1kVX9
         XiI8ddfYfBl+0jEtfH4kdWeW4EFwY1b61jXbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795702169; x=1796306969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7838JVCVIFZHpChcKzHUN7ifBcuei9XazkkD9p8QNFU=;
        b=UEE+iQZLJhpOfoy5XNcspUAM3z0IphAf9uQpw5OYL/SyxwjfjwRCjrZCNz33kNnUFi
         U+TnVLppWKYRqpUAC1hyC6kHRE0TiWpHepqMJdiIY2e6QW0jeJHalxqN9IP6EMos//0c
         ol2TcnSDvwxJTLqwLcFmKDZ/gcWYeNswMKcoGChRf/8An4jn0D+DLeRJz+H7BqdO/n+9
         Fe4seDKZTRTrXJO4I8uC92+8nQ3q1GtfqrQJGzL5Ggz9lxlyjA8WFTLTXUaYaBAp0Hxp
         OiKAmn548zGd4M0VfXvoqTUxC2pfPCVug/ll7lNwvuv0dzbVZCuwWcDntxXsdx22mKXJ
         5KzQ==
X-Forwarded-Encrypted: i=1; AL+hErH5MVr9VTUHjVPAeqonHIJwTMV8v9qGnR/qnirV7uojQImdxL6hqTw/bIU+R3PwcAaUC1zqw4tS9P/FYA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9X3TuURTVDeab8WzYOUIG1dGt/ojNHS9lDorLrXmUzFse8Ie1g
	frfJc3NkvSkL76m4Yb//aSiuDaPpNAhK/jpiv/MQegrAKb2k56VV/Jr1XlUFITyM0iCYZrGYDCA
	64oILIKFx
X-Gm-Gg: AZFdTZfd+7B+BayL1USqN+019rKoaoNsUPFyyqsjdAvBPRrkA6/ELUkquVcEM8LRVKf
	K0tSkjYl8mQtH6XfJEFsDVAiFpojfwEraLw0+OvdU8v/QJ8Hxd0aw8fuIL/hzqD0a94m6wgfwPQ
	LWT0gAnURrLS4/eNs0csQmIBmPYHciGLv6UmtmlXE+4d7Cbi5ZxhQFbkEZDBusiiNpklYZWSL4t
	vwHofvqLN4XHaU/BEcHx00maPr4nfEFRY5r+uqUSAfHhsDZ3w10xjsDDk33aPN/125Xjtiu6GWX
	hHhjQrqP+8NvwnEXCm51rFTUu7HlNvH89eYW9/zTQjiRAOh4TXBUrkNn6f8jTx3ADpxsyXU/eCc
	fr+9X2rK8Mmrq9oHVkMS2ltBU/MmmKR7fkkiLwOGvCIi1kcZT4l8NfNnr93G/JsZsF2sMdJ87W3
	jxC4rN8ETaaYQyLHykxVzWziIKoYaM4dVdkW4YRlv2TwqgmrQHfm2+7k+BvOuMEwgo1txg4no7d
	P2h9MNgWRE/IhGzEyzBAUrTKIr2E7XRMLx9FyVXpzgiVejna0DnvCUsxSz+cC+0uRTiYk+F0Ux3
	G+Bqr19AkTuQHmwdGnwlSrsS97mqKyWcdzBpu6wIJ0LzEHDpQ79Q0+qGytND5OoXDQ==
X-Received: by 2002:a17:90b:57cc:b0:3b4:f23:43f8 with SMTP id 98e67ed59e1d1-3b41c908fa4mr18111589a91.20.1795702169174;
        Thu, 26 Nov 2026 06:09:29 -0800 (PST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com. [74.125.82.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm32800257a91.4.2026.11.26.06.09.28
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 06:09:28 -0800 (PST)
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a2761c69fbso9552283c88.0
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 06:09:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE9WOfKBitix2k0Mb3xai4Bn/m59nF1pFw4sBZbJnFJ710e8SGa9JLWrJiIEptfnSiEVprGi2/73jLs9Q==@vger.kernel.org
X-Received: by 2002:a05:701b:450d:20b0:1b2:4378:3545 with SMTP id
 a92af1059eb24-1b5568e825emr23220173c88.21.1795702166818; Thu, 26 Nov 2026
 06:09:26 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org>
 <CANiDSCs1qyOpv=W-F-94skQm4o-Aj9d0PbL7xr5qtdtLjWQ7vg@mail.gmail.com> <0fd097a2-029b-4023-bc22-d2eb587a646d@app.fastmail.com>
In-Reply-To: <0fd097a2-029b-4023-bc22-d2eb587a646d@app.fastmail.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 26 Nov 2026 15:09:10 +0100
X-Gmail-Original-Message-ID: <CANiDSCtcOa1UuCOb8wwpMdGRk_3Kb0aZtoiNfMXX2Y-0fCjorg@mail.gmail.com>
X-Gm-Features: Aa3M54rtRoX6wSK5Y9qAl8rp--BKPEAndffZ9pTASgsLVd44EKFxzDfIZ7n7-aM
Message-ID: <CANiDSCtcOa1UuCOb8wwpMdGRk_3Kb0aZtoiNfMXX2Y-0fCjorg@mail.gmail.com>
Subject: Re: [PATCH] HID: Merge duplicated documentation for Lenovo Legion
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Derek J . Clark" <derekjohn.clark@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark

Thanks for your review. Do you know if this is going to land in the tree?

Thanks!

On Mon, 2 Nov 2026 at 18:48, Mark Pearson <mpearson-lenovo@squebb.ca> wrote=
:
>
> On Mon, Nov 2, 2026, at 7:40 AM, Ricardo Ribalda wrote:
> > Friendly ping...
> >
> > On Mon, 31 Aug 2026 at 13:12, Ricardo Ribalda <ribalda@chromium.org> wr=
ote:
> >>
> >> Lenovo Legion Go and Lenovo Legion Go S share some definitions. Merge =
them in
> >> sysfs-driver-hid-lenovo-go to avoid this warning:
> >>
> >> WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfac=
e num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times:=
 ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; ./Documentatio=
n/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
> >> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfa=
ce num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2=
 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; ./Docum=
entation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
> >> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfa=
ce num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is define=
d 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; ./Do=
cumentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
> >> [WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interfa=
ce num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is =
defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645=
; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go driv=
ers")
> >> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >> ---
> >>  .../ABI/testing/sysfs-driver-hid-lenovo-go         | 11 +++----
> >>  .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 -------------=
---------
> >>  2 files changed, 6 insertions(+), 40 deletions(-)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Do=
cumentation/ABI/testing/sysfs-driver-hid-lenovo-go
> >> index c8221373ef76..f3ba3504939d 100644
> >> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> >> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
> >> @@ -364,11 +364,12 @@ Description:      This displays the available op=
tions for the mode attribute.
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
> >>  Date:          April 2026
> >>  Contact:       linux-input@vger.kernel.org
> >> -Description:   This controls the behavior of built in chord combinati=
ons.
> >> +Description:   This controls the behavior of built-in chord combinati=
ons.
>
> Nit - this minor change is not part of the patch description.
>
> >> +               For the Legion Go S, this controls the touchpad's oper=
ating mode.
> >>
> >>                 Values are windows or linux.
> >>
> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld =
devices.
> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of ha=
ndheld devices.
> >>
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
> >>  Date:          April 2026
> >> @@ -377,7 +378,7 @@ Description:        This displays the available op=
tions for the os_mode attribute.
> >>
> >>                 Values are windows or linux.
> >>
> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld =
devices.
> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of ha=
ndheld devices.
> >>
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
> >>  Date:          April 2026
> >> @@ -640,7 +641,7 @@ Description:        This controls enabling or disa=
bling the touchpad.
> >>
> >>                 Values are true, false.
> >>
> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld =
devices.
> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of ha=
ndheld devices.
> >>
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_ind=
ex
> >>  Date:          April 2026
> >> @@ -649,7 +650,7 @@ Description:        This displays the available op=
tions for the touchpad/enabled attrib
> >>
> >>                 Values are true, false.
> >>
> >> -               Applies to Lenovo Legion Go and Go 2 line of handheld =
devices.
> >> +               Applies to Lenovo Legion Go, Go 2, and Go S line of ha=
ndheld devices.
> >>
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_e=
nabled
> >>  Date:          April 2026
> >> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/=
Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> >> index 4d317074bb7e..218164cfe544 100644
> >> --- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> >> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
> >> @@ -231,41 +231,6 @@ Description:       This displays the available op=
tions for the mouse/step attribute.
> >>
> >>                 Applies to Lenovo Legion Go S line of handheld devices=
.
> >>
> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
> >> -Date:          April 2026
> >> -Contact:       linux-input@vger.kernel.org
> >> -Description:   This controls which value is used for the touchpads op=
erating mode.
> >> -
> >> -               Values are windows or linux.
> >> -
> >> -               Applies to Lenovo Legion Go S line of handheld devices=
.
> >> -
> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
> >> -Date:          April 2026
> >> -Contact:       linux-input@vger.kernel.org
> >> -Description:   This displays the available options for the os_mode at=
tribute.
> >> -
> >> -               Values are windows or linux.
> >> -
> >> -               Applies to Lenovo Legion Go S line of handheld devices=
.
> >> -
> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
> >> -Date:          April 2026
> >> -Contact:       linux-input@vger.kernel.org
> >> -Description:   This controls enabling or disabling the built-in touch=
pad.
> >> -
> >> -               Values are true or false.
> >> -
> >> -               Applies to Lenovo Legion Go S line of handheld devices=
.
> >> -
> >> -What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_ind=
ex
> >> -Date:          April 2026
> >> -Contact:       linux-input@vger.kernel.org
> >> -Description:   This displays the available options for the touchpad/e=
nabled attribute.
> >> -
> >> -               Values are true or false.
> >> -
> >> -               Applies to Lenovo Legion Go S line of handheld devices=
.
> >>
> >>  What:          /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<i=
nterface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
> >>  Date:          April 2026
> >>
> >> ---
> >> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
> >> change-id: 20260831-lenovo-go-7b4ec4bf0cd5
> >>
> >> Best regards,
> >> --
> >> Ricardo Ribalda <ribalda@chromium.org>
> >>
> >
> >
> > --
> > Ricardo Ribalda
>
> All looks good to me.
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Mark



--=20
Ricardo Ribalda
