Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BB3A3838;
	Wed,  8 Apr 2026 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687143; cv=none; b=CFwdjvoLX0Z/l//5eDypyaa1zDe2vWszjt/PvbPIcJp43vy0OzuR2NJi1oXQDS2evUkiq8TSg0AHwnRmySkDVm2GRDlQgec0dDlaElwHg41dulgjv4gEJheN4xHIE9MSyREMSBV1kWy/6v+GVXBly/deVAkEas8Pvl/xS2/63nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687143; c=relaxed/simple;
	bh=hZt+wqMKpMBPgil4InK03dCInyT+1C7gGrlGgS0bASk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ktA+GF7ik786OKuEMjo39H5KsaH5DhR6gk/s+Cps/0mPt/WvCikLjgeW4ZmxtP2iWzFfqF+m487s7q0LqPnWXSTbigIy/0mk4wFOFNSguvsGEmDYzfwbIf506g4sRKQppvidpngqDVtYTim1BOqP7xEBC2Mj7sseHwHfo5nk9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7k9ZqIC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7k9ZqIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757E8C19421;
	Wed,  8 Apr 2026 22:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775687142;
	bh=hZt+wqMKpMBPgil4InK03dCInyT+1C7gGrlGgS0bASk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=O7k9ZqICnefW+7lfJnL3r9CWZ9JfHBWRgjGMGQ+rMlcvXGO7v7fLUFShbSwswng58
	 R+T/hzChxH11F/+Xq9Jb2Sp3/ToPouu/2PmD52/UQub3QvgsuISTp9B2YwvwGy6Ulu
	 LX5dMCpqR1YgnBfIgTd5s+0/4Ubk3B3YHgbkOQTVbUH/Ea7hgWX+alQKm+vDXY4+nl
	 jJdtKcr5ps5KNK1nb+5EBTjOhnx2MEPHH3zPWfMXdbktDThLo9UIhvPHzHndfGRU5t
	 vK9rQqpZjyJeG0EpLwYg9XMplrKc0KhUF5Lnrgg93DdRnKBWN014KB9187I+qtI3Dt
	 +k/nUMUuhmlAw==
Date: Thu, 9 Apr 2026 00:25:40 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: utzcoz <utzcoz@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: apple: Add Niz keyboard dongle to non-apple keyboards
 list
In-Reply-To: <20260403161806.31908-1-utzcoz@gmail.com>
Message-ID: <0rqo1ors-45s9-n22r-6qss-2q3q96n5r6rr@xreary.bet>
References: <20260403161806.31908-1-utzcoz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 4 Apr 2026, utzcoz wrote:

> Niz X99 uses a 2.4GHz wireless dongle (Milsky LL Dongle) that
> reports Apple's vendor and product IDs (05ac:0220), causing
> hid-apple to apply Apple function key translation. Since the
> dongle has no Apple Fn key, F1-F12 become unreachable when fnmode
> defaults to media-first behavior.
> 
> Add the Milsky LL Dongle to the non_apple_keyboards list so that
> fnmode=3 (auto) correctly resolves to fnmode=2, making F1-F12 work
> as standard function keys.
> 
> Signed-off-by: utzcoz <utzcoz@gmail.com>

Thanks a lot for the patches.

I know that the kernel documentation is now a little bit more liberal 
about not having to use real names, but "well established identities" 
being fine, but stil ... would you mind submitting this under some more 
comprehensible authorship? (anonymous submissions are still not allowed, 
BTW).

utzcoz doesn't really sound too well established identity to me, 
unfortunately ... if it is, I'd be happy to stay corrected.

Thanks again,

-- 
Jiri Kosina
SUSE Labs

