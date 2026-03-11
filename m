Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB50218ADD
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773239264; cv=none; b=EKYJm4rJkUsFdBoZiJc2kodxPXjn+NaTYmy52ekVl7MViZ0c+IVVYxx7SbdRtLdWq6Kts+Xwi/PrK+KGXWbemHqx4tV8gNdroyBRGEIQroIlEkJrHj7PEEnMzHxQsW2K4cIOB5OFAyok94O1oAvii8fQju6qJaXakgW8xPpT3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773239264; c=relaxed/simple;
	bh=e7uJIMsvCSKH14fN7GeXBHlyjNtpKTJDWyl+bBf1ETw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=o7rMsktnzh19YnlHioyHsOidZ7buOqJLhzt5t9gWo2l0VCr0soqj96EZRReLZQYKGx8z7I1DBm3G6EDTR4T2GtIHZrhyu9nWIJ4l+YuOOndWRevMOpAktQ4DAP76zqsW0ujFDr23/hjseEkFENgyguMDLa9v24O+Zhk1HH8sO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WS57n/eM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WS57n/eM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21727C4CEF7;
	Wed, 11 Mar 2026 14:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773239264;
	bh=e7uJIMsvCSKH14fN7GeXBHlyjNtpKTJDWyl+bBf1ETw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WS57n/eMm55h75EiRCc7ajFLes9ixoOWOau+Y9+pPshTU3v1ggwAFjUietQH5Y2oG
	 nJ9SsjXkuiLY0cW2lnKmxsPxOoEZZ0vUJznqN6SzDcTyUNYivisLYCtUoEm1OxI0/d
	 gGQV2HONPYzeImxBsQflWTFmZldbue285U1PsTwt8x6sfAWsIiA89kiR3SAyM69Ynx
	 VHQyTJVknSORjY3yblIJBSykMzKDLGGZ0E8QZGVrwZPbqUcEHNPYdZqJY2V3tCHKxb
	 VrYw6Lt3VaYsKXSDpKlVN1nEDMvT/3pwLxppBk9Y17h0NCSNVyWeEWiVxZcx7IYwsH
	 CY1ML84UzaP8w==
Date: Wed, 11 Mar 2026 15:27:41 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: input: Drop Asus UX550* touchscreen ignore
 battery quirks
In-Reply-To: <20260228145258.76937-1-johannes.goede@oss.qualcomm.com>
Message-ID: <05292qrn-oo16-10n2-q1q6-9qssp257qsoq@xreary.bet>
References: <20260228145258.76937-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Both patches are now in hid.git#for-7.0/upstream-fixes

Thanks,

-- 
Jiri Kosina
SUSE Labs

