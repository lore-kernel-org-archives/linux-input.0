Received: from outbound.pv.icloud.com (pv-2001c-snip4-2.eps.apple.com [57.103.64.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269464718E2
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 19:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797103; cv=none; b=mJHFqhKzZRH2gyMAgd0AOqauMHOrmMwXTorh5S6AFFO2fzflALkE0RA5tZjFUsvWrHOxaDda0LGzNX/lw173NrUvoR4abRWejhGvM1p/fQLxtih/2BFzXkYi+dqhbt5ZtI/qSJQcvkcCAC7fqmGtTvuyO3OgMr50O0qvQrsSh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797103; c=relaxed/simple;
	bh=mahWO6Hv67HejFru7SGWB6IyczElkIkBqJJGZg8oGes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VtsclGgbb0Ky6aRjkEyq65hw82jB8SIOUieIPIaEoF2e2Nz2hhvRtpaDdDrn3Xb1x9dQgqWyoMZe2Qw8MgWda+4TQ9PO+aWX6paO7VL1AWJnQqHkMGnv8YqhB3dlCgXwxiTEnpEcZUc9ygoQyOkEskxthw3RBUtIg3wjYvKd6i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=sAFbiX/d; arc=none smtp.client-ip=57.103.64.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="sAFbiX/d"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-10 (Postfix) with ESMTPS id AEE201800117;
	Wed, 30 Sep 2026 19:38:19 +0000 (UTC)
X-ICL-RepId: 01a0f3d3-3270-7c81-9e3d-1d804f2d2978
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQRNXw5eHwQXRhlVBEceXVZDGxkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg5CWksHCwZcBhZaS1BdUl0BEg1JAg5TCgcUWh0BCQNSU0gOQQoJAwkCXghPCl0AUgdHC04dCl4fHBYKFkFcWytfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1790797101; x=1793389101; bh=UUN03FSJarvghL1KapM0oVMxVGRDEvQLk2HJdY/QbGg=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=sAFbiX/dYEV2LtzhOZiIAChHayJ2y4tcIaKoIGYMW0fclT5XCCKTZ0vNmg6jFNbIdbGIzL5O/yhqZTCY/mNWBRtvSsTEtWB3M9W1r82qMLs8LurE29Tw4Hk542nsSLRsf79D+W5VOUtCL3yBtYEy8LZLbsLEWmoyDMGj/oFQtvzMAhCAMJO21DYfR9puKkn0aM8a19y6cV/iOXjGE4xAH9FKrlxE/DBdzWgPB4KrpkQ7VDUzXpoHrJoDOj+qtSlWwxQCeRa1N3pmnrk1xlBdX621vyXrSoEw1RdXwxLANe3R6TgRKtGnjelz4/99ZzZq6e4oXUAG6NeAqgWz8/RgJw==
Received: from fedora.vpn.altanet.fr (unknown [17.156.192.29])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-10 (Postfix) with ESMTPSA id 638EF1801FD2;
	Wed, 30 Sep 2026 19:38:17 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>,
	Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/2] HID: winwing: fix use-after-free of the rumble work
Date: Wed, 30 Sep 2026 15:37:50 -0400
Message-ID: <2c34f174fc3c0e63b411cda5dce2d49a8799d4b0.1790795726.git.f3nr1l@me.com>
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
X-Proofpoint-ORIG-GUID: SFxw5p3wIgl2jSlwXBea0qIOGBVEvtPf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4MCBTYWx0ZWRfX0grNS0khfgot
 Xk1COne9O6Z68r64J83tH6Aepop+RM9L9ryxu0xHTclAiyUDz82kAxZdcUlXLN9GSKtcwRMuKhY
 WhdQPZ+2yjG+1Sqear1AGnlInXTxswBtRlqyJt6aVSpDC6SYBIUizlHiGqcu8pUUZy+d6BfWapv
 A1KXkvsngGAmS0qrdPsMZWwtJEYejYSNugh8bFu19wrbE7ArV50KFj6j2b2iDuGM8wKqMS+YwK1
 /6bGdeJkT5UrpuWWN1c61kCG3T1BOolUbBXwXz3EqT7o3WLe8SIgsWhK7NvLflBoTffTdFD96e6
 Boqy65xIyXlMoVfahgWrYofiPlIv9IxRdLMEM5dHUbN9Xm8yFoMT7CJPHCblK4=
X-Authority-Info-Out: v=2.4 cv=J9GnLQnS c=1 sm=1 tr=0 ts=6abd652c
 cx=c_apl:c_pps:t_out a=aW9mcIavGNWWFvFFKOxBSA==:117
 a=aW9mcIavGNWWFvFFKOxBSA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=rKEBkSQJ8dcQsvHFcgsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SFxw5p3wIgl2jSlwXBea0qIOGBVEvtPf
X-JNJ: AAAAAAABA21QjXv1wyEbO9ENdwif3RSPdaV+ps5ssAGTaKdoyM98lqlzf5W+tXhhr/iNKVomM7Ib9zhDmhzOSJUZsTr48wUiiu3C5ch/mNSBq8L7J1xyMI/YDukdnxqRQcUf2OIKcN2OLd0WX+gqWVo+IywDxznNwdS/hL1MJqHwKbfo73wlX1P6uA2NCqtlRTFw9OFMDDB86lCz8ZkSG2yRJhYBiQUUMTtPTWf1bgzQ1MJSxT6Mvr3Hub8byNI7rr3pg2icz+3y/JvovXgIIieWjsiRJs+4IsWdOFnEmjDvwjxOkmVMIv30dZQnO6Xf1waUQFWxsddp/AHzKJ33ZRi3OYD8/NUeV+XEHKAoXTiNNpX3WX+2hhNmbD3XITgVPta7T2yiyOD0KkuVe3vso40GAfA7fbe8tRh7dKBxlWl51BzgfhP70yCaZBQiyqyyUR9Myt2RR6L+VIILbUtG4k2Wpa1hF45ObuFaW5w9wj3hJ+PkMSn+GdmjJZ0ZzEHRQ2lNt6ixNKR19XlxMeaTH4tpXS438kMVOdiSv6dJrMo6W6WCw/h2COHoTeqWtDhRDJym3PCiOk5EZp9o68Ndv28SjJjkN9NyfDSGwjl2yijt5xkiXgLUD0Ds341vyLlK9zbPK9OfxQZquRb0vEiYEi8xE4oxjQIv51LrP8bjeUxhAdKchhaoWQbfB3aq8GmCZDU7ruwxV5vG7uA+ZGXI+6QWLAkurfgiccLfcWn+zuY7UX3HP7z87qqanKID5z0WuxMXgPzqf9C5paZmLsCj6A1hJKHL5SGnsXl8FwY9sESRGJoR2EAF
X-Apple-Category-Label: MjczODQ1OTkzOiRjYXRlZ29yeSRfUGVyc29uYWws

winwing_remove() cancels the rumble work before it tears the device
down:

	if (data)
		cancel_work_sync(&data->rumble_work);

	hid_hw_close(hdev);
	hid_hw_stop(hdev);

Nothing keeps the work from being queued again after that cancel.
hid_hw_stop() unregisters the input device, and evdev_cleanup() flushes
it while it is still open: input_flush_device() -> input_ff_flush() ->
erase_effect() -> ff->playback(dev, id, 0). On a memoryless device that
is ml_ff_playback(), which marks a playing effect as aborting and calls
ml_play_effects(), handing the driver the combined - now zeroed -
effect. That is winwing_play_effect(), and it ends with

	return schedule_work(&data->rumble_work);

Unbinding, rmmod'ing or unplugging the device while an effect is playing
therefore queues the work again, after cancel_work_sync() has run.

The driver data is devm-allocated, and hid_device_remove() releases the
driver's devres group as soon as winwing_remove() returns. The pending
work then runs on freed memory: both the work_struct itself and the
report buffer winwing_haptic_rumble() writes into live in that
allocation.

Cancel the work once the device has been stopped instead. After
hid_hw_stop() has returned the input device is gone and no further
effect can be played, so a single cancel_work_sync() is enough. The
driver data is still valid at that point, since devres only runs after
winwing_remove() has returned, so a work item that is still running
while the transport goes down touches valid memory only; its
hid_hw_output_report() call simply fails once the low-level driver has
torn its endpoints down.

Fixes: 42d020b54edc ("HID: winwing: Enable rumble effects")
Signed-off-by: René Onier <f3nr1l@me.com>
---
 drivers/hid/hid-winwing.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index 19b92c2c65..e8030fdc14 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -391,11 +391,16 @@ static void winwing_remove(struct hid_device *hdev)
 
 	data = (struct winwing_drv_data *) hid_get_drvdata(hdev);
 
-	if (data)
-		cancel_work_sync(&data->rumble_work);
-
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
+
+	/*
+	 * Only cancel the work once the input device is gone: stopping the
+	 * device flushes the force feedback effects, which plays them one
+	 * last time and queues the work again.
+	 */
+	if (data)
+		cancel_work_sync(&data->rumble_work);
 }
 
 static int winwing_input_configured(struct hid_device *hdev,
-- 
2.55.0

