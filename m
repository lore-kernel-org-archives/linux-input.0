Received: from outbound.pv.icloud.com (pv-2001a-snip4-11.eps.apple.com [57.103.64.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDAF496D50
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797107; cv=none; b=ZcxreLNgjNbBLPZwgwb8HlL0hRvyuT6QYnIs6WsuAxGUkBiWdm9ajV5/l6uNhwaOVOfxE0GpzYnOEwh8rLNKhuIUmroFFh9D4thjqO5vuZOh0X6oJwIMYeuFTIVl/Xj3bvs+8qY1X9wtaj6NP+nsRLpDsCyrapqtYYfKurhNIVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797107; c=relaxed/simple;
	bh=gn4Z7X1Bz8S1aM5L2OBzFtSGg9XUeD4J2mbu052BedY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loiNAppyBbqWNYxzkr8TENVdeZOHTeHQmYD5WUgcrhFIJWTzVfN0yfh6EUza4BTnWHJ/8G8UGctqJeUTtI/JEnsxAXJJAuqQ12wsXH9kJS9UmxwHa6Ai/AXmzFFC4zEs9F/gQlGaQu9UoyzZ31QsRvurdbNrrGVDmRCKREjAxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=K6TAIuq9; arc=none smtp.client-ip=57.103.64.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="K6TAIuq9"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-10 (Postfix) with ESMTPS id A9AEC18004CD;
	Wed, 30 Sep 2026 19:38:24 +0000 (UTC)
X-ICL-RepId: 01a0f3d3-45e4-7310-acc8-34173ac3afc9
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQRNXw5eHwQXRhlVBEceXVZDGxkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg5CDU8HVQ9eVkJfSVBVAw1QEVobBV0AWgRDWk5SWAVbAEhfGgMOVg0GXghPCl0AUgdHC04dCl4fHBYKFkFcWytfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790797106; x=1793389106; bh=B+qmiAA8NB0KIei/Jc+VzkkUiOV3PQg4tH30TVw13pk=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=K6TAIuq9fVvqjweZdKhtrfUBTpdVW/06ShcGdq1rtWSXOODTWeMtm+eJGKpQyaPQf6V4v9+9A20r5VPd02sfsqY5TwXESs1m0mCvYhGRHC4oC4mvk2F/WY5kDHGY1RLDZLxDcdRnNk6XiuQTJsDWk/XbXrNYydC40Q8TIoXd1kr8AyFATBZUPw4GR3Xwxm7TlkLaE9z8nWOdyJDQMIIBAsk3A58AegdH86Pmkeg9p2ZaRZf27CgWsW2RzFUpskp8o1zJY+V9xIJNyuiaNQaS1cIQqDWmh7GqxCBoy08kx60uVf1vIw35aEaeDhdxcQfCUn4Q/y2adW/PW3wIB0WBLg==
Received: from fedora.vpn.altanet.fr (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-10 (Postfix) with ESMTPSA id 5DE221801FD3;
	Wed, 30 Sep 2026 19:38:22 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] HID: winwing: initialize the lights_lock mutex
Date: Wed, 30 Sep 2026 15:37:51 -0400
Message-ID: <2474885d2f1c84fbacc607163c6a52028fb0caf4.1790795726.git.f3nr1l@me.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790795726.git.f3nr1l@me.com>
References: <cover.1790795726.git.f3nr1l@me.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfX0jJsU9jJHaI7
 pT5hAQP8Equuv88KC/bfLoIgPsHsr9mleHBU7yPyc06KNLC6PoJ/ac4P6gCTfs9na7wTos+SmCx
 W5fq1hVDIc2KN5ad8hSs9XrcOWpUTiaI5qJ+k/ZIbPjBfCzUGqs7fREnTb4zBtG2lfL+SCMmlcC
 Nj3nwB79Ef4gtk+eymtQ6z+5q+ng5jsJglUenn+5Wmg1s5vuDnAluz6wGSlb0Q9uEstC5Yd71zf
 jCJJXHR+gFwKNx5NtnC0xRxS3RLFsPykcOAsrikscowGgFT1UTnlabAox9aiOcWWt1YS24zY4lW
 z3OgD5vxXVmz/Tg1nm3Zo48KFieqqhlKrOjF4pjIpWbRXyx5/+8Lgae/eQ3RNc=
X-Authority-Info-Out: v=2.4 cv=NZXrFmD4 c=1 sm=1 tr=0 ts=6abd6531
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=P_iz6yS4q_2TDqSedCgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: B6v5Q4fGnPcP2EPO5ho4ZoMecOiG8Rc0
X-Proofpoint-ORIG-GUID: B6v5Q4fGnPcP2EPO5ho4ZoMecOiG8Rc0
X-JNJ: AAAAAAAB9/6lDtgbTsDbI+bG9U6Bx7xOHMW9/HheUQLbZ/HiNBoMCgS8y1CQ9hW8ugW+bZx7ZudyOo8hkhtwaIUxe9ezkt5dau28vMN1rP/nG6doqugvsxsK+iG1lwOAXXGmdoW6PYMnF4we/fYNcQUuKlmTq9EiiHXUFSRq34hWPeSghn0A0qvmVyiqBCakrnLjSODeG4xuHO82kgm7b/GWm26Q729KYSFmT9lhKGpVMArOEtR9Z1Bt4wUSCBX2954Ts6ZHnW6gaLBacH6C8E8i8IpxiGHxZyx6e4mFxmRv93wzcsH61DtmhtL5hWhSE7d7HUYa56Po5T2/JqNka/x+AQqDdzQwhusDpyPtpaxJIf3w83o4EJub+ISRo0ABJwXzmbk9hAXDLRh1A20cfYs4pZl8bEhXLnPa9kWTofqafnA0AL334BR6gQ6U/2d2yWeKyvbnGQfNuQWmoJB93stAfsp4YALYAsL6AATUGavK33/ykYlOvxkNa0N6hTLCLyK/t1DmvGcBoOlbsF0wdex+tUrwhRLwQqnwpvS5aHwFu2GXswT61LoTRfLT/7FsGdoftMB02F2+xHjf0Vc/H0s3dTVPPNtqk4xvdTCbVfKn2V2abE5GiujH1sPTVUi93Ry6aaefjZLs7Yl1xL4e5J7vEuRl6n3S01ZQPXxxZZvzkMa01j0mqUk/en0iSRksB6Zeepf6Ae+CuojDACpvrDPL3NOEXmvbXpj7zPc3SCy8vDOLMFUoEDHzflEMOXQfHCY8t7Lq6KL6v/KYRrbCfQEQveAGmfmihzNavZGH0sh8Gg==
X-Apple-Category-Label: MjczODQ1OTkzOiRjYXRlZ29yeSRfUGVyc29uYWws

winwing_led_write() takes data->lights_lock, but that mutex is never
initialized. winwing_probe() allocates the driver data with
devm_kzalloc() and only initializes the work item, so the mutex is left
zeroed.

Locking an uninitialized mutex is undefined behaviour; with
CONFIG_DEBUG_MUTEXES or lockdep enabled it is reported as soon as a LED
brightness is written, either from sysfs or by a LED trigger.

Initialize the mutex in winwing_probe(), next to the work item it is
allocated with.

Fixes: 266c990debad ("HID: Add WinWing Orion2 throttle support")
Signed-off-by: René Onier <f3nr1l@me.com>
---
 drivers/hid/hid-winwing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index e8030fdc14..cbfdb9c66e 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -374,6 +374,7 @@ static int winwing_probe(struct hid_device *hdev,
 	data->has_grip15 = id->driver_data;
 	hid_set_drvdata(hdev, data);
 
+	mutex_init(&data->lights_lock);
 	INIT_WORK(&data->rumble_work, winwing_haptic_rumble_cb);
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
-- 
2.55.0

