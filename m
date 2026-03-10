Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFC43C049;
	Tue, 10 Mar 2026 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134140; cv=none; b=GnZ8mIJnmyWMV+S5r27T1UKp83E9fKNkCvf82Pw2lBVokvS6ycRBipSrFcdu2hC7muMW51MXSo9Sc8goQJtOLbg7QG2xnEwvdAytRX1ZKyXwhUGNSuf6bztGOg5CULm7rRcyofTV91qk6xnv89DR5q+AQGmIkuRBQBR/V/RlmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134140; c=relaxed/simple;
	bh=SAeZvPvgL/l1J7WIDXWmdSURQ+bZQ8pCkXykeIkCEJY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DQof9/+q0z9PCzFHG/miw5OqW5hvp2vnEtT8+P39JCbk7AKm3uxwsU4MBZKQlbr3ugX6MmhtrfNP9u+Kn+mpLTtB/I/COALxK5FF2cjeLHppzrUHBnIy/E6IUNaLuB3aTAKJhqTIDvHipT3R+1tXd4DAPmE+2jrQDaIVBb6f3pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5l+f/X+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5l+f/X+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773134139; x=1804670139;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SAeZvPvgL/l1J7WIDXWmdSURQ+bZQ8pCkXykeIkCEJY=;
  b=N5l+f/X+Iru+1MhXdrykRUB+RCHKk6hmbHEuuiYItvgIF+PTw5TV4uGj
   /dAP+X9tED+zT9ZgdKyRgTUn859i6uk4IYqBIIshi/LG3eSKcHJwZ/jMA
   0z2gRXs0vZkn1WMS1Ev77JkMeqgB+uA4svBtNwnuQCSpzhzRAtnUJ9X83
   sr0gIpOSZ4p61KTjRAN0pIX2awjV3ulqSEvlhviG1m4E5f+/OG/rVjaf7
   WzdwTgARYDe3JXxrVO1Pax+29q7tOHhoePvYiGHuQg62OddSGiRRS3HP7
   87HStaRhx5JJWJLgxDiwDktHw+O+3ley6iytaCo8zNmkWXNIy2EYLI3Gg
   A==;
X-CSE-ConnectionGUID: FoGkEe3bQ9e609Hhq/cKjA==
X-CSE-MsgGUID: DiwifDX/Q7Wx6d5nkVDTAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74051729"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74051729"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 02:15:38 -0700
X-CSE-ConnectionGUID: NZJ7bzEwTg6RTMTvcDZdFg==
X-CSE-MsgGUID: up21uw+XR9mnS4JZm760Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="216854330"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 02:15:34 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Mar 2026 11:15:31 +0200 (EET)
To: Vishnu Sankar <vishnuocv@gmail.com>
cc: Mark Pearson <mpearson-lenovo@squebb.ca>, dmitry.torokhov@gmail.com, 
    hmh@hmh.eng.br, Hans de Goede <hansg@kernel.org>, corbet@lwn.net, 
    derekjohn.clark@gmail.com, linux-input@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, 
    linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    vsankar@lenovo.com
Subject: Re: [PATCH v7 1/3] input: trackpoint - Enable doubletap by default
 on capable devices
In-Reply-To: <CABxCQKtf=RYrpgnbM0ODo3GA0oW3jgR=_erc9RCD6gEasasA+A@mail.gmail.com>
Message-ID: <0df2daf8-31ee-4fe3-fc38-de138b302549@linux.intel.com>
References: <20260209063355.491189-1-vishnuocv@gmail.com> <20260209063355.491189-2-vishnuocv@gmail.com> <fdd1d48e-61b7-2543-8a30-c7ad416f5dd3@linux.intel.com> <CABxCQKtf=RYrpgnbM0ODo3GA0oW3jgR=_erc9RCD6gEasasA+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1789825462-1773134131=:975"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1789825462-1773134131=:975
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 10 Mar 2026, Vishnu Sankar wrote:

> Hi Ilpo,
>=20
> Thank you so much for the review.
>=20
> On Mon, Mar 9, 2026 at 5:01=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Mon, 9 Feb 2026, Vishnu Sankar wrote:
> >
> > > Enable doubletap functionality by default on TrackPoint devices that
> > > support it. The feature is detected using firmware ID pattern matchin=
g
> > > (PNP: LEN03xxx) with a deny list of incompatible devices.
> > >
> > > This provides immediate doubletap functionality without requiring
> > > userspace configuration. The hardware is enabled during device
> > > detection, while event filtering continues to be handled by the
> > > thinkpad_acpi driver as before.
> > >
> > > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > > Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > ---
> > > Changes in v7:
> > > - Removed unwanted comments
> > > - Removed psmouse_info ()
> > >
> > > Changes in v6:
> > > - No Changes
> > >
> > > Changes in v5:
> > > - Renamed function to trackpoint_is_dt_capable()
> > > - Simplified string comparison without sscanf()
> > > - Removed wrapper function as suggested
> > > - Fixed missing period in comment
> > >
> > > Changes in v4:
> > > - Simplified approach: removed all sysfs attributes and user interfac=
e
> > > - Enable doubletap by default during device detection
> > > - Removed global variables and complex attribute infrastructure
> > > - Uses minimal firmware ID detection with deny list
> > > - Follows KISS principle as suggested by reviewers
> > >
> > > Changes in v3:
> > > - No changes
> > >
> > > Changes in v2:
> > > - Improve commit messages
> > > - Sysfs attributes moved to trackpoint.c
> > > - Removed unnecessary comments
> > > - Removed unnecessary debug messages
> > > - Using strstarts() instead of strcmp()
> > > - is_trackpoint_dt_capable() modified
> > > - Removed _BIT suffix and used BIT() define
> > > - Reverse the trackpoint_doubletap_status() logic to return error fir=
st
> > > - Removed export functions as a result of the design change
> > > - Changed trackpoint_dev->psmouse to parent_psmouse
> > > - The path of trackpoint.h is not changed
> > > ---
> > >  drivers/input/mouse/trackpoint.c | 45 ++++++++++++++++++++++++++++++=
++
> > >  drivers/input/mouse/trackpoint.h |  5 ++++
> > >  2 files changed, 50 insertions(+)
> > >

> > > diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/t=
rackpoint.c
> > > index 5f6643b69a2c..e12d76350252 100644
> > > --- a/drivers/input/mouse/trackpoint.c
> > > +++ b/drivers/input/mouse/trackpoint.c

> > > +     /* Must start with "PNP: LEN03" */
> > > +     if (!strstarts(pnp_id, "PNP: LEN03"))
> >
> > Missing include.
>
> Sorry, I am a bit confused here:
> strstarts() is already available through the existing
> #include <linux/string.h> in thinkpad_acpi.c.
>=20
> Do you think I should do anything else here?

Yes.

The file you're modifying in this patch is trackpoint.c which doesn't=20
have that include so please add it also there. :-)

--=20
 i.

--8323328-1789825462-1773134131=:975--
