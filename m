Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F026B95B;
	Wed, 28 Jan 2026 19:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769629976; cv=none; b=hPwRDw72VNJUNYF2NZGQa7SG8SiER0dpFWyUxSCmJv2Kl5LndL2JvqWUELF/Sv87Jsd01RoB2G+uapNDFDPc0JsIbUC/L8GpWNpu1zxS4u4pAOwwZn3cUp+3KT8S1n/B0+Nz09tNFuv0XHzskKkkdSOk8vjBkbrX7hoa97H/rsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769629976; c=relaxed/simple;
	bh=TMShfjmh4T3S0h1pucDmkoNvNg3NeE+IfCsm6Fe9djU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YRExAmGKgU4IxPCk2dxIzc3KM97RXDBpjrg+BsSoA+ePtrjlRp5jQsFGnrrkUGBigTAuNBmijZ8GzMZgXKi2y+NKS0IP9JzThaSeuToS1CMLwetNn28tbLXV3x5YpGx3xp/KQc+zfF/1m0gNqfZ2vGWiTidn6rTyZp3ruOS7d6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p88fggny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p88fggny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C716DC116C6;
	Wed, 28 Jan 2026 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769629975;
	bh=TMShfjmh4T3S0h1pucDmkoNvNg3NeE+IfCsm6Fe9djU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p88fggnylPWJ/zGLcm1mSAi7u6IcHuvrrMFMAraeA8ZPr+Z/V7mweZen5IQ+ssv9x
	 EYkLgpsJI0dX2/mVN3RJ8n8ce+fliZAyHklGqRKcCjyc31Emcqs04mjJyzSwxoohhd
	 Tf1j2pX6c01aWin9JwMKSK9fFCO2NCq7zzA5/hUC8cU6tOKVda5wf4M9O7pFrco96a
	 gbN7CJFKc8Omw8xUlJ81TD4ejUdaLMfkHlbnR3dMOYf7LbbycRnnDR7xEgOiUUNM95
	 qJ0ziEiXQ5FxRfKHi/vo+kvR52DrVf410HTJZ72vuURAzU0Hvro3fkiPueh1yfGUak
	 utOTjBr7o5b9Q==
Message-ID: <bb448595-ae60-4497-98ad-040f148af2e5@kernel.org>
Date: Wed, 28 Jan 2026 20:52:50 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/3] dt-bindings: i2c: Add CP2112 HID USB to SMBus
 Bridge
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Danny Kaehn <danny.kaehn@plexus.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Ethan Twardy <ethan.twardy@plexus.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org, Leo Huang <leohu@nvidia.com>,
 Arun D Patil <arundp@nvidia.com>, Willie Thai <wthai@nvidia.com>,
 Ting-Kai Chen <tingkaic@nvidia.com>
References: <20260127-cp2112-dt-v13-0-6448ddd4bf22@plexus.com>
 <20260127-cp2112-dt-v13-1-6448ddd4bf22@plexus.com>
 <20260127160217.GA3776731@LNDCL34533.neenah.na.plexus.com>
 <20260128-magnificent-faithful-otter-c4f900@quoll>
 <aXoF4zi4SZrXaku5@smile.fi.intel.com>
 <3db84b61-e463-4362-b142-59d3ca6eae90@kernel.org>
 <aXoz4Xs8csdxXeZU@smile.fi.intel.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <aXoz4Xs8csdxXeZU@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/01/2026 17:05, Andy Shevchenko wrote:
> On Wed, Jan 28, 2026 at 04:48:18PM +0100, Krzysztof Kozlowski wrote:
>> On 28/01/2026 13:49, Andy Shevchenko wrote:
>>> On Wed, Jan 28, 2026 at 11:35:25AM +0100, Krzysztof Kozlowski wrote:
>>>> On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:
> 
> ...
> 
>>>> That's actually rule communicated many times, also documented in writing
>>>> bindings and in recent talks.
>>>
>>> Does DT represents HW in this case? Shouldn't I²C controller be the same node?
>>> Why not? This is inconsistent for the device that is multi-functional. And from
>>> my understanding the firmware description (DT, ACPI, you-name-it) must follow
>>> the HW. I don't see how it's done in this case.
>>
>> What is inconsistent exactly? What sort of rule tells that every little
>> function needs a device node? It's first time I hear about any of such
>> rule and for all this time we already NAKed it so many times (node per
>> GPIO, node per clock, node per every little pin).
> 
> That we should represent the HW as is. There is no "rule", there is a common
> sense. Of course, it's possible to have all-in-one node, but this may lead
> to a disaster when there are tons of devices in the Multi Functional HW
> and some of them use the same properties. How would you distinguish HW
> with two GPIO banks, two I²C controllers, et cetera? That's what my common

I do not see problems in these examples. GPIO banks have gpio-cells for
that. i2c controllers are busses, so as I explained in other email, must
have their own node whenever any other node is expected.

And for everything which is more complex, e.g. regulators, we do expect
child nodes.

Still the "MFD" is not a reason itself, we consistently give such review
and we also documented it.


> sense tells to me, putting all eggs into one bucket is just a mine field
> for the future.

Some years passed and I do not remember any mine happening here.
Actually mines appeared when people DID create fake nodes, because then
when the actual true bus node was needed it was violating the rule we
have - not mixing bus and non-bus nodes on the same level.


Best regards,
Krzysztof
