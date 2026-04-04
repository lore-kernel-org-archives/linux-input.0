Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F98332631;
	Sat,  4 Apr 2026 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775297279; cv=none; b=Zs+uhr41ccvoQNGULgDoy0CIbO2I5UlpOi81lt9yfGd9oCJC/bROXr9MIyc3mb/ueJGuTnURgdH+V4Zk/WWZD9iQpvEapzqgoFG3M+6Qy1g1CudQo2wths/Jgl26JcUa3pJuhfOtfmBEKN9ystsBnVxtN7mXFWcypjcyblogXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775297279; c=relaxed/simple;
	bh=2ssktwxh0Bj8G2/8mwzWS4kH5amAID+s+Fzo8HNto+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYKNstIFpmvV6uWQLQIoWqqZ93JADmgs4XsdRpMze9Lh6+p79YOHICuuIm87uYcBQQUIqw73dQk1gYxhmjxVzj4UljJ1JY2pQmrRXqBSO4+BKnZ2Fn3tNBmho+WSTa8nPNRgj7QJY9wuK9b/KeTOTWWUGdDkhsVM590L1wr+7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABIgo9hI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABIgo9hI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706E2C19421;
	Sat,  4 Apr 2026 10:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775297279;
	bh=2ssktwxh0Bj8G2/8mwzWS4kH5amAID+s+Fzo8HNto+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ABIgo9hIdz+XUmNI4pBeefb64VBJKf1MwzEKN/OsKVAkQkNppAK6UKYhMwWdiwqBD
	 pKKIPg+OdUQbf4H65FsxLSkWo1VUVsEQyaLl+WanRPCOnTpcPC+mMePUp1o5XmcjIk
	 PfOpm2CHlbiC5pauaLiQ1NniT8MLnOf2/HeLWYvPotxjWxj2TPGB0WQ6Jcr0fAtFcJ
	 kjlqkhu+EOB3YRDx3oTEsmSK9LGf6Mjfjl/JNb35pyYgslFsE/2OYGZ9vFor7zunXx
	 KdtR+RAyI4XDrc+MT8gP8+dJ6Tqbtt5eq39luMgpD0E9y94Q+LcNWbNqxxtihkn0JQ
	 zPd02aBYF5lSA==
Message-ID: <fbc1047f-e51f-4a00-a406-ef2886457f3e@kernel.org>
Date: Sat, 4 Apr 2026 12:07:56 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: lg-g15: Add support for the Logitech G710/G710+
 gaming keyboards
To: Xavier Bestel <xavier.bestel@free.fr>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260402075239.3829699-1-xav@bes.tel>
 <f6f46cfe110053208e7dbb4dd3074eab7966e8e7.camel@free.fr>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <f6f46cfe110053208e7dbb4dd3074eab7966e8e7.camel@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4-Apr-26 12:05, Xavier Bestel wrote:
> Le jeudi 02 avril 2026 à 09:52 +0200, Xavier Bestel a écrit :
>> Add support for the Logitech G710 and G710+ (USB ID 046d:c24d) gaming
>> keyboards to the hid-lg-g15 driver.
> 
> Did that mail get through ?

Yes we've received your patch. most kernel maintainers have
a very high workload, so the HID maintainers will look at
this patch when they have time, which can take a while.

Regards,

Hans

