Received: from e234-60.smtp-out.ap-northeast-1.amazonses.com (e234-60.smtp-out.ap-northeast-1.amazonses.com [23.251.234.60])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E4497396;
	Mon, 28 Sep 2026 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790590119; cv=none; b=cgpoLnn/wWa+5Iqr5KQMTJ/KD/tWv9ho8hqBw7TWRxuaac+WbHLZPliBGwy0Zd8N1gylxuuA3oBEl9dl5YlPEoLcgtpNo9hTMtshpRg80HA0cQoroAcj0JdWHqDNu3p3eVmC22TEAvBTnIC9ZP/lZLZ8+lhcwA8En2edRNIpE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790590119; c=relaxed/simple;
	bh=yMSif6ynx6nwdCbZHY+fd5kWOasUfWU6Tx1mGHdyWwI=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=LQV6jwp92k4+cuW8Xm9VMI3G2sHadjIVWFdUrAs/DeSUww3rVTj4EQv+kjKMx3EwSKvkPaLK4QsDlIvym7a4gbxUvZb+ipttVffsYtV5fj0noy0OPahA/10uXYyoLcUy6OAPtUm17/qedDrWrFNhH0O6xB8qOeshRNGdm7Xsli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=I8IgdS8+; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=HQ6p/NJR; arc=none smtp.client-ip=23.251.234.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="I8IgdS8+";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HQ6p/NJR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1790590116;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=yMSif6ynx6nwdCbZHY+fd5kWOasUfWU6Tx1mGHdyWwI=;
	b=I8IgdS8+wA2fQ+k0Oy2LH+foCXQKmKHNbJkqBMOblk727ycomb2VIXFVuH4Rn4V+
	4qHdDFvR1ENxEbyEIcnoASM86dKxoBVBPIbYDty5sW7Ak62XkIsbQnKJjE4t0GEO6RD
	EnxHGoQhXDqIatm6eAobiqz7BJpp6eXNtNTIt+h4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1790590116;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=yMSif6ynx6nwdCbZHY+fd5kWOasUfWU6Tx1mGHdyWwI=;
	b=HQ6p/NJR4eW+L5zLl6mf+qsbfcDrQicaTYDNmW39mddiGyWgXrkvkkbV0QEvvn1s
	tdu2Q7XChE7FG7TA5+GfRWf0rB1qUN+aNz6Vyjogg4Fmuh27OMf+KYUlr8/eRTFC8pm
	H1nBYIaKgvkzSJd7A7RVDnL9FcFigmAEQ/QfoEBo=
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To:
 <CAEe3GZE9pVyV=PRxo_1V39dXCEHz_wx1fa5P3U=686b0fweOng@mail.gmail.com>
From: fQwQf <fqwqf@fqwqf.xyz>
To: jingyliang@chromium.org, daleyo@gmail.com
Cc: jikos@kernel.org, bentiss@kernel.org, corbet@lwn.net, broonie@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, dmitry.torokhov@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	hbarnor@chromium.org, tfiga@chromium.org
Subject: Re: [PATCH v4 00/11] Add spi-hid transport driver
Message-ID: <010601a0e77ce26e-204b61a2-f41e-4d77-b585-228c5da788dc-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 10:08:36 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.09.28-23.251.234.60

Hi Jingyuan, Dale,

Thank you both. Since my earlier message, I have moved =
the SL7 integration onto Jingyuan's v4 series, replacing the standalone =
downstream HID driver. Normal touchpad operation is working with the local =
GENI QSPI stack and existing iptsd setup. This is testing of v4 plus my =
local changes rather than unmodified v4.

The QSPI transport uses spi-mem =
operations, with 1-4-4 transfers and eight dummy clocks for the SL7 read =
path. I also have changes around DMA buffer alignment, report bounds and =
request handling. I plan to separate the generic fixes from the QSPI =
transport changes and keep the GENI/GPI controller work in a separate =
series, retaining the downstream provenance. I can rebase against v5 and =
drop anything it already addresses.

I also encountered a resume issue in =
this SL7 integration: the HID reset-resume callback could run before the =
asynchronous reset/descriptor exchange completed. Delaying that callback =
addressed the ordering problem. The touchpad also lost its =
userspace-selected heatmap mode after reset; restarting iptsd restored =
multi-finger input. My current SL7 workaround recreates the HID device =
after reset so userspace reconnects and initializes it again. Resume with =
this workaround has been tested successfully here, but I would like to =
discuss a cleaner recovery policy before proposing that part upstream.

Jingyuan, do you have a preferred transport interface for adding spi-mem =
support to the generic driver? I can prepare a focused diff for discussion =
alongside your v5 work.

Dale, thanks for the nix1e link. I have reviewed =
the patches and module build definitions at b274dd7. The build definitions =
apply v4 plus fullduplex.patch to SPI-HID and include separately built =
GENI/GPI modules with the downstream QSPI patches. The HID read path =
combines the command and receive buffers in one SPI transfer; my local =
implementation instead expresses the command, address, dummy clocks and =
data through spi-mem.

The DT configuration in that revision targets =
Romulus13/15, so I assume the additional Denali DT changes you mentioned =
are local to your setup; please correct me if I have missed a published =
branch. If those changes are available, a link or diff would help us =
compare the wiring. I also noticed that nix1e's README reports a suspend =
fix. On your SP11 setup, do touch and pen both remain fully functional =
after resume without restarting iptsd (if you use it)? That would be useful=
 context for the SL7 recovery issue above.

Please keep me CCed, as I am =
not subscribed to the lists.

Best regards,
Jizhou Tong
