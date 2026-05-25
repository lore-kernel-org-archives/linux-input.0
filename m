Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392F33ADAF
	for <linux-input@vger.kernel.org>; Mon, 25 May 2026 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733773; cv=none; b=im8oaCLCEnmtlh0Ot2Pa0Yn3y8e6KH81osOdsHiB/DPyz4YNbtsQwERQ920UHAt4LVwJ7QcuRIXBDMFWmNoDqSpV8XvqbmdzGatdyFZeZhf2CtU8+uoAQLzrwdKFd2rK7kyrr2joCiTHiqfwIoo8igCEL41Q80SbqtkYYzOVwU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733773; c=relaxed/simple;
	bh=y0uyQCEAM9V0NPk0kt6vbk5LGCMoiCyFoi4mUCkwdRw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmj2MUhsFmarb0cDPx4H3luX6G5HL0LhfyIpFum31ejqBSnW9dVKf/fHo4Fg/Xy2WC/6m/hyKalcD5qRTumY1QiCHQ9xOSP3RFpu8zIvthgYSBw5EVJ7fcPJiXKWu4aW1rZ26JlHcm2Pauc6nuY1OB1Amd1fa0AH3BL9IrdqcJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=saurla.com; spf=pass smtp.mailfrom=saurla.com; dkim=pass (2048-bit key) header.d=saurla.com header.i=@saurla.com header.b=kEo+qCjd; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=saurla.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=saurla.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=saurla.com header.i=@saurla.com header.b="kEo+qCjd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saurla.com;
	s=protonmail; t=1779733761; x=1779992961;
	bh=3wlGHaJL+WtUODhc4EGv3mI8bJluO2hh4xX6ySWx0pw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kEo+qCjdnf2iSJi8OJvG4JjaN/2uyUSJUwy+Pc6xNz+alP79VhKI5Wvb1D1RIzLcp
	 xXYETNRwVU87rVVzV42Woo+OvoOcB2U+L7NpTOdUkDRVBKsCfsqpWHCuh1lpJvGrNR
	 StAJ9nWvLFQkVDbdUVGCv4JjWxNyxpKoroj/eE2z5IGP7osOfguWKWa9Ji6GvWsegR
	 9hUaIt+iQX/QKHcR0VCIHbqFBv5DaYaws87mQs5MSDv4OyAzIm5yofXZv9zmqUhnrN
	 6cIZXxdV0QoUxJpwr8b6vVworlh3BJidPQqfXtbVjkjaoc2U06C9Ly/URGyx87c9ej
	 VgfrITHiOZwLQ==
Date: Mon, 25 May 2026 18:29:15 +0000
To: sashiko-reviews@lists.linux.dev
From: Lauri Saurus <saurla@saurla.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: sync wheel multiplier on wheel mode changes
Message-ID: <2soHS09EjxVmxoRVKFjk3JBN0u9OZD6kpOQvO2D16jhPHL79xzUNJR-BMLlBTIg2KE4EDSpPJUGLO6e1Cvivzq-mEJTFjZAzRmac-kLaQAY=@saurla.com>
In-Reply-To: <20260518201000.BBD71C2BCB7@smtp.kernel.org>
References: <20260518192649.245691-1-saurla@saurla.com> <20260518201000.BBD71C2BCB7@smtp.kernel.org>
Feedback-ID: 198286868:user:proton
X-Pm-Message-ID: c86d264a5324a657c7f4efc03cba756abbcbbb0a
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> > +static int hidpp20_hires_wheel_raw_event(struct hidpp_device *hidpp,
> > +=09=09=09=09=09=09u8 *data, int size)
> > +{
> > +=09if (hidpp->hires_wheel_feature_index =3D=3D 0xff)
> > +=09=09return 0;
> > +
> > +=09if (size < 5)
> > +=09=09return 0;
> > +
> > +=09if (data[0] !=3D REPORT_ID_HIDPP_LONG ||
> > +=09    data[2] !=3D hidpp->hires_wheel_feature_index)
> > +=09=09return 0;
>
> Does this code need to handle VERY_LONG reports as well?
>
> Userspace tools or newer devices might transmit FAP commands using
> REPORT_ID_HIDPP_VERY_LONG (0x12). If the request is a VERY_LONG report, t=
he
> response will also be VERY_LONG, and this check would drop it, failing to
> update the multiplier.

I agree, it could be possible some hosts could send the command as VERY_LON=
G report for newer devices which support that. I will change this to suppor=
t VERY_LONG reports also.

>
> > +
> > +=09if ((data[3] & 0xf0) =3D=3D CMD_HIRES_WHEEL_SET_WHEEL_MODE) {
> > +=09=09u8 mode =3D data[4];
> > +=09=09bool hires =3D (mode & 0x02) !=3D 0;
>
> Does the HID++ 2.0 protocol guarantee that SET command responses will ech=
o
> the requested mode in the payload?
>
> In the FAP protocol, responses to SET commands often return an empty
> (zero-filled) payload. If the device returns a zero payload, data[4] woul=
d
> be 0x00. The code would then evaluate hires =3D false and forcefully set =
the
> multiplier to 1, even if high-resolution mode was successfully requested.

As per the "Protocol HID++2.0 essential features" section in https://lekens=
teyn.nl/files/logitech/logitech_hidpp_2.0_specification_draft_2012-06-04.pd=
f:
"
All functions must respect the following rule:
  All parameters in a request must always be repeated in the response:
    Any parameter that is fully supported must be repeated "as is".
    Any parameter that is only "partially supported", must be returned as s=
upported.

The following examples should help to better understand these requirement:
  A read command where an address (i.e., memory address, register address, =
etc.) is given as parameter must return the address and the data in the res=
ponse (and not just the address).
  A write command which sets a collection of bits or bit fields, should ret=
urn the same value where all unsupported bits and bit fields have been mask=
ed to their default values (usually 0).
  A command such as open-lock, erase-memory, etc. should return its paramet=
ers unchanged.

Note that there is no requirement to implement partial support. Each featur=
e designer is free to decide if "partially correct" parameters
should return and error or be "partially supported." However, if partial su=
pport is implemented, then the parameters must be returned
as supported.
"

Based on the aforementioned specification, all parameters must be echoed in=
 the response. If the SetWheelMode would not support setting hires paramete=
r (partial support), then hires parameter would be returned as default valu=
e 0 (low res) in the response. In that case, it is correct to set the multi=
plier to 1, since setting hires was not supported.

Unless there are verified cases of HID++ capable mouses behaving as describ=
ed in the review comment, or knowledge of newer version of the specificatio=
n to have changed aforementioned rule, I would assume all devices to work a=
ccording to the specification.

>
> > +=09=09int new_multiplier =3D (hires && hidpp->hires_wheel_multiplier >=
 0)
> > +=09=09=09? hidpp->hires_wheel_multiplier : 1;
> > +=09=09hidpp->vertical_wheel_counter.wheel_multiplier =3D new_multiplie=
r;
>
> Is there a potential data race on wheel_multiplier and
> hires_wheel_multiplier here?
>
> Looking at hi_res_scroll_enable(), it writes to these variables from
> process context via the workqueue. Concurrently, this event handler reads
> and writes to them from the HID raw event delivery path in interrupt cont=
ext.
> There does not appear to be any synchronization protecting these shared
> variables across contexts.
>
> > +=09=09return 1;
> > +=09}
> > +
> > +=09return 0;
> > +}
>

I agree that in theory there is a possible race condition. However, wheel_m=
ultiplier was already written to from hi_res_scroll_enable, and read from t=
he HID event handler before this patch. Not sure if this patch should addre=
ss this issue or not.
