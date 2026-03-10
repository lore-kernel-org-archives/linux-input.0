Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23B3BD637
	for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108746; cv=pass; b=fX3uLOPvBmFjEpfhX49h2z69zpWhn6KhutSCsfIKVYcfcTtzq4eBijXE7EbItzo7OBGBlI6PnafWh3FN7sYXHcGcMrLowk6LRwSi20OuEdFYxhurFWagCyPdLLt2Xro2nHVM83/RGpZrcEzFEklpyWC+/XyviZKVBAQWZHBU/+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108746; c=relaxed/simple;
	bh=qInFR7+ruku82QTeduGJJurbtW8DPI5C9OdU4RWav24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXAxIYuYgazXZUXUOJrnJZzo6zIom7tywGc2BfveoxSy+Gwt/M+un74aB2WbzK7NapTPJ5QHHqX1CGZ8Oc4vGvyOqa5Qcv6u/eN95Tf0zSzm+PaS1AcLkEtWSjkm0KlA+rLzZpMVChVoe3ezgNxRIfhdD6pYTD/JgORtCV4b9aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaFVSkng; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaFVSkng"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a12f6871b2so6810941e87.1
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2026 19:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773108743; cv=none;
        d=google.com; s=arc-20240605;
        b=gxMZjJp3OsTkhJ28y4SUWX5g+ILqjdOPTQwFUYN578xYCvC7GoRBMT1J+OEGnpaCI9
         u2c0FOj3DOrHEPeb035CEbkI6Dpu4Mn9emtguFsJvv6kELGC/yhy4yW3SVFSMP5yI/g+
         H1XgkWrl/8OeD1kfV2p5/IKje+4fJ4HusLHDU6KlYf0rHcF1NikUbOx616l8htqF78vv
         m5j0XP78mPjX1HVRhiBPNioPRMIhlsmF8Md8a39aaU0gtFXlxu3pwJx6cfAxLsKH3Z4x
         8Vq5B60UeVvYRxOKgiqtEBhTkOq0vVlZhOni0JLcADBgwgG/7VVk1wekoP6unSDNzINn
         1Nyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KtlsLU3IPO5uqXUZY8olaTkPpadXjE8FCVLC/ftGY8Q=;
        fh=R2r6p4sBuMSJWcaJt11LtSBG0LdIuZV/MtNGYRAlckQ=;
        b=MsPce0SW8ZbgTsncU/GDSxRBiLfZAD8zXpAW5W5fNwfWpjRjYYNAE4DkBTRRJq45BW
         ADcDDNMW+AgMycUgTvYG+VBRshzabziVkEKXa4zdAC7zjXtYpdU1QgvHqvpP9gDLDj0D
         kX9azJEdW05ldK1TgLk7cyEvt4bQr5GfwRVIvQJuOmtrME1ylQxwNZHWgmWhB/HrwKGZ
         vp2Jq1RFDrtcUlYyqx8dqqVhfZPZJibSe7A1ThsEtKM5CRCRainOLHPDwW9teLXqO5W7
         wkITBn9uyJQxE3mVzToQuD1WKW2xN0BKrb4MRi8muhEFwAcdTcZ5vtY0H00ari7iD4BQ
         uE4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773108743; x=1773713543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtlsLU3IPO5uqXUZY8olaTkPpadXjE8FCVLC/ftGY8Q=;
        b=NaFVSkngboq1hHClKBNqJ3FuhfV0ZssRBy4ZTnxtJvCgURRChosdINNJB++x8ET3ew
         AeiJ9xDiUY3byUaJbIGDmTTouK4gaXztLmfSw2Q4x+0sT4erJvvUBqU6o48Z4nWge674
         DMJQyu4T2bHoxPwaxPMjKUAdQD90AYzZmPC1BG3hR16BkuV8XvI9x15N5rZLJHj1oja2
         rbjIMuAn4xF+Q/57f15taFtBCwjNmlqO+e86ppNn7h14IRC9guKptVhqRYR8wiECu5Ri
         UhWrk7lnr4hjxi2XPVMpmLmyaVL3H4yaZJSFSVUDfn31jM8VJh0+RRZonxU00LgWCEdL
         bzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773108743; x=1773713543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KtlsLU3IPO5uqXUZY8olaTkPpadXjE8FCVLC/ftGY8Q=;
        b=TF+46JxPP0ETqVHljEo04sQOogcnFJO6NHXfx4D98MRZV4M17KaNVqo9m61J+Z9FhV
         5W/scJMbfnvMGGm0zyu2AtbYL/z8d7nxX6kw+gs3P7of3apwDNj3wQrlZs1ES3nVvc5S
         5qLDHCYQh5M1c/9vG2HDtutKZoFNFKk1BdY9BXn9m557qhE5AEEqgk/BrbKf4pr0StCj
         rbX9TcMFZ+GPm4NEPgljVMgW6OkthY/mhJIB7ZjK914xlKvV5QWdsyHe0GfWJijagzFZ
         apfQyUt5d8STNT+ieCMXqHgQ0DckXEPkGQHlLywWwnE6Kqa5ZRXAKEcbx2Wq5F4WPG2P
         /JUg==
X-Forwarded-Encrypted: i=1; AJvYcCVBsYSma0p2XViD+KaAue2/DpP6ORMBvv4sOHmx5Ozqr/eVJbq7Itx3Nf5m9FscdBShUMNGCyhx6ALtpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YysYFTdriBv82HfdLaeDJsafzhfS52pdorBIdGci+5bdL2VXWyr
	li39NenvmlS6onK7kVFvcN51ISfaSp8jYwyCEjLEX/UEb9YC3qSQj9ilbYS1HNZnH9iNmNMwDCm
	UJBfr2rUQS92VtVATw8smZZXCGymPxCw=
X-Gm-Gg: ATEYQzybpFUR4cCKuakNXamwuCxLdg/nNTJJhppq7Mpuv36Q+/U67VbxGFiWo4b9RSG
	sTmwRb+tIZRZPnB4VwBympdyxNZqSGZZeibFMxgXp+eK4L0CK177vwL7i1EzkAGh1kTzyeqA5Tb
	Ehy6ErpFWlneW0s1lcIaaADrfxhc2XLvQ3zeU66Nd+CWm5LbM0peUDNlXvgKtaSqlSE4QituKvt
	0K+OUy9zn7p0N+Of2Y/43nw4g3WznD7wWEDlloGu2WC9bUYFguOBC8oibd929TXH3LkQmcTcV2B
	ehQBCEz9VJz4gDg=
X-Received: by 2002:a05:6512:640f:b0:5a1:2fcb:1da4 with SMTP id
 2adb3069b0e04-5a13cabad88mr4615178e87.11.1773108742407; Mon, 09 Mar 2026
 19:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209063355.491189-1-vishnuocv@gmail.com> <20260209063355.491189-2-vishnuocv@gmail.com>
 <fdd1d48e-61b7-2543-8a30-c7ad416f5dd3@linux.intel.com>
In-Reply-To: <fdd1d48e-61b7-2543-8a30-c7ad416f5dd3@linux.intel.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Tue, 10 Mar 2026 11:11:44 +0900
X-Gm-Features: AaiRm50mcZVhLubnwdp-BsgTf6noF_Wn1o5ArrsQT_Cbsc-4CO86otqEZNqhq_c
Message-ID: <CABxCQKtf=RYrpgnbM0ODo3GA0oW3jgR=_erc9RCD6gEasasA+A@mail.gmail.com>
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

Thank you so much for the review.

On Mon, Mar 9, 2026 at 5:01=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 9 Feb 2026, Vishnu Sankar wrote:
>
> > Enable doubletap functionality by default on TrackPoint devices that
> > support it. The feature is detected using firmware ID pattern matching
> > (PNP: LEN03xxx) with a deny list of incompatible devices.
> >
> > This provides immediate doubletap functionality without requiring
> > userspace configuration. The hardware is enabled during device
> > detection, while event filtering continues to be handled by the
> > thinkpad_acpi driver as before.
> >
> > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > Changes in v7:
> > - Removed unwanted comments
> > - Removed psmouse_info ()
> >
> > Changes in v6:
> > - No Changes
> >
> > Changes in v5:
> > - Renamed function to trackpoint_is_dt_capable()
> > - Simplified string comparison without sscanf()
> > - Removed wrapper function as suggested
> > - Fixed missing period in comment
> >
> > Changes in v4:
> > - Simplified approach: removed all sysfs attributes and user interface
> > - Enable doubletap by default during device detection
> > - Removed global variables and complex attribute infrastructure
> > - Uses minimal firmware ID detection with deny list
> > - Follows KISS principle as suggested by reviewers
> >
> > Changes in v3:
> > - No changes
> >
> > Changes in v2:
> > - Improve commit messages
> > - Sysfs attributes moved to trackpoint.c
> > - Removed unnecessary comments
> > - Removed unnecessary debug messages
> > - Using strstarts() instead of strcmp()
> > - is_trackpoint_dt_capable() modified
> > - Removed _BIT suffix and used BIT() define
> > - Reverse the trackpoint_doubletap_status() logic to return error first
> > - Removed export functions as a result of the design change
> > - Changed trackpoint_dev->psmouse to parent_psmouse
> > - The path of trackpoint.h is not changed
> > ---
> >  drivers/input/mouse/trackpoint.c | 45 ++++++++++++++++++++++++++++++++
> >  drivers/input/mouse/trackpoint.h |  5 ++++
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/tra=
ckpoint.c
> > index 5f6643b69a2c..e12d76350252 100644
> > --- a/drivers/input/mouse/trackpoint.c
> > +++ b/drivers/input/mouse/trackpoint.c
> > @@ -393,6 +393,45 @@ static int trackpoint_reconnect(struct psmouse *ps=
mouse)
> >       return 0;
> >  }
> >
> > +/* List of known incapable device PNP IDs */
> > +static const char * const dt_incompatible_devices[] =3D {
> > +     "LEN0304",
> > +     "LEN0306",
> > +     "LEN0317",
> > +     "LEN031A",
> > +     "LEN031B",
> > +     "LEN031C",
> > +     "LEN031D",
> > +};
> > +
> > +/*
> > + * Checks if it's a doubletap capable device.
> > + * The PNP ID format is "PNP: LEN030d PNP0f13".
> > + */
> > +static bool trackpoint_is_dt_capable(const char *pnp_id)
> > +{
> > +     size_t i;
> > +
> > +     if (!pnp_id)
> > +             return false;
> > +
> > +     /* Must start with "PNP: LEN03" */
> > +     if (!strstarts(pnp_id, "PNP: LEN03"))
>
> Missing include.
Sorry, I am a bit confused here:
strstarts() is already available through the existing
#include <linux/string.h> in thinkpad_acpi.c.

Do you think I should do anything else here?
>
> > +             return false;
> > +
> > +     /* Ensure enough length before comparing */
> > +     if (strlen(pnp_id) < 12)
> > +             return false;
> > +
> > +     /* Check deny-list */
> > +     for (i =3D 0; i < ARRAY_SIZE(dt_incompatible_devices); i++) {
>
> Missing include for ARRAY_SIZE().
Acked.
Will add linux/array_size.h to the include list.
>
> > +             if (!strncmp(pnp_id + 5,
> > +                          dt_incompatible_devices[i], 7))
>
> Fits to one line.
Understood.
will come up with v8 soon.
>
> > +                     return false;
> > +     }
> > +     return true;
> > +}
> > +
> >  int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
> >  {
> >       struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> > @@ -470,6 +509,12 @@ int trackpoint_detect(struct psmouse *psmouse, boo=
l set_properties)
> >                    psmouse->vendor, firmware_id,
> >                    (button_info & 0xf0) >> 4, button_info & 0x0f);
> >
> > +     if (trackpoint_is_dt_capable(ps2dev->serio->firmware_id)) {
> > +             error =3D trackpoint_write(ps2dev, TP_DOUBLETAP, TP_DOUBL=
ETAP_ENABLE);
> > +             if (error)
> > +                     psmouse_warn(psmouse, "Failed to enable doubletap=
: %d\n", error);
> > +     }
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/tra=
ckpoint.h
> > index eb5412904fe0..3e03cdb39449 100644
> > --- a/drivers/input/mouse/trackpoint.h
> > +++ b/drivers/input/mouse/trackpoint.h
> > @@ -69,6 +69,8 @@
> >                                       /* (how hard it is to drag */
> >                                       /* with Z-axis pressed) */
> >
> > +#define TP_DOUBLETAP         0x58    /* TrackPoint doubletap register =
*/
> > +
> >  #define TP_MINDRAG           0x59    /* Minimum amount of force needed=
 */
> >                                       /* to trigger dragging */
> >
> > @@ -110,6 +112,9 @@
> >                                          external device will be forced=
 to 1 */
> >  #define TP_MASK_EXT_TAG                      0x04
> >
> > +/* Doubletap register values */
> > +#define TP_DOUBLETAP_ENABLE  0xFF    /* Enable value */
> > +#define TP_DOUBLETAP_DISABLE 0xFE    /* Disable value */
> >
> >  /* Power on Self Test Results */
> >  #define TP_POR_SUCCESS               0x3B
> >
>
> --
>  i.
>


--=20

Regards,

      Vishnu Sankar
