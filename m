Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B62314A82;
	Wed, 21 Jan 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769004043; cv=none; b=g0mlMFuuo5Jz6qVRDczs/YD5FqlZM4r7I2OKhBdXkf0IUwG7Upc3UVcRuuWXHrVlHxdgY5Nz39otUUbquSTXvx6K5NC51I2wSl0N+pNs1GX+ETMcbraS/HuaHmqcTsw/toBUz6MPqFYpoxlbdO7ZIB/gv/QHYGfiPA/UAsZozM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769004043; c=relaxed/simple;
	bh=NDSvDKiJk7/GineOy56gwJIw5pXSFS1g3zqb8HY0xcg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QVgoRYTLMS/n8pMIL7zEdGEZHPJ64TnyFqVkvhlEGvBQYfbto7ggGiWgoJfMBBX6lN1+OwBViRouPOxCgI3RWsAEx0tdE4gaYOA74BbjfdNtyd3uAcrH2/3gpiIm8QY6Vgu59cEClPjxRbvMYetPjFkobaU8U24qBu0wzjgwxdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dlm2Ox3B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dlm2Ox3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B03C116D0;
	Wed, 21 Jan 2026 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769004043;
	bh=NDSvDKiJk7/GineOy56gwJIw5pXSFS1g3zqb8HY0xcg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Dlm2Ox3Bb5Y/K9cHD5OH77CNJbo9/F5YoQ3rZlKcZYTGFpvmlEo/o20wtA1hHv6Uq
	 XGtEbnq9q7z5G16zlDMispeGm0Um0EmVOMYhcnm845HId1di4xHlRe+xTbduZJ4K+X
	 Sae3KbRXQNNEes5qexwQx4LAjgnO3xAYA5N+pg1PwnD43C/SktL6O5+CnVEbe9PTB1
	 qY5Dvw49oi/BQC+qJnV6e7zsJ+qDOOJ66R2ctlOq3w6Q3MjHYo1USd/0SfKeHDxk1O
	 NQBxU32xt4sQiEUGVDB1Yr+QdUs/5yUQhlV2akB7UP2HISPNeQcGVPpA7FmkelQj+U
	 1C2CtJHi2zGrw==
Date: Wed, 21 Jan 2026 15:00:40 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Bastien Nocera <hadess@hadess.net>
cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 00/11] HID: Use pm_*ptr instead of #ifdef CONFIG_PM*
In-Reply-To: <20260113092546.265734-1-hadess@hadess.net>
Message-ID: <537804s5-p7s6-rn92-7s65-8qr26ss6so08@xreary.bet>
References: <20260113092546.265734-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 13 Jan 2026, Bastien Nocera wrote:

> Changes since v1:
> - Fixed most patches to build
> - Removed surface patch
> 
> All changes were compiled successfully with CONFIG_PM disabled.
> 
> Bastien Nocera (11):
>   HID: hid-alps: Use pm_ptr instead of #ifdef CONFIG_PM
>   HID: appletb-kbd: Use pm_ptr instead of #ifdef CONFIG_PM
>   HID: asus: Use pm_ptr instead of #ifdef CONFIG_PM
>   HID: lenovo: Use pm_ptr instead of #ifdef CONFIG_PM
>   HID: logitech-dj: Use pm_ptr instead of #ifdef CONFIG_PM
>   HID: nintendo: Use pm_ptr instead of #ifdef CONFIG_PM
>   HID: picolcd_core: Use pm_ptr instead of #ifdef CONFIG_PM
>   HID: hid-sensor-hub: Use pm_ptr instead of #ifdef CONFIG_PM
>   HID: uclogic: Use pm_ptr instead of #ifdef CONFIG_PM
>   HID: wacom: Use pm_ptr instead of #ifdef CONFIG_PM
>   HID: sony: Use pm_ptr instead of #ifdef CONFIG_PM

Now queued in hid.git#for-6.20/pm_ptr-v2.

Thanks,

-- 
Jiri Kosina
SUSE Labs

