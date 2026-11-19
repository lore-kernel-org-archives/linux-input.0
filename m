Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121840;
	b=5hjSn7K+RZoT5BsUrMdDYAO/tqmW3A6VbgfB023HZZjaTzpv27S2k5yxqxbW1oUFJD86
	 0OfiYnuKOsXv1COPujOJDb+pb8949e7YP+fmWeE7z9tvEOZkSY0WqbSNIG7OqHoIHkNWb
	 p8uxZLX5rGQoPTKMDIIzfhakc1j2iinL5NwAl7frVZOIEgNJTeIjcnBkcn5x54pgZVWNU
	 fcWEGs0jNYbFBCOYZSrFK4np9KhGo3zkKjdqaPuM92jJE5zgwAZcoKo6drW5xRrhZMZCb
	 7CMaHfoDt2km7IAJbrfMxMNvHqO453iHMAv+PpuouQzn1W3V7VA5T5rcwKYV+YSDSRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121840;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=tPzrUra+LnErAbnpIWE8RC+XmxeXyMzgxTDdozvjQ7k=;
	b=ZMbWuyvxY9/Yt1XyUPDuEuCArbSvTIWMrw0pRI480JOsiBMtWbGLyvQOF/WVe9FoWzAO
	 dLKh43J9vqPiftA+eXwlcAf9yJg2B2uApZQoH1HY3Tsjq1T/uhnP5ay5TE5yk3SO9Er4n
	 DVeLFvPAZ/AnbWGH6T8D7T3NyUdBSnDC1XMNQVGnvsHP8kr+ME3gtSpVzWCJz/Xs5v8kd
	 m+PdJR8II21UKLnvBLZpoi2xG24dWBOGjMtvoKMzOMYtH23XfZaWCDn/P1e1jxcxe6y4K
	 YCxJeklVB6MLFpj115vcdN0ALtcyg+nkkWMewTmaHqyunzB/YZn9LJGe8BiUJVYGx/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxsuqYZs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53D606A326;
	Thu, 19 Nov 2026 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxsuqYZs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755591F000C0;
	Thu, 19 Nov 2026 20:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121840;
	bh=tPzrUra+LnErAbnpIWE8RC+XmxeXyMzgxTDdozvjQ7k=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GxsuqYZsUGRRqjLgGBaAIj01nOJ2IJ1VpEkuB1HX+6fEomjQJ868YHdlIvkADz6Pw
	 yB9sXonfGxBQ7oFxr7BMpEeNLSnrhYouq18vXaJlxGL+54CwyqgN0Z7ZpCgz2+J3Kg
	 JzngTgRvUjVtzCHUcbbL3JZ95wuLRlg/m7ignavXUJiomK9x56mx3Boe+VYhqBl4PP
	 b9o+IEOiGOv0YsnqhL7QyCKaQZ6yO/9TsCCpxl1SEHyQqzS+TGR9Qqb2z+PxrP5tcJ
	 NXmw8YvRZ2wVqXpbtA9fmDXhZLsEulNmzrLDFpTOsW7uB6PSg9IUouxL/lrtmLl5Qo
	 CuaQd40ld2SvQ==
Date: Thu, 19 Nov 2026 21:57:17 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] HID: rmi: Fix report handling, device lifecycle,
 and clean up code
In-Reply-To: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
Message-ID: <s9prps69-s294-r1q1-319o-1orrpnr9r9p2@xreary.bet>
References: <20261113-hid-rmi-v1-0-afc43d97d766@gmail.com>
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

On Fri, 13 Nov 2026, Dmitry Torokhov wrote:

> Jiri, Benjamin, could this series go through the input tree once
> reviewed, as I have follow-up RMI4 core changes that depend on it? Also,
> would it make sense to move hid-rmi to drivers/input/rmi4/ alongside the
> rest of the RMI4 transport drivers?

Please, take it. The HID queue is currently so tremendously huge, that 
anything that you remove from it would be greatly appreciated :)

	Acked-by: Jiri Kosina <jkosina@suse.com>

Thanks,

-- 
Jiri Kosina
SUSE Labs

