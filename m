Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4D35CB63;
	Mon,  2 Feb 2026 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770039343; cv=none; b=P4kCqH/SU6FudyfV7zTh0r7/nZrFbdXUFGd00EiuXMeL6Ogkw2kiarll//j2wgBN4J4qzIIzpLoPv3bI5Qetd//TFQnSVvbAiu4jZwfZ9dDkMuDkHqvc7t7cHs36k5n+3eCQOOQHXK9FBegNO3DJNA2In00CIHaG/FP8d8UkPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770039343; c=relaxed/simple;
	bh=sVUgg7BRCytG43+95HkOIckiNhN/382D9rwLHL1rJIo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CzVZos+rMueb/a5aEPOGmMEY8xiU3Fjxp0gnTVvY4/F0C44T6HWavsKWds8k8R79lRM+QGPGH9eFOpiOw7tvO/m8qT/2bCgaEwRJXRXiVjC+pRCBPjAxVo+7F4OFS8ALnzJ0xu3hv31AIeLgxrpWFfkGU1NQGM0I9ifnP4JfWWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEwrvric; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEwrvric"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE176C19421;
	Mon,  2 Feb 2026 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770039343;
	bh=sVUgg7BRCytG43+95HkOIckiNhN/382D9rwLHL1rJIo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=iEwrvricF0DJM6JdT4Et1FFyGPJhwQwA1603MX/PGIj/qd++E/EcN+xXfOZ3Z81cz
	 J28picsx7mwrfHLY0bILZ474ckCWDBrs+O/BQDLclpgbvFLq5VnTOWbI+Rva3LH2RA
	 gRNhtoguctTUYHK0JAjEnJFykJ+pDXSGYZaZgvUys9MiOYMWKM3VM3LHn4NxWWwGq4
	 3PcgO8zpqauC34LkxV/4uPdJrhxkgUyMdjoWfXJzKabpaz5AmciDCmZrXDw2KHFzUR
	 zVzqJBwuo1/wY8VZWXamhdLAdKIJ3DmjcLhrGDYn93FxWT2RKsGDMp5TJ79GN9CsX1
	 ma/osgpyO4TWQ==
Date: Mon, 2 Feb 2026 14:35:40 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: add second device IDs to CRKD Gibson SG
In-Reply-To: <20260129071227.5533-1-rosalie@mailbox.org>
Message-ID: <q35o73pq-r722-rp5r-o72p-q419no65840q@xreary.bet>
References: <20260129071227.5533-1-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 Jan 2026, Rosalie Wanders wrote:

> CRKD changed the product IDs in a firmware revision, yet the dongle
> doesn't have these ID changes included yet but will have them included
> in a future firmware revision.
> 
> CRKD also doesn't allow the firmware to be updated on Linux so having
> both the old and new product IDs is necessary.
> 
> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>

I've added

	Fixes: bbf992775faa66d6c9 ("HID: sony: add support for Rock Band 4 PS4 and PS5 guitars")

and applied, thanks.

-- 
Jiri Kosina
SUSE Labs

