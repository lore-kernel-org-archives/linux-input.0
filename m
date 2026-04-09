Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E7B1A6829
	for <linux-input@vger.kernel.org>; Thu,  9 Apr 2026 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759114; cv=pass; b=Zst9k/8/tmttudrDVSlkXuC5Dp3wL/2oYKAbbLnP4U8usMOt2tSSLj8O8FyTvjCaoxEAPZwP2/uZMmH26Q39HdxwcCsP0YmW9ktImEaUcbuDsfEZfFZW8Nf99F9YB7dn2uoByC116iLfB/Yf54Cp+ucb/5SzFRzpTVAMx7C6IQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759114; c=relaxed/simple;
	bh=uRIpHIXY1Jgv/tUqLrduouxc+mc9S9SHsVuyZmzj/QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbNMKsX14X3BWeYDyBvnYGJ/+v3QrgD9gOhXU04cngbUcgrM08urWeSAZ0XvKH4xs5HcsU7ZWT/Qc3AmtveWinjcKTrmhFP7gCht6ZYsXaxi7OA9Vvy90hfnzL8GyB0YtLDkdg+JO00QxtCn/NWgt+dfFYqLRq8Q2oScC5/RuGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzLxomTq; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzLxomTq"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66c05fb27e4so2199231a12.2
        for <linux-input@vger.kernel.org>; Thu, 09 Apr 2026 11:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775759111; cv=none;
        d=google.com; s=arc-20240605;
        b=RqDP0q9AiU9Ik2nTACmFyOQUdzm9NDbt23X0Eu64DS4r8CoobAMtfZBSQMNpEY5F+U
         sjFKKZYZefRjyRP0G+DRRI8aHe3e76uj+DXhJFMiurdYiDeZNfJtx5NWj+ex+u3Su/IF
         zgnvrhy2pCpZCq5gIcIoyKiU/k3zegRwYoGWQvXCjEAhA3Hpqu+6dqQapv2vAqftsGOf
         iM7otFcKdUtVScWT8S3UEtP5hOrXFtUals3Db/D+p01Blb5keDSrKx/qBNy94EdaPuZx
         oAuEa/OEYFvUIWSaouadhvMWTbwoSu/njkiHnYq2fHm91wpe5joPFkna49H4+4tWe8VW
         dHvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bxi0Dq/1cOaYc6y9Kzzau5RxO3/CNiO8acCYH60FkGo=;
        fh=R5pvR1q5z0qbUOUlECRlQ2zmZ1pBbkGwcFSYRTXjxCk=;
        b=khYsOGGlXF4WihB+pPr97YLSF8zZ6q8WAJ6gn3WCj8WN+ajsGnusl8ajiDFrFf4f8W
         dzmTtEgm5y8kmC2gu9LzQAyhyzAv06agY03HAGSGOUmh/zvoETfZcG34BeGTIv3mcM6y
         oUwaRRIfZ0Hr+JudYaR1snxIdsMgC9gqV9lmcFac2+24Dtv75MecO97Ov6f5OsWgjJn8
         rZvfRTf8hg0qE03gZcyofnKFezq2q6BK1ZHf9mwX6qlTmkdyS0BLoMjhMIAPI+p/lix3
         zYDOXYCZemqdw4d8pKjiXWL4K/Z10vt+ReIMhAT2b7WwBFYVerZgZ2oFrhFS5gOykEQb
         cr0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775759111; x=1776363911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxi0Dq/1cOaYc6y9Kzzau5RxO3/CNiO8acCYH60FkGo=;
        b=LzLxomTqu3hI303cqh2kQu4o2QnX1b75nZh+6sCJ14WZQWRlau3rNtsEsjvR8ReWl4
         P5xC3YMB1IhHq1kdyBqUhi2nCBOXRxuHWNcvMIXZyADz281HJsOEBMIAhEbVLPuXaj7J
         ndczERAsnqnzXca/SLqO1WOQjw4VQ/7YKEkd22YnM6sYbeRUXQaUnNyqN0w7Lcn2ONgO
         9Opx+SCMutnon9umjt7iexP3KFc5RVv8ATMueCPD8aQA7XrarOswzjrs1YW9Uqa7YAFb
         Pf5B0nrRwGHlRmvI0+M/4f8iueNgVYY+xRf+APnq7COAdYqymyaDyL+0WTbNtiDuuvu8
         JF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775759111; x=1776363911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bxi0Dq/1cOaYc6y9Kzzau5RxO3/CNiO8acCYH60FkGo=;
        b=Pog0UVBYjsDuJNlL48Dyp3297BpzvRDn82xjmzCfQwQOA897NdLZmuCNFG86XvIhcB
         FGpALeibNE++bhMIp0P/nk2kEFMAOF8Vs1Q5lKfLHqfptkV9Wr8BCUM0jkubDRXAwxa5
         J4XPugXeIB+DATpSq7U1/lcg/4Ha62ZCAp9S8EpILKMJU0xu7tSszMJbhsHVQopfaiZj
         pT4juWPs52Jp219stPzDrfwayVgDSqSLW21G1T7Fz1NFKMcSpIhWk42wVuytNMdNHECb
         oOud0f0dfkKHbwgUZWQszRf2JFpGFmuIHmsAYScQ6EjOh5nYfJ7rMkekEqNC1zdlU5Mj
         wSHA==
X-Forwarded-Encrypted: i=1; AJvYcCVUcnkwo/OKtb4DhxTk7As3jCrpWFdn8IzFLGTh+lPwz5IVByqmcIJJYlBO2oD3pm+ng8iit2kjhimJPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+sD1wzyZNsvpfj0ittPcZGhXKpl/+gpIax15rU2nydGepxOME
	kTl3BL48+cuj2x4lggNtyreI5d++LTqRf6ziOo/nSsp4dhMPdf+ge/MHgny2ojQXoJjwMIV+lQU
	IJ98/2jEYTrrBy3uI+sPEo68rC0GuJTM=
X-Gm-Gg: AeBDietDX5dTuivXKBuQn7XXD1P6JXtJ5Fz1iDhb1y+lszoMo1cRp/jmMjG9g4h7Ruf
	vW6CZphAjg2bq5253fU2OtHwRPTOjfsO0gwshO2KfftdUBdXn12K8kJ8fPZpzR5tIXm8OHcjfTh
	dsRVMbJcBCfISRpXUEgu1NKccc1bWADh6Gq6oBH8PrktXq2ToK3l4Eu8zpNgyDjAY+tST4Mjbpk
	q8SeyGTbg5++KXe1gyn5e3FtzeS6bXllQEgMaxQgIrRXAIkDrIXlBKrtle8ACY6Yc2zEC4l3HgA
	3Lxovd4=
X-Received: by 2002:a05:6402:358e:b0:66e:f4c0:c348 with SMTP id
 4fb4d7f45d1cf-66ef4c0c5a1mr8652002a12.7.1775759110757; Thu, 09 Apr 2026
 11:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
 <20260324201858.46591-1-sebasjosue84@gmail.com> <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet>
In-Reply-To: <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Thu, 9 Apr 2026 21:24:59 +0300
X-Gm-Features: AQROBzD5ryy57P3iGUvqLsmBCdxSK-kLXMP5Y7ZvC8lV482_vL8uUBuQIdBTpOA
Message-ID: <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
To: Jiri Kosina <jikos@kernel.org>
Cc: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 6:50=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrote=
:
>
> On Tue, 24 Mar 2026, Sebastian Josue Alba Vives wrote:
>
> > ft260_raw_event() casts the raw data buffer to a
> > ft260_i2c_input_report struct and accesses its fields without
> > validating the size parameter. Since __hid_input_report() invokes
> > the driver's raw_event callback before hid_report_raw_event()
> > performs its own report-size validation, a device sending a
> > truncated HID report can cause out-of-bounds heap reads.
> >
> > Additionally, even with a full-sized report, a corrupted
> > xfer->length field can cause memcpy to read beyond the report
> > buffer. The existing check only validates against the destination
> > buffer size, not the source data available in the report.
> >
> > Add two checks: reject reports shorter than FT260_REPORT_MAX_LENGTH,
> > and verify that xfer->length does not exceed the actual data
> > available in the report. Log warnings to aid debugging.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> > ---
> >  drivers/hid/hid-ft260.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> > index 333341e80..68008a423 100644
> > --- a/drivers/hid/hid-ft260.c
> > +++ b/drivers/hid/hid-ft260.c
> > @@ -1068,6 +1068,17 @@ static int ft260_raw_event(struct hid_device *hd=
ev, struct hid_report *report,
> >       struct ft260_device *dev =3D hid_get_drvdata(hdev);
> >       struct ft260_i2c_input_report *xfer =3D (void *)data;
> >
> > +     if (size < FT260_REPORT_MAX_LENGTH) {
> > +             hid_warn(hdev, "short report: %d\n", size);
> > +             return 0;
>
> Michael, can you please confirm whether the device can never legitimately
> send shorter than FT260_REPORT_MAX_LENGTH reports?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

Hi Jiri,

The FT260 uses different report IDs (0xD0 through 0xDE) for different paylo=
ad
lengths, with each report ID defining a different report size in the HID
descriptor. So yes, the device can legitimately send reports shorter than
FT260_REPORT_MAX_LENGTH, and a blanket size < 64 check would break valid
short transfers.

Looking at __hid_input_report(), the HID core could validate size against
hid_compute_report_size(report) before the raw_event call - essentially
moving the check that hid_report_raw_event() already does to happen earlier=
.
That would handle truncated reports generically for all HID drivers. Howeve=
r,
such a change would affect all HID drivers and require broad testing, so th=
at
is your call.

What the HID core cannot validate is driver-specific payload semantics. In
ft260, the I2C input report has a length field at byte 1 that indicates the
payload size, and the driver uses it as the memcpy length without checking
it against the actual report size or against the expected data capacity for
the specific report ID.

I will submit a per-driver fix with two checks, both essential:
First, a minimum size check before accessing any header fields. Currently,
the HID core does not validate report size before calling raw_event, so a
1-byte report would cause an OOB read just from accessing the length field
at byte 1. This check is necessary regardless of the second check.

Second, a validation of xfer->length against the expected data capacity for
the given report ID. Each I2C input report ID defines a specific data capac=
ity
(report 0xD0 holds up to 4 bytes, 0xDE up to 60 bytes). A corrupted length
field exceeding this capacity would cause an OOB read from the source buffe=
r
during memcpy, even if the report itself is full-sized. Only the driver kno=
ws
these per-report-ID limits.

I have the hardware to test this change. I will credit Sebastian with
Reported-by for identifying the issue.

Thanks,
Michael
