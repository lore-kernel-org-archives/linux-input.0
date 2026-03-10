Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2803ECBD5
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134530; cv=pass; b=MogsV7UeEOy2C7g51SdAjl6/cuHP/02wcvjUeO4V0mcFgnSgrbkhZHy+L0qz9Hn1FFT6tzB+wdotgSVscbEs47U33xVVrHbeV3eNDtw5+KZBikVRGleNofei4yLInqUaDb/40KW9B0rai6jQQVWYwQXZdBPh3SrgiX8EMQkvKbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134530; c=relaxed/simple;
	bh=tl5/g99NELzOxMGo409f19JuxHQ2pLmrUlfv8ogw/uM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McV+Dr9fRG7NThTRN+A2wc1kpfoQnBWCCWvK3t3d9TrNhDFryzXIOs9Ls/eYdN0TlwyOyjbXgHV+WpV71kFs76MB4NkYlHTkZfbchTxg0WekPNy/QYtGNotKIjZHS1QYiMdCFMfN1vMXCjQIPYmTpTj1bNgCYEUWZ7NSxunRb/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwPL/Evq; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwPL/Evq"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a126b79512so5213790e87.3
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 02:22:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773134527; cv=none;
        d=google.com; s=arc-20240605;
        b=dlCdLrm9mpHn5fXl+YcAd642FNWhTzgjzefrWa0cWo0qke1D2w6tZTdxrRZdEaDBIC
         yz8C+O+faYqu/RadfwDWcR2kqkjbn3XXvJv0sjFh4FP4NPviFRPb2q/+cJRWgHVXzxn4
         Adgxg33Gjzb3bymac9wjbWWtpvT8bnRi3x5xD1BbN47CMPnGz3gontVAH9/ITNyoy+D8
         rM516OSlNmxP/v5SdGdRvTxUq8Kr+vNWbMstB9Vk0MaEbcTicyglkuwKW7kp097vTti5
         zLuRxZYMTUGHYV/rZNA+oRM1OU9XWaeJqrif9jFywB6CpqEkI1Y8DunEzK1VgXbWen6N
         uMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8fpTI3vdEJL+Z4u+Q4DZneNzvVwr7TWL4qTU3qawv8Q=;
        fh=XZdWeio0hzxTCYWxVLMgw/DfscE53QK7/NwtddIKcVk=;
        b=Wbq+eUd1ypqx71K9sWbNiENzCoEUxiytjDMcDgUvK09LL8S6E8sxiQ1AUXN/qsEnVc
         R3rm9ZtoTHlhtV2oCNbhYkDr76qkHtFDtNaO1WaOOUjJu8BU7BK31UiOH/jPP4b/Ix00
         bE45ve0cKqtrMSvKB07jf2pDMEYYdxzvpckw4VKLk/OGJ+9QxTK5pnihpTulRrgQ9R3Z
         aBJzvqA2sr978OgR9wVHF0JgSvDSuaTns629wHBbDJe4tkOAxXvALMi6m1DgYk1iYZSc
         fOB+wpYttF4r6gwBTmWqxeC/DrxgmxJNtVJFmSUOO6Nuk5/hPJKUr/muoOxlwYb4ai2s
         uTDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773134527; x=1773739327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fpTI3vdEJL+Z4u+Q4DZneNzvVwr7TWL4qTU3qawv8Q=;
        b=bwPL/Evq+eoeHEke2+3CCTMUTkJrW502WokNIAE+vXjl0wyTEGRuTvhUkoyF4bMr39
         ZL4UjOhSKK3VSVI88rSCaNCaVzFzwLSb79OBIOSbrkTJ5vHTL7Do8ojXXNzQ8kUKrxU0
         IfFzOvabzSrLHkGVxHwbWa6/ZBfwGnMAWvcITUhTlD0tH7K9cWHXmMSWZTPSHhpEb3hy
         JwqldQaPzrSuBsg8Zvmv5+AAO4NvynMnL4Rb7wKNqik/LGD6SYfMEqhOg8wMhS8TW3Iw
         gGPjwKIKYqgLrPaWneYjC1rYwKrU7V/oGzznSNqj1t65BRnv0ePLBU+y8F6V7KNgyR6W
         Qi5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134527; x=1773739327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8fpTI3vdEJL+Z4u+Q4DZneNzvVwr7TWL4qTU3qawv8Q=;
        b=jIB6mwL9f17nthBCBBFultA8HONcTFFSb2fcTpLRMQM8vb5YhbrSEO7fc/HKdKajh1
         oC4IJZ6ba3IUXLxbvtSpSqXtMv8qpF3Ook9Bi6w4J6HNWaTfRgzng911otCnE/scS//y
         XVbdKyJM8tPExQ4JofKKVNawX81o9qHL+vRahQIAA6lurra0sk+TaGQXD9cBXF8eVY62
         dHtAShc1rGQXCXTo4LotMuiA42XrGqzyIawCX4X8I+TZhHvRp9RWociA5P2dLL+aN6An
         vMB6YJTN/HtIntztn1V4UvU69f+gNtgUmZnDpt6pwdWuEkfqzH/727H2edeHOjc53a6R
         dj2g==
X-Forwarded-Encrypted: i=1; AJvYcCVCpb4t9LQbZXuVEuqPYSxx4R41NUmuZkZiKyVooxSHl0xvtjsIMJFbfuXvlEfW+GrkQHMVTjNHg3mKJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAOGtirLYW35UGFAWLI5UmhpivLDBZwC6zfUl8JlPdNOuyvKLP
	jnBwLiAH8xU37qARsiBrLrBbQcct8IolhzX4Q/XlLPRovMTzlFg/A4SPj1QLX5jHv1aRGpagh0x
	8xAmI8jHj3iQWHX31QtW+m+SYo9Wq0c0=
X-Gm-Gg: ATEYQzy1nMFH7uf3nna/oUuTV4ixY7xgl4UTocZH1GGSPG/qyR/2ICxfi/pi5qm7FtJ
	nFSc8X6CSNcEWK4pTW01YhMxnpnh1F3Ev0s82H9BhCwiMOPQpEp7guBQY9hrkrn33xMR5uqS0K1
	50xnstO9GebbYFH8aLLvwZ3SCgHS50p+K+hXvivKKyMbAiI/zESOV1pp6cE6/lSUBZmbbWvuu5W
	P3/U87fUhu09nELX5m96YJFNbtT4wX1HWt5hLSBkx6/OX0aBJi/4cAv8wHVdCVvGYDDKA3jx2Cy
	LxFTSsQ=
X-Received: by 2002:a05:6512:39c2:b0:5a1:3d47:1308 with SMTP id
 2adb3069b0e04-5a13d47160amr4958370e87.31.1773134526632; Tue, 10 Mar 2026
 02:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209063355.491189-1-vishnuocv@gmail.com> <20260209063355.491189-2-vishnuocv@gmail.com>
 <fdd1d48e-61b7-2543-8a30-c7ad416f5dd3@linux.intel.com> <CABxCQKtf=RYrpgnbM0ODo3GA0oW3jgR=_erc9RCD6gEasasA+A@mail.gmail.com>
 <0df2daf8-31ee-4fe3-fc38-de138b302549@linux.intel.com>
In-Reply-To: <0df2daf8-31ee-4fe3-fc38-de138b302549@linux.intel.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Tue, 10 Mar 2026 18:21:30 +0900
X-Gm-Features: AaiRm511VEyn4PbFLInkP2GfrKMqwBNJnODO-jlyMYwiozSyz1gLdW_tLl1yvUM
Message-ID: <CABxCQKt_1Hv2hPDpzQQ3TxFJWbRNHs-vRDi9hNhBq4oaoGkt3w@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] input: trackpoint - Enable doubletap by default on
 capable devices
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, dmitry.torokhov@gmail.com, hmh@hmh.eng.br, 
	Hans de Goede <hansg@kernel.org>, corbet@lwn.net, derekjohn.clark@gmail.com, 
	linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	ibm-acpi-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, vsankar@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

Thank you.

On Tue, Mar 10, 2026 at 6:15=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 10 Mar 2026, Vishnu Sankar wrote:
>
> > Hi Ilpo,
> >
> > Thank you so much for the review.
> >
> > On Mon, Mar 9, 2026 at 5:01=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Mon, 9 Feb 2026, Vishnu Sankar wrote:
> > >
> > > > Enable doubletap functionality by default on TrackPoint devices tha=
t
> > > > support it. The feature is detected using firmware ID pattern match=
ing
> > > > (PNP: LEN03xxx) with a deny list of incompatible devices.
> > > >
> > > > This provides immediate doubletap functionality without requiring
> > > > userspace configuration. The hardware is enabled during device
> > > > detection, while event filtering continues to be handled by the
> > > > thinkpad_acpi driver as before.
> > > >
> > > > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > > > Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > > > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > ---
> > > > Changes in v7:
> > > > - Removed unwanted comments
> > > > - Removed psmouse_info ()
> > > >
> > > > Changes in v6:
> > > > - No Changes
> > > >
> > > > Changes in v5:
> > > > - Renamed function to trackpoint_is_dt_capable()
> > > > - Simplified string comparison without sscanf()
> > > > - Removed wrapper function as suggested
> > > > - Fixed missing period in comment
> > > >
> > > > Changes in v4:
> > > > - Simplified approach: removed all sysfs attributes and user interf=
ace
> > > > - Enable doubletap by default during device detection
> > > > - Removed global variables and complex attribute infrastructure
> > > > - Uses minimal firmware ID detection with deny list
> > > > - Follows KISS principle as suggested by reviewers
> > > >
> > > > Changes in v3:
> > > > - No changes
> > > >
> > > > Changes in v2:
> > > > - Improve commit messages
> > > > - Sysfs attributes moved to trackpoint.c
> > > > - Removed unnecessary comments
> > > > - Removed unnecessary debug messages
> > > > - Using strstarts() instead of strcmp()
> > > > - is_trackpoint_dt_capable() modified
> > > > - Removed _BIT suffix and used BIT() define
> > > > - Reverse the trackpoint_doubletap_status() logic to return error f=
irst
> > > > - Removed export functions as a result of the design change
> > > > - Changed trackpoint_dev->psmouse to parent_psmouse
> > > > - The path of trackpoint.h is not changed
> > > > ---
> > > >  drivers/input/mouse/trackpoint.c | 45 ++++++++++++++++++++++++++++=
++++
> > > >  drivers/input/mouse/trackpoint.h |  5 ++++
> > > >  2 files changed, 50 insertions(+)
> > > >
>
> > > > diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse=
/trackpoint.c
> > > > index 5f6643b69a2c..e12d76350252 100644
> > > > --- a/drivers/input/mouse/trackpoint.c
> > > > +++ b/drivers/input/mouse/trackpoint.c
>
> > > > +     /* Must start with "PNP: LEN03" */
> > > > +     if (!strstarts(pnp_id, "PNP: LEN03"))
> > >
> > > Missing include.
> >
> > Sorry, I am a bit confused here:
> > strstarts() is already available through the existing
> > #include <linux/string.h> in thinkpad_acpi.c.
> >
> > Do you think I should do anything else here?
>
> Yes.
>
> The file you're modifying in this patch is trackpoint.c which doesn't
> have that include so please add it also there. :-)
Aaah, Sorry!!. Got it.
I=E2=80=99ll add the missing #include <linux/string.h>
Thank you for pointing it out.
>
> --
>  i.



--=20

Regards,

      Vishnu Sankar
