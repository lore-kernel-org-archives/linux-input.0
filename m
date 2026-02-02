Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D511367;
	Mon,  2 Feb 2026 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036507; cv=none; b=R70flT/tyHz5foPmyrGaIokOJSMQIwsdZLh+JIjiJTplHKfS0ikqzyETkemOTPC0FN556zhB/+MRoR+Ww2ZtiJoOa0AaFr6ynO15cVoCjIs0mRvB0tjj+jjljaLuyR/QmQ6Inej0acksRHLSD8EJzjftWj3iVaMMRPh9VwsrLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036507; c=relaxed/simple;
	bh=LogiOc69ECloWCenSTSmS/0lwD5Du5qslF5DbLWosVQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=a9fSkzXAA0SHY5rrVejaanWQi6WZZ20C0KX8+Fkkc08FpbSYRDa7c+9Ci0pvNhipcbC3Xm8/EegxghnxPJ2VHm0fsIAAsw8oVjts9mZ5R9PCsXMPhxSft3FuyT06LvBks56cyl/dffiG6Ee2f2CgqFPiKEiikC8IfrglQKps7kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPnZX7wp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPnZX7wp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83158C116C6;
	Mon,  2 Feb 2026 12:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770036506;
	bh=LogiOc69ECloWCenSTSmS/0lwD5Du5qslF5DbLWosVQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=fPnZX7wpmb7NqIa+iNxv9ZiuDsLRgmP0cZPQr8o6dQvGJU1huWwXsiWHHyf1yB88f
	 Ba8c6E7qZjm5Wj6d5ZpG+Cht56VL3O8J5pBZV19tNBoEMTtcbX1KqWdgMtg4BB3Pfr
	 7npTuFibSvrp+REIfRJmitpsQAmrBK06obgJis6JWubQCjeZY4XQPpLsOyydNRVJZp
	 v7ngWQ58+6ilr8Zz2IF5Dke+EMvk3+hucJVGeCpjWu299hd1/OZsFFTveGCeupCM1q
	 LYOjU+IDAr8McOJOTddfdEEG5Mk9x8dO0oJbNn/G6A6YLEefCfJvIXxeFFib1geDNA
	 Snut9aneKcpXw==
Date: Mon, 2 Feb 2026 13:48:24 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Bastien Nocera <hadess@hadess.net>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    "Peter F . Patel-Schneider" <pfpschneider@gmail.com>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: Add support for Logitech K980
In-Reply-To: <20260125121257.26508-1-hadess@hadess.net>
Message-ID: <075388n2-opps-nr27-14n1-4r4sq031011q@xreary.bet>
References: <20260125121257.26508-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 25 Jan 2026, Bastien Nocera wrote:

> Tested over Bluetooth.
> 
> Bastien Nocera (2):
>   HID: logitech-dj: Differentiate "invalid device index" error
>   HID: logitech-hidpp: Add support for Logitech K980

Applied, thanks a lot Bastien.

-- 
Jiri Kosina
SUSE Labs

