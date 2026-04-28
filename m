Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC907404E;
	Tue, 28 Apr 2026 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393667; cv=none; b=f9+ZEe7/EG7IfWJpyyq+hVvqJuPGznY3A4/Yj8sgJt5QnB1dY7a1E7QXNayvH2Knrf/rIx/J92v6hpZuq1eG97d9Ht40UxDv3FJQw3Bwp6obkUhV5H5Q5biy30Wfy9sn02lIykQ5r1TW4BsX2Enrs1S1djwGg+zlIy3W23ARISE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393667; c=relaxed/simple;
	bh=IX0xjSPa5chPjatm0KUQOsugANM6Rnw1bMCX4cNW/jU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=STEXo60dbY39Xf3cWfYzoz8lS4MMcfeNfat8CnyRmtY3RwKx2FLysJKLwnZJJfMJWLA3Nq60gi4TQ3Mpn/XnnRwe/sq1nZrOGsx0YNtS8gfFGWn6qaYYlzdUNQDVUE1TkokwsGlq3ShEw/jT2QUAVlQLKlq4XeCxs5v865uDyHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5cBSwdT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5cBSwdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A870C2BCAF;
	Tue, 28 Apr 2026 16:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393667;
	bh=IX0xjSPa5chPjatm0KUQOsugANM6Rnw1bMCX4cNW/jU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=n5cBSwdTZCZnAlwjHsvDZCvHY3GX94dG2tIZnrZ72G4P7e7d0BkC7LQLOAl0APXg8
	 Wi0b/Uh2f0tbog7pb97xHzu9yQNnFqvPsL3u2ZBwR9aY4LhSIYHt3/eai997BTp4ed
	 kzkoxIoHvPnGrD+YYQAJYhA7EWmrqWLfUXsf/nKOwE62+vnR9AfAjUlERw16w3yIry
	 eYqNzhKLKSYP12tIoTyErwL84xX7BIfEf7S1dpIu88LWqVglOxhDIEE5jCsqTfYEMK
	 +whFUi4KBGAdORE77mWth8CHFs2LYztYj12VeSe2wCKCNn7Anc4TMDOsywEJpBrV3B
	 VIW2y3zAKg8jQ==
Date: Tue, 28 Apr 2026 18:27:44 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: add missing size validation for SMK-Link
 remotes
In-Reply-To: <20260412010806.7997-2-rosalie@mailbox.org>
Message-ID: <5q421n02-q73r-2710-p454-53sppo68rn74@xreary.bet>
References: <20260412010806.7997-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 12 Apr 2026, Rosalie Wanders wrote:

> This commit adds the missing size validation for SMK-Link remotes in
> sony_raw_event(), this prevents a malicious device from allowing
> hid-sony to read out of bounds of the provided buffer.
> 
> I do not own these devices so the size check only forces that the buffer
> is large enough for nsg_mrxu_parse_report().

Applied to hid.git#for-7.1/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

