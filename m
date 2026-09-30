Received: from outbound.st.icloud.com (st-2001g-snip4-10.eps.apple.com [57.103.76.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F846A60C
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 20:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799250; cv=none; b=ho4/HWTuYX/EBwass0G6CpaEXFWEkYtDzwuPc5MiNt4597dO/n97JqhobMgCgn8RAmtyTqJjinltvjJotgPfLhR3F6EeL8OaijM306ZqPDMNMGmgDB3rLvFc7yBJJerRe5fm18n0j/lBxJ5X4DJ8lxrQMGdF47vu+ZXqv0oH8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799250; c=relaxed/simple;
	bh=b+Z5ntT5JZbhSicFvqP1kmcUkDaIv+Z0qga/ju/YmR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qEOiem6wUN/x9/1AHkdu3zMSOk4rOVCPKKAl6pUZbJ/L0byKG8RVztq3XVO7/D2AT0jzmCWbYBSIoHB68ZMYrm98nswtEPu+yezjopnFC7wYJJxkbDCd+1DL3vNsUocC2FrLZzjoOO6gjOD4fmKGvPKcuYZh82nsXFdUClz9fqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=V8tGWqG8; arc=none smtp.client-ip=57.103.76.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="V8tGWqG8"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id 2206D1800AC9;
	Wed, 30 Sep 2026 20:14:07 +0000 (UTC)
X-ICL-RepId: 01a0f3f3-f710-7d0f-99a1-9206a5d9f929
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg4TVg5WHxlaBUkJTwpUB1kKXl4RR0NRWFwCCBRzAFJFUR9URhMZThtXTVAbXwJCDw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790799247; x=1793391247; bh=UUiaNsoJgi7YzifMiJPEeGl9e+ftWqdkTH7hj9uTU1U=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=V8tGWqG8ye2QRuKEnYFQQikwN9/OtdMkahbJ3Kb7GJz4gLbPiOyS0LtMdz0de2YEG9NVG4ev3aW7Mz6EOIXwLOgz6mi9gaIKwLD0ty0EqpIvRoVV+jNcu7xgJv8l0+IEI7tQgyuxo9F93OEjDMIwOBcboGtP0WLb1qY2W6oPRjP0iGe/6Hkg2tGESVC/jzybRf4t4VR3dQiuVNvONOniRMvQUOl34Li+IdWBj7SykOCJ83wisVyvXwPpIvUtaySzpPn5AjCWK1rIhX/reOILPGPMPl6LijCPkyEDEbNa6LcbixMGIvCIhYRT3lbSTRG6gfB/F7hHCtSumE4z4G7M2g==
Received: from fedora.vpn.altanet.fr (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id CB881180008F;
	Wed, 30 Sep 2026 20:14:05 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/4] HID: winwing: add WinWing URSA MINOR sticks
Date: Wed, 30 Sep 2026 16:13:54 -0400
Message-ID: <cover.1790799028.git.f3nr1l@me.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UyDtTyV58XnuT993EyMZCB3D9eZBOxIV
X-Authority-Info-Out: v=2.4 cv=YbKwJgRf c=1 sm=1 tr=0 ts=6abd6d8f
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=HHGDD-5mAAAA:8
 a=d6IEsQdgvlLqoYnpI50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MiBTYWx0ZWRfX7q289k1H1uDa
 QUC1TKiG4CjzZ5C/KIPgcVo12Ep3t3xGXaoxPfR9e778YNSRWa/83SgDo+DLy63hNZ+DEQJZH3V
 Wejx8bzDaNtzqN48WPevH/97V22BXzvbV2z39pCmqfDK2PxUP+gbtDWfD3Eed/481opxoF6dhcp
 34gnOE9aLD5Zrb7fnzw7NtWy7Sgf5JpQ0K0fF1yxPbGURMMAJLWLrA0YAmaqzIW4fc1xJ/K+Si2
 d4CC5vD3dcV48u8EpgAwjGjrBQfhkmov00jZ0QP8Wsm3PUn7+UaSeInMAgV25AhTbeek2lX2Vff
 AEKN/t0DpadiK5TBvQVQZSCzHfQtNwvhBMqWLcrog/sS5B0gCNsXOQmFu/mGUw=
X-Proofpoint-GUID: UyDtTyV58XnuT993EyMZCB3D9eZBOxIV
X-JNJ: AAAAAAABAq0ma/pBCdPA67qwaZ5uCxMcLA6uzGLjR3f8qcutyg1UiBmTCMr/a65qg4tAcvz3Pn9DbGtT/CRpV4WHhTRcF66UVgcrSoCCmDFQTh5K7mspWFzH6t6MauoSTNEwRMRKIuWggc0gth31lZqDREp6e5CDjbj5TPG52OjtUo4LTl2fJXs0K/L8xNNUMMj5BpzJSFV0jG799scbvN2NKeb+NNTzs8Ckubg6j5B4KOXpASgf6DHn0OwQCR7+38J48WUWWKth2SyrN52bRviUS+OZYNGc87e3kWVC8MXbY0YF5lzpcO6aJD0qcU086zUmnV5ACa+pytAa6JnNsWst0fR05Uu8KYkAoRjnIPZzz8Y7S2WzCWJVk8gQ3s5O+wsiDfCJpdkJdFoNS7wMJM0Zs/K+xU/+e0hp54K9oQwwisMOvZFn0tyJTcz3CnZ0jrnrQuEssqT0G0aoSYm1tMOBJu4+t5U9WeNGylAG0JnVV5puxk0bWlwV9MJzaZGrpCbZGZ1wANcREy1Aaa3aGnZHUnwiDW9XqxyLHRx1kSojGJmUsDNn28wKy95D5KXbvq+7KVfL5bBSmSZhcKWaAFpGWfkXm/joSJVpMeyHpHWmxRJ3GV4rXaAtcgyTyPCGCKLEov5mRX83u0iApOw3wap6q5iG18NOBPPdQem9G6HEH2o0Ql3gqjFSlJ0+qKUD9EUabzU/FVWRQeYFYPxKU3IoaDRrGA9G+6bGnqwQ1cZ0Ks5hEZ0o3HnG0JYpNu4iA9NZsEjPuYypRKcJA/9c2YS/RIhGkIwrwKDa/Oj0B/CNPCPEqkciPULjQjvgts4twwTb8SE3qOomKBBTOJ06h6CTH4bYA+eUXE0tQCuW1tGrxjBEsf8xbnf78k4JlZYVkxK1sO7IL9pofuT6exuAFwpfTznldapFmvjbqmJTLcWjc5BnARSc4dNoqGeflHMlkhTUZVblRxyYZRFpcNe2MY63C2y+uj/
 AlhhF7qu/maCPVZViYx0uamXp9qr3CEu01WoV9qQPBCG7qHaDDGWQ/BrzxcUaxGX1u2+9qTdV88KdNZQeJk3OWveFJNH+8YQEj2sluwJi+3g1bIa/Ir3FcAEtMmodrtlJpFVRNwuIFgkya6Rf2/j/ygsiBdjq66PytBNBwPaslsi7CpIP1L/efPoxn6Zzqz9GNlhnN7Qib+gg+gV0BWdgEgS8Hy0YK+iF/oyLgw==
X-Apple-Category-Label: MjczODQ1OTkzOiRjYXRlZ29yeSRfUGVyc29uYWws

Resending: in the first posting, this cover letter reused the Message-ID
of my "two teardown fixes" cover letter, so it was dropped and the four
patches got threaded under that other series. The patches are unchanged.

This series adds support for the WinWing URSA MINOR joysticks (a pair of
single-hand sticks) to hid-winwing, on top of the existing Orion 2 throttle
support.

The URSA MINOR sticks differ from the Orion 2 in three ways the series
addresses:

  - they drive a single backlight LED through the stick base (a second HID
    controller on the same endpoint, addressed by a fixed device id), not
    through the Orion 2 lighting controller;
  - they carry a single rumble motor in the grip, rather than the two
    motors of the Orion 2 grips;
  - they enumerate under their own product ids.

Patches 1 and 2 are preparatory refactors with no functional change (verified
byte-for-byte): patch 1 factors the vendor report builder out of the LED and
rumble paths and names the report fields, patch 2 makes the LED set and the
lighting controller model-dependent. Patch 3 adds the device ids and the
backlight. Patch 4 drives the single grip motor while leaving the Orion 2
two-motor path untouched.

This supersedes my earlier "HID: winwing: add support for URSA MINOR combat
joysticks", sent from my gmail address, which Jiri asked me to resend with
full paths:
https://lore.kernel.org/linux-input/20260404172641.195619-1-rene.onier@gmail.com/
The device ids and the extended button mapping it enabled are in patch 3,
now together with the backlight and the rumble motor.

The series is based on hid.git for-next and applies on top of the two-patch
series "HID: winwing: two teardown fixes":
https://lore.kernel.org/linux-input/cover.1790795726.git.f3nr1l@me.com/
The only interaction is one line of context in winwing_probe(). for-next
already carries a1a5ad37e50c ("HID: winwing: fix use-after-free in force
feedback teardown"), which the new ids need since they take the
force-feedback path.

The Fighter and Space URSA MINOR variants are electrically identical and share
these product ids; only a stick-tilt accessory differs. The Civil variant, with
fewer buttons, is likely compatible but its ids have not been verified on
hardware, so it is left out.

Tested on URSA MINOR hardware (a Space left and a Fighter right): backlight,
rumble and buttons, and unloading the module while a rumble effect plays.
I could not test the Orion 2 path myself; the two-motor rumble is unchanged
and its reports are byte-identical to before (verified), but a Tested-by on
Orion 2 would be welcome.

The vendor command names used here (SET_LEDX and the report layout) were
recovered from the vendor software's own debug logs and the command table in
its WWTHID.dll, so the report fields can be named rather than left as magic
numbers.

René Onier (4):
  HID: winwing: factor out vendor SET_LEDX report builder
  HID: winwing: make the LED set and lighting controller model-dependent
  HID: winwing: add URSA MINOR sticks
  HID: winwing: drive the URSA MINOR rumble motor

 drivers/hid/hid-winwing.c | 267 ++++++++++++++++++++++++++------------
 1 file changed, 185 insertions(+), 82 deletions(-)


base-commit: 145c2b2e9a5c0f794fb4009bcb072ab19f8ccfcd
prerequisite-patch-id: d1a20c8f9775ea37cf424f0c7026816fbfecd127
prerequisite-patch-id: e6427bc64a0650061572e3923ea44827dbd63809
-- 
2.55.0

