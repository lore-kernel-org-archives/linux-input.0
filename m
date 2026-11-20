Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795172956;
	b=JKokZ6bmdQvvgQ0dAiMI0SF14B4YPLWBECnRJyVcgYD0zhQI6GTtYajs3TcFHSiJ1Ae8
	 C+BXX6LCssuZiL4ukrhJjakAZRVd3826nmOAan++kWhQi6KAbjHMFSCZKH6ohdLkHZfsH
	 Z3Q/NbgSOWwEhNTnKHV/+knRMGQWYw+sUOhiHmoPQ5vXFMN05wlzHt4KcvDHcSHThl/t0
	 imVVREd5a5GTfoDQ2KLayqeT3G7C0deRwWZpP+wL4rE4vG7cSsBC/ZI57BmiIZCD+vo+n
	 a9YxKpD8WvQeV9oXuwdw4p7Mw/BTkut/qK9nucn6HOcGKRGMMLmMAJLfE1EkP7tzUIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795172956;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=MCk598pBaKDJewYu5roXcXcvZY5TsezTZyAgGob65ns=;
	b=Vu2PNppYvgsJLA4FxRxQBkwDImu8fuDrsrrOOTKMYu4e/SVNgNbHq28qlz7XQsSgImoM
	 HZogvq2cs7qzL8Cx+H995eVh3/zqNOIzqOxhlDnXCZncbBkLLa8PiKc/LjyjVzquxdbBA
	 CxDzQS869bt/YumS9LnWkw8EVAQ4Xvfp3Hob9hbZCFcriWrbuo9HFtz93JapoWSEeO5Jp
	 VHdPXWuyWBHX17cU+ReszhA8Uq3Mf0Qqx3xfx+/oExICD0sOxKvORQC5mfXDV7FG1VPiR
	 ug/3/gv4FAGw3h/1tuassKFFO7lkrpbDjNHcBPFWpHqpFpz3SGZMV3zpZxdcEmdiIDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUOMrX8s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12E606A326;
	Fri, 20 Nov 2026 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUOMrX8s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E791F000C6;
	Fri, 20 Nov 2026 11:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795172956;
	bh=MCk598pBaKDJewYu5roXcXcvZY5TsezTZyAgGob65ns=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=XUOMrX8svA+occgo8ocF6ltdKHCocQJNdX45VJ2WMAFkph8jZFWIygy0lPS8fGFHj
	 GqzrpAxOrQetFN1HMaHQKyThVA3y7VRWcgdgh5nQJKM/1hR5Psw7jXJb2fB5lxqKRx
	 g9XAcohirfEMauGHr93eQMKvMrX9+qOLvvFv6YYP+P49UFTYMjC+ZY/5w1/rBVm7Bx
	 c3YA1wMK0MDfTuLewHBoWXlUVx60OUqdEpYCpBz2oFKiT2kGfXlU7S8h3HErun99w0
	 26EB63d3Q5NGxpoRX8fLmA/PqCyLU5+kZcymKw5OT4r1R22j2ZnlN8n+2H/IkXoz1h
	 XEpHpLR7i5IcQ==
Message-ID: <4f254948-29d5-4011-8865-c60a699d9bac@kernel.org>
Date: Fri, 20 Nov 2026 12:09:11 +0100
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
Subject: Re: [PATCH] HID: sensor-hub: Avoid holding spinlock across child
 iteration
From: Joshua Crofts <crofts@kernel.org>
To: Zheng Shuhao <viennaoffh@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
 <0428126d-684f-4b4c-a805-7dc3e2d56897@kernel.org>
Content-Language: en-US
In-Reply-To: <0428126d-684f-4b4c-a805-7dc3e2d56897@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 20/11/2026 11:50, Joshua Crofts wrote:
> On 20/11/2026 08:56, Zheng Shuhao wrote:
>> syzbot reports a SOFTIRQ-safe -> SOFTIRQ-unsafe lock order warning during
>> sensor hub removal.
>> 
>> sensor_hub_remove() currently holds sensor_data->lock while calling
>> device_for_each_child(). The child iteration enters the device core and may
>> acquire the klist lock. Since sensor_data->lock is also acquired with
>> interrupts disabled by sensor_hub_raw_event(), lockdep reports a possible
>> lock-order inversion.
>> 
>> The callback only needs sensor_data->lock while checking pending.status and
>> completing pending.ready. Pass sensor_data to the callback and take the lock
>> only around that short critical section instead of holding it across
>> device_for_each_child().
>> 
>> This preserves synchronization of pending.status while avoiding the lock-order
>> dependency between sensor_data->lock and the device core's klist lock.
>> 
>> The syzbot report is available at:
>> https://syzkaller.appspot.com/bug?id=c7c429f6851638ece81338f90c5b29ac9c0dea1f
>> 
>> Testing:
>> - Reproduced the target lockdep warning with the unmodified kernel in 3/3
>>   two-CPU QEMU runs.
>> - The warning was absent with this patch in 3/3 equivalent runs.
>> - Ran the HID selftests against both baseline and patched kernels:
>>   hid_bpf: 45 passed, 1 skipped, 0 failed
>>   hidraw: 27 passed, 0 failed
>>   hid-core, hid-apple, hid-gamepad, hid-ite, hid-keyboard, hid-mouse,
>>   hid-multitouch, hid-sony, and hid-tablet all passed in both runs.
>> - hid-usb_crash.sh and hid-wacom.sh produced TAP 1..0 / rc=2 in both
>>   kernels because no executable test cases were collected in this minimal
>>   QEMU environment.
>> - No KASAN report, use-after-free, Oops, BUG, panic, or general protection
>>   fault was observed.
>> - checkpatch.pl --strict --no-signoff reports 0 errors and 0 warnings.
>> 
>> Reported-by: syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?id=c7c429f6851638ece81338f90c5b29ac9c0dea1f
>> Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
>> Tested-by: Zheng Shuhao <viennaoffh@gmail.com>
> You cannot add a Tested-by tag with your name.  This is reserved for when
> someone independent of you tests your patch. Looking at the syzbot report
> there is a reproducer, so syzbot should test it. You can make syzbot test
> a patch by sending the following (note, this will trigger a test):

Ah, did some digging and the syzbot email is incorrect, it should be:

syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com

Cc'd the right syzbot and triggering the test.

#syz test

-- 
Kind regards,
Joshua Crofts

