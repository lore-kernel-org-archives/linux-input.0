Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7678A3DE431;
	Thu,  9 Apr 2026 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749985; cv=none; b=nprNhlhrvGxoUPzbzDVmXv7XAmrEqxxbAW3+1FEyqUJyHMQyNP5L1XlhtVnjrZ3k/g4SSayoOjpVsFcjI1JIyq4ZFji+t70qXwlIhWUjHspQ+Qatc6BHGGaLl/8Sie109XZtnOjqq4uMYKYFMLbb7ReViz6HrP/wCgg8hRgn70s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749985; c=relaxed/simple;
	bh=68t7NfKEzI5KfVOZlzjBmiQKi5qhdL7t+HsfNwYf72Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bxJJHAb9COgmnerGzZMG7o5juJjn8SVSHjrV0x7npR/qSq+FOMRa/MNbySifdLfGzgJhicFaoQN+7qRULlXcDSrM+6dp4kmrVdl7htchwOWaBb3dYO3Mljz5hdOc9Mdvk6rFBFl4pmkIHcuARt4Hm2LnxaLWplw3kyztXaMKA6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBcFcPFS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBcFcPFS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D5EC4CEF7;
	Thu,  9 Apr 2026 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775749985;
	bh=68t7NfKEzI5KfVOZlzjBmiQKi5qhdL7t+HsfNwYf72Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=SBcFcPFSJAS/AhLjxhw5pGe2B7CDFxGYpPfMDphK3U8fdY9xGEY2AplJkmgszwp18
	 BRiFfQzYknlB+Sjohw97nk/d+yKf7fHSHaP3ujflbyDcRn286QyoiLpp1Zxy/bkP3a
	 aH+iPZMF2l+eMM8OBhR0xS5UQjfN68P6b+tjOZe1aDTKWaAnI6Zys7BrSYukRIIw4/
	 McDKlaco3VQgnQ+rdiNsWC4uFdtPnDOBwXcfYliTeKlyNvF0mw2L344lWSVPD+gZHT
	 JXrxnVB7z5QC23Zj3f/TqShXE2zW/+uezl12VI5+28bDlKq5EuD1Wxd47mA5Yd7OtI
	 nQsKGyCWiFKQA==
Date: Thu, 9 Apr 2026 17:53:02 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: drop 'default !EXPERT' from tristate symbols
In-Reply-To: <20260321-hid-expert-v1-1-4a6d81b4f3ac@weissschuh.net>
Message-ID: <6s0opppn-qs87-590n-1121-1qonp84so45n@xreary.bet>
References: <20260321-hid-expert-v1-1-4a6d81b4f3ac@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 21 Mar 2026, Thomas Wei=DFschuh wrote:

> There is no reason to build random drivers for obscure hardware into the
> core kernel by default.

This is from the time when invididual drivers have been extracted from=20
monolithing hid.o, and there was a general fear that it would cause=20
regressions for people, because the generic driver wouldn't work any more=
=20
and they'd have to look for fixing that by enabling particular driver.

That ship has sailed ages ago though, so I agree we could just remove it.

> The usages of 'default !EXPERT' for the HID_PICOLCD suboptions are kept,
> as these make some sense, although they probably should use 'default y'.

There are very few fans of 'default y' :)

Thanks,

--=20
Jiri Kosina
SUSE Labs

