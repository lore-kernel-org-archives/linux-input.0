Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983571;
	b=MGwfk8ePX5RKNGAECIrDFjuw8N4hi9eVCYTnw0NmUCa66VR8ANlAraIS7IZBaR0H9i01
	 yeS/+TvyCOQDRMlCUcV1oGyM+jVLglgyeNXtMw9OLQu6QawoLHM5qQvY0h/rSO3keVHa1
	 YIxdWN33WDz1RaUwsQvGVml/tjeyXtyaaSobCDt4XqZG4W3I9/Opkws7OqpC8OcQPB9sI
	 GmDcPK0boJ+6aHfrFUylRQxVf3+7b/2Q2PM2MWiWWtASs4ngWQ7eG7+ZqmUbeOxqkZ8Y0
	 gwxLAKtcfhf/irv7/oKR6M6boltcntuWkYxOmiSSY9lY2GLTbV1S174wclIOClRpw+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983571;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=P8QBfiTTfPiEZ9dHQMg3odXwV+kJNdFbS4BVB2JlZao=;
	b=iJQv+Iij4TyTH9Re8sddPt9G4gWK1UQsR4uq6qT3eUW4UbI6w4MyA38z6WDf7IW+CfQA
	 bO9h2i4YbiFtl8eaYa/j8PlWVYxcdhjgFU443HyHA3Ur2BnJLlzP0EP3WGK5to7m5tc4r
	 Aqc65UoWOiXys3stYm/1+mDVyrCCKedah3MgkxjyMQA1tefAdWpWEM6sys2BEhADOWo3h
	 3YLGxTv5HlzN9216gYlT/PeX5RR062jAI73dvAPHCmUKoWPCwx9sWdffM3MUsoni5MslT
	 6o6U7b5ADPS2RFMuV1x2kv3KdnvufPvpXzgf1RoNKZSqQ/YUB/qESH3g8ucnB5cPcPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jfvMsI+K;
	arc=none smtp.remote-ip=95.215.58.170
Received: from mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98D606A331
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 16:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F98D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jfvMsI+K
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=P8QBfiTTfPiEZ9dHQMg3odXwV+kJNdFbS4BVB2JlZao=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793983565; v=1; x=1794588365;
 b=jfvMsI+KuJ8UMom31avO/aEdRYsXynMr9s+g0dlF6DyGSJWwFvHz9lrxCjSu633+4Ozx6fbk
 4WV837AgyE9NwyPCH8NsK6fwbJ4OGv3hDdurd8/9y6nuZjRzoZC1MHm9FzFaE96Sm8abZISGwJF
 iqM0Fzi7G21g7Ya3aeJCoSyk=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0526edb197ecc249;
	Fri, 06 Nov 2026 16:46:04 +0000
X-Mizu-Trace-ID: 0526edb197ecc249
X-Migadu-Flow: FLOW_OUT
Message-ID: <1a79cc1d-1c47-4a87-82bd-304c63deabd7@linux.dev>
Date: Fri, 6 Nov 2026 17:46:03 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] HID: flydigi: add support for vader 5 pro
To: Mirian Shilakadze <mirian@msh.ge>, 'Jiri Kosina' <jikos@kernel.org>
Cc: 'Benjamin Tissoires' <bentiss@kernel.org>,
 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Derek J. Clark" <derekjohn.clark@gmail.com>
References: <befcd715-ecc8-463d-9617-a269dc7c62cf@msh.ge>
 <546fd97f-bbd6-4867-b86c-9a4a44ca44c6@linux.dev>
 <9231fd80-a35e-45e6-a608-858e60a7faee@msh.ge>
Content-Language: en-US
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <9231fd80-a35e-45e6-a608-858e60a7faee@msh.ge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/6/26 17:02, Mirian Shilakadze wrote:
> On 11/6/26 4:03 AM, Denis Benato wrote:
>>> Should the driver check the flag and warn or turn it on itself with 0x11?
>> I think it should have a sysfs property allowing to change it and also set
>> the most reasonable value at probe.
>
> Makes sense to me.
>
>> Since you two have the whole range of hardware and SDL has working
>> code why don't you take over? It would surely be better than me making
>> the bridge since you do own hardware and care about it.
>>
>> Let me know if you are interested and I will be more than happy to
>> make that happen!
> Yes, I'm interested. Thanks for the offer!
>
> Could you Cc your friend so we can coordinate? It would also help to
> know what the recent firmware update changed.

I have requested him to contact you via email.

He uses discord: you may opt to use OGC server (ex asus-linux) or
communicate between you two.

> If it works for both of you, I'm happy to send the next versions of the
> series and handle the review.

Sure, I also have another driver version to be cleaned up with apex 6
support.

> How would you like the handover to work? If I take it over, I would keep
> your authorship on the existing code with Co-developed-by and
> Signed-off-by. It would be great if you could stay in Cc and review.

As per rules you will need to keep my signed-off-by and git send email
will automatically include me due to that.

I don't promise timely reviews as I have quite a few things to take care of
(asus, mostly) but I will surely try.

> Thanks,
> Mirian Shilakadze
>
>
