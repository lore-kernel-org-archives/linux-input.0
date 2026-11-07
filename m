Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.247.164.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794066774;
	b=Ncea9tGsAU+yybCowRKautTb2x03/PpY+AK5GEIgksfosQ8kqHeJYq3T7SzQBjqPt6Hp
	 iveo36ORq/hmwdPNiBpbMixudAIcF1XIsRM1uy4nK/3bk9W+35oFYHtlbpnwxw8eHosWb
	 mVfPR7wixRmda6rc/Cgup43yMj2EA8QrYXfJej4weLunkGFbu6nUCBNrCmD4XkamhOSEW
	 jVLrktsUSnL+ZpAS5Q7vvhwkWbZ5VETbSVIu0dKLp9I0hUM5gmWdXQ7umIKMRkOKVu+H4
	 o9m9SHnUvueCpOOOkCu//j244frsMeuv2BahRzzwrTvhj/dO+/I9C1A+J5kgN3y68xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794066774;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Last-TLS-Session-Version;
	bh=xQC6OT9roe3RlncS9kE0WNNuJ+HW68U46WHqq1DoEUc=;
	b=a7o47mgJkcQnrufuy3NTqZdhX5copuZlTWjQxZsW49xn80zRtbWmnBGQyoTefHbLy6bY
	 Q8xrkfFlbEVmsw/Blopb6yko3KHXhRVCMPuczQp4eFX7ejBFj3Wplq0exlfZZWwB81KQg
	 B7WUoSFiw5n0CfeQFL8EPnBbdN77XCdVqjSEUQBS9ia1M7lKaQWdLJYhJEWSq/KVPLh21
	 mL32uVQFWPVpHxSKZUtBvvgb3yUx9HJpHj8BbmA8Cq/pXiwPowtbs/G+T8l1dlhhHteep
	 c4GXzaEjI2j5baXB/CS3IcqUCSXNibzoc0Vgrb7WTEWEnmKXSdVycNQj8z6PPmrQ1XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=koesling.info;
	spf=none smtp.mailfrom=koesling.info;
	dkim=pass header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=pX44pzpU;
	arc=none smtp.remote-ip=84.247.164.36
Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10513606A32D;
	Sat,  7 Nov 2026 15:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10513606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=pX44pzpU
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7BDDF1320F84;
	Sat, 07 Nov 2026 16:52:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1794066763;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xQC6OT9roe3RlncS9kE0WNNuJ+HW68U46WHqq1DoEUc=;
	b=pX44pzpUfipvYtAOsEhGIZXGM4PGkGnB+kr74dBLrnqEhulTjwQjc+kYVwXDRqi5uEYmfa
	5u/lh50edN9lpeUd+gVcfXbN5nToAx0UXdHjRZaJXOsya5ooU0HM6251fu6qYgHCJbDlFU
	7Ywk9hERJGUbtO6MDgauG+1YP20LIJBRuc1N+Rjg7rT3/e9iCWNrmh9V2X2vhQFDYDPDKa
	UGgEKblvhXjgbVZ9mw8TSJZ4dgicUxAv14jTWmWtw0KNR2qXYQhBIn8tVtMzMO6w5ofoDP
	9gInE/87ppKgN0fV5JtoMLZzYL/wNc7umcuQrAaDH+NDKC/TObFMsP5iavK+yQ==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Aryan Sinha <sinha.aryan03@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aryan Sinha <sinha.aryan03@gmail.com>
Subject: Re: [PATCH v2] HID: pulsar: print errors with %pe
Date: Sat, 07 Nov 2026 16:52:41 +0100
Message-ID: <_CWnjz-KRgGiytw170VmPw@koesling.info>
In-Reply-To: <20261106083419.29334-1-sinha.aryan03@gmail.com>
References: <20261106083419.29334-1-sinha.aryan03@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

> %pe prints the symbolic errno, which is easier to read in a log than the
> raw number. Convert every print in the driver that logs an errno so they
> all report the same way.
> 
> The prints that log data bytes, battery readings or a byte count are left
> on %d, those are not error values.
> 
> v2:
>   - convert the remaining errno prints too, not just the battery one
> 

The changelog should go below the "---" line so it doesn't end up in
the commit message.

The code changes look good to me.

Thanks,                                                                                                                                                                                                                          
Nikolas



