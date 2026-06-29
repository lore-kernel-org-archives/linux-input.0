Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9423B42F2;
	Mon, 29 Jun 2026 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724236; cv=none; b=c8USibNK4nrEd0R9rgxRUdRGd6v8rZhfIZ3q6D/76/VAPApLKUVVTRxfNfyvaoywlJX3V/gf1wauFvTU4DNV8sOmyCGXo8yVzRDTJfK7VoXUxmAbGS04Pso6hexWFegH+lVrD1afRwQt+d6FZBWQ5slB/eYGBtj2hstqjeSoffI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724236; c=relaxed/simple;
	bh=UhrzLcmun+fL6n4r0clSZUiw3f45Kxt0VvTOhyr8oQ4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HZZTX9X8cej6keI7+3igcJaT7Tgk8PysNKqkg1N/9FhFJF9oI+VNWWp7J4q40PtjvpJYhOn1vpemZjAyBnD0vFNsD/odUXPkmp8fejSih5zoY/nLD1gAu/gvJRsT7cCST4YmngszaHLzcq+fWzAaZThJLJHbIIZVeBL2TgsjE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQmFCki9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQmFCki9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F151F000E9;
	Mon, 29 Jun 2026 09:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782724234;
	bh=GNioUB/vnjxgNPqbPoa00YVnJcMk+x8Ql/C9VsYs7f0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=UQmFCki9fuMkxEmyJA93jW3+OVbvQw1tr+z7XnicoPPOvHnVPJhHC6OSlHdGVf7Kk
	 vAN7h/jQohsTkN+0HcbUcF5ftCo6GkzXL58z1PFkPk+zi8eT8uYojp7DT9eWYtgJHc
	 EQl4ldK4g7tAvkYyDhaPTk+wHpktWEeXFIMN1kFnFpz5joV8UhyWOwtgzsbWWAaQAO
	 wUD+3SHIgigA6VSAOP7L8p71IvEsmchnSZWeZKR7bu/rhM5l51aq4W9KeFAAfYEEqp
	 ++EASYg0lnHkPgdUFMemEOPKwlpyTech9agMg755FrmpK1Hw2qRSNe8BFgOkgfB7kN
	 mJ5X3ozUZzXtA==
Date: Mon, 29 Jun 2026 11:10:32 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Lee Jones <lee@kernel.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, Johan Hovold <johan@kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: core: Fix OOB read in hid_get_report for numbered
 reports
In-Reply-To: <20260616112700.1990813-1-lee@kernel.org>
Message-ID: <14s73q1q-nq76-84nq-8s7s-03986056q620@xreary.bet>
References: <20260616112700.1990813-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 16 Jun 2026, Lee Jones wrote:

> When a caller passes a size of 0 to hid_report_raw_event() for a
> numbered report, the function originally called hid_get_report() before
> performing any size validation.
> 
> Inside hid_get_report(), if the report is numbered (report_enum->numbered
> is true), it unconditionally dereferences data[0] to extract the report ID.
> With a size of 0, this results in an out-of-bounds read or kernel panic.
> 
> Fix this by moving the numbered report size validation check before the
> call to hid_get_report(), ensuring that size is at least 1 before
> dereferencing the data pointer.
> 
> Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

