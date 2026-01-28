Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A33033C3;
	Wed, 28 Jan 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615306; cv=none; b=tSBp3bBhc11oKs3chBC62/CSOoG+CjFzVa8kVos+fuJy45XLcqyMtFyqLCqvyPdLHdnrp1YuWVLDMOSyn22tX9d8IT5FYBoyME7+aYop8sIKt92BEQ5gOAqIos1mhexlMJCvEGtLi9Kj0AbTUaP5oj1qNASns+OvLPZ1wU+swDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615306; c=relaxed/simple;
	bh=nMmyDWkQnV3I7GZMPlWVQ0MXtLcXBmX4DSwzNeO1os4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4eJahJhGMowej7V/zmuEoY4xt7a32VCPMKV2JVF8xsOMXfzbZb3uChbh50yO7yERlSJgJiTHrE55UO4/+N6D/ZQ+0A/QkRQLb7BJap9/4Ays4tBLzX8PxvLgwFFfgfF9fzFG2Iw+WlDr26G5+Hob1S3O0gD2YIOPrqUb+K8IYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQsU+VSH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQsU+VSH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31568C4CEF7;
	Wed, 28 Jan 2026 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769615304;
	bh=nMmyDWkQnV3I7GZMPlWVQ0MXtLcXBmX4DSwzNeO1os4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tQsU+VSHZpjZdAXLTmABg/gNAXMA+TDHBfkk8V3n0zVkM7a0o/6nl5BSQiRifK2aN
	 1OvAANda2HLtuH7qYpR85cqB40xQBgKaNz9M7h8H+PHEWXUaLfsMEKVtwqD+P7rpIN
	 MM+Cx3P/H9jr4YW9VqozqSaK1NS7QAN8jBelpjlM8nbziS2MVUTyU7eUn9R5FY/G6x
	 UPTIAqx6Pm6ngLCDvIe8ioTGsvn845+T7IKfcTmlFaEkBlG/xusF/6YoX2Hc+Ix1lY
	 HMhC5QZ2BQTakGSq6fzJO8WyCOL+VmxXNhvMio3a+NU7RSUj9dvMgxEclwGMSlymgR
	 TnPDqqinB9+IA==
Message-ID: <3db84b61-e463-4362-b142-59d3ca6eae90@kernel.org>
Date: Wed, 28 Jan 2026 16:48:18 +0100
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJoF1BKBQkWlnSaAAoJEBuTQ307
 QWKbHukP/3t4tRp/bvDnxJfmNdNVn0gv9ep3L39IntPalBFwRKytqeQkzAju0whYWg+R/rwp
 +r2I1Fzwt7+PTjsnMFlh1AZxGDmP5MFkzVsMnfX1lGiXhYSOMP97XL6R1QSXxaWOpGNCDaUl
 ajorB0lJDcC0q3xAdwzRConxYVhlgmTrRiD8oLlSCD5baEAt5Zw17UTNDnDGmZQKR0fqLpWy
 786Lm5OScb7DjEgcA2PRm17st4UQ1kF0rQHokVaotxRM74PPDB8bCsunlghJl1DRK9s1aSuN
 hL1Pv9VD8b4dFNvCo7b4hfAANPU67W40AaaGZ3UAfmw+1MYyo4QuAZGKzaP2ukbdCD/DYnqi
 tJy88XqWtyb4UQWKNoQqGKzlYXdKsldYqrLHGoMvj1UN9XcRtXHST/IaLn72o7j7/h/Ac5EL
 8lSUVIG4TYn59NyxxAXa07Wi6zjVL1U11fTnFmE29ALYQEXKBI3KUO1A3p4sQWzU7uRmbuxn
 naUmm8RbpMcOfa9JjlXCLmQ5IP7Rr5tYZUCkZz08LIfF8UMXwH7OOEX87Y++EkAB+pzKZNNd
 hwoXulTAgjSy+OiaLtuCys9VdXLZ3Zy314azaCU3BoWgaMV0eAW/+gprWMXQM1lrlzvwlD/k
 whyy9wGf0AEPpLssLVt9VVxNjo6BIkt6d1pMg6mHsUEVzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmgXUF8FCRaWWyoACgkQG5NDfTtBYptO0w//dlXJs5/42hAXKsk+PDg3wyEFb4NpyA1v
 qmx7SfAzk9Hf6lWwU1O6AbqNMbh6PjEwadKUk1m04S7EjdQLsj/MBSgoQtCT3MDmWUUtHZd5
 RYIPnPq3WVB47GtuO6/u375tsxhtf7vt95QSYJwCB+ZUgo4T+FV4hquZ4AsRkbgavtIzQisg
 Dgv76tnEv3YHV8Jn9mi/Bu0FURF+5kpdMfgo1sq6RXNQ//TVf8yFgRtTUdXxW/qHjlYURrm2
 H4kutobVEIxiyu6m05q3e9eZB/TaMMNVORx+1kM3j7f0rwtEYUFzY1ygQfpcMDPl7pRYoJjB
 dSsm0ZuzDaCwaxg2t8hqQJBzJCezTOIkjHUsWAK+tEbU4Z4SnNpCyM3fBqsgYdJxjyC/tWVT
 AQ18NRLtPw7tK1rdcwCl0GFQHwSwk5pDpz1NH40e6lU+NcXSeiqkDDRkHlftKPV/dV+lQXiu
 jWt87ecuHlpL3uuQ0ZZNWqHgZoQLXoqC2ZV5KrtKWb/jyiFX/sxSrodALf0zf+tfHv0FZWT2
 zHjUqd0t4njD/UOsuIMOQn4Ig0SdivYPfZukb5cdasKJukG1NOpbW7yRNivaCnfZz6dTawXw
 XRIV/KDsHQiyVxKvN73bThKhONkcX2LWuD928tAR6XMM2G5ovxLe09vuOzzfTWQDsm++9UKF a/A=
In-Reply-To: <aXoF4zi4SZrXaku5@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/01/2026 13:49, Andy Shevchenko wrote:
> On Wed, Jan 28, 2026 at 11:35:25AM +0100, Krzysztof Kozlowski wrote:
>> On Tue, Jan 27, 2026 at 10:02:17AM -0600, Danny Kaehn wrote:
>>> On Tue, Jan 27, 2026 at 08:47:48AM -0600, Danny Kaehn wrote:
>>>> This is a USB HID device which includes an I2C controller and 8 GPIO pins.
>>>>
>>>> The binding allows describing the chip's gpio and i2c controller in DT,
>>>> with the i2c controller being bound to a subnode named "i2c". This is
>>>> intended to be used in configurations where the CP2112 is permanently
>>>> connected in hardware.
>>>>
>>>> Signed-off-by: Danny Kaehn <danny.kaehn@plexus.com>
>>>> ---
>>>
>>> Hi Folks (Intended for Rob or Krzysztof),
>>>
>>> Wasn't sure the best way to go about this, but trying to see the best
>>> way to get a message in front of you regarding an ask from Andy S.
>>>
>>> In [1], Rob H initially directed that the gpio chip share a node with
>>> the CP2112 itself, rather than having a subnode named 'gpio'.
>>>
>>> Initially, I did the same thing for both DT and ACPI, but Andy S.
>>> directed that ACPI should not have the node be shared in that way.
>>>
>>> With the last revision of this patch, Andy S. asked that I try to get a
>>> rationalle from Rob (or other DT expert presumably) on why the gpio node
>>> should be combined with the parent, rather than being a named subnode
>>> [2].
>>
>> Because it is explicitly asked in writing bindings. Please read it.
>>
>> Because we do not want Linux driver model affecting design of bindings
>> and DTS, by subnodes present only to instantiate Linux drivers. I do not
>> care about driver model in this review and I do not see any reason it
>> should make DTS less obvious or readable.
>>
>> That's actually rule communicated many times, also documented in writing
>> bindings and in recent talks.
> 
> Does DT represents HW in this case? Shouldn't I²C controller be the same node?
> Why not? This is inconsistent for the device that is multi-functional. And from
> my understanding the firmware description (DT, ACPI, you-name-it) must follow
> the HW. I don't see how it's done in this case.

What is inconsistent exactly? What sort of rule tells that every little
function needs a device node? It's first time I hear about any of such
rule and for all this time we already NAKed it so many times (node per
GPIO, node per clock, node per every little pin).

> 


Best regards,
Krzysztof
