Received: from outbound.soverin.net (outbound.soverin.net [185.233.34.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DD221723;
	Wed, 27 May 2026 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.34.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779867550; cv=none; b=I82A2HF/MYBsxEccBHSJsJwbBuipbae4md9i/J0FOP7EZHwe1JJhG0G9fYxWl/T81MoLBNxKeA+WUjcviE2vOudwVoZ762VvEWIgdeDbOMraKy7x2FYfMU4J+lAKw+ShC5UkyOoSP+cVXobvSnBNz7wSJ3UISRsI6FBSs9/7M7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779867550; c=relaxed/simple;
	bh=bS4me3VHd0oux3Vn0ftSpX0EIhEiAOzXWyNcuhDwpGc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=abll7/zRh+etkFXM/5Zya0bTo6b+Mo9HYC3exu+Kw15HXytG13Y1HobhCuB4VMiq5JDRycuaRhpKfa7tuRN7ZpAJ2/JqJlUa7xV1gSuj1BJYEu/r7++6P34jhJ2pocYCRI6K8qi30cK2WM1E8Wubg4Ns4xAWdGiCg8/tRJ6uHPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jjverkuil.nl; spf=pass smtp.mailfrom=jjverkuil.nl; dkim=pass (2048-bit key) header.d=jjverkuil.nl header.i=@jjverkuil.nl header.b=VC5NaRch; arc=none smtp.client-ip=185.233.34.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jjverkuil.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jjverkuil.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jjverkuil.nl header.i=@jjverkuil.nl header.b="VC5NaRch"
Received: from smtp.freedom.nl (unknown [10.10.4.107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by outbound.soverin.net (Postfix) with ESMTPS id 4gQM1r6Gh8z1MdM;
	Wed, 27 May 2026 07:38:56 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [10.10.4.107]) by freedom.nl (Postfix) with ESMTPSA id 4gQM1q5Dwdz4M;
	Wed, 27 May 2026 07:38:55 +0000 (UTC)
Authentication-Results: smtp.freedom.nl;
	dkim=pass (2048-bit key; unprotected) header.d=jjverkuil.nl header.i=@jjverkuil.nl header.a=rsa-sha256 header.s=soverin1 header.b=VC5NaRch;
	dkim-atps=neutral
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jjverkuil.nl;
	s=soverin1; t=1779867536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7oBvJJHP9myU8RCuLTP4WJXbyCN3Ps/B/utCRjtg0E=;
	b=VC5NaRch94XY/G/XilJKJnml9Av/mJXto5QSps/+kmKydvGo+r8CFji6UhuvtLEvFteeZj
	VSFfdmtj+TQTbnmBq8aBWnAmAq8iaynJ7rJVU+lT4wpjMiPxqRKQAVXxUMqewt9ZJoLpME
	aP+RniYzhkWff11KBgMCiuQgI3M7jY848dbaaPuGyP5t78HR482k9djrdI46YTZY83c7Pe
	uHyC6VkHKVtmNU0CN5fnbHt9btSYuiZiLUX/wB8R43Vz6/oPb+DAbUIW0EaK7uRYqxLAeu
	0qIy1tycT3fDx9C9cujYVeWjhHHMsTga4C7ZoB0SZ9OKMtiVS1bmXr8dkIKeOA==
X-CM-Envelope: MS4xfLTCSg6FcNICcs4FaBwqXSgyY5Biws8MIu8XEBixWQ99TN6hg/93gCGmKE1/S50nyhZGN0kTnXeGJTvSHDfgleQUuH8vQ8zZiuWo8a5PXqZzIp5x1aXg n/HZy+9MJ/s2PCvn8OFkfnDZTJ6GJlQGUj90cc4umYqaEJXrHhBpPWmzvBEr6z8FWcjLHueZO8IXOZ2R4letovD4cN9LI50fR5FiRtPoFf2jb1Icnk+rFiwi sRX+w9qrujCkNWy+QPHRsdVe1/zr1rjypPTUG/EaizoZb8h8ThVQqSNb5c2SLFH0yQf8f4e2prWpSsclqDAii+H666nz/+s5KTs11tKZeVfqFwrUIHxzCoJ/ A1pCYu/x2l0Kfbp39HcArc81klbfkeUj+OBniJT5D4yC+ydiM7k=
X-Soverin-Id: 019e685f-4a80-7206-bb05-79e009b2d40a
Message-ID: <bc33bb80-6e21-4870-82c8-6d4714127a90@jjverkuil.nl>
Date: Wed, 27 May 2026 09:38:09 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hans Verkuil <hans@jjverkuil.nl>
Subject: Re: [PATCH] Input: rmi4 - release F54 queue on video registration
 failure
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Myeonghun Pak <mhun512@gmail.com>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
References: <20260524182351.27658-1-mhun512@gmail.com>
 <ahXYreASLGSPuIe_@google.com>
Content-Language: en-US
In-Reply-To: <ahXYreASLGSPuIe_@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spampanel-Class: ham

On 5/26/26 7:36 PM, Dmitry Torokhov wrote:
> On Mon, May 25, 2026 at 03:23:45AM +0900, Myeonghun Pak wrote:
>> rmi_f54_probe() initializes the videobuf2 queue before registering the
>> video device. If video_register_device() fails, probe only unregisters
>> the V4L2 device and leaves the initialized queue unwound by neither
>> remove nor file release paths.
>>
>> Release the queue before continuing through the existing probe error
>> path.
>>
>> This issue was identified during our ongoing static-analysis research while
>> reviewing kernel code.
>>
>> Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
>> Cc: stable@vger.kernel.org
>> Co-developed-by: Ijae Kim <ae878000@gmail.com>
>> Signed-off-by: Ijae Kim <ae878000@gmail.com>
>> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
>> ---
>>   drivers/input/rmi4/rmi_f54.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
>> index 61909e1a39..fca7b9fec5 100644
>> --- a/drivers/input/rmi4/rmi_f54.c
>> +++ b/drivers/input/rmi4/rmi_f54.c
>> @@ -722,6 +722,7 @@ static int rmi_f54_probe(struct rmi_function *fn)
>>   	ret = video_register_device(&f54->vdev, VFL_TYPE_TOUCH, -1);
>>   	if (ret) {
>>   		dev_err(&fn->dev, "Unable to register video subdevice.");
>> +		vb2_queue_release(&f54->queue);

vb2_queue_release is not needed here: since the video device was never 
created, it also never started streaming, and this call is only needed 
if streaming is in progress.

Looking at other drivers I see that in most cases they shouldn't call
vb2_queue_release at all. I need to go through the media drivers and
fix them.

In any case:

Rejected-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

>>   		goto remove_v4l2;
>>   	}
>>   
> 
> Hans, could you please Ack or Nak it? It is unclear to me if this
> cleanup is mandatory and whether it is also needed in rmi_f54_remove().
> 
> Thanks.
> 

