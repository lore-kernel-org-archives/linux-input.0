Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF872BE051;
	Tue,  6 Oct 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.39.247.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310596; cv=none; b=BLp0jmbcMy+Th0/Mv8gW36dL9FRPol23c8coiXXnHv5/iwcR3tHkE2anhpeX128KUjarkrYS00jnrU3SXHR+4kXGgK5KAEGVLBYsAjOY7l7gfIbRR1HZMs01ccUxHWRddt1pN4r5EuhOkyZ1O8G8uQfHzsqVJnMN9S0/m7L2vqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310596; c=relaxed/simple;
	bh=x2vr3dF1DWdZ2SUcRfb773bwTgUZ5TNV+HWv16ROyw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQVqkyE7LT93wMKT/WyMCStF9Be0jT8HcYoH90QwS/UT15d3xViVXfONo6syf9tyoqROvw9lhG5wADvqHt5gsG68+WTsL2URq7qBegwcgeC3+eZ+gzi7oRic0fj6SCy2BOE0eIxhRxH21R/EY2Et6vJMJE2dJzItIRLNSesW460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev; spf=pass smtp.mailfrom=cyberchaos.dev; dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b=sOtzM009; arc=none smtp.client-ip=195.39.247.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.b="sOtzM009"
Message-ID: <2687bc3e-b73a-415c-8c68-8249e1fe4e6b@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1791310194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZ7Zbdj+yKYKNXrBaPGB9zhpgSXQIaPLXdeU1VEC/2g=;
	b=sOtzM009DrBMvU9D6riKuu1ASNyS2/4w4Xm0K/Nx+RPjC8cIbI0xqFpo2urN42HF0elFcX
	kQXqcZ42s6Tso4JvM6tsYw8uZ07FnJyagBKCKbiD05AJaHZGX7Q+L/y4LH6G6CRxjPHLkf
	Hj0a26GpymZcg0YKSUBZ1aFuQeBitN8=
Date: Tue, 6 Oct 2026 20:09:47 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 04/10] dt-bindings: input: apple: Add DockChannel HID
 transport
To: Rob Herring <robh@kernel.org>,
 Michael Reeves <michael.reeves077@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-input@vger.kernel.org, Yureka Lilian <yureka@cyberchaos.dev>,
 Julian Braha <julianbraha@gmail.com>, Sasha Finkelstein <k@chaosmail.tech>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
 <20260925-apple-mtp-keyboard-final-v4-4-304c267518f4@gmail.com>
 <20261006160049.GA2406717-robh@kernel.org>
Content-Language: en-US
From: Yureka Lilian <yureka@cyberchaos.dev>
In-Reply-To: <20261006160049.GA2406717-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/6/26 18:00, Rob Herring wrote:
> On Fri, Sep 25, 2026 at 10:09:31PM +1000, Michael Reeves wrote:
> [...]
>> +
>> +  mboxes:
>> +    items:
>> +      - description: ASC mailbox used for RTKit control
>> +      - description: DockChannel FIFO mailbox used for HID packets
>> +
>> +  mbox-names:
>> +    items:
>> +      - const: asc
>> +      - const: dockchannel
>> +
>> +  iommus:
>> +    maxItems: 1
>> +
>> +  stm:
>> +    type: object
>> +    description:
>> +      STM interface providing the vendor, product and version identifiers
>> +      and serial number shared by the HID devices. When present, the host
>> +      must query this interface before registering the keyboard.
>> +    additionalProperties: false
> An empty node is unusual. Why can't you just query the STM interface and
> treat it not existing or having those properties the same as no 'stm'
> node.

The issue is there is no indicator for the stm *not* being present: We 
boot the MTP coprocessor, and then receive a message when the stm is 
available. In that case we know it's ready and we can proceed with 
obtaining the serial numbers and registering the hid devices. But if 
there is no stm, we simply do not get the stm ready message, and the hid 
devices are never registered (this is the case in the original 
downstream Asahi dockchannel-hid). To make the stm optional *without* 
taking the information from the device tree, this would require some 
sort of timeout for waiting for the stm ready message. I outlined the 
available options in this thread[1] and argued the empty stm subnode 
makes sense, since this is describing a peripheral which may or may not 
be present (and this information is useful to initialize the device 
properly).

Link[1]: 
https://lore.kernel.org/asahi/bbaca769-312c-4a24-9524-16cb2b4f277f@cyberchaos.dev/


Thanks,

- Yureka


