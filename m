Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B344231326A;
	Fri, 16 Oct 2026 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143443; cv=none; b=HEuDdZnYribmRvqVGyRXK0WfwxYZfLXBVYQzl1Z0yoxNC0VOHOMtDMUtKigGoxa5Bz5vpEhEfhFNFYjCLuokfJ4s9YyMMsPkGXC8cn/JIoBma9AwihMSgL/idJTxrH40FuoLOmwuGl8RznvFGG0C9BVf5kgh4CBZb1ze4aRKMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143443; c=relaxed/simple;
	bh=0h4y8ewI6vpe63BMTbKm8/orUTWs1RpLPPVuvxHBfQA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JRMfR5cJrKl3MKyZEfe2CwgPqOaQJUW364Bi11j3VTrLDDME97W/rfDE7JKLlGqiHzAhgy9RwAzafkrvkAVF8s+8nkMg1bLyVdN5LX7aVLvCZQEvtko7HB7LMMYmwtwV/4S3ZzW5J8HyRiOf3V2DegRf5WlG5NAzvxJ5bkvomHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVcucW6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVcucW6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103171F000C4;
	Fri, 16 Oct 2026 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792143442;
	bh=5sfvuyLfv+Jii3kYwTgfnM4uAxR+GVFTSUQiN0eU2Ns=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=hVcucW6jzLN3hu1kByVp6dfA2ALCYZoUZV0VE4rxRTISONyNweZcdr6qYSZdl2mIA
	 vVsDAZoG6ozhYsYBAMsOaWzUuctSTQWLMCAE0Hl59rKDqpShphc4BwA78zxh0dL96y
	 W6wIyM++ddA+KYTQCgIPcU4ru7q7HEwIseqfmNmXC4lSrqiSl+MD+GWMuss8nJmhLo
	 g+HuVd5opXr3zWuCPJfI/i9hel3dfyVrxotZLAL6dDa90Vw8pYZ8HqFpv9MjWHJuNG
	 OqXgTcdCrigRAhzmXpLRv4WjyhtLHcbsFa8MfQuHliaO4M5/navwm0089s5sIpdRTj
	 qpSpxmo/BF21w==
Date: Fri, 16 Oct 2026 11:37:19 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jiale Yao <yaojiale02@163.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Rishi Gupta <gupt21@gmail.com>, 
    Marcus Folkesson <marcus.folkesson@gmail.com>, 
    Masaki Ota <masaki.ota@jp.alps.com>, 
    "Daniel M. Lambea" <dmlambea@gmail.com>, 
    David Barksdale <dbarksdale@uplogix.com>, 
    Jiri Slaby <jirislaby@kernel.org>, Hans de Goede <hansg@kernel.org>, 
    Johannes Roith <johannes@gnu-linux.rocks>, 
    Rahul Rameshbabu <sergeantsagara@protonmail.com>, 
    Clemens Ladisch <clemens@ladisch.de>, 
    Don Prince <dhprince-devel@yahoo.co.uk>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH 00/10] HID: validate short reports in raw_event
 callbacks
In-Reply-To: <20260924144414.1192037-1-yaojiale02@163.com>
Message-ID: <00135752-q124-75o4-q507-pq99452p5n5n@xreary.bet>
References: <20260924144414.1192037-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 24 Sep 2026, Jiale Yao wrote:

> __hid_input_report() calls a driver's raw_event callback before
> hid_report_raw_event() validates the received length against the report
> descriptor.  A raw_event callback must therefore validate size before
> accessing fixed offsets or casting data to a protocol structure.
> 
> Ten HID drivers currently access fields beyond the received length when a
> device supplies a truncated report.  Add protocol-specific checks before
> those accesses.  The patches are independent and each changes one driver.
> 
> The mcp2200, pxrc, and zydacron cases were reproduced with a fake HID
> transport under KASAN.  Their individual commit messages include the
> relevant reports.  The remaining paths were verified by following their
> fixed-offset accesses from raw_event.
> 
> This follows the local raw_event size check added to hid-asus by commit
> 47669bec44fe ("HID: asus: refactor the two workqueues and init sequence").

Applied to hid.git#for-7.3/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

