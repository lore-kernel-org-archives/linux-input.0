Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E623F107E;
	Sun, 18 Oct 2026 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359495; cv=none; b=fVwzvkAJbVWj9nf++DwuaJAPk/+4u73gmawTzArTFFEtUywJIqpuuZyDIqFeHiIAivFNgSOBADxBzMxsw5VSJSeXjhihgMw5/XiVpFZVxDkJT1hfcFGkHj7dmyOuJgNtI0+j2VffJhJ/rerxya2Y3LILvxAHnYq58A9T55UdQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359495; c=relaxed/simple;
	bh=bx3SDqjkNUdIhgxZIPUeL43cyj3rdifBiAut4X7l+AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P99/1meKCIh8J+ECb/n2ThwTKnyJ7DnghA8c2fppNcRVytjfoeepsCmiMBdCx7T5UzU+iGs7ST7yHL0gvQcWkiqQWVuBWvvcm5kcOOWOdyYKhijUblGvfI357Fgtb5fRPLh7WSsGB2kUAwBjk85y5BnLcgYEnHXKaDt+9LgbK5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTX1G7zM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTX1G7zM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E96E1F000C4;
	Sun, 18 Oct 2026 21:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792359494;
	bh=OkQx0kcaUeYPHkHiDcRMc78J8sbTqOl+Cvm5G4bPTTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TTX1G7zMWcVCkC86iL0CWDJNlkk6Apr7pyV9TFDMTp9bZtlcCzf94Fi2usLsucAdX
	 7revi5qro+RTUaLfzHg+3w8ojPSWwppSVRTKo+Ek8XAPlZDPGCf8seC1jspDjoM0vP
	 iVQf2z6Zrxv5xfSCRyKBu7JuhzH4tVChNdbK9waXBQOMmxe3EaeB/T0hww4NndvGAW
	 5gMKohCahkN4pfLCu1x0N5N/4Z3+OB41h/5Q6qXskZwwEo1PnZwc+bM9L9UrSZHVrg
	 fMAYaI9cNEWkW2OFisfjtkSWEBkQ9LzPiO/uR+3y7rUy3HC1HNwEaI0Xol5kTcMVko
	 rjClchWzpueZA==
Date: Sun, 18 Oct 2026 14:38:09 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Denis Benato <denis.benato@linux.dev>
Cc: Paolo Pisati <p.pisati@gmail.com>, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luke Jones <luke@ljones.dev>, Ivan Levchenko <me@livan.pro>,
	Rebecca Mara =?iso-8859-1?Q?M=FCller?= <rebecca.mara@posteo.de>
Subject: Re: [PATCH v3 2/7] HID: asus: Add missing Zenbook Duo hotkeys
Message-ID: <20261018213809.GB4068315@ax162>
References: <20261013104033.36079-1-p.pisati@gmail.com>
 <20261013104033.36079-3-p.pisati@gmail.com>
 <7dfed94a-f7f9-417d-ba0d-09f199047b70@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dfed94a-f7f9-417d-ba0d-09f199047b70@linux.dev>

On Sun, Oct 18, 2026 at 05:55:02PM +0200, Denis Benato wrote:
> On 10/13/26 12:39, Paolo Pisati wrote:
> > Assisted-by: LLM
> 
> Assisted-by tags have harness:model like this:
> 
> Assisted-by: opencode:deepseek-v4.1-flash

Just an FYI, Assisted-by: was adjusted to Paolo's current format in

  816d9992d9ed ("coding-assistants: simplify attribution")

in 7.3 and it is being removed altogether in 7.4 with

  1e035297ffda ("docs: remove Assisted-by references")

currently sitting in -next.

-- 
Cheers,
Nathan
