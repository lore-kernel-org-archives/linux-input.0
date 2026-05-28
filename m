Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08190314D18;
	Thu, 28 May 2026 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779984032; cv=none; b=TmnSKFnGELbyPDuf8xqTS5WubswRl/qMjuZAzDthRTDxFbx7LiLgiIn2nsaBEY2A9GMnUVQO1Xa7ZVb8tcvxfHltjJ5WXNmuyWNgmOUTOIZCypSvmzStoev4WkgePqj91/XXUEixW53hL2oiN7/HiQoLgCaBtNhYwqXMETr7Zgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779984032; c=relaxed/simple;
	bh=XjdpM+bEMIbxnFJ7na27MmOIkGmRde8DJAxsshmsW5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oodCml4z5d9hD24MBiY2bfT4OZ5tkWvhcDhU1C169AvJuCvLSbogiiE2FpewfbHkoCo5DqbH2eZLgjpr9mZwskyh6szr9sG1kqdjUxIud6ZGHPtQHTjV+u3lYmiUxbRvdY0nB8HPkaCnrZYvQN7WSY/oLoG0IPhq+KwWmP/uGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReXQo8mm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReXQo8mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EE01F000E9;
	Thu, 28 May 2026 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779984030;
	bh=b4g7bkHPpBLS0vV/m1nqDB5IvndzDAVT5VIv6F0KbqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ReXQo8mmXW45dc6JTBAu+ohgnUw966891SBEMCLvNZ81Zwu9+t97I2qalD2ZuSFWg
	 PjRdtYHW1cXKuOUP2P+y9URb/BX607f5T97ggIMKZLJbHdueY6z1JS0hNpjwZSjuqM
	 lkZCw/3sj/ochT2RcSZg2Yrrkoho/hZwooSi/rzRWeE3+YI1dwNNWNgfywjNgC+ksg
	 7z12R3jQR5FH3Digkzo93ysYDWdMRd4Ad3yvbPv9HUZWorViKFCRbnnxhiXqffRPR2
	 Jxt6z6rmNRUVeBMy7h6Po8M9GJBjstLac2UTwacs6lKLVDCPbKK20yKWFeaQbIrqzP
	 y9rzS7prqMZaA==
Date: Thu, 28 May 2026 18:00:26 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Cc: Jiri Kosina <jikos@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>, "Christian A. Ehrhardt" <lk@c--e.de>
Subject: Re: [PATCH 00/11] HID: storing pointers in
 'hid_device_id::driver_data'
Message-ID: <ahhjTbG0Ye-mP9WY@beelink>
References: <20260518-mod-devicetable-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk>
 <ag8bARsGNVqA8xbQ@beelink>
 <ahBgYbMWR4VwFAy3@commodore64>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahBgYbMWR4VwFAy3@commodore64>

On May 22 2026, Pawel Zalewski wrote:
> > I would agree with sashiko that the series introduces an anti-pattern by
> > allowing .driver_data to be an arbitrary pointer. The reason is that we
> > can dynamically set driver_data through the kernel command line, and
> > when it's used as a pointer, bad things will happen.
> 
> I have not considered the command line override ! This indeed would not
> be a good case for having a pointer at all in there - in the current
> form of the codebase.
> 
> The series does not introduce this anti-pattern - this is already the
> current status quo in the codebase and�the problem predates the patch
> series itself. The series makes the problem more visible and validates
> the existing status quo - agreed on this.

Oh, yes sure. But the series makes the anti-pattern official, which
would encourage people to use it. (we are saying the same thing).

> 
> > I would think we should fix the 2 offenders to enforce not using a
> > direct pointer but an offset in a table of pointers.
> >
> > How does that sound for you?
> 
> That could work, probably via a named enum (so that the idx is bounded
> and validated to avoid out of bounds memory access) with its items mapped
> into a table of const pointers. That way the command line override still
> works as before and my goals set out in the series are met as well.
> 
> Perhaps an alternative solution would be to sanitize the user-input instead in
> the 'hid-core::new_id_store' function, such that only 'driver_data' values
> that match an existing entry in the driver's 'id_table' are accepted, this
> is how it is done currently in the PCI subsystem in 'pci-driver::new_id_store',
> so it would be consistent as well.
> 
> The bonus here is that all other drivers in the  HID subsystem benefit from
> this aproach as opposed to just the two current offenders, as providing
> 'driver_data' from the command line is now mandatory and must match the
> existing table entry - which is what we want ?
> 
> So something among the lines of:
> 
> @hid-core::new_id_store
> 
> ```
> struct hid_driver *hdrv = to_hid_driver(drv);
> const struct hid_device_id *ids = hdrv->id_table;
> 
> (...)
> 
> /* Only accept driver_data values that match an existing id_table
>     entry */
> if (ids) {
>         ret = -EINVAL;
>         while (ids->vendor || ids->product) {
>                 if (driver_data == ids->driver_data) {
>                         ret = 0;
>                         break;
>                 }
>                 ids++;
>         }
>         if (ret)        /* No match */
>                 return ret;
> }
> ```
> 
> Would that approach work for you ?

Yes, sanityzing the input seems like a good idea.

> Do help in what is the correct
> termination for the while loop - for this demo I went with 'ids->vendor'
> and 'ids->product' fields as common-sense would indicate that quirks need
> to be device-specific by definition but that was without any actual research.

hid-core.c does:

const struct hid_device_id *hid_match_id(const struct hid_device *hdev,
		const struct hid_device_id *id)
{
	for (; id->bus; id++)
		if (hid_match_one_id(hdev, id))
			return id;

	return NULL;
}

So I guess you can simply rely on id-bus being set.

> 
> The downside is that 'new_id' drivers that actually use a pointer for the
> 'driver_data' will be rejected - which would be actually covered by the
> solution that you have proposed in the first place. To think of it the
> input sanitizer could work additionaly in tandem with the enum-based
> solution if this fact is an issue, so it might not be an alternative
> actually but a complement for it.

Agree, we need both.

> 
> In the meantime I think that patches 1-8 can be reviewed regardless
> without any changes (as they predate patch 9 that adds the union and the
> commit messages does not mention anything about it).

I'd drop patches 1-4. I don't see the point of just rewriting the list
of hid_device_id if we ensure we have just one type.

I need to have a closer look at 5-8 TBH.

Cheers,
Benjamin

> 
> Best regards,
> Pawel
> 
> 
