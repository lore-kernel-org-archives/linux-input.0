Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D21257855;
	Tue,  4 Aug 2026 01:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785807713; cv=none; b=QLNVFYWKGlzQLpyc5sKvC8XLbZw9QEC3JbpJqG/rv91GX44KEs/Ufevtlk/5/rjg/aPd8ecbmPJq5wv2ziGBi8sb5TL+G657qR3PwauyQNG7Wx6+CsbSrVrn1MbIgzmgqfqitZr7yofi12YT0YEcDe6Zb2IhN7QCgCBikjTyYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785807713; c=relaxed/simple;
	bh=5gNcFCB3Vj5V9Zpv0AFqmr3gsHDzKG4qPPzrkhBLJ4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dN5T/06w5+BGNUhG1idpxzvfdMxIIUSWGqcD2SrcNpXj9RneaLaZpMNg17qTys5va9mb9dYyM2K6yXDXdB0W3ujUFks67kFKsT2WC9nSwNJVecErNjSFDAscFrFP69UJH1KU1TX3WLxIBBA2kXMIhkf6NkoYkEQ4J990/su/Xfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a4d770728fa511f1aa26b74ffac11d73-20260804
X-CID-CACHE: Type:Local,Time:202608040858+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:30382da1-3fe8-4b40-a7f9-4314c8fc7e90,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:14b31d5e9135692ec2635d0aa24d34bf,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|865|898,TC:nil,Content:0
	|15|52,EDM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a4d770728fa511f1aa26b74ffac11d73-20260804
X-User: xiaopei01@kylinos.cn
Received: from [10.42.12.251] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1945894045; Tue, 04 Aug 2026 09:41:42 +0800
Message-ID: <1ecf4899-53f3-4688-a3cb-fa29cbf277ee@kylinos.cn>
Date: Tue, 4 Aug 2026 09:41:39 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: hid-steam: fix uninit-value access in
 steam_get_serial
To: Vicki Pfau <vi@endrift.com>, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <6a27d055.39669fcc.33b062.008d.GAE@google.com>
 <0c5f5bcd3d01776615a97d7f23b5c1bff6a2acce.1781092734.git.xiaopei01@kylinos.cn>
 <85n82qo4-q3q8-8052-1qnr-n7qo12p2p01n@xreary.bet>
 <5ad5f7d4-a29f-409a-8153-c162059807b2@endrift.com>
 <16471b27-6f78-4627-874b-9474ee28375c@kylinos.cn>
 <03420881-edf5-4102-8156-79f314284a07@endrift.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <03420881-edf5-4102-8156-79f314284a07@endrift.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/8/4 09:05, Vicki Pfau 写道:
> Hi Pei,
> 
> On 8/3/26 5:58 PM, Pei Xiao wrote:
>>
>>
>> 在 2026/8/4 04:39, Vicki Pfau 写道:
>>> Hi Jiri,
>>>
>>> On 8/3/26 12:34 PM, Jiri Kosina wrote:
>>>> CCing Vicki Pfau here ... could you please give your Ack to this fix?
>>>
>>> This was already fixed in 9f8ee99f831b2711624ef81d0abba1d183f28b09 in the series I submitted earlier. I didn't realize there was an open bug report for it.
>> Hi maintainer and Vicki,
>> I took a look at this commit. In fact, my patch was nearly two months
>> earlier than this commit. I had originally thought that this one-line
>> patch, especially for an error-path case, had been ignored by the
>> maintainer.
> 
> Yes, sorry, I wasn't marked as maintainer at the time and didn't notice it before I wrote my equivalent patch. Jiri just happened to merge mine first.
> 
It's okay.
> Vicki
> 
>>
>> thanks！
>> Pei.
>>>
>>>>
>>>> Thanks.
>>>>
>>>> On Wed, 10 Jun 2026, Pei Xiao wrote:
>>>>
>>>>> The reply buffer in steam_get_serial() is allocated on the stack without
>>>>> initialization. In cases where steam_recv_report() returns a short read or
>>>>> an error, not all bytes of the buffer are written, leading to subsequent
>>>>> access of uninitialized memory when checking reply[0], reply[1], reply[2].
>>>>>
>>>>> Zero-initialize the reply array to prevent KMSAN uninit-value warnings.
>>>>>
>>>>> Logs:
>>>>> hid-steam 0003:28DE:1102.0007: unknown main item tag 0x0
>>>>> hid-steam 0003:28DE:1102.0007: unknown main item tag 0x0
>>>>> hid-steam 0003:28DE:1102.0007: :
>>>>> USB HID v7f.fd Device [HID 28de:1102] on usb-dummy_hcd.1-1/input0
>>>>> =====================================================
>>>>> BUG: KMSAN: uninit-value in steam_get_serial drivers/hid/hid-steam.c:457 [inline]
>>>>> BUG: KMSAN: uninit-value in steam_register+0xd83/0x10e0 drivers/hid/hid-steam.c:965
>>>>>  steam_get_serial drivers/hid/hid-steam.c:457 [inline]
>>>>>  steam_register+0xd83/0x10e0 drivers/hid/hid-steam.c:965
>>>>>  steam_probe+0x6f1/0x19b0 drivers/hid/hid-steam.c:1273
>>>>>  __hid_device_probe drivers/hid/hid-core.c:2822 [inline]
>>>>>  hid_device_probe+0x60d/0xb90 drivers/hid/hid-core.c:2859
>>>>>  call_driver_probe drivers/base/dd.c:-1 [inline]
>>>>>  really_probe+0x4d5/0xe40 drivers/base/dd.c:709
>>>>>  ...
>>>>>
>>>>> Local variable reply.i created at:
>>>>>  steam_get_serial drivers/hid/hid-steam.c:448 [inline]
>>>>>  steam_register+0x180/0x10e0 drivers/hid/hid-steam.c:965
>>>>>  steam_probe+0x6f1/0x19b0 drivers/hid/hid-steam.c:1273
>>>>>
>>>>> Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
>>>>> Closes: https://lore.kernel.org/lkml/6a27d055.39669fcc.33b062.008d.GAE@google.com/
>>>>> Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
>>>>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>>>>
>>>>
>>>>
>>>>> ---
>>>>>  drivers/hid/hid-steam.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
>>>>> index 197126d6e081..f65ad1a21c01 100644
>>>>> --- a/drivers/hid/hid-steam.c
>>>>> +++ b/drivers/hid/hid-steam.c
>>>>> @@ -445,7 +445,7 @@ static int steam_get_serial(struct steam_device *steam)
>>>>>  	 */
>>>>>  	int ret = 0;
>>>>>  	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
>>>>> -	u8 reply[3 + STEAM_SERIAL_LEN + 1];
>>>>> +	u8 reply[3 + STEAM_SERIAL_LEN + 1] = { 0 };
>>>>>  
>>>>>  	mutex_lock(&steam->report_mutex);
>>>>>  	ret = steam_send_report(steam, cmd, sizeof(cmd));
>>>>> -- 
>>>>> 2.25.1
>>>>>
>>>>
>>>
>>> Vicki
>>

