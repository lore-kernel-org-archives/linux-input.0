Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05CAF507
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782663831; cv=pass; b=qwwYEQc0WyU24qiznoJ9kAoK2O3K6SHtJYdeobVmvy5Y04eDwGALFlHAXyhZHkz/v8q7wVPCl/fPuzTPxXDwHPuus6Oe6+WbEp2bYS0GpsHGa3l3fuIQ6zJM1OQb+ef0A2ij4j0MWkRkcV9oBd38Oxj8Z6cZAShY5zliIZ3hEc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782663831; c=relaxed/simple;
	bh=5OLImKYP/mPH8qI5V/oFbG+GvYL5S1bGpUq89sWRLyo=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMn86bA7KK/mFMOJ5znSiBkIenBsznvZW+MrTwfGIbaXrJAHBoAJnE3jW6jtd97MHAIpPpXxc4VqXpVAMptefF94ew65qN6heetBGJJ+t8AOlNA5lXqZbjqMrqZvSoCvPYhGqz1pIdpEWrp/d8+a8x1b5OwK+z13OFqKXWfbwRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNdUWzHL; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNdUWzHL"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80bab6cf5ebso22552607b3.1
        for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 09:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782663829; cv=none;
        d=google.com; s=arc-20260327;
        b=JXcz4+0qf3Ojt3GfGcFEX6ZdqoouU7RTWdpk+8cmJODB7U/S7jm/2eI/O+8A8afRRy
         ryDe3Lk7UWFPd6NaWsYbSOx4hkvvjC4HJeTnn/nK9lL8MKdFD4H7Ovg6iFBeBxH5zsv7
         FET34p+wEv7FyXku48gEH32PHrYxnqzWRaHa0ayKumPR/e1/h1H20UK0ebkyb/HeL1WF
         Fj8XLEIOneYOe7xtsDKCdOnOpuTHNKY2WKlHmbUkHE6txlw99Ex9t4kVSZHJMo0XDi/W
         cJOAtQcE2RB2RApbZqnMVICHf7ZtPy9FiiO4ucfnNdcMOcjESiH0VD6jfvA71spy8zp6
         yuig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=5OLImKYP/mPH8qI5V/oFbG+GvYL5S1bGpUq89sWRLyo=;
        fh=Zo/V8w6H/beZM8erurRY8NR4i9IxeFhCcd4pif+9iDg=;
        b=I3c2GonM+eduXkFYGMMEQszKb7LKw9gXcjc1+flzazcTg3dxsC1ZJxiHVHizBztXGN
         VK9AFN8HP8Ahre7JHJotK44/NdeVFLq97B3baAF+ggFFqbhKwyDWlNXPzLQ3sSTfIpvh
         EADkpIMqQqBgPMtg8H+tfo4JoeXMxXWwh8z463tsxbju+diBJKpUgT6iLBKKfe3u3WNL
         8FobXfgUhhv48lnmUSRFBwxLDINSPD9nCuE8Gh3oVVkH/QZC0cVsi3WLoVOm+GEXmU6c
         NxvCUG6/8IUQvMzhubqffO5QGfwZYRI41t01DVTQIzSn/ifuadkxVJvnMoBrBDh0xjcl
         2x4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782663829; x=1783268629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OLImKYP/mPH8qI5V/oFbG+GvYL5S1bGpUq89sWRLyo=;
        b=FNdUWzHL+JaJMuq4NFFdca+2lRDsUd5oSMptFzGAD1BUSEOu9BVroXtMfz3SIQHj8G
         6NPl1X4nqio2fwqFm2mj3w+wkZsBY2dv0aZ6cWhTesxgsf242j/+lVpv8A2FZ0nPXpwt
         9aGqLT80AGAazqi7gkIUWpQwtLtLx5ZmM7wyVNbE6ZdjHVWvGsHI1lVrnvJUztdqDes3
         YCvQBk0r9DNf/3FndsRzdYrxFQOJdS2pnO1CuDVn0hTYAKWHUV6/Yr681+fT2flyzkgw
         SvWfGJS0VpGSgMfYMsEm0sh6uZOKvpLirGYITBeNBNR75m+FZ8jlip04UQrZzxB/HUW4
         YUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782663829; x=1783268629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5OLImKYP/mPH8qI5V/oFbG+GvYL5S1bGpUq89sWRLyo=;
        b=dmWQAkujqdQ0kKyjnzt+iqjQUuCBJwi8HjZF9ESuwjSswJSomJbDKMR7z40Nwb0Sc1
         pwoYwPSTmS/oMcDraHdo237fxj/AeRz/3cNTVT6OJTW9HsAxVikjYxO5Do7jFcXv0ya0
         kLVkJAzOxejtNUueiQw+Fo+hQ8cI+Ubcoa2Dj2Nnnv6+4KayjnVukO+rwOC9wQqC84ow
         L8ICKeExL9sWuMVA4TjjByia+pyA52nA7j9k/vPIJ/lT/g3O8i3cuYlYMiQI+4RJXZsr
         MVye72wCCSZwp5hsFvop9Ue8YKt2V06UzHpb2xWxGH89mBzqMQWxh8MSMylp9NEqneXr
         rJWw==
X-Gm-Message-State: AOJu0YzRUAuKQHvXVdEZJNnzSbm9wTWqpY99fHRsdzaJKQXtqnDx80DP
	OJj13RE59YjGTrmWdkvVAsqhVSi1ehK6CHxuCZOf/H9WV2p+ZCn9qI2OCo/uT9kthQxEF13xqQB
	0tik6iUqMV5665vehCpxBljhn3FzEJ30=
X-Gm-Gg: AfdE7cmg7s2sDMhgew5HtGH99gMIsHVi/FMH+pgvRZ7ZKpnzt0OYSSMhecQF241XF3k
	olIS7QlIircuZt1D/fSX2yfNgX0cPCDuK+uMXdi6qmglPUg/Od1asAXXs4QU61AYOx9dJPugNGk
	feV7fMmOXSDgoXfhcxks6dDGU5k67njhw65XEMk1RIs2VwyF+X9cM7rwR/KOfER/LURj92hNw8S
	wd+8rCLMlATw0PpTZuNqrqHteDGetQQO7MxLXA8ygav/7kCVoUHC9wKgQPXPDg/m/H+lB7+nQ==
X-Received: by 2002:a05:690c:112:b0:7ea:3cda:4246 with SMTP id
 00721157ae682-80670e4828dmr202936807b3.3.1782663828777; Sun, 28 Jun 2026
 09:23:48 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 28 Jun 2026 09:23:47 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 28 Jun 2026 09:23:47 -0700
In-Reply-To: <612b5987-1bc6-4b42-bfba-9c72ee5d51dc@endrift.com>
References: <20260628004106.26920-1-alhouseenyousef@gmail.com> <612b5987-1bc6-4b42-bfba-9c72ee5d51dc@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Sun, 28 Jun 2026 09:23:47 -0700
X-Gm-Features: AVVi8Cf_Hsynpd7VFdZCCXNQws45bnaGAsdX41yi79mlGX0Szrz_YJ4WDc7NEQE
Message-ID: <CAMuQ4bUX-jpuX8LcCpAwb1b+OoK+jP2TtpU3BY4HvERM69iG+A@mail.gmail.com>
Subject: Re: [PATCH] HID: steam: reject short serial number reports
To: Vicki Pfau <vi@endrift.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vicki,

That broader fix sounds preferable. Please go ahead and split it out
and submit it; I will drop this version to avoid overlapping work.

Thanks,
Yousef

On Sat, 27 Jun 2026 17:47:40 -0700, Vicki Pfau <vi@endrift.com> wrote:
> Hi Yousef,
>
> On 6/27/26 5:41 PM, Yousef Alhouseen wrote:
> > steam_recv_report() may return a short positive response and copies
> > only the bytes actually received. steam_get_serial() nevertheless reads
> > the full three-byte header and trusts its length without checking that
> > the serial payload was returned.
> >
> > A malformed USB device can therefore make the driver read uninitialized
> > stack bytes. With a complete-looking short header, those bytes can also
> > be copied into steam->serial_no and printed.
> >
> > Account for the stripped report ID in the return value and reject repli=
es
> > that do not contain both the header and its declared payload.
> >
> > Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
> > Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D75f3f9bff8c510602d36
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > drivers/hid/hid-steam.c | 9 +++++++++
> > 1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> > index 197126d6e081..8c8bfb10e8b8 100644
> > --- a/drivers/hid/hid-steam.c
> > +++ b/drivers/hid/hid-steam.c
> > @@ -454,11 +454,20 @@ static int steam_get_serial(struct steam_device *=
steam)
> > ret =3D steam_recv_report(steam, reply, sizeof(reply));
> > if (ret < 0)
> > goto out;
> > + /* hid_hw_raw_request() counts the stripped report ID byte. */
> > + if (ret < 4) {
> > + ret =3D -EIO;
> > + goto out;
> > + }
> > if (reply[0] !=3D ID_GET_STRING_ATTRIBUTE || reply[1] < 1 ||
> > reply[1] > sizeof(steam->serial_no) || reply[2] !=3D ATTRIB_STR_UNIT_SE=
RIAL) {
> > ret =3D -EIO;
> > goto out;
> > }
> > + if (ret - 1 < 3 + reply[1]) {
> > + ret =3D -EIO;
> > + goto out;
> > + }
> > reply[3 + STEAM_SERIAL_LEN] =3D 0;
> > strscpy(steam->serial_no, reply + 3, reply[1]);
> > out:
>
> I already have locally a patch that fixes this as part of my pending Stea=
m Controller 2 support. However, it chooses to fix it in a different way th=
at would affect all uses of steam_recv_report instead of per-callsite (with=
 only one callsite fixed). I am hoping to get this patchset submitted soon,=
 once more widescale testing is done, but if you want in the meantime I can=
 pull out that single fix and submit it separately; it's a bit more sprawli=
ng and involves adding a new function for combined send/recv.
>
> Vicki
