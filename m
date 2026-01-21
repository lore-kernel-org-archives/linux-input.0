Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038DD47D924;
	Wed, 21 Jan 2026 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986180; cv=none; b=sN7ozsxuygbqPYNFVhOYxL36jIwP+xVizEOy9SGRxaYpfTUtIj6Ei8kAgQWhhGW0ApjaH8gScUzfelbOP4To5WzeysL1Nex27YKNqXt0l8Lg4/XsY1EowAvzSNxlbw/I8apTTYEqrRS6sn3gFL6m32sbycc3UatYTVSh33c0pm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986180; c=relaxed/simple;
	bh=oy9Zng5uePpCrNY75T7ouncc8VXplz/AzRGE7DWTQtI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l1ZMZge8QGniP2Q/IJP+w7TaAGCb/dOb5ePQDlWNS7aP+oBg6yU2QXxPJW2TljnBNWa2YYPCi+sT6nnosORTwcKHvbgHDnnUnFK7getALg5kA2ZWQy9z+u2TLeUIBcZBdCeJteeudDXEy1cqkVWi6iP0pJmtH4kbTL4xR5BoLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD4YMz7v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD4YMz7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10831C116D0;
	Wed, 21 Jan 2026 09:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768986179;
	bh=oy9Zng5uePpCrNY75T7ouncc8VXplz/AzRGE7DWTQtI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=HD4YMz7vamg0PILEWuLAzqMSgwWkA7FfMMHDCVS1BhBGz0qNy8M9HaJ0Vxb5YIChi
	 7fVctcdat+wesi8XPEGlX6/U/m18E4OUyJ9N1PojVbZ/9QfDrUZLJNjO1jnzWbLqmm
	 rkLow2y1zJo3ml9+85FZpX/xFM9VOFU2vLIsqs5fBWjqVK/KOtXXJRkK181t3JVaQK
	 yRkw8Oj9YSJ6dTjDwc0MxFWX9X9l7mqDhS6Qm9W0GZY4wCLLa6HLepziR8uEqMOMUR
	 7LQ4hNdImM5Ccb7td8/3cuddlfF1LBBHOq68yYZkK7+uf2kLBVXcSwK/0XKcHuaMAi
	 lru8uGz4jRARA==
Date: Wed, 21 Jan 2026 10:02:56 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: daniel_peng@pegatron.corp-partner.google.com, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Douglas Anderson <dianders@chromium.org>, 
    Pin-yen Lin <treapking@chromium.org>
Subject: Re: [PATCH v6 2/2] HID: i2c-hid: Add FocalTech FT8112
In-Reply-To: <eb47h436johngo3bz5b5cn6tyvwqoplg55uhk2siftxk6n547n@4rgwokhtrcec>
Message-ID: <o6r34srq-os0p-76no-4or4-40525n63o31s@xreary.bet>
References: <20251117094041.300083-1-Daniel_Peng@pegatron.corp-partner.google.com> <20251117094041.300083-2-Daniel_Peng@pegatron.corp-partner.google.com> <eb47h436johngo3bz5b5cn6tyvwqoplg55uhk2siftxk6n547n@4rgwokhtrcec>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 Jan 2026, Dmitry Torokhov wrote:

> On Mon, Nov 17, 2025 at 05:40:41PM +0800, daniel_peng@pegatron.corp-partner.google.com wrote:
> > From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
> > 
> > Information for touchscreen model HKO/RB116AS01-2 as below:
> > - HID :FTSC1000
> > - slave address:0X38
> > - Interface:HID over I2C
> > - Touch control lC:FT8112
> > - I2C ID: PNP0C50
> > 
> > Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
> 
> Jiri, Benjamin, do you want to take it (and the binding) through the HID
> tree or should I take it through input?

	Acked-by: Jiri Kosina <jkosina@suse.com>

feel free to take it through input.git to make it easier.

Thanks,

-- 
Jiri Kosina
SUSE Labs

