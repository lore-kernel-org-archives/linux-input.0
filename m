Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9864BEE53;
	Fri,  9 Oct 2026 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546581; cv=none; b=R4Slt9xHoXMK6sCsASp0LGMkFv0ZvS++5acncY5C7R6PK7zazrjYtFIgFSvvaDFSYWKbdXl03AmQ/yoefM6XnyrDStQj7Db7f8MmTK9tNxDQp+EQ2sYtR0JM1CUgX1Sp/Nwn9pZbBgmPpmOGi3antKblhlEqZgZd9f8LaAscZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546581; c=relaxed/simple;
	bh=qqpWBb6K0zxBB49oafd/WyrzEvAjnkElc6lknN10aDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/+QmwG92eBhVTr9O6ZrsXYUubR+RzCyejEKT/dN1eDw1WURrtn4eCfyrjY6V4YoNYts80Ic3zUgtZ0bOIq6Y3Oev1mWIZhbyayTAikP8AyXdegkb8AMy6oJBcL27bU5wQRibkphLFASRCO4g3ag69PYgeky3VWgHUhT3wMp7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlS+lTP+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlS+lTP+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE491F00898;
	Fri,  9 Oct 2026 11:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546572;
	bh=CIyXD8wTbt3nZtZ5v+UTmUyElDBfr2EMxvYLIBrKQjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dlS+lTP+H5P82dbQnhwsvIM7M2QtStqmsl4/8YzjCzNW6nLQ7fP8nsOklLjxqTKPQ
	 oYyz3qaFva9yrKND7feZiBP/cu35e6EXNoqOg83EZMKYRPDASNzelMKz9TAjAEs74k
	 N54vGN8f0Sml53COFVjxziwLs/b4+UrmgiGqtZv9XWp1UpiwBHSlhyLKS2FwbXAg2B
	 eQ30QhMBjz3D94amAxWAZER5pNcMRxma+o2rDxVog7tbwZgnDwzbeGTZRmqrRzVz4I
	 psXifW/L5Yt67dIraRL5PzgHqJEu2mfnWT3Yb7EqrVwNUn9vKkQO/31Fw3waw8y/XH
	 oK76Uv2O1NUrQ==
Date: Fri, 9 Oct 2026 12:49:25 +0100
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
Message-ID: <20261009114925.GB199624@google.com>
References: <CADrS85612m-Hh-G4BJmOhy-y6r3Ni3kD8_GM-2QRBeWWEEZWuA@mail.gmail.com>
 <CADrS857iYjafXEZcHRSmeOFjrzs0DYG5Dp2PeS0n669cHBjAuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADrS857iYjafXEZcHRSmeOFjrzs0DYG5Dp2PeS0n669cHBjAuQ@mail.gmail.com>

On Fri, 02 Oct 2026, Andrej Scek wrote:

> Update: this looks like it is caused by
> 
>   0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
> 
> which was backported to the 6.18.y and 6.19.y stable trees on 2026-04-11.
> 6.18.16 predates that backport and works; 6.19.12 and 7.2.8 contain it and
> fail. The AMD SFH sends 14-byte reports where the descriptor declares 15, and
> those are now rejected instead of zero-padded. (This corrects my earlier note
> that hid-core had no relevant changes; I had only checked v6.18..v6.19.)
> 
> The same symptom on another AMD SFH device (Legion Go S, "18 vs 14"):
> https://github.com/ublue-os/bazzite/issues/5796
> 
> So AMD SFH (hid-amdsfh 1022:0001) probably needs to be covered by whatever
> short-report quirk/fix is adopted for this.
> 
> #regzbot introduced: 0a3fe972a7cb

This is on my radar.  Leave it with me.

-- 
Lee Jones
