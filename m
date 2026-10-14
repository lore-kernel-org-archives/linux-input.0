Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5AE51DAE0;
	Wed, 14 Oct 2026 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985836; cv=none; b=Kv2DkYR+h+BKx9RQSYLgHA542FkUb6T3UWnA1Tw0eTJHZiR+pe86+9dpXCmRZexjjz6GjqJ0Ml1mC8StGq3pNrR+KyQtiSr31tWYlvnyOYMzFtQkQXS/da5WxIquvOoVMgZXDZxgtPonCXtpZPRes4Glw+SnyelmWon2QWh3cJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985836; c=relaxed/simple;
	bh=Y0kqPV4NiYR089LXFlLwFoO6+rgAl6iQg/PWOf98D8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHZS07XuoZxPbwdLETmn+vToqAtKrLIwwMxfnm7WcxVShlxzVedg4qNhDaICyvBvdGdDiO/eIhhvoBpOUVeecltEKpg3TZgrQxEtOFupfGNBFGX9XNE8c181RZb08oETp4J6eV2fL9Hjmyarq15aqdcqMxXPBoQv1PLgVs/oVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmF8M5Iu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmF8M5Iu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E8F1F00A2F;
	Wed, 14 Oct 2026 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791985835;
	bh=ORnKpIyYnrFI/qKTM3/A77hyoUOm6u+HVKEp2jC5Vj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CmF8M5IuT///GxMWFmO6dqezDSjFwisaPstXQlOLbKWbREN3vhhKtziKwzjY7bJmM
	 wVgIYTjDOEpd5vtwP3/eFm/GkgIGp1suSG64ulAGs2Y9OUnavWDA/WyYut005R7JnX
	 AZTQWqUq5wAKR+jvoaZoWlCni/Vfy8hYB/hycPBDL5XKq8tmiMShUcXkmrHyPBgWcE
	 9R7QvzQg9Q6lO6gNGhXy+9WzFVj2TwviSwkMPj8MuTI7puUyWEguIZfLcnP+IPJzgi
	 d+1aCeaiZKQBk9vg5cEGEGirjfI9+JskKMWRVRiq44K2dV1xz46uSs1I9xCT/vQ3gy
	 F7fL+oStrx7sA==
Date: Wed, 14 Oct 2026 14:50:30 +0100
From: Lee Jones <lee@kernel.org>
To: Andrej Scek <scek.andrej@gmail.com>
Cc: linux-input@vger.kernel.org,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	srinivas.pandruvada@linux.intel.com,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] amd_sfh: accelerometer broken since 6.19 ("Event
 data for report 1 was too short (15 vs 14)")
Message-ID: <20261014135030.GA839238@google.com>
References: <CADrS85612m-Hh-G4BJmOhy-y6r3Ni3kD8_GM-2QRBeWWEEZWuA@mail.gmail.com>
 <CADrS857iYjafXEZcHRSmeOFjrzs0DYG5Dp2PeS0n669cHBjAuQ@mail.gmail.com>
 <20261009114925.GB199624@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009114925.GB199624@google.com>

On Fri, 09 Oct 2026, Lee Jones wrote:

> On Fri, 02 Oct 2026, Andrej Scek wrote:
> 
> > Update: this looks like it is caused by
> > 
> >   0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> > 
> > which was backported to the 6.18.y and 6.19.y stable trees on 2026-04-11.
> > 6.18.16 predates that backport and works; 6.19.12 and 7.2.8 contain it and
> > fail. The AMD SFH sends 14-byte reports where the descriptor declares 15, and
> > those are now rejected instead of zero-padded. (This corrects my earlier note
> > that hid-core had no relevant changes; I had only checked v6.18..v6.19.)
> > 
> > The same symptom on another AMD SFH device (Legion Go S, "18 vs 14"):
> > https://github.com/ublue-os/bazzite/issues/5796
> > 
> > So AMD SFH (hid-amdsfh 1022:0001) probably needs to be covered by whatever
> > short-report quirk/fix is adopted for this.
> > 
> > #regzbot introduced: 0a3fe972a7cb
> 
> This is on my radar.  Leave it with me.

stable/linux-5.10.y:
59bfdb41a34c HID: pass the buffer size to hid_report_raw_event [5.10.259]
QUEUED: HID: core: introduce hid_safe_input_report()
QUEUED: HID: uhid: convert to hid_safe_input_report()

stable/linux-5.15.y:
a4d6cb7cf45b HID: pass the buffer size to hid_report_raw_event [5.15.210]
QUEUED: HID: core: introduce hid_safe_input_report()
QUEUED: HID: uhid: convert to hid_safe_input_report()

stable/linux-6.1.y:
121dc93ae1fc HID: pass the buffer size to hid_report_raw_event [6.1.176]
QUEUED: HID: core: introduce hid_safe_input_report()
QUEUED: HID: uhid: convert to hid_safe_input_report()

stable/linux-6.6.y:
9e36568e67f8 HID: pass the buffer size to hid_report_raw_event [6.6.143]
QUEUED: HID: core: introduce hid_safe_input_report()
QUEUED: HID: uhid: convert to hid_safe_input_report()

-- 
Lee Jones
