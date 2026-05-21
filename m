Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893C2DE6F8
	for <linux-input@vger.kernel.org>; Thu, 21 May 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377703; cv=none; b=YXbielcSFZM4KbGd6e+SLzu+fw7AGiHcBwKgNcNqHgl3di99nAxBWRmIP2d+cErY8TBt/ifKfsNseEYRkNuP8CH1ZL7SoWymLk4cQG+FvO8hhSjfJ4bYFmkENCU/4tZ0Ncm7vsD/ec62yHbKSl77/cdzNbRmEdeuoSBpyzdezi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377703; c=relaxed/simple;
	bh=S57KdUht29Har3QeI4ZVqd1QR/UQeHXjIyVB3PD/lyg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nx0QpjPYxF1sgsEpzBCaI+FJPDiOgPfyjG+thmtK9Iel1goO20C5aeit9nbMEp01CO4tjoBz0HMjtfl8ikZxT3xcdn9D0Xrcet/oSuGy8syMFF/H6EqRyxh+vdaMoejN1Sa0n2sGkZga46PRuxUoepyFQ/E1TpvPmdIZthIILT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjrvec+S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjrvec+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B3A1F000E9;
	Thu, 21 May 2026 15:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377702;
	bh=ZXn/eBHKk2GIR/k22CIP4tg8odCYxYfjHDS1ZeN1mWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fjrvec+SsrAxjo3cNNoT6hf+P7sn6D287lpKBRiv2iDiZ41WSKR6RV7TGxgZheVEb
	 dU3MNq4I+dHV7UpDwD+reUVSAgHwnX7+OKdUjfCoHg19pUOrQBuGSneY7dVrawWv6T
	 RHlWc1VFTWHonmSVU7L4nGNNJ61HRvbHDzh51ECBWNi9Qp3K7Gp+pc+lAoCW0Wx4He
	 iRUufhLFX7Yv0ItiOqY1P77PcsqyO43odUggzbi4DjXrfHgz23ChNRjfDIe1fJbQ+M
	 9iuPC5zC6BAnt5Zjzn1lvKTWuw0abA9lW8PVp8eu/f4+MxVVJl95qrYZ7WZvCxZqBz
	 FlE5zIsIM/DLw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: jikos@kernel.org, Nikhil Chatterjee <nikhilc1527@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20260426031819.808555-1-nikhilc1527@gmail.com>
References: <20260426031819.808555-1-nikhilc1527@gmail.com>
Subject: Re: [PATCH] HID: bpf: Add Huion Inspiroy Frego M button quirk
Message-Id: <177937770132.1123826.15993975170303420557.b4-ty@b4>
Date: Thu, 21 May 2026 17:35:01 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sat, 25 Apr 2026 20:18:19 -0700, Nikhil Chatterjee wrote:
> The Huion Inspiroy Frego M pen report descriptor exposes the second
> side button as Secondary Tip Switch instead of Secondary Barrel Switch.
> This makes userspace see the control as the wrong pen button.
> 
> Add a HID-BPF report descriptor fixup for the Bluetooth 256c:8251
> device and USB 256c:2012 L610 variant. The fixup matches the expected
> pen descriptor and rewrites the offending usage from Secondary Tip
> Switch to Secondary Barrel Switch.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.2/bpf), thanks!

[1/1] HID: bpf: Add Huion Inspiroy Frego M button quirk
      https://git.kernel.org/hid/hid/c/857e71cb0a53

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

