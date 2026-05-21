Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9863D7D7B;
	Thu, 21 May 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374042; cv=none; b=aOsJjhrFt3vTFIDPA0OkXwPlpkB80/iJoaqGFEc3ET3UwQndcV6neRta4R+6CUSvAUZ7LIpWZhDD/uovOUZzArzREHDgYKmhAZKvQK7N7BuJl2RgT5/KvuyU8FVp2Bto+GFTvK70x0yDCX4Plf7Bxk+f30sE6BlGsCW4AzmNauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374042; c=relaxed/simple;
	bh=qoAJ3yyCi5HN3+BWEBNgehP5toeAQ5KqiXepQUthTos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hotoKFuhczkpGnScVKP1u1oUNFdwdeoaKQpNsnODWNBfYwns7Q5bL2Er3zNfJBLEvLmEI03v4TLwcrGrooEmX8QQm2ONrzZCT2YEg0MZ+nxPuCyqRUgFhCcMfycdGL8sU0JeNxuqqcdnXi/7SDDIJr+8vva0fg+58yFvrvxWrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBYMN6yl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBYMN6yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C711F000E9;
	Thu, 21 May 2026 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374040;
	bh=6FiV5T64gd6HjIBBX/O7h0nUuwydIyLmGfq1Eh7pQDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aBYMN6yly9/ELcpeWNaufeab2Dwg0vR/WkZ7IAipKmQwDUad32f7O7gp8YcQ2GuYF
	 7urTBbUM5Cr2pcQrxR04gclU2hASnNtzu6Td8ymNpXftaphARS+H4JnIj/hXJlFxQH
	 9xqjzK+JuJFfPOh82NmDqx6Dk6TcvQQszca5wvHMw6ng2Z/t8RK3nyzRYP/fWTsfGo
	 i+pX6HQbtOjNcf6W+UvuxElq7McK1+kQnqKGqANxdsm2nXkJqtwEWM2ofEWk9eiBF+
	 rLYH2FUWVALPHWQC9me0BAW8inK2fS8+ghMVIPCr/4tdi0uOHfY9FpKM1OG9XVYx2J
	 qoydKNgA0Ii2w==
Date: Thu, 21 May 2026 16:33:57 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: =?utf-8?B?5YiYIOWHrw==?= <lukace97@outlook.com>
Cc: "jikos@kernel.org" <jikos@kernel.org>, 
	"vi@endrift.com" <vi@endrift.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] HID: remove duplicate hid_warn_ratelimited definition
Message-ID: <ag8XEIP_KNBXoA_V@beelink>
References: <OS3PR01MB7969C09559DC6C0DCA520720C73C2@OS3PR01MB7969.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <OS3PR01MB7969C09559DC6C0DCA520720C73C2@OS3PR01MB7969.jpnprd01.prod.outlook.com>

Hi,

On May 07 2026, 刘 凯 wrote:
> From 565c81e1b2e1aaad675d9844428af7b35f4328c6 Mon Sep 17 00:00:00 2001
> From: Liu Kai <lukace97@outlook.com>
> Date: Thu, 7 May 2026 16:32:04 +0800
> Subject: [PATCH] HID: remove duplicate hid_warn_ratelimited definition
> 
> The hid_warn_ratelimited macro is defined twice in include/linux/hid.h:
> at line 1317 (added by commit 4051ead99888) and at line 1339 (added by
> commit 1d64624243af).

Checkpatch complained about not using the proper format for commits
(i.e. 'commit <12+ chars of sha1> ("<title line>")'). Also, putting
lines numbers in a commit description is not great, because they are
only valid for the time you wrote the patch, and if we apply other
things in the middle, they get wrong.

Last, your email client (outlook) mangled the patch and converted tabs
to space. I managed to apply it with --ignore-whitespace in git am, but
this adds extra steps. Please fix your process for your next submission.

Anyway, I've taken your patch in my local queue, and reformulated the
commit description with the remarks I made above. I should push this
soon.

Cheers,
Benjamin

> 
> The second definition is correctly grouped with other ratelimited macros.
> Remove the duplicate definition at line 1317.
> 
> Fixes: 1d64624243af ("HID: core: Add printk_ratelimited variants to hid_warn() etc")
> Signed-off-by: Liu Kai <lukace97@outlook.com>
> ---
>  include/linux/hid.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 442a80d79e89..e1877a9a58e2 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -1314,8 +1314,6 @@ void hid_quirks_exit(__u16 bus);
>         dev_notice(&(hid)->dev, fmt, ##__VA_ARGS__)
>  #define hid_warn(hid, fmt, ...)                                \
>         dev_warn(&(hid)->dev, fmt, ##__VA_ARGS__)
> -#define hid_warn_ratelimited(hid, fmt, ...)                            \
> -       dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
>  #define hid_info(hid, fmt, ...)                                \
>         dev_info(&(hid)->dev, fmt, ##__VA_ARGS__)
>  #define hid_dbg(hid, fmt, ...)                         \
> --
> 2.43.0
