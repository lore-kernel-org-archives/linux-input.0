Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC02DF13B;
	Fri, 12 Jun 2026 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781299831; cv=none; b=ZwdaXguCTGX5cXxNHwTMS80PX+T6L9gmp0UkiJNfsIZf71vNA8x9FLJlsFrefi2CuPkVFVfRA+kubEZZWFEwy+IxpXJbiM1pRmbn3xe5mRL8Luj7Xd3gEJ6QcVbOHOkxueVb6+JAaeYTOvr38Hm94xTKPmqIwYR2+5wCm+CzQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781299831; c=relaxed/simple;
	bh=rU7DUEgzbug/5oBFy3tWbXQ8oSj+UcUEMuSulc14Rj8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ASKJsZBV4ZsV4pY6siFVAVZr8uoWLk7YB0jGjj3EIfCs27fbcmLXqXBxONjf6BkS49kTzvbTzQKAHtkdM2Uyl/bjAVGiTq3au6pomKc5UFnupGFGM1fvJqj4cAmQnFfWdtA6g5V7Tnw3Wt6YqYyo3DSoZGneS6vgvgEof66PN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+b0CbYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+b0CbYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9001F000E9;
	Fri, 12 Jun 2026 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781299830;
	bh=1vG2nnxIK64uLO2wl+h9IAs9tW1pCIi+q6hAfF4ZM88=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=S+b0CbYoD+twtxu6xIpplVT63zU+OGuczQXnXleW1//c8lFA+Q97knwBYZqYKQl0V
	 KnT/RtpR3COMCwA4NpOc6K6A3VsRHIJTlJLNPqFCBjhCuqU6uVGGV/yxiaGVDPLqXD
	 41j6J8Tpr0dPOdap8w1WmbZs6LwOHfacXB2AAlo6FCBnml1iXKBLIamAlCq4dStIxi
	 aDpVMu2QOT68hQ27TPJQT3EuucMs2eVhguECmvUvtlMEkaUYvEVQGlPocu+DjYUrTd
	 aXMNY0bYF/hZRGkJi4+m/LLa32uZEF09c0zjAKwhW3Z4vEgMzjaqCaloKTaL5KQd3z
	 I3LIsIyDaFqmw==
Date: Fri, 12 Jun 2026 23:30:27 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: sashiko-reviews@lists.linux.dev
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
    Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH] HID: hidpp: fix potential UAF in hidpp_connect_event()
In-Reply-To: <20260612160404.1E45A1F00ACA@smtp.kernel.org>
Message-ID: <rq62o7s8-sq9s-o9p2-2471-q081493qs989@xreary.bet>
References: <r7qq6043-p432-51o0-3s93-r9382q44n027@xreary.bet> <20260612160404.1E45A1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Jun 2026, sashiko-bot@kernel.org wrote:

> Because hidpp_connect_event() runs asynchronously in a workqueue, incoming
> HID reports can be processed concurrently by hidpp_raw_event() in
> interrupt context. 

This is good point. I will send a v2.

-- 
Jiri Kosina
SUSE Labs

