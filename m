Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795826870;
	b=cMeXD3PedXRPjGXaTbRYfKfeuFHJJOx9sX4LIU7WtUJx+GO5kCNYcz2fV6n6sORtIzio
	 l/yjiEhLY2cRyNiP2fb6HNXgDRENAEoDTG+pcYL3ydKkROIw0aKkad5f85qMW8I1UJnjK
	 CW4lTGHJdHNqlaE21a6ccDQSWVNSZfH6kB+dPrJFcipYlo+aUVBccy/X8SCewq+4c/3nR
	 9GcuM9HrEHL1uBLvf/G6AArfaU/+ie4fW2j3IZKYA627m6SdqsqK4EWG1LE4cVJN+HSBh
	 8FLqMIOIKGo7ypceSy1zY8qKSZbMYXa8Sk+VwwAOu/97Co/qw+8EbRA1TQBwSrB0Oag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795826870;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1kYaZkVu4hHdWnq014DoYYGMay8TDDPlvwbeqXFq4T0=;
	b=Mg3b47c8byqsbbgcbtiOd/Z38s2Xhjufcj0QsuA6SkFA1otz+HYr2NLb7anOanaQvnsr
	 wIL4RC+YKA1IcnimCNluG45H6QUw7142iHF0rT1Y65nl9DnNgrzjIBOjNIHN+ONO0wZRr
	 xGkl9LrxxW8pS77yn2EWOWp9AbUkQwvY3W0I7Dh6AUBDeTaQ/6EZSVkKBZorGrjOBxMur
	 ngd8hBm4am0PTO3aq3DsgcRrZM/ZnIghWr9lHJbJpZhMefkpPscqlBHaxSkMhIKIVCOk5
	 cAePQaxznz7KvSQ6ZgOjh1jlCN8JtJuWxUfdhbUxQwc53V+HihqJeQoKCgwiwmk8T+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlZM0klj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF1606A31C;
	Sat, 28 Nov 2026 00:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlZM0klj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD6F1F000C1;
	Sat, 28 Nov 2026 00:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795826869;
	bh=1kYaZkVu4hHdWnq014DoYYGMay8TDDPlvwbeqXFq4T0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NlZM0kljSKDqIbKMQ8CA0rY/RZkOfHQfSlfxPzsmHpVFJaqdXmQ5Us9jz/NtV+Xf2
	 0CA6rbmy1YEfuHsZudSMeWnH7kkCZhJy/8Aa7YOYZiR0JI+vVYEmKumRvHlyl+nvJ+
	 IfTOktbrr/0QLJX6y/7eMWLtwhSsuLD7LIfAlXDA2V+41khIG7OFx+XKFeWHDiMCiz
	 3WB3IN4zViL08rK8COSWXOrwZVJ4IzPLJDEMoDXsNN/X6DllA6oHsDePjjJLmS0vE1
	 5ANa/dQduGfTdwnfrMCKaZ9RjncRk3KnkFK9EdF/TgJAj9mMWW6gMCqTMyAtCqLDUC
	 YL+OnnmBOfMlw==
Date: Sat, 28 Nov 2026 00:47:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: sanjayembeddedse@gmail.com, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Joshua Crofts
 <crofts@kernel.org>
Subject: Re: [PATCH v2 0/7] HID: iio: Unify probe-path logging
Message-ID: <20261128004743.233a15f1@jic23-hlaptop>
In-Reply-To: <awllftF3xR6Arvua@ashevche-desk.local>
References: <20261127-19-oct-hid-iio-unified-print-framework-v2-0-3f476fe1a940@gmail.com>
	<awllftF3xR6Arvua@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 13:11:58 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 27, 2026 at 04:03:55PM +0530, Sanjay Chitroda via B4 Relay wrote:
> > This series provides consistent support for logs in probe() path for
> > HID IIO drivers with suggestion and input from Jonathan.
> > 
> > This is followup series on top of multiple sub-series submitted for HID
> > IIO device drivers which included fixes, devm support, cleanup and using
> > preferred kernel coding style. This series adopts a common logging
> > approach throughout the HID IIO device drivers in probe path.  
> 
> > ---
> > Changes in v2:
> > - Following suggestion of Joshua, remove the comparison and change the
> >   checks to `if (ret)` as respective devm_*() API `return 0` on success.
> > - Link to v1: https://patch.msgid.link/20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com  
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> for the not commented patches (the one is depends on the answer).
I'm having one of those days where I decide there is too much outstanding
and to try and trim it down to something manageable by taking what I can now.

Applied 1-2, 4-7.  So that just leaves 3 where Andy had the questions.

Thanks,

Jonathan

> 

