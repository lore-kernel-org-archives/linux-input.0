Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075EB1DFDE;
	Sun, 12 Jul 2026 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783817261; cv=none; b=a4dmt4Kl7OoRZjAgW396HmoIQ+2Yij+u288aSSQGSLr2U9vXP0+FEp/W+TbTX00Y2kBU9kE0yN4KgAxu/yXjmi3MmLMvqloH5aC/AIuErGE5gyf4qOFUsyUbsU2QHwTVLHqce2NkoAc13hHQmjDHtdRA/8f3UOhrZgvgoW6bwQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783817261; c=relaxed/simple;
	bh=NzgAZqa18Mtc2zVkrLNw5rsGMTDu2PxkWqGPNO6lMdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flBVJHR+qyRnovBQ/yFaQfafYP6+En2ZopH8wyuBi/kUUpmVltGa8TECbqYERWwS8NXUnaW81rae6khg8UibCn2Z4nNHeMmkrFocdqjY6JH+JizumWDe5FHYFhSE65zZNyofDvmRKsOE7V/+/12coKKtBvjR6jJGg75HsdrA8nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TogIj2xe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TogIj2xe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6694E1F000E9;
	Sun, 12 Jul 2026 00:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783817259;
	bh=ZAGV71bqNugqKn5T9IVR4eMOuq6ywDna2wbJxOCqXxs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TogIj2xeLtlcmLEPeI/CPABh9t6U10KpuUq4I8Ugmny19FkPiZi7t1jSRGPrK6KDs
	 +WAqAP9XjoLx+AgaMiscNbJNVQsRy4gb7sF1UxHWzRUVYELSIrZQZwES0wjTGlX6Aj
	 kjUf+2aZxQmvKkXfj9DACNcLUqsp9uObuY5M1RZ3vjoMBMQKBL/+iWd4ymOPd/MY5X
	 T+wJ+wE7QLn7FrtlRopz1QvvQq8kkdK2/N/0dPDVwBjc30IAEQqChzjDW0aoVnQv0E
	 RAvPoJ9BvGFSvxBHzdQ4ZipjtIOW53mRjG6/FqUcsEj1wLLJw+AfJds/c8ZnkzBW44
	 FD02DqMM3dQJA==
Date: Sun, 12 Jul 2026 01:47:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: sanjayembeddedse@gmail.com, Jiri Kosina <jikos@kernel.org>, Srinivas
 Pandruvada <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Maxwell Doose
 <m32285159@gmail.com>
Subject: Re: [PATCH v3 0/2] HID: iio: warning clean up and prefer kernel
 coding style
Message-ID: <20260712014733.3f5ed10a@jic23-huawei>
In-Reply-To: <akwbOnnEuQ4wA-OE@ashevche-desk.local>
References: <20260707-15-jun-hid-iio-alignment-v3-0-8791574ad0fe@gmail.com>
	<akwbOnnEuQ4wA-OE@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jul 2026 00:16:42 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jul 07, 2026 at 12:29:42AM +0530, Sanjay Chitroda via B4 Relay wrote:
> 
> > This series updates HID sensor IIO drivers to address checkpatch
> > warnings, improves readability and compliance with kernel coding style.
> > 
> > The changes are:
> >   - replacing explicit NULL comparisons with implicit pointer checks;
> >   - adjusting indentation and alignment;
> >   - reformatting multi-line function declarations for improved
> >     readability and consistency.
> > 
> > While updating alignment and line wrapping, function parameters are
> > grouped more logically and common callback signatures are formatted
> > consistently across HID sensor IIO drivers.
> > 
> > Testing:
> >   - Compiled with W=1 for each patch in the series  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Given the set of fixes working their way upstream for HID, it
might be a little while before I apply this one.

Jonathan

