Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C95528454;
	Tue, 22 Sep 2026 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066942; cv=none; b=rFwDkV9zQ7yBwRCL0qQ9QN60pOKVfJHx7+h7n58KnLosTqRjW1z7OTbBYM7kiYtcqYpWIWskWwmsNoFURYg9Nrnk4PduCFJj0bLIw0AhVw1XUCWWw61XbkbquG+orlDqH7f4x/urGOecLvA1mzb4PHS2olQ6Ifh2LXvKbnzwbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066942; c=relaxed/simple;
	bh=XyoOzB8ihijh/xsKK0YcCfpk1RCVC/mcYFS9N53eUdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOxPMo0Q31Y9OWnH7rpc7ieRydLVCB0RQFtVO3vYA6YR/TErGn+NGA2AlgSJaq5a3zKPa+daLA1eFD9UKG9CTs7M8KCUAB8BFXzChzhl36BN9Tjp2gwSqCwSgVBOfpU1cZGOnzx46tGPpqj5EW1Gv1RrXrSBhXgGaTQ00cC2G4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xl21csvZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xl21csvZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7261F00893;
	Tue, 22 Sep 2026 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066940;
	bh=x2LbWyqsBJi8UoBpecRL5XHK+9G27RrqTqLAShUht5Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Xl21csvZQzm6ARRrwxq6HULPt7eS8+OtYd2FFNzF+XvDYWhm9DnqTr1ZukIbSBV4B
	 iBFeBb7m5kLiZvTutjgrAgMLxB6fGpn17i8S+yM9MDH5EBep8oxe17DJPjDt8fMNUk
	 qADPT9tecGMPEkwx5h1xj4NgBOqQXdrIZk6utxNivuPgMsmS1b6gbseNlooBQcNx1D
	 +ZIUO9TT7dgSDbk2FmiR4UAAtJOeVxaGNtw4ylHNUIcJYcjukQTqj7nqrETNJYxgsV
	 k8U2EsceBqidp3YE9FS8W8SLurztwBQnkWLs6Kh88NvsfqMFoxrqGUtDWUjCblboEf
	 jZ69U+kdUeSQA==
Message-ID: <c356fbfa-0787-4314-862c-aa51972d59d7@kernel.org>
Date: Tue, 22 Sep 2026 10:48:53 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: add pinctrl states
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, s-kochidanadu@ti.com, a-kaur@ti.com,
 s-tripathi1@ti.com, vishalm@ti.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
 <20260914-unbreakable-competent-beluga-efb5ad@quoll>
 <20260915164819.nlgpuvf37rhzgc66@uda0506412>
 <dec4f6e1-115e-46dd-8fb9-a3c67f1a8811@kernel.org>
 <da881fb0-93da-4d75-88da-8898b2c734eb@kernel.org>
 <20260915174103.ad6tjy6w6s24h2yc@uda0506412>
 <20260916-dancing-loud-guan-fbb1eb@quoll>
 <DLGUOGCLFAI9.2JSS4DCFRYTNI@baylibre.com>
 <dfd82438-1c40-42b7-8a90-bd349a476489@kernel.org>
 <arGGhvIieis2_sZ9@google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <arGGhvIieis2_sZ9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/09/2026 21:35, Dmitry Torokhov wrote:
> On Sun, Sep 20, 2026 at 12:24:32PM +0200, Krzysztof Kozlowski wrote:
>> On 16/09/2026 17:36, Markus Schneider-Pargmann wrote:
>>> On Wed Sep 16, 2026 at 9:17 AM CEST, Krzysztof Kozlowski wrote:
>>>> On Tue, Sep 15, 2026 at 12:41:03PM -0500, Kendall Willis wrote:
>>>>> On 19:07-20260915, Krzysztof Kozlowski wrote:
>>>>>> On 15/09/2026 19:05, Krzysztof Kozlowski wrote:
>>>>>>> On 15/09/2026 18:48, Kendall Willis wrote:
>>>>>>>> On 12:13-20260914, Krzysztof Kozlowski wrote:
>>>>>>>>> On Sat, Sep 12, 2026 at 04:33:53PM -0500, Kendall Willis wrote:
>>>>>>>>>> Document pinctrl properties on the gpio-keys device node. By using the
>>>>>>>>>> wakeup pinctrl state, the pins are able to wakeup the system from a
>>>>>>>>>> low-power state. The default pinctrl state describes the default pin
>>>>>>>>>> configuration.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>>>>>>>>>> ---
>>>>>>>>>>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
>>>>>>>>>>  1 file changed, 16 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>>>>>>>>>> index cc78c2152921308fe0cad3e29ca78a5fad08f066..b554933e93412d8b6c2ec401dc1e1eeff57d4190 100644
>>>>>>>>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>>>>>>>>>> @@ -22,6 +22,22 @@ properties:
>>>>>>>>>>  
>>>>>>>>>>    poll-interval: true
>>>>>>>>>>  
>>>>>>>>>> +  pinctrl-0:
>>>>>>>>>> +    description: Default pinctrl state
>>>>>>>>>> +
>>>>>>>>>> +  pinctrl-1:
>>>>>>>>>> +    description: Wakeup pinctrl state
>>>>>>>>>> +
>>>>>>>>>> +  pinctrl-names:
>>>>>>>>>> +    description:
>>>>>>>>>> +      When present should contain at least "default" describing the default pin
>>>>>>>>>> +      states. The second state called "wakeup" describes the pins in their
>>>>>>>>>> +      wakeup configuration required to exit sleep states.
>>>>>>>>>> +    minItems: 1
>>>>>>>>>> +    items:
>>>>>>>>>> +      - const: default
>>>>>>>>>> +      - const: wakeup
>>>>>>>>>
>>>>>>>>> This will introduce new warnings, which should be being fixed in this
>>>>>>>>> patchset (e.g. at91-kizbox3-hs.dts).
>>>>>>>>>
>>>>>>>>
>>>>>>>> Will fix the binding to work with current device trees.
>>>>>>>>
>>>>>>>>> But nevertheless, isn't second state the sleep state? How can you
>>>>>>>>> configure pins for the wakeup state - like being in the wakeup? You
>>>>>>>>> configure the pins for given state, which will be a system suspend, so
>>>>>>>>> sleep?
>>>>>>>>>
>>>>>>>>
>>>>>>>> The sleep state usually refers to putting the pins in a state to save
>>>>>>>> power. The wakeup pinctrl state is for putting the pins in a state to
>>>>>>>> allow wakeup from suspend for that device. Both 'sleep' and 'wakeup'
>>>>>>>> are for system suspend, but they fill different functions. The CAN
>>>>>>>> subsystem also uses the 'wakeup' state in addition to the 'sleep' state
>>>>>>>> [1].
>>>>>>>
>>>>>>> So you mean sleep would be a separate state? But then aren't both
>>>>>>> exactly the same states? IOW, if device is wakeup-source, it will have
>>>>>>> for "sleep" state pin configuration allowing to wakeup.
>>>>>
>>>>> The 'sleep' and 'wakeup' pin states are both used for suspend. They
>>>>> would just be used separately since only one could be used at a time.
>>>>> The reason 'wakeup' is separated out is because it is more specific for
>>>>> allowing wakeup from the device.
>>>>
>>>> If they cannot be used together, then it is the same state.
>>>
>>> If I understand this patch correctly, 'sleep' is not relevant here.
>>> But 'sleep' and 'wakeup' serve different purposes and can be
>>> used/defined together in a single device in the devicetree:
>>>  - 'sleep' describes the pin state during suspend if wakeup is not
>>>    enabled by the user or there is no 'wakeup' pin state defined.
>>>  - 'wakeup' describes the pin state during suspend if wakeup is enabled
>>>    by the user.
>>> If the user enables wakeup, 'wakeup' is the relevant state and otherwise
>>> 'sleep'. Which one applieas is a runtime decision of the the user.
>>>
>>> I introduced these two states for m_can for that reason. This was
>>> discussed here:
>>>   https://lore.kernel.org/r/DCD1YPX4T779.ADK4JCGW1MU7@baylibre.com
>>>
>>> And then reviewed/applied in v10:
>>>   https://lore.kernel.org/r/175993598226.3512549.5295923279078928995.robh@kernel.org
>>
>> So we seems to be discussing same issue again, because commit msg lacks
>> proper explanations.
>>
>> The problem and difference here is that there is no sleep state.
> 
> Isn't there? 

Isn't. Quoting patch:

+    items:
+      - const: default
+      - const: wakeup

No sleep. :( So both the commit msg, rationale and could improve so we
won't be asking the same questions at v2.

> The wakeup can be controlled from userspace and can't we
> possible have 2 distinct pin control states, one for when a device is a
> potential wakeup source, and another one when the device is in "off"
> state while system is asleep?
> 
> Thanks.
> 


Best regards,
Krzysztof
