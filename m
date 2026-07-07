Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC92F8E95
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 02:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392518; cv=none; b=krD2RO85iMYl4EBAhKBxaIdUCHNta/OmFJy9V44tUx9YsiNYwAG3hRLYlWnraj0vViZTO/wHBrTApKDvvSswpLe5tcw2b84zcGL3hyS+LaUfoDwjIGnEXuHIQV27y62QfyOIiH6PYkpyF5kBHIOgxz5tx8h8SU8yCQzTDTgTknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392518; c=relaxed/simple;
	bh=NQzHE3fUJ6IHoob+p1h8G0amJc0TiSba5Hwg8F42GsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0KuGLdpRa0GXTkEzGDsvKZ3C23a96TNZNPaDwAZuFuRnyNb74iTjg1i5uprlWgVLtwIB6Er4JuBOfD5ArYpMcz7JySVu86CVLaX3AibDG5yWLrFR0W1Wzp/EZPbH4QrgCV4z823QCj6gcM8UKy9yLm41Xjbyb3d5A1B1rSePok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=eHMqrx4k; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="eHMqrx4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1783392510; bh=NQzHE3fUJ6IHoob+p1h8G0amJc0TiSba5Hwg8F42GsI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eHMqrx4kS47tzLey1RTaGJkHZryAj7pzKcRVYZCuTO0P/UYZsPCP5O/DzQAAHRaLW
	 QGvaunQlkFgIAF/SPRjS1irUCh3DyEPNshYtrKiCvAHikxzFugpWW+JDOBS2+0UG7Q
	 zi0Y+OxZ7ouMKLbjgiGuovol3DiJ+oeYXhr5ru5NAtzISyU+SE/VCVy42QNu+EafvF
	 NNEkNRAsv5zbjsuXqpbcNGx+Ot5zarN1VtpaHX7Y2fNwW1aBOWscJ9EjINFWdt0N/O
	 lyBpIIoieMfzArz8DLB7ZBNDxHvQwp/IKUPEYRZvtFQA3f5PPLLZPNknS3gca8vasm
	 pcbpAzkL5mTqQ==
Received: from [192.168.0.27] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 709BAA062;
	Mon, 06 Jul 2026 19:48:30 -0700 (PDT)
Message-ID: <6f9d2330-8d60-4725-83dc-f72f52a974a1@endrift.com>
Date: Mon, 6 Jul 2026 19:48:28 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] HID: steam: Reject short reads
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
 syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
References: <20260702222145.1863104-1-vi@endrift.com>
 <20260702222145.1863104-9-vi@endrift.com>
 <CAMuQ4bVSA-Ca8RKaCeRASO=HJV=hkPDNOPyfdg6TZm7BQURnSA@mail.gmail.com>
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
In-Reply-To: <CAMuQ4bVSA-Ca8RKaCeRASO=HJV=hkPDNOPyfdg6TZm7BQURnSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yousef,

On 7/3/26 4:26 AM, Yousef Alhouseen wrote:
> Hi Vicki,
> 
> I think the length comparison is reversed here.

You appear to be correct. Not sure how I messed htat up.

> 
> hid_hw_raw_request() includes the report-ID byte in ret, while
> steam_recv_report() strips that byte before copying, so only ret - 1
> bytes are present in data. The encoded report body is data[1] + 2
> bytes (command, length, and payload). A short report therefore
> satisfies:
> 
> 	ret - 1 < data[1] + 2
> 
> or equivalently:
> 
> 	ret < data[1] + 3> 
> The current data[1] > ret + 2 test will miss the usual short-read
> cases. Also, when ret == 2, only data[0] was copied, so reading
> data[1] is itself uninitialized despite the ret >= 2 guard.


In theory you'd be correct, but in practice I've already cropped that byte off when doing the copy from buf into data, decreasing ret by 1 (if positive). Thus, both of those bounds are correct as 2 instead of 3. However, that decrement is based on a min(size, ret - 1), which means that if size is e.g. 3 but the reply is e.g. 5, overwriting ret will still appear as a short read. That is another bug in this code, but distinct. I'll fix that in v2.
> 
> Perhaps the check could be structured as:
> 
> 	if (ret > 0 && (ret < 3 || ret < data[1] + 3))
> 		return -EPROTO;
> 
> with the diagnostic adjusted depending on whether the two-byte header
> was present.
> 
> Thanks,
> Yousef
> 
> On Thu,  2 Jul 2026 15:21:42 -0700, Vicki Pfau <vi@endrift.com> wrote:
>> Steam Controller FEATURE reports encode the size of the message in the
>> message itself. Previously we were trusting that the size reported matched
>> the size we actually read, leading to a potential issue with short reads.
>> Instead, we should actually verify the length of the read.
>>
>> Fixes: c164d6abf384 ("HID: add driver for Valve Steam Controller")
>> Reported-by: syzbot+75f3f9bff8c510602d36@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=75f3f9bff8c510602d36
>>
>> Signed-off-by: Vicki Pfau <vi@endrift.com>
>> ---
>> drivers/hid/hid-steam.c | 6 ++++++
>> 1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
>> index 593151709cf1..e97431bc2828 100644
>> --- a/drivers/hid/hid-steam.c
>> +++ b/drivers/hid/hid-steam.c
>> @@ -389,6 +389,12 @@ static int steam_recv_report(struct steam_device *steam,
>> hid_err(steam->hdev, "%s: error %d\n", __func__, ret);
>> else
>> hid_dbg(steam->hdev, "Received report %*ph\n", ret, data);
>> +
>> + if (ret >= 2 && data[1] > ret + 2) {
>> + hid_err(steam->hdev, "%s: expected %u bytes, read %i\n",
>> + __func__, data[1] + 2, ret);
>> + return -EPROTO;
>> + }
>> return ret;
>> }
>>
>> --
>> 2.54.0

Vicki
