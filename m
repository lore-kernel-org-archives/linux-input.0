Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36530C63A;
	Wed, 28 Jan 2026 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615527; cv=none; b=kBz8Wo53JLfMf/5G03h1orC/me/FfT115aASesbbJubJbxKT0Yb9jW6ldhKHW5ygOYziDHKdGuCTmD4qjKYa/X6gVnXNzvnMKugsiM4AdY2SJ9VPtNN1C6bsTAF20p7lSPGdASlK84GXeRg7fxlaOxGuZnJILJmq8i7J+47oDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615527; c=relaxed/simple;
	bh=67kT40TUbe0KV3MGrshwjGJDIfgBsmnyIv64CZ7jEM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHaIuDNnBkNFjoyepoNVN928vFGkgtqHsGz+1BAs3xwbnQ5/g8kvgN4SZejKRHwTLmBA9SwQJISV86WNCaieO8TtDCtUv7JOMg8mKoTrRBHp8rx1pLTWZpwmerGtX9uLn4GxGbQr1BmAkfLas+xX2NHxHT6fWVVQQryAtWJ/bxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOqyDpFC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOqyDpFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E90C4CEF7;
	Wed, 28 Jan 2026 15:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769615527;
	bh=67kT40TUbe0KV3MGrshwjGJDIfgBsmnyIv64CZ7jEM0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YOqyDpFCOW1PHiL4LGoLxV9m13/Y3Hrntsen+74EkeKdh1CBMOv2SPGn8rkcKsx51
	 g+pzYheWs2rb3CtRUrSEn9f2IXqypMOlCDZQT3f9WIKLoBBgTfteNadlJjEGQr+D4d
	 oopCjh+U4aXtJkIMfHDIrWFrSc64tDDXQVWLrHGj/hIZjmU0TXsA7Ux2wPccII6FbV
	 xFyhDnhvGi66/cZhSTMPiyqfBcwDbW56UL/KoX/M4DAUk/rLvNymqjJM0MO0Eg9Dsk
	 5G62q4J75rdHUSS1IQ9xjG9nmOaeBfGCCLrxEsvHvdFU0LAAdk919OP8e2KQRBsy0E
	 XbTZLvYUFTTnQ==
Message-ID: <a579100b-6c38-4fd1-bab3-b1e7663ab412@kernel.org>
Date: Wed, 28 Jan 2026 16:52:01 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/3] dt-bindings: i2c: Add CP2112 HID USB to SMBus
 Bridge
To: Conor Dooley <conor@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
 <20260128-pelican-silenced-cd6a5bf69672@spud>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260128-pelican-silenced-cd6a5bf69672@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/01/2026 16:06, Conor Dooley wrote:
> On Wed, Jan 28, 2026 at 02:49:39PM +0200, Andy Shevchenko wrote:
>> On Wed, Jan 28, 2026 at 11:35:25AM +0100, Krzysztof Kozlowski wrote:
>>> On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:
>>>> On Tue, Jan 27, 2026 at 08:47:48AM -0600, Danny Kaehn wrote:
>>>>> This is a USB HID device which includes an I2C controller and 8 GPIO pins.
>>>>>
>>>>> The binding allows describing the chip's gpio and i2c controller in DT,
>>>>> with the i2c controller being bound to a subnode named "i2c". This is
>>>>> intended to be used in configurations where the CP2112 is permanently
>>>>> connected in hardware.
>>>>>
>>>>> Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
>>>>> ---
>>>>
>>>> Hi Folks (Intended for Rob or Krzysztof),
>>>>
>>>> Wasn't sure the best way to go about this, but trying to see the best
>>>> way to get a message in front of you regarding an ask from Andy S.
>>>>
>>>> In [1], Rob H initially directed that the gpio chip share a node with
>>>> the CP2112 itself, rather than having a subnode named 'gpio'.
>>>>
>>>> Initially, I did the same thing for both DT and ACPI, but Andy S.
>>>> directed that ACPI should not have the node be shared in that way.
>>>>
>>>> With the last revision of this patch, Andy S. asked that I try to get a
>>>> rationalle from Rob (or other DT expert presumably) on why the gpio node
>>>> should be combined with the parent, rather than being a named subnode
>>>> [2].
>>>
>>> Because it is explicitly asked in writing bindings. Please read it.
>>>
>>> Because we do not want Linux driver model affecting design of bindings
>>> and DTS, by subnodes present only to instantiate Linux drivers. I do not
>>> care about driver model in this review and I do not see any reason it
>>> should make DTS less obvious or readable.
>>>
>>> That's actually rule communicated many times, also documented in writing
>>> bindings and in recent talks.
>>
>> Does DT represents HW in this case? Shouldn't I²C controller be the same node?
>> Why not? This is inconsistent for the device that is multi-functional. And from
>> my understanding the firmware description (DT, ACPI, you-name-it) must follow
>> the HW. I don't see how it's done in this case.
> 
> The i2c controller should probably be in the same node too, unless it
> would cause conflicts between function (e.g. inability to figure out if

This one is the rationale.

> a child is a hog or a i2c device). I would like a rationale provided for
> why the i2c controller is in a subnode.

I2C controller will have children, because it is a bus, so moving it up
one level would make the entire node I2C bus and that's not only problem
for the kernel but actually for reading DT - we expect consistent choice
for children, instead of mixing nodes with and without bus-addressing.
What's more, if you have two buses you also need separate nodes to group
them (obviously).

Best regards,
Krzysztof
