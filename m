Received: from outbound.pv.icloud.com (pv-2001j-snip4-8.eps.apple.com [57.103.64.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335946D2C8
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797088; cv=none; b=N0vO63/3OZbZf6eVrPzw0Em5MkfekZ4M7c1qJloKlCF0YFK/ZJB2Peg3Ggc/8k/G5AA7aBQrPwVMPcjNxv91Ds/dxT1OsF6Zj4zLwFwFwDiDCR8j4Y6dhK5jX66NF7Nft3+mtfN9qtcZniyJfpDLAv4uAfHdsjenZdkjxBtxZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797088; c=relaxed/simple;
	bh=mHmfLrNTGx+b/0/s87nTCknXQ2zTaqP3hhwitizwAmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DMVm5GEAM44eDUqdWCLA75bkh7mcF+CW2Y35MUn7tbPUHkP0mHbEJA+0dBnrhoFF98vv3chKMzSSjo7MRxb2gY5SN1Dj2yRahytmx+mL/qet1fHO0H710F4K10FN40EntArlyrfj9mnUtIDEn3Aa/A6/NS9G5AkpI8qFjCjt09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=E8Z9RMTC; arc=none smtp.client-ip=57.103.64.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="E8Z9RMTC"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-10 (Postfix) with ESMTPS id 0531E180013C;
	Wed, 30 Sep 2026 19:38:05 +0000 (UTC)
X-ICL-RepId: 01a0f3d2-fd16-7e79-87e2-5eee55880ac9
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQRNXw5eHwQXRhlVBEceXVZDGxkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg4TVg5WHxlaBUkJTwpYAFkEXl4RR0NRWFwCCBRzAFJFUR9URhMZThtXTVAbXwJCDw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790797087; x=1793389087; bh=oqR5z2oHEqdzqiAvnE44B60F+sBnKAwcy0aKZtJFpBA=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=E8Z9RMTCm8GqVRXYWrJujRhKS2FCKIZUvXqpgrAj4yilfL4IYG1hc1S92VN5kR5/DB+1TPQS4HFLnIaNWxAp7+hK/aVdHEeUDBAyCJiKeYhieXZUKwzFWx9qEtjQlE247b1QczQDbtcCs4PES7d//v3Yh7+b6m4U+/yGDqN6Dav6o7mLeNub4N03ypqQC1F97WnBHseDXT5g0VHSoOOW8picgeOD78c+ig09e2HGobojFKBs0imZiHVdewwyZ+STUKX96MJrqa8vyfjFahxVsZegZUA+8hreWUNneXaS0EbAkrum4BWH5YlYgE3W2XXGU9nyy2FctHyJFe9s0dEFgA==
Received: from fedora.vpn.altanet.fr (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-10 (Postfix) with ESMTPSA id ED04B1801FEF;
	Wed, 30 Sep 2026 19:38:03 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/2] HID: winwing: two teardown fixes
Date: Wed, 30 Sep 2026 15:37:49 -0400
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
X-Proofpoint-GUID: D3Prgu7fvwmrQkJ8W27YYn0gIEqDuZMq
X-Proofpoint-ORIG-GUID: D3Prgu7fvwmrQkJ8W27YYn0gIEqDuZMq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfX/9/6qKAR89XB
 frbx/oorcqRqcUg1y6EnPakyLMkBVV2eXcQiDQYtGK9fTiNK+5qywlEf4/nT6EIy4eQGni0wde4
 GrjX0tzyYYwrVISyQmVH318s4GW1H6zPLDyKmtvF+kn9fwU+YVSeoJUmoaQC6Kxhbf3M6gfKotm
 HevXH5D7P4CYhEkpu0s9ge7txIJTRYEdG9BJ9UXRy76tUwVpss0t2Jmff50mh67LuRxHxffa7kC
 IuA5R7RTdMLe+2qBltW/GqgvjvSgH3fZ6MXOq3nXB68cePG52Mx1iRzki3IhNeYRZ0uwhHy7xXn
 i7nclhaE9bO3ojv49wk5gXhvzmVQyTYjKvgNHoAq3+MD9tNxNKEqEF1LZkRv0o=
X-Authority-Info-Out: v=2.4 cv=IbuKmGqa c=1 sm=1 tr=0 ts=6abd651e
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NVxr5sMXn2Treso2F6kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAAB15mj72XKTaP4q27R8zeGtwKfiJCzMcoEvS1jMaj2JEu0jlPJAe8xqYKx7gRZWV3hB+Yfc3UFiQ7d6PJCDf6h9glkBGs43Cgh6uVU13jk5mPgU7Uy9tCPgw0fXyWusNQ82O/6Ny0A5Ohh08++cJGOiMfVfYIxamVrdg/zE4coIqC4rryP/NnNDxWzXP8Cy+FakphLymzGYBPnX1Qe7w5AGCP2mg85nLAm4xl+Bm4S0a5zOZTihNZ3L9jYvVukDNw1qAeROg2dJbhyVUlyRwCVLVhupCHw0U828QUpTqjWccb9nTtIha8A2KPaPb2pQ3EZntuLJm//8rKyh5GG9cejDWHFxnNl6A1opCZAc/487s1PHcq52bEJM6DKojr8rWav9Fi61YuY0D0y3ZUfObP7SjsUWWwAgZ7nJPjtvRlqWL/PwGI9x+t98UzvFM8pNT7WQ66y5fuMM1fEPefCbuUAClNFDc6PHfSFOCQ8O89LT7VWFLf7KO5RRXNMYt/S/MHbq+YrXouix15HBV8IpHqnzx6yiubL1hcqIxNNKhRlCPEkwT2XmM9T+NeyRhyQrGh5h4zmFxNmupU7aCaQgRYjUv3JN4PuIRfiF8DTu+fQY3rI+3gwV+8G8G4VuTrWbayxoQDKrOWs5scwozqP/Eg0C6vs06mXKWtxzOlZ/pDQwHgyTwKzY1/PsQPJEL0qeGDcozC9gihBXkmk1M6ZCByZzA0MEV2JdT07anMQstmFBNuQ3tgKAmA0tydiW1T9vqZ4T6nTN739/PJn43F9hCr3GpW4BayoEJxy9seYrRdiit+ZzhGZYarm682ht2IKn1pMR3L5qNr9WLRyf0fxTkrLhCJTVMPrk6nnPAG6+ju/zbHtlItZpmzef+WAzGq/q7D8G9V8GgCPBSjiAKkTkvCOPCumuOx5EuiV8ydj2Fi4Vp/InpxV14hpQDrQtz5aC9FitOFBYxYNy+igLfY5cqSwH7o
 unp74Cgo0b/bYT7McazCgSiPuBEVPZ5awAeSyuhWVxNmXjEAGrapuL5eaOmgT/x3X+CjIBJ2ftt82ZnXwFiRSMXm0BxtgqiWxroNL0N7GACbZmLz3cIOes3qIYcKgG9KrF0TWENVs6Hgn8WUqLaj5I/HJVHSI3pL6Tb4hc5hq7rZWi1ciISwnzcTJTcthejDJ5Mwz5bWaLS513zbPACCMioBJzMDDp9YWY/OZNCROWJGvn7K8Cg2WhJ3f
X-Apple-Category-Label: MjczODQ1OTkzOiRjYXRlZ29yeSRfUGVyc29uYWws

Two teardown bugs in hid-winwing, both present in mainline. The series is
based on hid.git for-next, which already carries the related fix
a1a5ad37e50c ("HID: winwing: fix use-after-free in force feedback
teardown"); it does not depend on it.

Patch 1 fixes a use-after-free of the rumble work item. winwing_remove()
cancels the work before it stops the device, but stopping the device flushes
the force feedback effects, which calls the driver's play_effect handler one
last time and queues the work again:

  hid_hw_stop() -> input_unregister_device() -> evdev_cleanup()
    -> input_flush_device() -> input_ff_flush() -> erase_effect()
    -> ml_ff_playback(dev, id, 0) -> ml_play_effects()
    -> winwing_play_effect() -> schedule_work(&data->rumble_work)

The data the work runs on is devm-allocated, and hid_device_remove() releases
the driver's devres group as soon as .remove returns, so the requeued work
runs on freed memory. Cancelling after hid_hw_stop() closes the window: once
the input device is gone nothing can queue the work again, and the driver
data is still valid until .remove returns.

Patch 2 initialises data->lights_lock, which winwing_led_write() has been
taking since the driver was merged. The mutex only ever gets the zeroing from
devm_kzalloc(); CONFIG_DEBUG_MUTEXES and lockdep both flag it on the first
brightness write.

Patch 1 needs a device with a rumble motor to trigger; patch 2 affects every
supported device. Both were pointed out by the automated Sashiko review of
the earlier force feedback fix on linux-input, and confirmed by reading the
teardown path rather than by a crash. I have since exercised patch 1 on URSA MINOR sticks, with the URSA
MINOR series (posted separately, on top of this one) applied: unloading the
module while a 5 s rumble effect is playing. ftrace shows the chain above
taking place inside hid_hw_stop(), and the requeued work running before
winwing_remove() returns; no warning or oops (on a kernel without KASAN).

A third, related issue is deliberately left out of this series. The LED class
devices are registered with devm_led_classdev_register(), so they outlive
hid_hw_stop() by the length of the devres pass that hid_device_remove() runs
after .remove returns. A sysfs brightness write in that window reaches
hid_hw_output_report() on a stopped device; usbhid returns an error once its
output URB pointer has been cleared, but that check is not serialised against
usbhid_stop(). Fixing it inside the driver means dropping devm for the LEDs
and unwinding them by hand in the probe error paths - a fair amount of churn
for a narrow race, and the same shape exists in other HID drivers that
register LEDs with devm, so it may belong in the HID core instead. I have a
driver-side patch ready and will post it separately if you prefer that.

René Onier (2):
  HID: winwing: fix use-after-free of the rumble work
  HID: winwing: initialize the lights_lock mutex

 drivers/hid/hid-winwing.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)


base-commit: 145c2b2e9a5c0f794fb4009bcb072ab19f8ccfcd
-- 
2.55.0

