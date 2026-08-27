Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD84746D5;
	Thu, 27 Aug 2026 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837256; cv=none; b=biKW+JfzDbDmXMpzLA8mnnbgzeouJuxwjHA/clxDD25W2ilRB0DLSAFALJeysb4jUEPxeIcbEnuX/yXG660oqOAZldZev50ZcHc6EdwoVxm8d9v/9oZz8bNrRG39sBnlBBrjUkxrL2SdrGVuCyUpoB6Jh9J/mvliNe3oimpASA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837256; c=relaxed/simple;
	bh=HjKVzbx0ka2ysw5tJK5V1jc6iPgys042GFj8Xu8Z4ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki3iLpEFSG6sqib5ovQ2cpeVcW5koptmmna842haq5FUaI5ssr/wLRWpwWyp5w3tEvL9fok/V67ZQPfIH2/KV2QdRk4/36H9bo9ufyP+XK3436/uHEXqGFeQIO35lgEPmQDlqnsJZ0k9tRM43UgONgjSBA+/lh/n47i8sG5wxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGAfIwmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGAfIwmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23AF1F000E9;
	Thu, 27 Aug 2026 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787837244;
	bh=2hBO9m0vTd/jCO9LU/z38lMIHBJ+dYBt/6htURH1XbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aGAfIwmtuk9++SPdW6FRgTgug2ia1wvEzaHSv1xBVBVCmb5RWlJlK3peSPAFgR9ZY
	 cVf2XWDqZrLsihSFF3LzFIeZSKMoOuyJPlQ9UT6vSRBCUP5FyDOpu7rDivLrAI2o9w
	 lDHz6X5Oqg9V+8Uo5amRdFqoyLtrO9ysxljH97jfKEdXWLnq44ttmWYVE4KHAWhXkY
	 DPTSExS7FJwzNkjOz0hrEIZY/9c9nWLOeKty0gen/iKiiTQ4Roa5DhxAQubSXsf4Xj
	 yKNsKpCBBT+KYhksv32RQdZZ9ZzZuGZ5ZSXLcRmoZNJXpdO/MOS7XeQP1riJZRuHY0
	 9Qtq8iZTZiwTA==
Date: Thu, 27 Aug 2026 14:27:18 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>, Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C
 fixes
Message-ID: <20260827132718.GK770273@google.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <CAD++jL=DZnKeSUu7TrC1uFn83eUu=WAFh5FGiVkO=oT3DZ6yzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jL=DZnKeSUu7TrC1uFn83eUu=WAFh5FGiVkO=oT3DZ6yzQ@mail.gmail.com>

On Tue, 25 Aug 2026, Linus Walleij wrote:

> Hi Michael,
> 
> thanks for your patch!
> 
> On Sat, Aug 22, 2026 at 11:40 PM Michael Zaidman
> <michael.zaidman@gmail.com> wrote:
> 
> > Mainline supports only the FT260's I2C bridge. This series adds the
> > UART/TTY interface and GPIO on top of it, and carries the I2C fixes made
> > alongside them - two years of out-of-tree work [1], now replayed upstream.
> (...)
> >   HID: ft260: add serial driver
> (...)
> >   HID: ft260: add GPIO support on top of UART
> 
> This comment isn't pertaining to this one device in particular.
> 
> I'm not a HID maintainer but this trend to make HID devices spawn
> serial and GPIO devices sort of turns HID into the new MFD, but
> I suppose Jiri and Lee has discussed this phenomenon in the past?

What is this?  4 device drivers in one, shoved into HID?  Each
component; HID, I2C, GPIO, UART, should live in its respective
subsystem, surely?

-- 
Lee Jones
