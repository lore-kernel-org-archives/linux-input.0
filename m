Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E1280317
	for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 18:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770921885; cv=none; b=rBSg393rY2Bj76YY0WtPWYYRNnJ9DZFDryms0jCYgd2K/cpJplf28SQ8QdO1hHrYH1yTHxV0/yodZNRwGW4F4XwsPoiphp23Aw5s9yUAc4t6SqW95bvrwvHt0IMX5VAQwqg/sB2841oqmrO3w8w5WEUN/O4JWFWF25ZlUzJLmQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770921885; c=relaxed/simple;
	bh=TLr7Xz7J+QMHaUJJHB/f6wXGwqzv0T7QxmkAVsEpQs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwH/nKHUM3QlvlFURXl2bDSJT+pEiAO4sagKMEAnafJ7TqNU3u0+dcFL0RJVSsbwU872zQkWEuteRbDxVgcEBHE/Y78YooQW+/30FeTJ617C1beyT+J7wXr53bysyHuSVjKbC3hAaeiGoERyOQBoL7VXUS+rrA//1Db8CnwOouA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlGbxhf2; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlGbxhf2"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270adc5121so332828c88.0
        for <linux-input@vger.kernel.org>; Thu, 12 Feb 2026 10:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770921884; x=1771526684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f37EbsIX7Fwq2gmEwPUE6uD06P4To39ry9mVkkXdhXE=;
        b=IlGbxhf2osnSoTZUDgEoRZ48fVG/pAvmk3fFlEOYcRLN2p3CacsMKMRaYNIOTstKBL
         ufcks2SlGEJDiMfstdyoX0DEqO4tOIkjRxa+hUf2wlepCYIAgltPrwJYbHxZKLDOL5qa
         xG1vpqZgVWZr6WuP6svm12WFsOGf2a9jxMrpCna45ILwgxUzp/+LKxWX4FdpQHoZEPjJ
         ur5o6orqhoHkYugDAqJ0EiptiraMXmgaft71cuSBm+gaz9j9YUwPvZhVhZokFIkQcDZD
         6Bkr0wMGNpuNUnubFekiBWWRbfbgJ83fzgW5gXCGRI3ZmZrse6kRAOmXoAhJW0uOBbVR
         +Kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770921884; x=1771526684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f37EbsIX7Fwq2gmEwPUE6uD06P4To39ry9mVkkXdhXE=;
        b=lJrlbWuISb4zeHjHkOpUHTF7F/A3JD1sqfcFI4nXWRBfkNPP/JPG4ef/K6MxwgA7YZ
         b8ht9CJbkyPnZ8LB2SOrQpAkT5HSVfC4gnM5u8jDn0jJbonB/+5AGwQ0moLkkgsX5Cq9
         kJigxxV6M/0bTOx8kiN0oOlbey9wijMZ5hEh4YCviysOX4xNkPIDMcd1+05ZjQ/f7Wbv
         89VP7LFo4TGuBGMM0ScOR9KU+VBo3+tTQuj/QBctfG+My6GG1aILz4b2YXrUlH7Rd989
         qsTKvUEWPtlTAXZ3vNchv/OfAXk+jGqN48z829mfDBNs8jscQvmm55snZcuxRnF6ip+u
         9++w==
X-Forwarded-Encrypted: i=1; AJvYcCUY+0U8XHVLx+nCaUaVD6wFwrCjMegPiJrnCiS/4tMBDdXOsaPBoTOBEWhuhQRF3MgDaeCP8QQb/Y4+ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJXuzVMm9RUKP0/1fy+pAyJqXmx5y02SzS6vs93WXgmYlZ+Y3
	TKNr0nR5nWLZNTNS95lAYPm1DPtcmrXHzAqrVTIe9RfdqxFeeDYdOS87
X-Gm-Gg: AZuq6aLTTLyCwoLlFqtS9euUIchcbhNducBmszxB5/Q79lRn+TlC1W6GL2pKuKQkK8L
	9GwzPTf48GQuvPB7rUAK5CjwyT2R+gOGS2IoyZ73JImIXVTqm5atVpv7yAu34udPTfEd0tRnNG2
	9DfD4eXpf2svI4nxFZ40TsYE1DFZINpkfmdvNg2i6lLVy8UA/106tbuePcgwt4QD6ApOGZz7VLC
	KNUvCXuhb8AvN+yZra534viBaCQI68mdo4ir14sWQrhC7HfNL3KaFKFsBkZXsBExnLorLNnAuyv
	GRbbOLVH085L3yctsBTd7Q2EctaXPHdu0e/8S7Nr8wMX40neQo9VxehxlaUxNO+xSYnjMTiB7RZ
	zpDlE1o+O8rh6TjTIxT7gUVx1pDdA0ZM2N4DuVZQuqw5K+eozeEdVuKc3rW9EerS1OVg8KlDS43
	Y0yoUdTUH6H64pqUN7wN7hilJk/zZCdEN4vSnYXqjRX9I99l6uYhPo5JykQYItLw9L
X-Received: by 2002:a05:7022:920:b0:11b:9386:8271 with SMTP id a92af1059eb24-1273059ecfamr1328253c88.46.1770921883727;
        Thu, 12 Feb 2026 10:44:43 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:7027:6cb0:48e2:2882])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6e944asm4630977c88.9.2026.02.12.10.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:44:43 -0800 (PST)
Date: Thu, 12 Feb 2026 10:44:39 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Thomas Gleixner <tglx@kernel.org>, linux-input@vger.kernel.org, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Cheng-Yang Chou <yphbchou0911@gmail.com>, 
	Frank Li <Frank.Li@nxp.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Jinjie Ruan <ruanjinjie@huawei.com>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Marc Zyngier <maz@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] linux/interrupt.h: allow "guard" notation to disable
 and reenable IRQ with valid IRQ check
Message-ID: <aY4fdWbsBAuoavgx@google.com>
References: <20260121232522.154771-1-marek.vasut+renesas@mailbox.org>
 <87sebrbenj.ffs@tglx>
 <701e739d-2e82-40e7-87b5-b4ec92903af6@mailbox.org>
 <871pj9alui.ffs@tglx>
 <1a2db366-a611-4454-a86e-cf7df9cbc358@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a2db366-a611-4454-a86e-cf7df9cbc358@mailbox.org>

On Wed, Jan 28, 2026 at 03:33:03PM +0100, Marek Vasut wrote:
> On 1/28/26 2:49 PM, Thomas Gleixner wrote:
> > On Wed, Jan 28 2026 at 13:23, Marek Vasut wrote:
> > > On 1/27/26 10:14 AM, Thomas Gleixner wrote:
> > > > disable_valid_irq is a pretty non-intuitive name if you look at it just
> > > > by reading a usage site. It's not really improving the readability of
> > > > the code, it's in fact obscuring it as the reader has to actually look
> > > > up what the hell this means and then stumble upon a completely
> > > > undocumented lock guard define.
> > > > 
> > > > I'm all for using guards, but using guards just for the sake of using
> > > > guards is not a really good approach.
> > > I wouldn't even be opposed to converting the ili2xxx driver (the piece
> > > of code in patch 2/2 of this series) back to simple enable/disable_irq()
> > > . I am not particularly on board even with the disable_irq lock guard,
> > > or more specifically, lock guard used for non-lock things like this.
> > 
> > I agree that guard() is a slight misnomer for such usage, but this is
> > about scoped auto cleanups, so using it this way makes a lot of sense
> > when the scope mechanism is sensible.
> It is indeed a misnomer.
> 
> Would you prefer this patch be updated with some better function name, or
> dropped outright until there are surely more users of this functionality ?

Maybe call it "disable_irq_if_valid"?

Thanks.

-- 
Dmitry
