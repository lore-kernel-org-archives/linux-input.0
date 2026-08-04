Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7142E8DD;
	Tue,  4 Aug 2026 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785830544; cv=none; b=QOTG6in2Cjie/M7Ce6VgNZXbV9DOeLBPoc6ldvDcBUKpTu5u/O8ZIXijjxeeY9lwa5UqNfe0xnZUsQ0K8HXpSylKOR9yxPthzMInCJRJS3b5yuXLgFvwPnTprZZj+6bR8grMEbZdneeopFEvn7442rI/ayV4373ZkQAjk8LFzhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785830544; c=relaxed/simple;
	bh=pG3EVgqIvbZnSgpk957Ha+nWQjvXv0NLfo0AdSGRry4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFRKlfE3/zxiznJLNx7SNQbFLdJv9ho+ibcjarOOOrVonfbjCMcGVTNxxzouT8gDEglVSCYBWlkRz+yxz93byBwabV5KFrUuGxOgDT0x6TpnYKcCbcydBpkc1iJbdnhAX5xP7qjMONQ/wpeM/kPhMmqJUUMnuYCxa9svEf0Oz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=F4Jink/C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jEAAyXfL; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="F4Jink/C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jEAAyXfL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 869707A0045;
	Tue,  4 Aug 2026 04:02:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 04 Aug 2026 04:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785830537;
	 x=1785916937; bh=aWTUcPVr/evagyqHivUsnZPDcpUu7p23rLzEyEGYUDU=; b=
	F4Jink/CcQ90VF9eYn9UK4zEl/U6Gkqk2ca4M96k5hQsslV1d0Fdvf3s3Adqx306
	m4l0AG5FAztVTEbO3yiGVSoKif2s3Cnshcw1NVWUWkdJrttjCSoKqtX335hCqUk8
	OUOngM4pIUaQQ6dmZfkTtLVFZxmoZ8As2IsxzRWhzxlPIwhyvsPpmQXM54xf8TaV
	/JpE9+8Fym+T/I9FNEj92kbiUocpZriijXSZHCXtCHGm/DKqBpVOGTvkXIvBbTUe
	3DMhldGMYRrztKggq0KD2Xerw14SHwFsjItcyzTnJja1xeZ1+MIfmU4r4+E0d/4s
	U7wq6BrLVNQevddOfr0lJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785830537; x=
	1785916937; bh=aWTUcPVr/evagyqHivUsnZPDcpUu7p23rLzEyEGYUDU=; b=j
	EAAyXfLyoGdB/a0dFdcR+yTHH8KkcFPu1mhfTEHG8bI3YykNGcEnn4c83ny10QGt
	JxLhQsbRGHeF5rVlrYZTbRo4GMbOpw1ydoGXwHXUmXzZ0u4R7cUYUzi0uV0a2UmW
	8sqGLaCOuCxvejBTBdbj5ypUlEs383BQ2WpYve4aOltRwtaHE4ihatDDT96t7UHy
	L4qdUkM2O3RsurR3/PXX7ScAUPYVM9fdN0yTEDGjXUi1bZGRc+ctvkSfk6fZiD8I
	3rboTNe2yQhdVXqfJ33B+DVnQSI1xflOibYiDFyAWCxewmD9M30Y0QztAjbUVOBx
	M6whk5ZZMvKgsC+XafBcg==
X-ME-Sender: <xms:iZxxaimufXlev9c-HKFdIwz01epkSv8o47CU3Ri97ZrWrsTPFS-_xQ>
    <xme:iZxxarUnaUb_VHtdIPUS1bcVi3EALhkXu-ctyqHV-sFoZ2sp_DQYiyiTvDlshlfGX
    M7b3udn4U7KG98d1ezyiKj6iULnPW0A2dZawBeLzQPYD9gcdfg>
X-ME-Received: <xmr:iZxxagtDZDpFBN3d2iTt6VnUs3QJWufMQYMhe-XrZSXPCRGnDIG_NXWlIpYOS5DniOzOD5_ijcehJnDgQgyE6YxCZ6OPU1iSomh4CJrs-9QLiBmgRVI>
X-ME-Proxy-Cause: dmFkZTFHrmUYQx/7BdqUI0OodASGrSuRg4/XdyscnSO0sxcGCRPVvCwmVyOnMYIbrj5FHT
    eK8fVqOnwNfdDqUbyGfq0pa1t6eUc+btAS9pztxgdFGgVK19Zuv3Z2sJp1IbCbp5iDyaE8
    xQvdUCEfHNUNwk68wLosMASkEf+t1m2NzXkUetx6fAxM7syCeNvPFD5LJ0QcmXbOOqb0dR
    OLRxrWwVJ3TsCC3yWUsNfeN7/3SA9SRQU/2CH+ikJMExPUveLdgCafNZPcGQ9SHevg2Tck
    9erouizVTMI4X9/xb6fNhw880RMb4pDOCIDXDuWu3YQdyoJKrRCoC9jWuNpL6ZCyIwwVnn
    2ewqhh9a7ChgSzCjJ74q4t/SMaOd8EmgerrKE/KpQwodjpDSgCkUYdZQFj/a9yoDfkF/q6
    897GO+MvDhJWSMmhtsu/IHRQc3czKwHEpkHaDWPLV0LFfgdbYXAlOIQndHPFH2fIG962UD
    gl7wC2hiz2vUsE+AevjgYA0KVDcc8Ou24X4aijibN/rL2DooohhjOScW7eE431cL6sCdza
    HhKFOrNOEbHItUQ90ZMM81ssfY1BRZW/eqEBzrKPfNr746djHMyr9TPK5WawHVE6EB5Nhr
    Tnwy9nbDWI12eXPggCG6lEa24N0h3szFcHGKhC+mKFkCOb5pCtcqcEvp+bDw
X-ME-Proxy: <xmx:iZxxambHDE3Cg-6RLUoR0Xd9EjIfvIegkRhi4yWxvK_smxnvHyoB1Q>
    <xmx:iZxxanXS1-WKJXnCwdDtGml0IjpkELtU7M3gmmSHdcvJ2U4QqJD_lw>
    <xmx:iZxxajT7RjUJP0qW7llruy15dGE7YiV1DmPb6hMkFeptZNQyglHqjQ>
    <xmx:iZxxatMHnWkVE7ouKi1WVkKKJ2BvnVD2EydbkvlfUSPYvp2uL75DgQ>
    <xmx:iZxxalbmN_OeG-uiJTwG29qgva4txyE4NuAhWqg4OX6EEKxobEADhQvs>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 04:02:16 -0400 (EDT)
Message-ID: <adb228d4-abef-441c-91ff-fe009cd899e8@kroah.com>
Date: Tue, 4 Aug 2026 10:02:12 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Input: xpad - add safer data access framework
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
 <20260803-xpadone_packet_fix-v1-1-280da203f15c@kroah.com>
 <anDAK28M7wBWtzSf@google.com>
Content-Language: en-US
From: Griffin Kroah-Hartman <griffin@kroah.com>
In-Reply-To: <anDAK28M7wBWtzSf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 8/3/26 6:23 PM, Dmitry Torokhov wrote:
> Hi Griffin,
>
> On Mon, Aug 03, 2026 at 05:07:24PM +0200, Griffin Kroah-Hartman wrote:
>> USB xpad devices could send short messages which would cause reads and
>> writes outside of the data buffer.
>>
>> Fix this by adding the safe_data struct and the sdata_check() function when
>> accessing packet data for input events, and add the usage of this to
>> xpadone_process_packet(), which was vulnerable to OOB reads/writes.
>>
>> Suggested-by: Ingo Molnar <mingo@kernel.org>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
>> ---
>>   drivers/input/joystick/xpad.c | 115 ++++++++++++++++++++++++++----------------
>>   1 file changed, 71 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
>> index feb8f368f834..c516860711a8 100644
>> --- a/drivers/input/joystick/xpad.c
>> +++ b/drivers/input/joystick/xpad.c
>> @@ -780,6 +780,24 @@ struct usb_xpad {
>>   	bool delayed_init_done;
>>   };
>>   
>> +struct safe_data {
>> +	unsigned char *data;
>> +	u32 len;
>> +};
>> +
>> +/*
>> + * Safe Data Check
>> + *
>> + * Returns the correct data when inside the array's bounds,
>> + * returns 0 when accessing an out-of-bounds index.
>> + */
>> +static u8 sdata_check(struct safe_data *sdata, int idx)
>> +{
>> +	if (idx >= sdata->len)
>> +		return 0;
>> +	return sdata->data[idx];
>> +}
> I'd rather we had explicit length checks for various packets and skipped
> the processing if the packet is short instead of making large number of
> what can be considered repeated checks.

Sure thing, I can instead replicate something similar to my original 
patch here:

https://lore.kernel.org/all/20260727-xpadone_length_checks-v1-1-19aa9331e82d@kroah.com/

Ingo had suggested this method instead.


Thanks,

Griffin

