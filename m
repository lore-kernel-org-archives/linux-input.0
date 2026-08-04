Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380B92E2EEE;
	Tue,  4 Aug 2026 01:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805547; cv=none; b=CjtcWMSOsdipv3cqxQ/sqr2LAu06PT62erMeBRlVbQc8MigcsgYzzs1hd9/N0TCT2fyGum2oriP6Veu6/Szhz621YXbcCCk+eLTvDHHGC2WloOPrY1eOhmn1s4Wq86eKZvKhr80NKBp71ghotKrVQ63KHLACp4TOcYU1Hi3Zjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805547; c=relaxed/simple;
	bh=+6h0pHFfLgNwQA2ZK8wivXDo6yd6+GxV/nV+fXywnhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rD8rv8hWr2wfnbUrl0oPQVtTfgx7024WJZHuSDJ/V8YhvDCn75aEWYzQi0W97kvfac0aVYK+TkVJL7UmdphLYJVGcl5RQPlg/hk9GJD9q4BPEeOIEOYoy/rwGtqIh38rDaRp4CwVLoucfBXxy/YmGgX/8CxiDkvlIRRJBBorGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=Q2NfXhBp; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="Q2NfXhBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785805544; bh=+6h0pHFfLgNwQA2ZK8wivXDo6yd6+GxV/nV+fXywnhE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q2NfXhBptPIcInsBomjjhktTmdeF4MIt9B9TmVj5c16VhK0JC+PXWDHl7I+gtrukg
	 hpU5lCkUR7THLbyxsXG8NA8BDCkX56V46cBkfXhY5js9UlOvkYuUTLQMUu8z72aR1o
	 57Z46TsLzaAcxF7hhHP5v2w4XXlZ2BzP0P1bIMJlqOiBlfPI2/kTD3gSzN5BDIYpQJ
	 gx+1Imurq82Sr0tfW5j/60uMptcwx2krvDP7FlEM/gMRZCXEnG0tndhJjSpXqvIoVj
	 v49cm9STDRdwkhpZ+BR9d0DhhCtYoiC4iy7iGeI6aGj49Qya1crV4ZAo3JUDXW2Kt+
	 IGTrZhNjEzbHg==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 11AB7A010;
	Mon, 03 Aug 2026 18:05:44 -0700 (PDT)
Message-ID: <03420881-edf5-4102-8156-79f314284a07@endrift.com>
Date: Mon, 3 Aug 2026 18:05:42 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: hid-steam: fix uninit-value access in
 steam_get_serial
To: Pei Xiao <xiaopei01@kylinos.cn>, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <6a27d055.39669fcc.33b062.008d.GAE@google.com>
 <0c5f5bcd3d01776615a97d7f23b5c1bff6a2acce.1781092734.git.xiaopei01@kylinos.cn>
 <85n82qo4-q3q8-8052-1qnr-n7qo12p2p01n@xreary.bet>
 <5ad5f7d4-a29f-409a-8153-c162059807b2@endrift.com>
 <16471b27-6f78-4627-874b-9474ee28375c@kylinos.cn>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
Autocrypt: addr=vi@endrift.com; keydata=
 xsBNBFtJAmYBCADmRIN9O/aBbYc93lUMvG2hPip++otLit+65EwNHB1y9BmbVr0Q8Tz7rbAM
 K2mB0EiA4Z3DesoLIOzlJq0E4fgDsAi8ok/i7aTx35d0Qeab95GEdkCMcL98xNJE0agq+KYk
 pnvFlhdyC23K32KdOijsUqqbd86GgxRZmuf/Yf932KxKAj+n0aFBw5y6i0ep7WQBF6ytpqah
 Uzy04D//smiTr6rrXg+C09MX0XZ2Fvcv3gmimnoV6C/ZCO1Zecqyhrs0YFfdIhFEBp2ItYim
 MoeU4g6y726gyRO/+wwzZkryJMU8hHootzW1gUylZeELSwx8uIJSHFiLE7AK+M5soPtDABEB
 AAHNG1ZpY2tpIFBmYXUgPHZpQGVuZHJpZnQuY29tPsLAjgQTAQoAOBYhBNj+0QMp9OPSosB4
 6X72E7X7Nb0rBQJbSQJmAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH72E7X7Nb0r
 WIcH/0GnIOkmAyy2UlgS/VKi193ZRWYJjBfUncIBf57gLt1KYY0PvUoR9MVvkLqcx8vaCxWh
 bVSqzxT6WU1ECp/URdQV2W4IGB6W4B8rT3VGw0QzbVVQRmt6vReEMFVL+vBfgHKTRBItiy7x
 Bd+JZDusiyrrGok9TqqkBYlZPWE29ajiOAe05N1UhuRq7y8w/bOkzFD36ohMtfqV4hByWV+q
 d0LujqgZm1AkM1FqpJ4j8h1Gox5rpmWfaHJmBQ8HcKqQfwACQCvDNHS2vlTXJYfxlh+mVerL
 YKZgWnyvqx4pLKqJOXQKssIaDjnDfTu6bQgXvhaKb1+piBUYuoe9/+3E15TOwE0EW0kCZgEI
 AL/KzT+NR1/LbJ7Kuv3gAHFp+S7cfyyPSamN6i6/X135vNSawG7g81iWUweAW6YahFA2haqw
 t+8/Bm9Dzc8rF6RHCElK1GoHiF4SIYQxjqPo2wwqvTad9FblWTfaYRKfVDvNz2Rz4i681JrR
 8gizvzJPX+gocH7FMzPwb1DAwL2kKA5wilgAGSv8nZqeG55hNt2t/XiT6Yd97DJv86D24UUP
 BetLTq2jUWtX+omt+JhF3QzMjnyGQYKHNXUB/ipBxNSkwnDrWg/f1EjDtNzuOHManJDC9Bqi
 qhi1abiTNlmmewI5iLEnnxzfSKS5HO9nCC1szl229DHwIMH7jA+G+z0AEQEAAcLAdgQYAQoA
 IBYhBNj+0QMp9OPSosB46X72E7X7Nb0rBQJbSQJmAhsMAAoJEH72E7X7Nb0roioIAM0oDKEU
 QH7Og4+AXm35uklIiCX6cFQPgDVlQn7M/QFLnEhhCfPTt8PkIIN4dLgs4lIJxExpgQWgOLUX
 h+ZLLupzZXoysAXfdwNLf/RqRed/zTZbUjssy4D7yeNIJThzU32kDy0Hx3pMNM/Hd9yaXmHL
 LDkfwcyQuqA9+eeOogkDC8inLNLfYQ8JtVQZuWppNcbOZkBxfMVAmPHg6C9fe2biQFojoLPe
 4nQheprKfBp5QsY2cIjP8kaWPpfJEJ5i2aNgtrfebEzjYoWWLkK78Lo8qABdxkVhH6rhAlw2
 rVf41cHNCfHF7ddvOb9IItWacXxYn7ql+dI/Se3+ISWDboQ=
In-Reply-To: <16471b27-6f78-4627-874b-9474ee28375c@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Pei,

On 8/3/26 5:58 PM, Pei Xiao wrote:
> 
> 
> 在 2026/8/4 04:39, Vicki Pfau 写道:
>> Hi Jiri,
>>
>> On 8/3/26 12:34 PM, Jiri Kosina wrote:
>>> CCing Vicki Pfau here ... could you please give your Ack to this fix?
>>
>> This was already fixed in 9f8ee99f831b2711624ef81d0abba1d183f28b09 in the series I submitted earlier. I didn't realize there was an open bug report for it.
> Hi maintainer and Vicki,
> I took a look at this commit. In fact, my patch was nearly two months
> earlier than this commit. I had originally thought that this one-line
> patch, especially for an error-path case, had been ignored by the
> maintainer.

Yes, sorry, I wasn't marked as maintainer at the time and didn't notice it before I wrote my equivalent patch. Jiri just happened to merge mine first.

Vicki

> 
> thanks！
> Pei.
>>
>>>
>>> Thanks.
>>>
>>> On Wed, 10 Jun 2026, Pei Xiao wrote:
>>>
>>>> The reply buffer in steam_get_serial() is allocated on the stack without
>>>> initialization. In cases where steam_recv_report() returns a short read or
>>>> an error, not all bytes of the buffer are written, leading to subsequent
>>>> access of uninitialized memory when checking reply[0], reply[1], reply[2].
>>>>
>>>> Zero-initialize the reply array to prevent KMSAN uninit-value warnings.
>>>>
>>>> Logs:
>>>> hid-steam 0003:28DE:1102.0007: unknown main item tag 0x0
>>>> hid-steam 0003:28DE:1102.0007: unknown main item tag 0x0
>>>> hid-steam 0003:28DE:1102.0007: :
>>>> USB HID v7f.fd Device [HID 28de:1102] on usb-dummy_hcd.1-1/input0
>>>> =====================================================
>>>> BUG: KMSAN: uninit-value in steam_get_serial drivers/hid/hid-steam.c:457 [inline]
>>>> BUG: KMSAN: uninit-value in steam_register+0xd83/0x10e0 drivers/hid/hid-steam.c:965
>>>>  steam_get_serial drivers/hid/hid-steam.c:457 [inline]
>>>>  steam_register+0xd83/0x10e0 drivers/hid/hid-steam.c:965
>>>>  steam_probe+0x6f1/0x19b0 drivers/hid/hid-steam.c:1273
>>>>  __hid_device_probe drivers/hid/hid-core.c:2822 [inline]
>>>>  hid_device_probe+0x60d/0xb90 drivers/hid/hid-core.c:2859
>>>>  call_driver_probe drivers/base/dd.c:-1 [inline]
>>>>  really_probe+0x4d5/0xe40 drivers/base/dd.c:709
>>>>  ...
>>>>
>>>> Local variable reply.i created at:
>>>>  steam_get_serial drivers/hid/hid-steam.c:448 [inline]
>>>>  steam_register+0x180/0x10e0 drivers/hid/hid-steam.c:965
>>>>  steam_probe+0x6f1/0x19b0 drivers/hid/hid-steam.c:1273
>>>>
>>>> Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
>>>> Closes: https://lore.kernel.org/lkml/6a27d055.39669fcc.33b062.008d.GAE@google.com/
>>>> Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
>>>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>>>
>>>
>>>
>>>> ---
>>>>  drivers/hid/hid-steam.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
>>>> index 197126d6e081..f65ad1a21c01 100644
>>>> --- a/drivers/hid/hid-steam.c
>>>> +++ b/drivers/hid/hid-steam.c
>>>> @@ -445,7 +445,7 @@ static int steam_get_serial(struct steam_device *steam)
>>>>  	 */
>>>>  	int ret = 0;
>>>>  	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
>>>> -	u8 reply[3 + STEAM_SERIAL_LEN + 1];
>>>> +	u8 reply[3 + STEAM_SERIAL_LEN + 1] = { 0 };
>>>>  
>>>>  	mutex_lock(&steam->report_mutex);
>>>>  	ret = steam_send_report(steam, cmd, sizeof(cmd));
>>>> -- 
>>>> 2.25.1
>>>>
>>>
>>
>> Vicki
> 

