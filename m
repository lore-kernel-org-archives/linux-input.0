Received: from outbound.ci.icloud.com (ci-2005k-snip4-11.eps.apple.com [57.103.89.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C30403B1E
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798176; cv=none; b=hmCyAGTSqvgX1kVudDQ+YYeL387vR0ySelESAMF68tHDiZTa6DQKEeggnAAoYLJWmamu3A9u5EAwqxTA8NLYO+s+anD/mihaPTSGSJtIG+mUp7Vbpd1wkx6dA0zK9jcvR9VDs1PYMsUWH4QfEs05Pzfg+N2xSnxmD7wKciDQl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798176; c=relaxed/simple;
	bh=l1IKzdUwR+kkcq5hodAT705K09hxLq/VtsfcmGHwh/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oFS+fkdJZOvhN2rgPDG2sSjPJAsS4bKeQ95A+1udRL3pgFPNODnHdaSwPmeQsgdtBC1xojJcBUrBzBo2T4OZXLpbw+fj3gcHSTB0MKBZvRe6van4KAN+l6D8zYIFZSyPwDuAJNF8yM42DvWjs7sHTdZaoAxPDX2o92yj0jELLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=FzOOCGao; arc=none smtp.client-ip=57.103.89.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="FzOOCGao"
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPS id 56FD818007A3;
	Wed, 30 Sep 2026 19:56:12 +0000 (UTC)
X-ICL-RepId: 01a0f3e3-9053-73c0-80f5-f9a90ce55b20
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQVNXw5eHwQXRhlVBEceXVZQBBkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg4TVg5WHxlaBUkJTwpYAFkEXl4RR0NRWFwCCBRzAFJFUR9URhMZThtXTVAbXwJCDw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790798174; x=1793390174; bh=gj7in7LVhOj96LKc5XuK4jD7sU5UgWz6mx5qX+7LtxM=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=FzOOCGaoH98h/Rgc0DPnjokYkphunLekemaEtkvR/vTKp8bFh/isUYPiAD6to4aUUw9tu25HYK7DuFQnr2bj6krCQ0LayZqBPIBj3DhDVCPx3kglnrGsW0rN6EA2vdABTYah+XWJvoDrZFx+fuIcyOCQpHwdq9VVVbidEnX6ABpfOIDS95WuN+9VwMXh9FG48N3uSznI9ey+nSUjQRfyViRpbVUXK4iLjxSrlQQm5EjXuQH+Hon/OuJadDKr2hIzBdBTs78ZsYI0YEEIPVAt1OoktTlqVdUDCI5IY/gkFS2glhLCt5PZuk789bZBXioE93l7wxQquO+ROIbP+3R2Tg==
Received: from fedora.vpn.altanet.fr (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-1 (Postfix) with ESMTPSA id 7E6CB18000E5;
	Wed, 30 Sep 2026 19:56:10 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] HID: winwing: add WinWing URSA MINOR sticks
Date: Wed, 30 Sep 2026 15:55:56 -0400
Message-ID: <cover.1790795726.git.f3nr1l@me.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tmwP2f7frNBpWqj-SdDY9Kj5VRn02uQ-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MSBTYWx0ZWRfX9rV7DTnJhRzJ
 SJr1yVMxenIaOd48kfSU/Kmjv1T78t4YnRB1nCgoNP4W41cKbgSWPGgMvbfrOUS62ATgDl87YyD
 MJVVJR0F5qDXfRJkMnyCQ78xrLrCutXmpQwhzRqcTPoSToEU8IP9XQaiZECsWBZjwy9HNOwWsoh
 kgUHViZ0HZQ+xti146frmTCGQ5ONlneb3VvigY4NhnDM4rQsEZazWkWdVYxw5lRlP3PdpeFyMdj
 vOEehR2MbkVqe6EWdNDpq7tffAnDcf5oqVfRyk6v/jHvjG/T4KTgiaN2+dsEmfxSBx6ujrLm427
 j8epnrL66OBMc4Q8pceebIFHCH4kKhtft+eoPVtW6A3PxgF0xMjIBLHtotICCk=
X-Authority-Info-Out: v=2.4 cv=P883RyAu c=1 sm=1 tr=0 ts=6abd695d
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=HHGDD-5mAAAA:8
 a=cGhIfSCK3ErxYmg02mwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tmwP2f7frNBpWqj-SdDY9Kj5VRn02uQ-
X-JNJ: AAAAAAAB9RjReMHkaKrFzXfiYdL2qvvnoOmwWNc9+pWkwZR1jqN8vFe+E9fURu9mkMUa/gOmDa3l0qABgm2dawfkKk2lbKn6uwkkSLa3qPSZJ8rqsSZLZHf8+3ah2GfUjsEaYP3DTHM7kALAuOvhT8D6FjB9XCwjNNRZ0IPHXqkN3Vnyj7Gs4bvuU2XFzb3pojnB3S2J5B2zD7nlMFYhwDPBE1/Guk0gjHWfVTyYZ9gVOkN9D9101H8NwIz9d1LUFwtuyMD1F7vfA1WObx4s6ty+Z2FPlKQ/NM/kw6JnxwBrX7hMJNc7wMbIDiMWJpRWqlgKHD/fwOyQovp88G1X2JQGCWgPV67dYvioRbBbcqJwCHLxwrqosYAza5yAHyeeQqAq1RKfbwQ0FkOb1GzN1hELh2krDsBiaQ2P+fdS9CklT7kuvhj5LOQFclSIvPFSGJFA/4ee790IpogfeSw6K1haJD3qu8kIP1E7hB7HwVq+uO0Uss8OC2dsiXP/u22bUb6NjOXK+cmZKuKceSJ/10ifA01VrXmnPX8CPsV/GD/Grzn+zdhMFjIJwXd+C9ePsLpGeDu8MjXmtLAamMGEPY3a7nMa0Hr+yrGYo6XFMQi7afvVdV73ZQ7/4hUATLxsvDC/K1VgbU7ZNyj4TwD4NRJEkmcGcxzb6DPbh1lol9OMQzEHOaEu42MMQMz+mk3zi87higzrxS9AAYZoN/8pAhmuJnXre1A8kw2yFPJ3f4vCwxl4ETcD83iMA41iNdKW1OmHELffFO97aVb63/EEKzb2Q+zn5yHqt+IP9iyYLVt8BUKghWajUhNMNa5Xe0Mzb9dvx+QG5MBpr4q55gEhc3Li+GDvBgYpMuY/JKr2eUf+zQntyMMhBV7/FPF2aO32T6ZG9o9fa+pLadpkUuqlFuD5w5mqdVZAkb5o1qgKkSZI3MTqUbj3jRh3rJZTofD9/39XRoJvKWwMxGfx76NQIqhtWRGZUZG
 TR/Ozy3jheXeRc7AypdaKzJUkwUCNTnit4MvepBlzTKUFvD/aTFak7ejHFUBl7xmCH6YCsrZqgvcPcEYJphbWXZdI+3SlBnfS5jAGA2ybrVSadY4+6CY9CYHEzKWzP7Zs5Rdnwz6s7vczbActWdm5LdCRcTCDrmU82mWm7+5fLRdkjMcoHnY7MXF02X9ldjkJpf85qKDFzPnTp2sqMesRYb8FidNPyunzEB8=
X-Apple-Category-Label: MjczODQ1OTkzOiRjYXRlZ29yeSRfUGVyc29uYWws
Message-ID: <20260930195556.VEMpi3_uDKcgV1u8y1_8nGK7olT8akasdy-uXFuDO_g@z>

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

