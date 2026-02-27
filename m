Received: from hognose1.porkbun.com (hognose1.porkbun.com [35.82.102.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77583563D6;
	Fri, 27 Feb 2026 23:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.82.102.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772233824; cv=none; b=HkwmMm7jYl9H3dkoUuBmiCwLaQQa1DZjG/gpyDKA8jUwh5dSc82OQrN/qd++KWTjh7O05Sy0NBDDNZXQPEb2HStQKgtWfJFQ7BP4uubP4C1VbHbrWAG2W756LS/S45kExDOrrTJlZ5diB1oZY3LknbmOA1ua/tBGuOij2/mOa5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772233824; c=relaxed/simple;
	bh=ytDTTvj+3cOYdOeFq174/k+vJdt+338WqbIK9zDSpww=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bBCy1r1WrOQrvxDUQLEoxXkgUXfL4L++Mh/RsFc40PiHiZIxHDiyf7udjeBSUzFrCChHZt/t7kVZnWNCfrHu1FWEcCt3AkC4u0VkDRx6E6qwvKC42lz/okExst8ppy+ORMsCKiW7gD3MhhIPpKnEEAU/S4o5gjk60HPI/2kFT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=altimeter.info; spf=pass smtp.mailfrom=altimeter.info; dkim=pass (1024-bit key) header.d=altimeter.info header.i=@altimeter.info header.b=SeD/uHdO; arc=none smtp.client-ip=35.82.102.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=altimeter.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altimeter.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=altimeter.info header.i=@altimeter.info header.b="SeD/uHdO"
Received: from webmail.porkbun.com (unknown [35.86.129.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: linux-kernel@altimeter.info)
	by hognose1.porkbun.com (Postfix) with ESMTPSA id EA028461FB5;
	Fri, 27 Feb 2026 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altimeter.info;
	s=default; t=1772233817;
	bh=Thdb+pZ4/hiCXoNxxzNQ6j+SwRbjywgt1AD45Lsad/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SeD/uHdOO8WgrHPkkHBcuL2o1cUkuSD3zROK7scYTfU3uuEGu1xFQqNofbD+RC4uk
	 AAaYcapoHQX7EkLDviksNbi4PurPLFb+q7BuPssR1FLE1DhQZHPsM53+8Y1cfsgmBv
	 LuhcoPUUm+MW+fRurd9ge68rLSAEqgb5K/DhSSj8=
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 Feb 2026 15:10:16 -0800
From: Ivan Gorinov <linux-kernel@altimeter.info>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2] HID: winwing: Enable rumble effects
In-Reply-To: <s44p8pqp-6934-0r6q-n712-o5p5n2qs0429@xreary.bet>
References: <20260226054913.GA8668@altimeter-info>
 <s44p8pqp-6934-0r6q-n712-o5p5n2qs0429@xreary.bet>
Message-ID: <f9ae4ed457bcfebe9f9ad1c7305b986b@altimeter.info>
X-Sender: linux-kernel@altimeter.info
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 2026-02-26 06:58, Jiri Kosina wrote:

> On Thu, 26 Feb 2026, Ivan Gorinov wrote:
> 
>> Enable rumble motor control on TGRIP-15E and TGRIP-15EX throttle grips
>> by sending haptic feedback commands (EV_FF events) to the input 
>> device.
>> 
>> Signed-off-by: Ivan Gorinov <linux-kernel@altimeter.info>
> [ ... snip ... ]
> 
>> +
>> +        buf[0] = 0x02;
>> +        buf[1] = 0x03;
>> +        buf[2] = 0xbf;
>> +        buf[3] = 0x00;
>> +        buf[4] = 0x00;
>> +        buf[5] = 0x03;
>> +        buf[6] = 0x49;
>> +        buf[7] = 0x00;
>> +        buf[8] = m;
>> +        buf[9] = 0x00;
>> +        buf[10] = 0;
>> +        buf[11] = 0;
>> +        buf[12] = 0;
>> +        buf[13] = 0;
> 
> Do these magic numbers have any real meaning, or is it just mimicking
> observed binary stream?
> It'd be nice to have at least short comment explaining it.

Mimicking USB requests captured by usbmon when the vendor's app is 
running in a Win10 VM (Qemu).
I will add some comments.
