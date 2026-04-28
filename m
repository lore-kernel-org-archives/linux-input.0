Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F132D5432;
	Tue, 28 Apr 2026 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393763; cv=none; b=m3f0bXyMW6LHMOSKXcKaKsGlrg8bMlTaO7RDnBXWT7Db8jias/KzQphvwYbeqG9D2nsM2s8e/p5wQJ17GJiI/jt2KnOet4iuNUefHh7qTFaah+AwXvNtHGIY7bw7EsSwOT0arW59lzlFSpTJ5rcPiN/m8X7yxRofIZpaRgfWme4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393763; c=relaxed/simple;
	bh=bFdD4mwY0HKU3s9SpjGJ0sFTuP0rfvUyepneJER30BI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WGCf26KMAYcYBQy30dkCDj7yuj6PqTJ0EGJfO0xgFjCw3UxPRjcN0225wnMtTLxytyXZ8XEIw4uI1eSAgepsIxswwfwKHndnBV2ImegDoir2l4M4fpNZ7JQhE8a8RIzHSbrFb/74CtgnWpuYjnuR2Pu91X1h8ZnUb1dGo+e2dBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msxWG1RS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msxWG1RS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445D4C2BCAF;
	Tue, 28 Apr 2026 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393762;
	bh=bFdD4mwY0HKU3s9SpjGJ0sFTuP0rfvUyepneJER30BI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=msxWG1RSF4Hq9yM3veupc8oYPTyGL6+mAC81pzHDjO0O43WZaECVZsFFfJyCZQQ1T
	 Bwb7ahyuF4IR1XJ2O630iBtMonAJW1EFJitM4nvu3MJlpZi1MtR7d/H85nFXaP085c
	 hEvc05DOvvqjE+NNfFo3tiPHmUhQOcAalQbw3+U4R9UvcmTFetSRSDdn9B2ra/ROHc
	 ZssQ/uxomFXzQlN+UhEjgF4i/hSGZ+2a68QCsxISkbFgiQzpnX3pcFsmeqtS6Y64rP
	 NMQGrp9av9ru6H4suMWsUTpCboOoySIc6fTV/Vmub98khgYJqWsIyTwa/jPJ9U2xsb
	 ivi/aVlXbY6+A==
Date: Tue, 28 Apr 2026 18:29:20 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: add missing size validation for Rock Band 3
 Pro instruments
In-Reply-To: <20260412011203.8921-1-rosalie@mailbox.org>
Message-ID: <5so4r8o2-o0o3-1n9o-2848-qn8977pp8221@xreary.bet>
References: <20260412011203.8921-1-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 12 Apr 2026, Rosalie Wanders wrote:

> This commit adds the missing size validation for Rock Band 3 PS3 Pro
> instruments in sony_raw_event(), this prevents a malicious device from
> allowing hid-sony to read out of bounds of the provided buffer.

Applied to hid.git#for-7.1/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

