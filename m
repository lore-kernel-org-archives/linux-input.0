Received: from outbound.st.icloud.com (p-east2-cluster6-host3-snip4-10.eps.apple.com [57.103.76.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612735AC28
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786554858; cv=none; b=a1Cvaw8eKZMpY4KeiAYk/8Hq/pq4Ln4vX8lnVCKWl8xzz4ERElBksc74v2vWI8DDeEp1pKXhyQhYtJUklBXaqulbmU3KWRx8wFji1txwM9yaJq/I96VO5I+gYiqfhewZpS2TChEHiepEPhP139eB1n66/tmKIBRgae7tDjt3rx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786554858; c=relaxed/simple;
	bh=BGV1MgZXxYXNslLqKfGf2J17sOwwWOJv7MI2kF5/qQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IIrrl/iMUBxOfh1wLRf0gLhCj+Cg/oxF31zRMdwpTBuCuPHE4W8PM+FkX2SRj3j1DO9EJrKAQeDjFgnDYzHDdETicQ6d0cQ7OALGbuFTwCbIjbaL0kcy002T70BjFtTLCP7cWAxC0+NJl/91dh+qyWSh1pX1V9CJHxEPfX9KZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=b7HEPwT/; arc=none smtp.client-ip=57.103.76.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="b7HEPwT/"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id E775018023C8;
	Wed, 12 Aug 2026 17:14:13 +0000 (UTC)
X-ICL-RepId: 019ff6f7-aa1a-7e94-aebd-8fed7d015402
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFLHV8HWBxHD1YKTVIPDxYKFkFcWytfFRcbXAAXDVZNVB0dDlgGEgJaRQZNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4AUkVRH1RYXgRTVg5CCUoFXQ9aAEEOSQBYDkUDSAhLBkAGRlRDVwoCAXcGV15aF15TFx9LAFxFWg5bBEcU
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1786554856; x=1789146856; bh=trXbooArr6IgUzVMq8zu+CyqfCddlT4aFaGeZl7m7kU=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=b7HEPwT/X6K7ChhxUAQTp1IaOkFx9TAnZ6LGi5RBZsuK90VnchAc9pEIGaX99tXglxsRqyRBSkSgMR0YZilvvxXyVorkqVOcm8ub83tTFU23asvXqJZcm6y7f3BClx/5KrfjFWVnjzuC86UGGiY+dJpAqe6bqHdEpW09jaP1LAJXVdithUasnLTHFHeB7oo6armCtJ394BP1ZepGSUwJaWniDxNl+moBGOrOoj8IKRhfCkaefd2EBNS4irB4kI5PqWvF4EbMKZtPp422gqXwNgN0n9nmGpVXk+1nICnfTisZoT1CL/YN5WBfzA4g9/B48ikoUjAvcFFG9ASBNO74RA==
Received: from fedora (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id 9397818001B3;
	Wed, 12 Aug 2026 17:14:12 +0000 (UTC)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <f3nr1l@me.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jikos@kernel.org>
Cc: Ivan Gorinov <linux-kernel@altimeter.info>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: winwing: fix use-after-free in force feedback teardown
Date: Wed, 12 Aug 2026 13:13:59 -0400
Message-ID: <20260812171359.18135-1-f3nr1l@me.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0MCBTYWx0ZWRfX/tS18YCF2TJQ
 SDbpea8UzPC486cXPJYlIdDUh2eoSwZhcUlhUKAZ/b5J0oHM3t4FLxu++K66l2MsAc/7mAlfLaU
 ZUeVzPCsRoECBDZ9vdHCRXQjHAY7uW58itKDpqOkRbnXq1U09bVXWc/YFaAuXhbqSb5dlJNqhjD
 sUY75x6eWr9JZtrz0EaPv9QGraFDXTNfedKrnK1PlnrPZ9TMqnEJeY+dpZumgK6u9ez1bO2Hkb8
 bTd9vqSg/Jk1gskuPmkSy0iA3eukjmgeeACqvJwW/hx7BAmz0054TcC2vFZFpOLiHC/353FKPpW
 YzpXUOG+RU6ci1nGSf4NQ8G91GXaV+R91RwBEMzWkVVpaguhWX4ncTZJTPqdUY=
X-Proofpoint-ORIG-GUID: CC2l54s0qvSphbW69l5f-EhFfpB3Qdej
X-Proofpoint-GUID: CC2l54s0qvSphbW69l5f-EhFfpB3Qdej
X-Authority-Info-Out: v=2.4 cv=bZRmkePB c=1 sm=1 tr=0 ts=6a7ca9e6
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=tnT-KND3AOYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8 a=JGVArrzWy-SbAy_XPb8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

winwing_init_ff() passes the driver's private data, allocated with
devm_kzalloc() in winwing_probe(), as the effect context to
input_ff_create_memless(). The memoryless force-feedback core takes
ownership of that pointer and frees it with kfree() from
input_ff_destroy() (ml_ff_destroy()) when the input device is
destroyed.

Freeing a devm-managed allocation with kfree() is an invalid free, and
the same object is then released again by devres when the HID device is
torn down, a double free. As the allocation also embeds the LED class
devices, their timers and work item live on freed memory and the slab
gets corrupted. This triggers on unbind, rmmod, hot-unplug and on system
suspend, where the firmware cache walks the now-corrupt devres list.
KASAN reports:

  BUG: KASAN: invalid-free in input_ff_destroy
  Allocated by task N:
    winwing_probe

Pass NULL as the memless context instead and fetch the driver data from
the input device in winwing_play_effect(): the HID core already stores
the hid_device as the input device's drvdata. The force-feedback core
then owns nothing that it must not free.

Fixes: 42d020b54edc ("HID: winwing: Enable rumble effects")
Signed-off-by: René Onier <f3nr1l@me.com>
---
 drivers/hid/hid-winwing.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-winwing.c b/drivers/hid/hid-winwing.c
index 9cd25a7..19b92c2 100644
--- a/drivers/hid/hid-winwing.c
+++ b/drivers/hid/hid-winwing.c
@@ -315,7 +315,8 @@ static void winwing_haptic_rumble_cb(struct work_struct *work)
 static int winwing_play_effect(struct input_dev *dev, void *context,
 		struct ff_effect *effect)
 {
-	struct winwing_drv_data *data = (struct winwing_drv_data *) context;
+	struct hid_device *hdev = input_get_drvdata(dev);
+	struct winwing_drv_data *data = hid_get_drvdata(hdev);
 
 	if (effect->type != FF_RUMBLE)
 		return 0;
@@ -342,7 +343,12 @@ static int winwing_init_ff(struct hid_device *hdev, struct hid_input *hidinput)
 
 	input_set_capability(hidinput->input, EV_FF, FF_RUMBLE);
 
-	return input_ff_create_memless(hidinput->input, data,
+	/*
+	 * input_ff_create_memless() takes ownership of the context pointer
+	 * and frees it on teardown; do not hand it the devm-managed drvdata.
+	 * winwing_play_effect() fetches it from the input device instead.
+	 */
+	return input_ff_create_memless(hidinput->input, NULL,
 			winwing_play_effect);
 }
 
-- 
2.43.0

