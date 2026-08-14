Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640CC46D2C2;
	Fri, 14 Aug 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710609; cv=none; b=NX/7rA7c63u5wEuiXYNa3ReALw76/5CJlzV24knT+WescgA54M0EUCx9c9/yfefSYIgejCNASrzCIo5H9o9TydH+VM+kTbYo57ua7ztwq8iYfqS2E3brrS3Mb/Rawp4umYDvcPZjFGt7tq2i2QIeFvBU37NjoyyAONgCfOoKpxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710609; c=relaxed/simple;
	bh=df5gFxzqRzVG5v/SakHUBWAXekic4I9DrNBD87WZqN0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=olL9hix6b6PEVrr6+oQ9uLDmNHlHfDayMH38MKmxi51INOeWyuyQSsL9ITtKeMTw/7BCi7Be/xWOvPTecSKLQzDd34pNa0TA2M49rb+vp+PUwhSIfU8iTKpV3GOLAPW64osDwKSE30Ludc0vEwEP3vG8QS+mKy14SJGy79rEt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5JvDCxu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5JvDCxu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472081F000E9;
	Fri, 14 Aug 2026 12:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786710607;
	bh=WKuxqB4jEbmhjvSANdyiU0M5ZI5k4F+7VXj83WduUxA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=L5JvDCxuwD3YKTN/1laNzmjZLQLdO2bpk7i1TdLU0zr/0t2XLpxgzwiur7MdPeKN2
	 /WXw8LNuL6oU1yYW79OsOJszm7gkWCOJVn/ftdn4SuOKwBGR7t2r18pIyklCsGA+5O
	 qeT/Mll9qLkrD54X5vl0XDgJokSLwLVa/aKt2qHMIrMT1y5mu9dXfcf8/dyQlDJXbb
	 euNw9ZKlTc3zgzEYGEEK3XdxRJQm8E4NzcmSKR7igKyTt6ezFH43II+a3H1D5WJnZq
	 yRFVdcp6PusIc7DdXpTSYRKIDV+1JHLY0Az6jIxhE879UJr50NYz4Hft2X/l85PkqP
	 pa1RXU3Kn/TWA==
Date: Fri, 14 Aug 2026 14:30:05 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Alec Hall <signshop.alec@gmail.com>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, pepemontfort@gmail.com
Subject: Re: [PATCH 0/3] HID: Apple Magic Keyboard/Trackpad battery over
 Bluetooth
In-Reply-To: <20260803051707.53252-1-signshop.alec@gmail.com>
Message-ID: <onq9q816-q84p-o4s3-soo2-69n2n5p5p09q@xreary.bet>
References: <20260714101235.99447-1-signshop.alec@gmail.com> <20260803051707.53252-1-signshop.alec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 3 Aug 2026, Alec Hall wrote:

> Gentle ping on this series, posted three weeks ago. No rush intended -- I
> am mostly checking it has not fallen through a crack, and asking whether
> anything is wanted from me before it can be looked at.

Hi Alec,

both myself and Benjamin have been on a few weeks of leave at the same 
time, which didn't really help the throughput of HID subsystem tree. Not 
sure about Benjamin, but I am still recovering.
The increase in number of incoming patches after the AI outburst is 
overwhelming.

Anyway, as I've already applied Jose's patches some days ago already, 
could you please respin your series on top of it, give it a proper 
testing, and resend?

Thanks, and sorry for the hassle,

-- 
Jiri Kosina
SUSE Labs

