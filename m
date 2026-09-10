Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E81379966
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054002; cv=none; b=RkLcmeSpsgtgz9+c6hXYKI2qXGE2mxvlT56vissy7kiYbVke7HiK1LfyFXcZklstgQuXVHyxLK4n717pfxmCavuZfL0HzErk7eMcWGjuopfKklnhRpGAWjJprowDa/CRtNnvRyvbesBgDBR8p1RP0XNV1auAgbpr78fCuj8lcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054002; c=relaxed/simple;
	bh=hELU+70qG8nKeZu4YCU/X9LpjSjkuVII5YLPtLEcnus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nb/hA033ZiIbjof9jy75gGtXJpJ+KnAeK3FJ0dFt9h65yw7Bj0BhL1QAgcxftREpwFW5E2DLccW8A2O3yi8SXTNbNNhpzhr+Wf4QW0qOvahg2+wgOyHIQveHLV3fL2eYVZ3Zlfa6FCTbhmbq8zj+jMR8yLcmKWZtOJK09iH3dwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnLF3nda; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnLF3nda"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3852E1F000FF;
	Thu, 10 Sep 2026 15:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054000;
	bh=vmhqK7jLSuUtXuiJgTIcW3TUsvlE+VCONeOWFjEWiXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KnLF3nda/+7YEjU9JRMu9KUtI+BPjcGP9akG82qbNHcDLYJEnJ08mUA0om3A79t7z
	 Mr/UmuYgKsrvBMxIiCIOApkaYax14BnqDHUMIPm3mbzcygPXhIgA6ptgPBhFK9xBK2
	 a5eHlKjJuaAOI6dJK3lMgsqB+heC6FwsYJvawKCXvWVkJ5KWNd+Bz4qD7k9E1XKc3Q
	 ykG/9c7mquMKAoc/vf7g5SqCB3Nja9Ffjzt2LNdEtHGiJMFUZ8WuRVdJibyWF/0hsG
	 M9zRbnkeJESZtTgrR0W71kj4oglEEI6LPucWyZnbU8z8Rj/BaW5Ib1zh5Yp4ugBIyr
	 GfbP9GwGxbuDA==
Message-ID: <59682a31-49b9-4db2-b8b4-6abaf27fa9fc@kernel.org>
Date: Thu, 10 Sep 2026 10:26:38 -0500
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/4] HID: amd_sfh: Add DMI quirk and support for new AMD
 SoCs
Content-Language: en-US
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, jikos@kernel.org,
 bentiss@kernel.org
Cc: linux-input@vger.kernel.org
References: <20260902134431.3146117-1-Basavaraj.Natikar@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260902134431.3146117-1-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/26 08:44, Basavaraj Natikar wrote:
> This series makes two independent improvements to the amd-sfh HID
> driver: a DMI quirk for an existing platform, and Sensor Fusion Hub
> (SFH) support for newer AMD SoCs (MP2 1.2).
> 
> Patch 1 exposes intr_disable as a module parameter and adds a DMI quirk
> for the ASUS VivoBook TP420UA/TM420UA, which needs interrupts disabled
> for correct sensor operation.
> 
> Patch 2 enables the SFH on newer SoCs by adding PCI device ID 0x1152;
> MP2 1.2 reuses the MP2 1.1 initialization and operation paths.
> 
> Patches 3 and 4 switch human presence detection (HPD) and device-mode
> reads to DRAM instead of the C2P registers on these newer SoCs.
> 
> Basavaraj Natikar (3):
>    HID: amd_sfh: Add support for newer AMD SoCs
>    HID: amd_sfh: Add HPD support for new AMD SOC
>    HID: amd_sfh: Add device mode support for latest AMD SOC.
> 
> Helge Bahmann (1):
>    HID: amd_sfh: Add DMI quirk and module param to disable interrupts
> 
>   drivers/hid/amd-sfh-hid/amd_sfh_common.h      |  2 +
>   drivers/hid/amd-sfh-hid/amd_sfh_pcie.c        | 10 +++++
>   drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_desc.c | 13 ++++++-
>   .../amd-sfh-hid/sfh1_1/amd_sfh_interface.c    | 37 +++++++++++++++++--
>   .../amd-sfh-hid/sfh1_1/amd_sfh_interface.h    |  7 ++++
>   5 files changed, 63 insertions(+), 6 deletions(-)
> 

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
