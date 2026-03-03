Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97326D4F9;
	Tue,  3 Mar 2026 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573247; cv=none; b=Z+Tnx/fM+HjzXmkBkT81B+elZoPp9LXQki55kgnn5A9wPS/4Ia3VDMdLxjui2lKNY3g0cMfBviI/ec/8fe5bm1pIGHfoYdc6XkZY+aa4Wn0k9ROh9lN665nifeSSLyTrD2kz6HBzhLo7s2NNH4y2MxckKNHgeCEcw1k+wN+krKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573247; c=relaxed/simple;
	bh=w0amKkvJ6RXEUxqZklGWueLOe1lG8K7mDP5+N77hv6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gr1i1IrIGI1hn4zNXYQMVVWnLw4z1Zn3rHxxi1Art3PABNAm7TuNSUncHInsPSu/3K50ARxwDwClFvsFBR2yssEB3mlPmO+X1LNZeO8OhEbQ1aYIl9fi0PaUAAEauIQ4lqS6G0LDKwoAJvEXLI51Juvn6nxFYSRe+bvrKFSV9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7/I21Ab; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7/I21Ab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC31C116C6;
	Tue,  3 Mar 2026 21:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573246;
	bh=w0amKkvJ6RXEUxqZklGWueLOe1lG8K7mDP5+N77hv6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E7/I21Ab5uHCpmgIxITz1VNJcmMMRnBzWjg1qdEog7YtQCsrkJS1eYM0GrXflW8E1
	 /IV5If8udYmKoXDrFlIpam3GL9V8tyvVHSl/PtNCnF96k1nUJtKoTCR3YtgC0gP8MV
	 cFzXUHEG+xS5F437eVvl21Uj7FJKA6z4jNn2MrsJv6pxIwZvTTFw0NGc2IFwHdY654
	 SJfNOVQH+sF5soBbz8fOohmdVvK0uJa3kA70W4nd9Z9H7kQh42zyFXLqKHLBk6Ehpi
	 EkmD5DD4uj0K/1Szd9Qles9Ub9xH3LVGf80lfyqfjEEz2VVgA3VAb9EJOnqoRhm/mx
	 u/Uvg3QDkkA+Q==
Date: Tue, 3 Mar 2026 21:27:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee
 Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dixit Parmar
 <dixitparmar19@gmail.com>, Tony Lindgren <tony@atomide.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 05/11] iio: adc: cpcap-adc: add support for Mot ADC
Message-ID: <20260303212715.55664444@jic23-huawei>
In-Reply-To: <20260207135555.6e82e6d3@jic23-huawei>
References: <20260206172845.145407-1-clamor95@gmail.com>
	<20260206172845.145407-6-clamor95@gmail.com>
	<20260207135555.6e82e6d3@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Feb 2026 13:55:55 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri,  6 Feb 2026 19:28:39 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> 
> > Add support for ADC found in Motorola Mot board, used as a base for
> > Atrix 4G and Droid X2 smartphones.
> > 
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>  
> Applied to the testing branch of iio.git.
FWIW I messed up my trees, and lost this for a bit, it's there now though!
