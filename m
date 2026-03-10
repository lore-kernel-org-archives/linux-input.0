Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25F53CD8B2
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143721; cv=pass; b=hk6jqundxNThEDrI5BHmYXS7Xw/8na7r4pgglncLLOn0mwEO9bJ96ZSq+9Hi/o+TekDgcqUAlzKpOLi86i5IR36n0ufCZIPHJeNGlkeEo7r0PyR54joRYzXyUBJbf9SBUhpiNymqbvWXGPvHA/yz+PwW8oIHSeWGg6NG7AgjI64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143721; c=relaxed/simple;
	bh=KJ34G7jXVW6vaVlUYzHj+z8DcGKlvG+6o58Yti9Gnh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kN6h1mlxjiZPeybRyHNE0Iq8HrhBdYVV/CD4sHrzAoOzNblYGa5LQ+TG4c6vJjFN0DBj3ub1bS3SFDBMA8ofFH5TQ2/9oyU6Xm0KMzzwwbHAobrP/SR6cx5/QI+UVX/K4cQANALgaseLLc4zV2i3Sb9Uu19W12FYGBGxZIE/iao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6wKgHzv; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6wKgHzv"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e4989dacdso7260190e87.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 04:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773143717; cv=none;
        d=google.com; s=arc-20240605;
        b=PkgJ+qYLFqK4MlOfi7e3VDEOJ0OEdOwK1WCdhSS8NCTONc+3ALq45ZwCqyWO/yUTfQ
         pkQJKA2+75Rgvd+0brJx95xoYOaLl/BpNb+9jH8KqOlSK4ye6lvyJmnLLlzh54CqlMmE
         PLMoemuDnCaZnURwOJi1uoT4BmwDuaWLnMt2sxNY2nghVmxVf793Rou4QN/CY5xX5UGY
         sgfxn5TzySf4BjeDJ2P+ekGG4aGj8DWud/HYuXEL/OYEnUZWIrUkI7r0TicIellH8f25
         JEoA0+WKXKyiSfycSFLMtXMSpUuyRcODx8nOCnuiogd/OVrq8wFIRCq/yLAruBRmvNPs
         p3Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W70+Vn6PejFfPeY6VWdAiMcWtVOjKl21UuQnq+3EYxE=;
        fh=BgVFNIHxeDS5XFoKrWdOL/9Eqxxb0hf/ZOb6XAGrpNw=;
        b=j1G0srT7a43o8ApwXNP4MObQTQ0PJWqk0C7GDdEfhE1hRQSNuQhYQE68wUGCdl0mZ+
         1s5iqVhIPCGPE1JZbVxjBr+qhrjmfUJnFsY+CAqghp3z7zPwx/QGiRKL4/GgPSK9+qDF
         aaX4sCcEwxkC1UL74HQ65OlwhyNcFheozOIiX31ZPbuYnyP/MoWduF6bbhtLVsOUEJzT
         58xECMv+TxHaDtfrADQGQ3enmxoQdclNHF3VWuXzXdQluD8viQc/n8EuzRoOO2StK5J5
         aqthjbElRbZT1p8lhKTxQkDDLrjgLrHVw7MT/v77nEeQ5Uiq/u1h4Smo36sFMl1lHoQd
         ygoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773143717; x=1773748517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W70+Vn6PejFfPeY6VWdAiMcWtVOjKl21UuQnq+3EYxE=;
        b=X6wKgHzvGfZjbb1VVXQ4DqgxIlVZOJBD9U1LIvi4mW/O5C0P62KEy9HGblhr0BMtAM
         npdmJAQ9sUaSzeKYQ1R7qXnh++b6/ua7hVl4hFVp1dmMq8r0++Oqq097Q+rF1V+u8b9f
         otHVbs4H/CtAwLry9pjvlj4kY9oYBtNTzCy+mYpoBhik9xRHRdfm60SKlML/GENR9IM4
         0BfEP69xzxRmg967Xb0piwhVLFux37sZJGAPweJxGVy4HgQqwuCrKwgyKqaSdxhMgwXH
         5173A89GAwer+msqJZPK8tcuJETMTkmYKmMTjILAFDieO4nk2vyjiSx06I3cHXOR3ytA
         0/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773143717; x=1773748517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W70+Vn6PejFfPeY6VWdAiMcWtVOjKl21UuQnq+3EYxE=;
        b=sl2SVlEYZ+ojIsqb0/b3mMoHbXBHBFEwWN6QuiUc63AaysG1dBkhhBO0CIqLjKlRfJ
         zopHyopJrSGi3nMcyoNZBHmtBtTsom5fIOcDTo4WSU0s9JONLkFXFS+TBCgzHVnZiMEf
         Fvk0kOBQNTalRS8Dyn7oCw/RcxfqtysFsjIrkYf1JhfkL77Sl5+iZEJyfu9sEgMGV9I3
         enJjSdCNhHmF/+q8OrEwWbW/5QDc9j76RxzvMa3naDxDMnGocwZ9BouAX8RGRSBbYlxF
         aWFPwJR2HZnvjZEyfSb3la7rnBrfBCTDWb3OAKM6PfLYle5WQzT8glX/MkyP8Vn2Rgm9
         JGEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCqB0VtEOZd3hujITZluo7riPu5Q29bhTDFVC19F9jkeKzIzrE6TDcHbdr5T+awg45KzAyjamt27OFwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHOs3Sa/AQfWtgPvXbwd5xfGd7ePtsaHwImxA312FYHi32drF
	wJQi1TpFttY74s1O0MXp7KRE47fFHyMj4dO3hUh3uryRWnx82yYhdMdoBcNE5oQhNlEl9xBgbso
	6wbwchT2fbvdNrXytV9kcqQYk5ZrM6Cw=
X-Gm-Gg: ATEYQzwEkxrbcyWcJCOkbNgnvKTpaGkJ8/24ZB+EYqeSrsx3w+P62H+GqKmazH7bmFb
	6YyPqxX+U1BcOsFeDU3WTmDoVgAi/Q9TRIvOVLryL3tPFZTMhIU3yhaf2eJXY9IkBPdxH8YhYaV
	XgpVUZQC7E2/DjMO0p4jkeHSQMQF6n9tcnDMJuhh53/hkC9/jOeVBdwDSy+suEdbhOVZR3nAye1
	OSL0KUBvs70U6dt/O2tyuk/l/fgamv6s64d2P+Z4rOwP6RvgFjDabztPPdkMMiSMD+Oa9gkKUmi
	V5KVKwQ=
X-Received: by 2002:a05:6512:6c8:b0:5a1:18f0:930b with SMTP id
 2adb3069b0e04-5a13cd1c912mr4967420e87.42.1773143716734; Tue, 10 Mar 2026
 04:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209063355.491189-1-vishnuocv@gmail.com> <20260209063355.491189-2-vishnuocv@gmail.com>
 <fdd1d48e-61b7-2543-8a30-c7ad416f5dd3@linux.intel.com> <CABxCQKtf=RYrpgnbM0ODo3GA0oW3jgR=_erc9RCD6gEasasA+A@mail.gmail.com>
 <0df2daf8-31ee-4fe3-fc38-de138b302549@linux.intel.com> <CABxCQKt_1Hv2hPDpzQQ3TxFJWbRNHs-vRDi9hNhBq4oaoGkt3w@mail.gmail.com>
 <8216aaaf-bdaa-2a48-a7de-b0b81d49eda5@linux.intel.com>
In-Reply-To: <8216aaaf-bdaa-2a48-a7de-b0b81d49eda5@linux.intel.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Tue, 10 Mar 2026 20:54:40 +0900
X-Gm-Features: AaiRm53Z7FInzVa7AHviwaQEjkqy6ucSeO9srFBPc2Ymkf_rnYJvGp7zbxxDC7Q
Message-ID: <CABxCQKsWtmM5zJDKM35WL_bvi=01QLT0ot5fidH-9yZ70_Q5cw@mail.gmail.com>
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

Thanks again.

On Tue, Mar 10, 2026 at 6:30=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 10 Mar 2026, Vishnu Sankar wrote:
>
> > Hi Ilpo,
> >
> > Thank you.
> >
> > On Tue, Mar 10, 2026 at 6:15=E2=80=AFPM Ilpo J=C3=A4rvinen
> > <ilpo.jarvinen@linux.intel.com> wrote:
> > >
> > > On Tue, 10 Mar 2026, Vishnu Sankar wrote:
> > >
> > > > Hi Ilpo,
> > > >
> > > > Thank you so much for the review.
> > > >
> > > > On Mon, Mar 9, 2026 at 5:01=E2=80=AFPM Ilpo J=C3=A4rvinen
> > > > <ilpo.jarvinen@linux.intel.com> wrote:
> > > > >
> > > > > On Mon, 9 Feb 2026, Vishnu Sankar wrote:
> > > > >
> > > > > > Enable doubletap functionality by default on TrackPoint devices=
 that
> > > > > > support it. The feature is detected using firmware ID pattern m=
atching
> > > > > > (PNP: LEN03xxx) with a deny list of incompatible devices.
> > > > > >
> > > > > > This provides immediate doubletap functionality without requiri=
ng
> > > > > > userspace configuration. The hardware is enabled during device
> > > > > > detection, while event filtering continues to be handled by the
> > > > > > thinkpad_acpi driver as before.
> > > > > >
> > > > > > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > > > > > Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > > > > > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > > ---
> > > > > > Changes in v7:
> > > > > > - Removed unwanted comments
> > > > > > - Removed psmouse_info ()
> > > > > >
> > > > > > Changes in v6:
> > > > > > - No Changes
> > > > > >
> > > > > > Changes in v5:
> > > > > > - Renamed function to trackpoint_is_dt_capable()
> > > > > > - Simplified string comparison without sscanf()
> > > > > > - Removed wrapper function as suggested
> > > > > > - Fixed missing period in comment
> > > > > >
> > > > > > Changes in v4:
> > > > > > - Simplified approach: removed all sysfs attributes and user in=
terface
> > > > > > - Enable doubletap by default during device detection
> > > > > > - Removed global variables and complex attribute infrastructure
> > > > > > - Uses minimal firmware ID detection with deny list
> > > > > > - Follows KISS principle as suggested by reviewers
> > > > > >
> > > > > > Changes in v3:
> > > > > > - No changes
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Improve commit messages
> > > > > > - Sysfs attributes moved to trackpoint.c
> > > > > > - Removed unnecessary comments
> > > > > > - Removed unnecessary debug messages
> > > > > > - Using strstarts() instead of strcmp()
> > > > > > - is_trackpoint_dt_capable() modified
> > > > > > - Removed _BIT suffix and used BIT() define
> > > > > > - Reverse the trackpoint_doubletap_status() logic to return err=
or first
> > > > > > - Removed export functions as a result of the design change
> > > > > > - Changed trackpoint_dev->psmouse to parent_psmouse
> > > > > > - The path of trackpoint.h is not changed
> > > > > > ---
> > > > > >  drivers/input/mouse/trackpoint.c | 45 ++++++++++++++++++++++++=
++++++++
> > > > > >  drivers/input/mouse/trackpoint.h |  5 ++++
> > > > > >  2 files changed, 50 insertions(+)
> > > > > >
> > >
> > > > > > diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/m=
ouse/trackpoint.c
> > > > > > index 5f6643b69a2c..e12d76350252 100644
> > > > > > --- a/drivers/input/mouse/trackpoint.c
> > > > > > +++ b/drivers/input/mouse/trackpoint.c
> > >
> > > > > > +     /* Must start with "PNP: LEN03" */
> > > > > > +     if (!strstarts(pnp_id, "PNP: LEN03"))
> > > > >
> > > > > Missing include.
> > > >
> > > > Sorry, I am a bit confused here:
> > > > strstarts() is already available through the existing
> > > > #include <linux/string.h> in thinkpad_acpi.c.
> > > >
> > > > Do you think I should do anything else here?
> > >
> > > Yes.
> > >
> > > The file you're modifying in this patch is trackpoint.c which doesn't
> > > have that include so please add it also there. :-)
> > Aaah, Sorry!!. Got it.
> > I=E2=80=99ll add the missing #include <linux/string.h>
> > Thank you for pointing it out.
>
> Thanks. Please also double check you added inux/array_size.h into the
> correct file in case you were confused what file this patch modifies.
Thanks, and yes =E2=80=94 I got mixed up earlier and checked the includes i=
n
the wrong file, which led to my confusion.
Sorry about that.
>
> --
>  i.



--=20

Regards,

      Vishnu Sankar
