Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276410;
	b=3oyqds7N8dHSw1vXzjDjBXnpPBW5HD7tK5cgxCGU90/13LR7T4Ctu97AGPJkg1tFYp6I
	 lTN/XYZUGqDP6ToTyx2MgBSn9z1B5NoAcQ/PlDQQON2iKuHz4kEyTuD0YT+4wsQPcHhFw
	 xKTjRU3kz0EG5bwU1m7rxZLsqQ9t8iQ0z5GTWwPtvsjOWtL46sujSTelIr0VDi5nbvpHE
	 u0xPCqXFPdIcCXGpVMoZrWTdQGJKIGTDLSBt0TdTOrmeEWdCUhLr1kbUfgaDUJKyq4gXp
	 RkTmsf5mJihsDCr+lBNBApNx6D+opgjbUA+EmK3LQK91zKoklyVpf7rrAdEEGoq75xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=YBgckZ7YOb7fe4+YR2v1CJm9q/fhedgcNMRGuz/XwV4=;
	b=lQBP1eNBGdlwkA6r1Sj52PJc/DxaHl35KtjwvBwIUT+D1mjUpg98VJoNW0+cgAE4wiRW
	 8AhHabcTRCFsH10/XLRNQ8BpMo63tEWLdMXTMiPODMnGq8aGL6n33Gtl2UG10Btfn2hH1
	 AG0gWtTjLgpr3/uNq3vO24Y17+sSMPxw1nXyd9iWNS8tudDyrJEZttZ7nAFdtxmtoO4ZA
	 i6FGoE66AjiG1aowPy0H1MEUuZww+OIa+2J2ASTraCwBlF95Wk6Sp7CfxbKp6fVq1XE1f
	 wwqu6eY3lHOJRgN+r6TJRpTd8qEWxTIHLM1GGrmQD+JGsJZrO81/8Ig9utBp7a8+JAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--svv.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hMuXKmgA;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17CB606A321
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B17CB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--svv.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hMuXKmgA
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so3603820eec.1
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 18:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794276409; x=1794881209; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YBgckZ7YOb7fe4+YR2v1CJm9q/fhedgcNMRGuz/XwV4=;
        b=hMuXKmgAlxvjCv1tdg9wPUFKW6bfJ1nlFYZzhkjcFlWtoeLRoFqZeZFOKKqRBKuqc5
         qDB3U4AgTe5xaslef+rRLwkIGMNIx+uLKDPXYI5rSbymiGejA5zS5hl0gIQIdJjQiD0b
         uJua+RCqYfEsmPQIFbDsW38yTkARoN7EE3eQpBVch1aozOKvdPRGoV21HGCoHd0Y4UAp
         UDI6CgU9Bvc5gxfB4uvbNR+wGQboiwmAaqJ5YgF50hU31rtcCwpgwlp6EehYrDRbJ8fR
         Owhy7v1RpkRLld3XelimfhAn059UoRKE67zgeZMmqffHe0sSLbPTtJ41CXoMJP60Fs/3
         1Nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794276409; x=1794881209;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBgckZ7YOb7fe4+YR2v1CJm9q/fhedgcNMRGuz/XwV4=;
        b=txZk1tUQN1MLn6orMcts7/hVXkm7C7syFSTi7s26hNU3w2kla6XlfJjtlITy6Dt8Z6
         iTShG5ccnWKIGMUHSYDP8qAc4kDSi6rclVgvFzP1ONQg2fJXiYxJFzwr3+OjIgmNuQPO
         nLkeROawO3DPPBjhefiTDt4RktnEiOCIJ3y+Bo5+NHdj9iGw5hyhLaivg/ajWCA7fdA7
         Ketpld1GDHXF4wyugycpLm1ToJFAb3j3ZdUrQGJK59W27IAQGys9om4dwxMe7Ld0p1ON
         V819l7YPCWUyme10cQxIxDgvhH+kzWYBBlfbqGDyKMmIUKjMf4c4U3e8Z7Rx5pw5+vBn
         9/Xw==
X-Forwarded-Encrypted: i=1; AL+hErH0dodvfB/r3shetirROhF22UbXHAlYJ9JRcWsFpO3vCzB36Xeame4UDeVTuOYPsAEVzxjolWw2aPIpbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+TZr+zoruNRUWq+Z6++LQa+/2bNQ/o8fukMqMlxvVqxm3/Do53
	eq0My+M7JNwcp3br6f66SYStZnpkKRPwJroOikgbjF5OyTePmjxm1Cg5klAtSg2EpXScXA==
X-Received: from dysg19.prod.google.com ([2002:a05:7300:3d13:b0:36d:461b:fa1f])
 (user=svv job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e9cd:10b0:36e:aa5c:7851
 with SMTP id 5a478bee46e88-3751f6593cbmr1699067eec.27.1794276408525; Mon, 09
 Nov 2026 18:06:48 -0800 (PST)
Date: Mon,  9 Nov 2026 18:06:29 -0800
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110020632.4003499-1-svv@google.com>
Subject: [PATCH 0/3] Input: add ABS_TWIST and support it in HID and Wacom
From: Siarhei Vishniakou <svv@google.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Ping Cheng <ping.cheng@wacom.com>, 
	Jason Gerecke <jason.gerecke@wacom.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Siarhei Vishniakou <svv@google.com>
Content-Type: text/plain; charset="UTF-8"

Some styli can report rotation along their long ("barrel") axis,
commonly referred to as "twist". While the HID specification defines
this usage as HID_DG_TWIST (0x000d0041) in the Digitizers page, there is
currently no corresponding evdev axis code to expose it to userspace.

Because evdev has no MSC_SCAN equivalent for axes, drivers and OEMs
currently work around this by mapping stylus twist onto unrelated axes
such as ABS_Z or ABS_RZ. As a result, userspace input stacks must
maintain device-specific workarounds to know which axis carries twist.

This series introduces a dedicated ABS_TWIST (0x1d) axis for single-tool
devices such as styli and wires it up in the HID subsystem:

1. Input: Define ABS_TWIST (0x1d) in input-event-codes.h and document it
   in event-codes.rst with resolution in units/radian.
2. HID: Map HID_DG_TWIST (0x000d0041) to ABS_TWIST in hid-input, compute
   its resolution in units/radian, and add KUnit test coverage.
3. HID: wacom: Report pen twist on ABS_TWIST in addition to ABS_Z so
   that userspace can use the standard axis while maintaining backward
   compatibility with existing applications that expect ABS_Z.

Siarhei Vishniakou (3):
  Input: add ABS_TWIST event code
  HID: input: map Digitizers Twist usage to ABS_TWIST
  HID: wacom: report ABS_TWIST alongside ABS_Z for pen twist

 Documentation/input/event-codes.rst    |  6 ++
 drivers/hid/hid-debug.c                |  1 +
 drivers/hid/hid-input-test.c           | 87 ++++++++++++++++++++++++++
 drivers/hid/hid-input.c                |  5 ++
 drivers/hid/wacom_wac.c                | 35 +++++++++--
 include/uapi/linux/input-event-codes.h |  1 +
 6 files changed, 129 insertions(+), 6 deletions(-)

-- 
2.56.0.455.g6c5a503b38-goog

