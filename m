Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30C93E314C;
	Wed, 10 Jun 2026 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781088933; cv=none; b=SR9b6uqxVk4OVs6yueucS8VfRjasmdimQ3V6tf2ic/U7cgZb0x0Tkc8KArQFikgCsLPuoliZkYYLmcDaTQ7Vgl/+vDR9G+egw3m+RSVp5i7BvPpM2CZ0IucjhV+9t4BiZAWDsRMH+FyecSNQST1w+9b6+1ptFwDf6N6gSIzBLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781088933; c=relaxed/simple;
	bh=7hDrFbIvBGnQxwJfohGlBieZMa8/u34T224aj79mXMg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nnv/xCOWiFeWd6xMHf2t+ezgZZ8kK29CkBFbj2IQF7cxBIcDY93zIQIPic2AY47UOS/XMl9boIDgH2abmtn1pSOILX6a3Mzf6EimQeP0je/CV/zvPF04RMbNIu3mBDFlpHv7yzQrTj43COSVBepFuEYiAUD6oM5EuzWLuQiVvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ica9Ja3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ica9Ja3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07091F00893;
	Wed, 10 Jun 2026 10:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781088932;
	bh=2JVhdn0Ro7GrPy1sMRV03cxvRhiXWHlKcNwOv6YLqyM=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=Ica9Ja3wM8yA5Rv2Ih6073sGcNDBfmliDrNDX8gB7m7V+PA5PSmMAVjlm1oaBTC6s
	 vDXzPMWb7w7dU+xeXyD2xb7xJPi2o4kI1CXTJ10aO86SCFBc0oV49AQTx74n3QaV/7
	 CX9d9cXpWy2mAG5HptlANzgUuScXWA7gLb2N/fpHE2SXHcS6h4AVJI2nBG5Hi6ju/O
	 bcGwP/O169DNas4WI4L/tcmmG7lT5cOwp0Omn7F7btmHzFuPSA0L3COHg/xKO1Fmzc
	 QMpSj803OyML6Puwoxwg/IX06Wt/urSQ07j0s27S9B4S0SeLpXx/sH/kR6LC9HycWz
	 W0hH49rhKkacw==
Date: Wed, 10 Jun 2026 11:55:28 +0100
From: Lee Jones <lee@kernel.org>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
Message-ID: <20260610105528.GJ4151951@google.com>
References: <20260609121353.3743782-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609121353.3743782-1-lee@kernel.org>

Note that all of the issues raised by Sashiko are pre-existing.

-- 
Lee Jones
