Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473040;
	b=jQWz9kgn+ZL1jvALT/PeMoe6VW9RxJfkOlzIKTjEFpOUIa+Pz3w6Nq0TZkBGompHdqFr
	 dQNMUxXjH+WqW2pLSYU21Q7RIAJS43EM46KPyJfek8BE6HYTLDVhbhq8u6+bER/LjgQH6
	 9rYsSjQ24WsfPd3PT8lQ+QM7jehT7saUYUoV5hLlvMZ+UH1zSadwMZWTW6xl9392hmJdU
	 3NxHdG1yrazWyuMEu588WgP0rGD10nVeEc158hTVZbCv69hk60xL3L9sPfTPqJbDwGZa1
	 usds5XpwUhz1mbMNapa8cF0sPfSlURV2PHjJG+EzQf5ETDsiZzM+fxU8yZAwHAjpksg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j4z+t7xZiBYWqSlCxRL9tqHGVa1+jJSPT4E84fY0Opw=;
	b=a/IVw1AeyXlV2XDSzflyRnGmIy++zfd+WVF8yeYx2vKLjgRFEOMikQ/qqqO36Zc1ha3+
	 JNfofgZnbG76MpAMTDs8gfj/eRy9mGCXjCe/qr9h32CgoN20KkWA2rf8+pVzy0OHjrHbi
	 5wafbriF4W2wSZKYc20XYdIjrTKccr/Ppwgd14BQQJXkaQ4+xLdAueHulBxAr5ZpKjBDE
	 2QtVEXmKCKbZFX2Zs+7NmBXhgn6AsuGYt7OKsnYPZwYSjXz9+AuArie/tSyR65RvH2n9a
	 fnx7faEppq3cf5wXMbufjo+fbN3wJvG5P9Df6vmVdNerPWwDw9gTvS+unDYXrxddIJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1pDnbWC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.181
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F3606A8BA
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 08:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 937F3606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1pDnbWC
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3acd523a802so33563481fa.2
        for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 00:44:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794473039; cv=none;
        d=google.com; s=arc-20260327;
        b=CXrQNJjai7169Uel7z712uuOopbxdIIM5bHjurtsHJ28bSd+1mUhrWaVL0YAdJCRsH
         aT2+Vsoq1JY2hrcfi7w0Zff6gwEbLrT31MP/QiBe8c5X/dZIv6lOtpYgyVLAFzfT0vEA
         R5ER2QiB8uwJA63XhHsMsIoQOxMwsdZdWodcWYxyb3MzBL71ZV/s2UPIXPfc6t95UAKS
         74Oo7Dc2U4aXSYcoVINyYxMVttGXcMJ5i+7rY8Fa7WC+fOvq47pd/d/F57wfgaVYWhAE
         Nnu3MvlZ3XjYnrF0D0t20Amq2Xf3m9fOXRTsNVOIVFEsbJ1TS6kBKCWoku1dw+EB87aM
         BNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j4z+t7xZiBYWqSlCxRL9tqHGVa1+jJSPT4E84fY0Opw=;
        fh=sqOlnSlNfwy7H6CNTbkQYyzIwGr+/4V1EV5kot1ATwA=;
        b=pfV9Ut4DgycnmuKj+a0j6MYHBIEHdPB3kKjZemYEIBwhKzImpvRfsIpUAGTXas6cMM
         Is+AikfZQJLE0hsVZjSyRxDSWekIujD23560vZRsbdXrk65CANZxxSyjNUR/9tcOGT48
         mFNAMG32WoyCCNhQ9m4VKy4bkv338UBfJo03M0BvqQ+y8iEgCGko3gPQ7ibue4vcz/lE
         uF68TRp+tIx+DI3E/e35sayDR3BPHzo/y44HVxIucPI6/ee+GhSyRsas2GWsff7OqL+1
         lrHkLyMOk2H7+4+a7+Qhz6Hk6Jsfswq3B/nsYOhD1k1mBiNwiDfLbPS7qG9Gwer+ldVc
         kOow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794473039; x=1795077839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j4z+t7xZiBYWqSlCxRL9tqHGVa1+jJSPT4E84fY0Opw=;
        b=U1pDnbWCVTCGQ77KHMpS0ryIaY5Fd8M8qQtnYvIN/tmX8WicigA45WByhGmV43ossZ
         pfnI64oIMCvXG8XXWmk+gr6tcrgPDj2fU22ue+zSzsR7sWEBVKcL1DmwcPTMaCnFOF0r
         jtyUZsI2FR+DNUEReCFY+5P31HvJWHAgDLN9G1NMVXtFNZO/8aFXIldiyBt/uGWxzziM
         0EcImUD+ORPm4MwTBn/RrhH1tyrHovLeXJYT6nviSzb3QU2VqavcDOUCsYAA0KG4QHaj
         NY47PsuSV+Mo+t7BQpe02fEgrRDAVk6MO79V1ILDOteoY6ktLVHeZRk2yQ0X/uOtUpHq
         luwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794473039; x=1795077839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4z+t7xZiBYWqSlCxRL9tqHGVa1+jJSPT4E84fY0Opw=;
        b=Z0xBlTEilj+YO32XkZaZTTH/nHx6CEGrFnTjtMb+YcrYifi0lSsyByGuasU294cmCi
         BBjcnNxUmw6LNgylf+2fLoCbhDGw7x7KIfQUBmwZpqRRDCaDRBsqG14E9oZaVfNmymfO
         O3SckWJKKwheBxxlYxtbbCHF51ZgT5Wht0FR2hGm9wB5ACU2dFm4kT5C5XQtu5W3Huk0
         +WRt2pViO+h8nyHbbTgEBwncXiTqLIgTlbjaZhlhth9bGxlD8W/wpQoH5UQ3TDs1qLpx
         wgWs1q5GOsfDiU1yoiSpEzZPGKxZsFZWo2kOGoSDwhvFdcLPOcHx3/YFU84jPHu6MfCe
         trlg==
X-Forwarded-Encrypted: i=1; AL+hErEa8C83KdMTFtbWp/JYgHuzeKvQm0yLTiFf/rvWWSOc54zBYuuqv6Es+q/JxiKnsxmuexn9iqhbehjajg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/cXcy5lOHn2Sw7s4v0NoxaxJGosJ12UiJiow1XjSpRiqI7Ihm2
	+xphFWI7KEMvO5mBvASc+Xf9RWkaeaYjkAYGaWAREqYwDoQOHLQ35HeEeadua2xYgRTupf4cpuL
	RWj2bn+MEHbeUnoRtk8VQBk2bO4nZluE=
X-Gm-Gg: AYBFou21E34JA9zIeUrD+bhK7WgRX0sFc8hEBW0GjBH/bnvoArU3QxVkN8M7XhEToSm
	9YmZZ/JWAs76i90NH4f4e+8JveBuhF7QsHoTd3ST3ywk+DZi8i6Pa2LAvU711Xm7BdnZXFDDsO8
	evVm5pbv9wv70wGe1Ssj7xC1xD+BWk9TzkUJs5+kdfFhIxa+mBpAZiTQ3MObAiaxSsE6dHdli4W
	gXGrBzxykWWSuFz3ytZp8zTJo2ID4tJ7YWai7y0o1zfSB1ky7eNwK9BkDnMttx6Q9K2dufdwPMA
	s4n8qXHVaWjY/9X+unPUwzVUaMmf7TC8DrHx5q5cFw10CDd09SCV6kOmAKEJAhRgNxMZ3yEO3l5
	C+w5cmengSEBhTyUR8lxti5JJOP0vksTgo0DTOM6qIbPM6mgb8NcidqqOqylWTl5j
X-Received: by 2002:a05:651c:a347:b0:3aa:fc64:a92c with SMTP id
 38308e7fff4ca-3ae125cc73emr11313481fa.1.1794473038570; Thu, 12 Nov 2026
 00:43:58 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com> <avKBsi-E7IeUgsSY@google.com>
 <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avMcB0q7wF9oP5X8@sapienza> <PUZPR01MB477458CD012208A31DE60068DC712@PUZPR01MB4774.apcprd01.prod.exchangelabs.com>
 <avRttU9N0EZeq8nY@sapienza> <TY0PR0101MB47865DFC765932B9E6C3E1C0DC702@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avVPRySmoH_KKHa6@google.com> <CABxCQKt9o--KrucZ-jcG+tb4AGtrBnPY_mypqX64ojWRpoO_yw@mail.gmail.com>
In-Reply-To: <CABxCQKt9o--KrucZ-jcG+tb4AGtrBnPY_mypqX64ojWRpoO_yw@mail.gmail.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Thu, 12 Nov 2026 17:43:21 +0900
X-Gm-Features: AclHuK8ZD51yIggX2ulMSfaDbMsjgHBr0y01lwFMAIyoSpiv0HXa-d3ugFJHB-A
Message-ID: <CABxCQKvPhvs5X+fej2gHaCJv_rWWPYciG8cUKVtxgSb-iFK5yQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?SmluZ2xlIFd1IOWQs+mHkeWciw==?= <jingle.wu@emc.com.tw>, 
	Yao Yuan <yaoyuan0329os@gmail.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?UGhvZW5peCBIdWFuZyDpu4PkuJbptaw=?= <phoenix@emc.com.tw>, 
	=?UTF-8?B?U3RhbmxleSBDaGVuIOmZs+W7uue2rQ==?= <stanley.chen@emc.com.tw>, 
	Vishnu Sankar <vsankar@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 4:14=E2=80=AFPM Vishnu Sankar <vishnuocv@gmail.com>=
 wrote:
>
> Hi Dimitry, Jingle, Yuan,
>
> On Thu, Nov 12, 2026 at 2:33=E2=80=AFPM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Jingle,
> >
> > On Thu, Nov 12, 2026 at 05:26:46AM +0000, Jingle Wu =E5=90=B3=E9=87=91=
=E5=9C=8B wrote:
> > > Hi Yao:
> > >
> > > Upon inquiry, it was confirmed that a black TrackPoint stick (0x07)
> > > underneath the red TrackPoint cap corresponds to a vendor that is
> > > compatible with the Windows ELAN driver.
> >
> > Are you at liberty to share the vendor name? Or should we mark it as
> > "Elan" or "Elan-compatible"?
>
> Sorry to jump in; this is Vishnu from Lenovo.
> I have now confirmed with the component owner and supplier that the
> TrackPoint reporting variant ID `0x07` and firmware revision `0xA1`
> are made by JYT/NDT, not ELAN. The physical check also identified the
> corresponding button/stick as white. It uses the same ELAN driver for
> Windows but has different FW.
Sorry, typo.
The physical check also identified the corresponding button/stick as
black/off-black
>
> Therefore, the patch should recognize `0x07` as the JYT/NDT variant
> rather than naming it as an ELAN variant.
>
> Can name it something like  [TP_VARIANT_JYT_NDT]          =3D "JYT_NDT"
> or something like that.
> >
> > Thanks.
> >
> > --
> > Dmitry
>
> --
>
> Regards,
>
>       Vishnu Sankar



--=20

Regards,

      Vishnu Sankar
