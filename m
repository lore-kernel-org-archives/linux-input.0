Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795171851;
	b=2n31BGaBior2vsVdsT5bQSFNMIwg+ebGj4Bc07pdeueNoyMlGNNRHL2Vhh7olLd7i5cM
	 Xfy4dKjfNAn6yJ2sXNDUyhGe1Brw51Oyn5PwzAhdPY7L5dXO76cgIXzTwDEVKcD1ZnmFn
	 26KCZzU/qZ1Q9TjuFxVGF58QWt80DgwtDzumy9V6kJMOTqQvd3KiRBLUM91oPz0ylacHP
	 80l2rwIRmyFEv/yps8abkOOptGghbRvLaYaI6hwHHIbsdKC841MpX15p7I9t8cpwMb279
	 LHNsKkiWqcv1xxC9wRX5ApjDN5hHMENRmkKIQRQ4Y9jKpVU3BBM54jquibMLvJDqIkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795171851;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=5dwD7udU1MAtwItjeMysrMS5pcMrk1+oZk8uLzi5y4M=;
	b=mrii3xIhwBpYJLc1C7lC/T8qmpqMnR9kzK3WGxdoHYf6q+DBeBf0mhhV9q6xwZilEaa0
	 4bm6ijGj1mBderDjOM96MJHEjubnFt3zhX0FWbx9TUrGWmUjYLgqAV7kS9K3gaucHQ/1C
	 +XjZiP73COd6vCA+xF+SCzpo7cq+HFpdgUNkE/o7mHZxvIeMZq4C5si2UvSD9dhWn0NED
	 eYMqCTSvVuMILNoqHijCbiD5mwRYKol+i3QNCFHruSCu4aHi7ZkX46pPgMqVVEMJ3RCUS
	 168AZDV2UKMP1uA8oqtJQXzJ6YDoO+wsvVWHwXLox+fjsJEk0WeyY4q8PRFWa0eNHwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NF8FczTS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9E0606A332;
	Fri, 20 Nov 2026 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NF8FczTS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31081F000C0;
	Fri, 20 Nov 2026 10:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795171851;
	bh=5dwD7udU1MAtwItjeMysrMS5pcMrk1+oZk8uLzi5y4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NF8FczTSCiVCq/wXVh9jTRShRosHCSjjNdYqeh43gz7oE67LQUMYcOsp5en3dkee4
	 B8Ppvx6vNAFZWwun52Azl/h3MX02jGf5d6T0kGs3AWUlczbBZJ2Xfdu13UQ7EywpWc
	 HvIFrO1U0biX2A0wSH4IXlsuNCXwrYz/RP9VopLyeLbpx09eb0pdwj1A5cKVgvn3/f
	 djJZD1ErmvXfYu+T+H8mQDwOWMaxfwZc6FW1LlFQ1/48U11u2zMC1C/mwYuUYl/g/j
	 CnY1PXJ8kemUuXyi/FrrwDsI7ekKvZoaI2JDZW8rS8iKISEKqTkrj0ekFieTAvIKF4
	 lond/zBJNbnnw==
Message-ID: <0428126d-684f-4b4c-a805-7dc3e2d56897@kernel.org>
Date: Fri, 20 Nov 2026 11:50:46 +0100
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
To: Zheng Shuhao <viennaoffh@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspotmail.com
References: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <1795161418.hid-sensor-hub@viennaoffh.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2026 08:56, Zheng Shuhao wrote:
> syzbot reports a SOFTIRQ-safe -> SOFTIRQ-unsafe lock order warning during
> sensor hub removal.
> 
> sensor_hub_remove() currently holds sensor_data->lock while calling
> device_for_each_child(). The child iteration enters the device core and may
> acquire the klist lock. Since sensor_data->lock is also acquired with
> interrupts disabled by sensor_hub_raw_event(), lockdep reports a possible
> lock-order inversion.
> 
> The callback only needs sensor_data->lock while checking pending.status and
> completing pending.ready. Pass sensor_data to the callback and take the lock
> only around that short critical section instead of holding it across
> device_for_each_child().
> 
> This preserves synchronization of pending.status while avoiding the lock-order
> dependency between sensor_data->lock and the device core's klist lock.
> 
> The syzbot report is available at:
> https://syzkaller.appspot.com/bug?id=c7c429f6851638ece81338f90c5b29ac9c0dea1f
> 
> Testing:
> - Reproduced the target lockdep warning with the unmodified kernel in 3/3
>   two-CPU QEMU runs.
> - The warning was absent with this patch in 3/3 equivalent runs.
> - Ran the HID selftests against both baseline and patched kernels:
>   hid_bpf: 45 passed, 1 skipped, 0 failed
>   hidraw: 27 passed, 0 failed
>   hid-core, hid-apple, hid-gamepad, hid-ite, hid-keyboard, hid-mouse,
>   hid-multitouch, hid-sony, and hid-tablet all passed in both runs.
> - hid-usb_crash.sh and hid-wacom.sh produced TAP 1..0 / rc=2 in both
>   kernels because no executable test cases were collected in this minimal
>   QEMU environment.
> - No KASAN report, use-after-free, Oops, BUG, panic, or general protection
>   fault was observed.
> - checkpatch.pl --strict --no-signoff reports 0 errors and 0 warnings.
> 
> Reported-by: syzbot+c7c429f6851638ece81338f90c5b29ac9c0dea1f@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=c7c429f6851638ece81338f90c5b29ac9c0dea1f
> Signed-off-by: Zheng Shuhao <viennaoffh@gmail.com>
> Tested-by: Zheng Shuhao <viennaoffh@gmail.com>
You cannot add a Tested-by tag with your name.  This is reserved for when
someone independent of you tests your patch. Looking at the syzbot report
there is a reproducer, so syzbot should test it. You can make syzbot test
a patch by sending the following (note, this will trigger a test):

#syz test

-- 
Kind regards,
Joshua Crofts

