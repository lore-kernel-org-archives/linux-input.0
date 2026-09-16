Received: from outbound.qs.icloud.com (qs-2004j-snip4-11.eps.apple.com [57.103.84.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537651123B
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575373; cv=none; b=QN+33FtsaeMKDcgNKmfV8DkX/5tddfz6L2cuEbia+zf4aJcPyBS3pyBQIa/wO+rXM/FdT7BdsadxlTKHxr2tKz8EmI40Tf8nlyEPHN6EGS0/mRByD+O9luMrc2ZoojPSYNV8E0gE4j2qFJEK+joO/5ZbKSnH7MMUZTU4N9iTzK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575373; c=relaxed/simple;
	bh=MQb8tSbx0/HHOCcszCddBWvThTIgIDq5xTskbCmHgLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YS33nhOe6DWjULB6K/Q6USpw25kQuKXvsuGDhiwlH/ylsQ69ErN9pggQQkvUzfeR8LQZSSEb0Ss1jzWVXrioT/qP8ti9KoN63lrTHebGwSKM2dbUXYa6N7TmJEC3decjes+Nt72Oe4WdG2awkrpxMXwzOajTV+dBQY4sCAuras4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=hPWcfcFA; arc=none smtp.client-ip=57.103.84.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="hPWcfcFA"
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPS id 0FD8B1800110;
	Wed, 16 Sep 2026 16:16:10 +0000 (UTC)
X-ICL-RepId: 01a0ab01-153a-7b59-a1d0-e9d6eaea5ef5
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQBOHVUZWQdDF0oDTVIPDxNUFVIXTQRyGVoUXBhTRVEfVFhVCQoCURxWDVdDVARfUEsbDlUXA1ccVkVcGEMJXQVXHB0cREVbE1UXRgkZCF0dGQhHHwowA0IOVgNDB0UALRkcV1BeCF4fTBwdDlgGEh1QHA5RBVsARglBAlsGXQNFDEkdXgFdC0UUSR4OWgZTCkMXcwRUB10FXVZQAlpVEgRACFZQXgheH0wc
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1789575370; x=1792167370; bh=XfJd1U4QADoydamY5G5HVBx5mXqXQNhew3wDV+lTvWQ=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=hPWcfcFA5WMbtC3DBJzrSqv3ACF7kRzv0uOrnwLPVHsmb3dtp1xbG+XSRnpCGqtDozHviMq6a5d8EZ94qVad2TMZuLgO8NtjnNchP5rxUg46uWHq8JjMSZAOcC9QqzDcIW5ZtIksr57Z1Lz68NMwNzzLef0xKxZnhn1s+xI/nj09g0yM0CycRbw4kTrqLEZ+K6MTz2dQxAGKJgoeMCw9DgHWbvOQGDAdWtq0Jp+9/xjMzSQunomtyM+tYuPqj4QjgPTABoE7CjYALb+eckGS5sM/PCESEnh4EGRi7K1CA+YGsb0K2jUxwY8w0vHcEmF7cECztgVOEI6owhzygdNxkQ==
Received: from komputa (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-20-percent-0 (Postfix) with ESMTPSA id 4C10C18004F9;
	Wed, 16 Sep 2026 16:16:09 +0000 (UTC)
From: Cristian Mazzotta <cmmazzo@icloud.com>
To: aer@tuxedocomputers.com
Cc: W_Armin@gmx.de,
	bentiss@kernel.org,
	cmmazzo@icloud.com,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wse@tuxedocomputers.com
Subject: Re: [PATCH v6 0/3] HID: generic: add LampArray support via hid-lamparray helper
Date: Wed, 16 Sep 2026 11:15:51 -0500
Message-ID: <20260916161551.36695-1-cmmazzo@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916144838.456239-1-aer@tuxedocomputers.com>
References: <20260916144838.456239-1-aer@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Du4IQlhNk8aJfkPUjAyLSW9WijmCnGME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIyMiBTYWx0ZWRfX6L5vboLaKiC5
 WkDkCg5HEczz/PHO6bayRsiG5fuzEENuiJTVZhzi51GZger/35Iy3kn3fs+HDz/P3XMPVyruIsF
 wEaHK6ixEb8hV5SeC8+7mJEdr4me2iJjD5+lW1eITYYi+x0NoT4qkmlWu/BYl5mlpcNgjr/zK6H
 nubKQZgBcZW4lOAxetQ8vp3ZLE71yPcVrBlUfgxq9GHzxVEytGps18T2msS6oLQGFsFkWP0pHy0
 dxcmtZylp9HyNczfmzZo9U5ipPPF7VD+OTYK77n/IQPfiOy5mgeqT0ZDViJO7Fmq9Egc/zDv+6U
 gQ+raLWydlofme3wzuyFkHDW8hjc+u3qfvmD3ddSXCjrSjvURs0qZacjTagqRQ=
X-Authority-Info-Out: v=2.4 cv=Zpvg6t7G c=1 sm=1 tr=0 ts=6aaac0ca
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=zMoZyIPnO1cA:10 a=VkNPw1HP01LnGYTKEx00:22 a=YuKY67GBq93p-LlOLQUA:9
 a=Uh4tPsEYL5Xn7yYgV4Nn:22 a=mGzgV76dRlD25_95D0kX:22
X-Proofpoint-GUID: Du4IQlhNk8aJfkPUjAyLSW9WijmCnGME
X-JNJ: AAAAAAABBC72ES1mF4ciLMmKVOPj0wOq0mq+55wR2xOOEIMfMF6xZQXXZGrJjYCSIl++uC/6mM7ZnGjdoO6MvvGukq35Ag/EN3Hgnn3pukgAgK6PHa5mrCRshwLoewhjD3WQMs/KZzI3/SBQX3tO9D15AzEkYsqXx6d6gG+4+4ZkNBAv+fQMHhCptnDq2G8gsJF6bipN7kFeUqezKnvWy06hXESdp+ZDCLBtr03hZ4szdrxWWeTHoABaGNCD9+C5n48BBzyzwZ83a2uMp+b1Vn9CeIrbduf1i1mL/BNoqOF4TKHPXpQetvEBHictcp7fU6z7xmgxagggNDm2SrBQJH0uyqC7fh0Pmh40v3CL1VfAIkWKUzN+PivTeh2eR2Fs7yjEgxubx0eYNzvESrgAe3j2eZb4xxwQfcTt3RoXWcjUBGcx8obzRZHCUI+hLNZ40CHai31WK+enQMzKhb0lGJz4kzLfyOkPw7nC0dtMC/wmpP6jlQfwtajPLaCSxykdzSIKXCbYLPK+Lb0tqylIn6KxJpYvo4Qc2iiCAdslQZaCS9VKUGF2Sw+4bQnuOb1DaTjurUs3b23UpUZ+9MD3tFCqdtW9s22yq56ARloi05flDOK0z0ujxsYws3OinZDQ68hkgYHymN3MixMNySNOv0br9T4Jt6Okd0Fu8Y5c4mN7Xx6UFifHvsTOTCjuevEbB4RiZQ1zN/w7wZLYMHNU8WZUHKpx9wWXNE7F5DY99pSvLWdYD4Ro1fAtvNqJSZC7WnnONsn4KI3T532L2hFDqiDM3o2UzhayiXzOsCdsmwVKJyg2xBBVd1W3UtvFM/Jy/o6g5b2BdfaCKPCfVv3lIeK3Hz9BMIr+bkyiY/ouNbvvWZojkQzYSX+UsPeDVobtfINR5KKXoD8TR3CXQ3o2T+0C6vADnbQ7K5C6TLQYZtKN5sdgIkFLVPRJ3KUhZ+z4XIk2LQeGeo/CRTVwOKP3PTmNbKyXT/J
 gZnu96fVXyY42v7t0MdVWO3b9vehdIUq3qdJmQPHbVU8M0/sUBcKn1JlsZe1E46ONk8f/48mfsAZ7JgO3IfD5qNTr1gx6kmOBHMj30fQwnUmqQxULj7dBX1juRPCnUFQ2Uy5MJ5HsEYVBf4oOdT7q/T7pdbUO/YyoyqjfqCdyz4Rmm5u8RyujAaHEiPky1n9ZQ0FR1wysmcbd5mdF2lq4fZ8L6DICcCYMMtIq4dryc4jFqldlvhSiA6LZAW7s3CcDXgnRH66g6j9jzH0pxffuKA==

On 16.09.26 16:48, Aaron Erhardt wrote:
> Add a new hid-lamparray helper module and integrate it with the hid-generic
> driver.

Thanks for picking these up!

I do have two corrections on patch 3 however, and both were mine
originally, so my bad:

 - The measurement in the commit message and in the comment above
   lamparray_suspend() is wrong. It should be 12.35 W with lamps lit and
   3.14 W blanked, which is 9.21 W or about 75% of s2idle draw, not
   2.84 W / 77%. The 2.84 W was an earlier test on a local branch that
   includes full multi-zone support. It's worth noting in the comment that
   the 3.14 W still includes the lid zone, which single-zone control
   cannot reach on this device.

 - The kerneldoc for lamparray_suspend() still says it "writes zeroes to
   the rgb values only, keeping the brightness", but the call is now
   lamparray_hw_set_state(ldev, 0, 0, 0, 0). The code is fine, but the doc
   should follow it.

On your question about the default state: I think the lights "look like
they don't work" can be a real conclusion, but the cause is the intensity
default rather than the brightness default.

With led_init_state NULL, last_r/g/b stay zero, register_led copies
them into subleds[].intensity, and brightness_set reads r/g/b back out
of subled_info[].intensity. So every brightness write sends
(0, 0, 0, brightness), which is black at any brightness. The
zero-brightness quirk does not change this since it only forces RGB to
zero when brightness is already zero.

The LED class device is therefore inert rather than just dark;
systemd-backlight restoring a saved brightness, or a DE slider, or
UPower, all write brightness and see nothing happen. This is because
nothing in that stack writes multi_intensity first.

Defaulting to autonomous mode would not fix that. It would replace an
inert knob with an ignored one: the cached RGB and brightness would
describe nothing the hardware is doing, and a DE would have to
discover and write use_leds_uapi to make the node real. That is
driver-specific knowledge that desktop environments are unlikely to
carry.

On a second look, I would suggest keeping brightness at LED_OFF, but
defaulting the intensities to max_r/max_g/max_b. The device is still
dark at probe, autonomous mode is still disabled so the cached state
matches the hardware, and the first brightness write from existing
userspace lights it up. Combined with the quirk you added for Armin's
device, it stays dark even on firmware that ignores the intensity channel.

One hardware data point, since discoverability came up: on the Acer
Predator PT14-52T the keyboard brightness keys are handled entirely in
the EC and never reach the LED class device, so they cannot be relied
on to show the user that anything is controllable.

On multi-collection, I don't see myself getting to it soon. I might work
on it during fall or winter break of my university, however I cannot
guarantee it, so please do not consider it blocked on me. The ENE
controller exposes two LampArrayAttributesReport collections and
lamparray_parse_update_report() only keeps the last.

I have a local branch which includes working multi-collection support.
It's based off of Tim's v4, and it's what I referred to in the original
v4 thread; I'd be happy to send over my branch as a reference, though
porting it to v6 is not trivial.
