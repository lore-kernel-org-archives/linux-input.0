Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87588355819;
	Mon,  3 Aug 2026 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786075; cv=none; b=K/dpzVA0YAtPGNML2Bgh15SbjIu2iYi4JOXvO24+47DS/i5dHoTNC9Rhu4evYEQC+75BULl8Kq0SPy5UJRy3HyTOxS0XZcdi1Rns+cl7Mu4/OkOMCaasoplruuRYI7kyXcsbNvcMrNBJN1l57Or4jQx2/2LRmHCtMm0MLsDOLeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786075; c=relaxed/simple;
	bh=EpM4nVXg56SL0a6+ddYWPNtMAntwlvHkpVBUIZGi2Z8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T6B7x2wD0Fi1CP1IM+KT9ZXvAgFJvdvBdeB3n3h1qiMa1rVZS56/AB8ApnxE5dNHGERpDrNlDMvnno6eNRfCj/d3tw2mp1B34YhrMFgte27YMD6UIc5W8Z5gl1YJloUohQxuxy6HN4/ST6s4atv1v66suKrRH/iCYKRmNciFEv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS386hCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS386hCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9476F1F000E9;
	Mon,  3 Aug 2026 19:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785786073;
	bh=G632JSs0JVWtYzDBB3w3sC4WoF6dk9yDMNFm3libwz8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=eS386hCwG/GaUrQ0fFf9kQ/ggJq24n2E2nMUAscQ+D48QniKfwhAGF6qtXWJ2JZFN
	 xYLms5wuhMQeR6hRI2IhH8iBHoL1HLXZDgtXrpTwIziTTCok1vqW+x2+qN8w9onZMo
	 +28BzvNEibmzM2XoFJoAwB/A4pHE1hpHZqXNLKo0zIRHzXrffQjCCHz8ZxH8smkSYC
	 RMziRPZKJ143x78Ycd3oYbOuKsPDP28sjLC9QAxRzC7kQci3VVwIDMfWzb8CGDul33
	 uUBPJaDMv0NisalGlCxTMYO7c8eKFjh7j/tJkzJ4YBAA30JiLyJJBkKou6pTYmNP+r
	 S8hJBlIRiK5BQ==
Date: Mon, 3 Aug 2026 21:41:10 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Pan Chuang <panchuang@vivo.com>
cc: Basavaraj Natikar <basavaraj.natikar@amd.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
    Zhang Lixu <lixu.zhang@intel.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    Steven Rostedt <rostedt@goodmis.org>, 
    Vineeth Pillai <vineeth@bitbyteword.org>, 
    Sakari Ailus <sakari.ailus@linux.intel.com>, 
    Abhishek Tamboli <abhishektamboli9@gmail.com>, 
    "Danny D." <d3z.the.dev@gmail.com>, 
    "open list:AMD SENSOR FUSION HUB DRIVER" <linux-input@vger.kernel.org>, 
    open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] HID: Remove redundant error messages on IRQ
 request failure
In-Reply-To: <20260720084310.210976-1-panchuang@vivo.com>
Message-ID: <n947825p-92q2-7pr4-nr1n-4p1n5642p9r0@xreary.bet>
References: <20260720084310.210976-1-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Jul 2026, Pan Chuang wrote:

> Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()") added automatic error logging to
> devm_request_threaded_irq() and devm_request_any_context_irq()
> via the new devm_request_result() helper, which prints device
> name, IRQ number, handler functions, and error code on failure.
> 
> Since devm_request_irq() is a static inline wrapper around
> devm_request_threaded_irq(), it also benefits from this
> automatic logging.
> 
> Remove the now-redundant dev_err() and dev_err_probe() calls
> in hid drivers that follow these devm_request_*_irq()
> functions, as the core now provides more detailed diagnostic
> information on failure.
> 
> v1 -> v2:
> - Added the same change for the intel-quicki2c driver
> 
> v2 -> v3:
> - amd_sfh: directly return devm_request_irq() result

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

