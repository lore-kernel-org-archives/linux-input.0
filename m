Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177955;
	b=ycLHITHkpLzZirP9udXmmg0/o1PapMdwBnKNv9p+AV+VZ7ufLtc2gwZZY/VRAIu7sxPr
	 i70iDC5945BX7N1vt4qkOAvtVcCuk83ZilFkRlwTWmfMXiW8s5j2GpnJqVkBnbiGbG8UV
	 6KzeuHBcOUB4dJSSPg91s2up4KAZxK/WYkpSunhxrxHjEV067PDDo95dRfbhqIpr6Qa55
	 t3/uiWBJGQDl75Xxa63Z62OhfsSxY8OSnXb8uTd+94MoDDlmSFED5Di0jl94+THlcwmrj
	 L5RoUGZe55xxYpZmKs/kth6B4ENvmHFGv58hnpxkDDzzh+R2l+iVzGbSYY4W7/2A6UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177955;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:Date:Message-ID:
	 In-Reply-To:References:To:Cc:Subject:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RV3O/PwKqpyaXeGhe8S/uigLY8k3rFkySny/9HpiMGw=;
	b=G5Ikv2WNuqFftGbfJqu5EC4SP8SaJosZLnKdQHdEpLBvhsrBF7INnrViJqo0bsMil5y7
	 FsIcqDq/4OZy2fQKGzl5J/+AwEjWC3pSJjIuPXsEmquBSIz95l0cK4126NuVRhtkwvoFd
	 amLIoboOVWX3l4dzQ3BL/Igd11qJE15On3j79fFV5nSsng+4Xq7FaHnzu2Hmd4QBAsR7I
	 e+xUatuWJ8AlYGbLTE+6ZHBiRAJKSoiyBxbFi7jJ7HRDSMKqE9oY57sAlSG/2jjG/Sp++
	 7CPWQS3ifNVUpveYljxM/tV6i0MUa4xQEjHOjOcDRBUUnW/c0cVDLyNxnw6VOpJBcHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aclaesson.com;
	spf=pass smtp.mailfrom=aclaesson.com;
	dkim=pass header.d=aclaesson.com header.i=@aclaesson.com header.a=rsa-sha256 header.s=protonmail header.b=AnKAWx0y;
	arc=none smtp.remote-ip=185.70.43.170
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA324606A320;
	Fri, 20 Nov 2026 12:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA324606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aclaesson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aclaesson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aclaesson.com header.i=@aclaesson.com header.a=rsa-sha256 header.s=protonmail header.b=AnKAWx0y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aclaesson.com;
	s=protonmail; t=1795177952; x=1795437152;
	bh=RV3O/PwKqpyaXeGhe8S/uigLY8k3rFkySny/9HpiMGw=;
	h=From:Date:Message-ID:In-Reply-To:References:To:Cc:Subject:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=AnKAWx0yPTqLrOtbX21PR++AxHeQKoO8qqnPII4JEmOBKsz7G2SrQNRL5pLDeC0+U
	 xKC0aKY2Y1uD76Aa2MH+2aegtlFuHxAoCRwnW1QcBGPUPa2Fxc9G3zU2kTekNMiuGW
	 /WbfUwAQ31CXh6I2qTaDTlUTtcGtEjHoAcdqYShFgDNj1tWR9EZSbYUGhdIDjaWZLp
	 xoX1GBVLBvWpDXCGZ8OxqGGXGgCnHM/LXvvMm4RLoJfOuADnUYzwiHxsWZprveQrtm
	 PBvUWyvy+mnPZU9jHXzOfG7+/8Jxq7E1KLUhDaqWDtFgk/WfWVZq4U+dnjwy6frJqN
	 kHK7h8k2oXotQ==
X-Pm-Submission-Id: 4jWF8q4WYZz2ScNn
From: Andreas Claesson <andreas@aclaesson.com>
Date: Fri, 20 Nov 2026 12:32:26 +0000
Message-ID: <179517794674.913381.2170078871879428776@aclaesson.com>
In-Reply-To:
 <20261111-hid-corsair-k90-fail-sysfs-v1-1-cc4e94fce0d7@aclaesson.com>
References:
 <20261111-hid-corsair-k90-fail-sysfs-v1-1-cc4e94fce0d7@aclaesson.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Chen Changcheng <chenchangcheng@kylinos.cn>,
 Danish Khateeb <danishkhateeb03@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: corsair: cancel record LED work before unregistering
 on probe error
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Jiri, Benjamin,

Please ignore this patch. cc8d022e8679 ("HID: corsair: use
disable_work_sync() to tear down the LED workers"), now in
for-7.4/upstream-fixes, already converts the fail_sysfs path, so this
is no longer needed and no longer applies.

Thanks,
Andreas
