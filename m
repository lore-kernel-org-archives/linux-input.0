Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEAF2E7378;
	Mon, 29 Jun 2026 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723086; cv=none; b=FFWY9+9RJkNsaeacDC2PTDOnJQdED0ZH3Ufs3VpfdGMnabX/45miAxsqB9S7RUgoKnDUl0/QzILfPGriKOgsygE6BxaZLFFlaB38ev3hUGIdwJDkVEiYarIc7nnvAn5h4lHTsb0M5tTSRoGSzdZM57Ynuub4YchMPiPWw7O6rmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723086; c=relaxed/simple;
	bh=1ZKXjT4eRy/z6NRQl9SKqaX+obrsecDlzBy8qDMBC9k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hEPyhPo84zh0Mo2htzVEuCFsD1nqoOZk94tGxnfyJDudWT2hpBiM/HEapX2HHitTS5TfW47PP9NLbrwBY0zZCsry5vtMKgLdZPsgQrSSHFeWm0ah0Be3rEYPyYiaUww0II0a2Lh9nFFe3UesuVNq2c22FQa6tR+2mark3RDKrFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyQJ+M1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyQJ+M1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249C01F000E9;
	Mon, 29 Jun 2026 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723084;
	bh=XRMxQ/1KD4SMniSfvO3J1a/rKusbAij00E6gOFZB7NI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=UyQJ+M1gOrQaYc9JFSFf1GeFFCRHDLeL8aUMbOtRUNzFmXEi46Wl4Q6q5b4T+iZeh
	 TT7xCFldS5+7xbtqG6QeM0k4wvOE8lR6yPLarT98SVsnr0HwNeULTRguvZSqMQUZgB
	 CKXklRRxtJ2Q7UD6O9xDV23w2g7xa2JTMrG7cZ8tbPjyw3YfuzTiko3YQvdZoFzDbZ
	 Js1VW+PSlIrTRGft+d0hKUTopnhK3/EO/fuwuf4WhVl//EadesoF6El0JJelar2jQ2
	 8pjy1+MYH/GBdFnVSQC2HX1q2wJf3UqFkRGcZ3H2MRZ7VLVzMLDgxBC776gwg2H4/8
	 hL7zTqW8mXu8Q==
Date: Mon, 29 Jun 2026 10:51:22 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
    Denis Benato <denis.benato@linux.dev>, 
    Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org, 
    linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/4] Add MSI Claw HID Configuration Driver
In-Reply-To: <20260529072111.7565-1-derekjohn.clark@gmail.com>
Message-ID: <qq26pn5q-96qs-0o7o-9r10-5r78p3862qn6@xreary.bet>
References: <20260529072111.7565-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 29 May 2026, Derek J. Clark wrote:

> This series adds an HID Configuration driver for the MSI Claw line of
> Handheld Gaming PC's. The MSI Claw HID interface provides multiple
> features, such as the ability to switch between xinput, dinput, and a
> desktop mode, RGB control, rumble intensity, and mapping of the rear "M"
> keys. There are additional gamepad modes that are not included in this
> driver as they appear to be used in assembly line testing or are
> incomplete in the firmware. During my testing I found them to be unstable.
> 
> The initial version of this driver was written by Denis Benato, which
> contained the initial reverse-engineering and implementation for the
> gamepad mode switching. This work was later expanded by Zhouwang Huang
> to include more gamepad modes and additional features. Finally, I
> refactored the entire driver, fixed multiple bugs, and refined the overall
> format to conform to kernel driver best practices and style guide.
> 
> Claude was used initially by Zhouwang Huang to quickly parse HID captures
> during the reverse-engineering of some of the features. Since Claude had
> already been used, as a test of its capabilities I had it implement the
> rumble intensity attribute after I had already rewritten most of the
> driver, which I then manually edited to fix some mistakes. I also used
> Claude to review the driver and these patches for any mistakes and bugs.
> 
> Assisted-by: Claude:claude-sonnet-4-6
> Co-developed-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
> Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> v11:
>   - Restore dropped changes from v10.

Thanks Derek.

Sashiko had quite a few insightful comments, I find especially the one 
with IRQ-vs-kernel context deadlock on drvdata->profile_lock valid.

Could you please go through those, and address it?

Thanks again for all the effort,

-- 
Jiri Kosina
SUSE Labs

