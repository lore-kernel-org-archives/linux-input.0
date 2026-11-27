Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.91.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769181;
	b=WazjEgdWyGJRPi0ry70w5KHdSmSBtieKskxItVA7uFv9nlyV+10LimE338JnYN1qge2J
	 RtZSatW8DzNP22ViwpEr/vpXGOwUbC/Eg1rRDzh14ek+yE33+6g98F0Gk0eE4rF+r7QN3
	 PTGcMON5gkxk0IDG/HJdh0+rvxCmFsDDrY6S6GCLKNCZFCzsifLvmlnhtuv6ex3isaRwK
	 vKLmQYyekFMPPK5xnri3kU4pQqultqAbKZe1sJcLdriEOYkTosXHbkTDj3plm4F9ZECTP
	 ZyUdQsJUNrGoQWYWQkFBkpmFXFQpgWkMnlWTurYA4+7Of8jR4Nvt48yGogIoAnC6YNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769181;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Info-Out:X-JNJ;
	bh=mZTbHwvFC2zOiNyBy0kVl7UsdOqSjsfO3gRxzoPgOtc=;
	b=KEvS12hhPGAbrMy3rkcVSaaK56DBneW4qkyHWeSSe7HFSw0S487XtzufXpTLtEWXOX2y
	 flM720O9mI2uZia+zGnnt6l9jC+P1yF8dZghQ1HzdXnciJzt9+6ByZ+aM1Kc561sdoDli
	 gvc288EUAZG4Y3m3t981dUk9nR4Ooutt//QWuBBvuqk6GmZfL92F/hO4lJCbVQe7zT6Ds
	 niqSi8eWtUdZ8zH0GsolKO5fFrooKgCow8G7tIaohvhLTveaLVrEqrBf06xCTUb1Sjboz
	 7AkfEuhVSmR3cToXWMUGPFd15TONu2ptRRIzjqFunghdMvL6cZHdIKP9zDgd7mOkUvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ynnk.dev;
	spf=pass smtp.mailfrom=ynnk.dev;
	dkim=pass header.d=ynnk.dev header.i=@ynnk.dev header.a=rsa-sha256 header.s=sig1 header.b="dPg9f/G8";
	arc=none smtp.remote-ip=57.103.91.33
Received: from outbound.ci.icloud.com (ci-2001c-snip4-11.eps.apple.com [57.103.91.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CF0606A31E
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 08:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16CF0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ynnk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ynnk.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ynnk.dev header.i=@ynnk.dev header.a=rsa-sha256 header.s=sig1 header.b=dPg9f/G8
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-10 (Postfix) with ESMTPS id D1AEC180065B;
	Fri, 27 Nov 2026 08:46:17 +0000 (UTC)
X-ICL-RepId: 01a21c2f-1648-7441-ac5c-5556e368693d
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynnk.dev; s=sig1; t=1795769180; x=1827305180; bh=mZTbHwvFC2zOiNyBy0kVl7UsdOqSjsfO3gRxzoPgOtc=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=dPg9f/G8p8JSqZLeFpSLKbLxTAVj8gLbW5qJpuYB8qsUX9J6tqMDelvDkb+miu7r05bqqf2BBINMKfMv7GUdk9k4SWL6rNcN0+X0vg7PxvzY+oG5FTM3ysP46v6K4mG3iai9Y0tB02vh8I/QRuwKPwYCbXcRoH6DbmOjC2FDChCG0uX6o21sqQKDPLQhVoLbaf6cZ9G7s+x+/MXoDFEgMJ269ZVYguh4vk9a676w+78HE0eXXTiI3YpIgtaUvbvHoCJMnSyadYHtcHeeOkvhQByF/f/1d80lRW5dbMdi/ufwdNGaHiJGy8Z7qxcKvfsdzx1DvwZ8aiJzEddc7/yA1A==
mail-alias-created-date: 1686161252489
Received: from notyourlaptop.clients.bit.guest.onway.cloud (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-10 (Postfix) with ESMTPSA id 9A2021800406;
	Fri, 27 Nov 2026 08:46:15 +0000 (UTC)
From: =?UTF-8?q?Yannick=20M=C3=BCller?= <mail@ynnk.dev>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-usb@vger.kernel.org,
	=?UTF-8?q?Yannick=20M=C3=BCller?= <mail@ynnk.dev>
Subject: [PATCH] HID: usbhid: drop pending output reports in usbhid_stop()
Date: Fri, 27 Nov 2026 09:45:10 +0100
Message-ID: <20261127084612.222563-1-mail@ynnk.dev>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzNCBTYWx0ZWRfXy0iapWt4CDXA
 xeNNVf9UVC9jJwp5KCyDUInS5Dze+mzc30sGI+7PLSZFius16dSdBFwJfTFzTp1oJGMTvfRWSM1
 Yzq4AfTWsOvgc1r/RIdGhC5X3hYSHRndZbgmoImtSBeJMtT3w6WY3RZ/UPiZeICgHTRbEurYifE
 RSoxlfNdCdi1cPhQt6+knlIFTyPQzfv5rkHDPUwtQqWONjXYRHKzuP/PZ4+SktPe32lVG2pa7/4
 y8psDDDYGVGWH0cf7xSI8lQcUStHcurRx4s00Rj/gOatwwy1w3Gdlg/1LxWpPE3tVNrRxvF88v5
 AAcup4fXUXRoSeQH4FNY9kXwFlOAeQ591kJbhv7Z7QKxbwXdbAZrO+P892bamI=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzNCBTYWx0ZWRfXzKY2UY1Iqje5
 qocim9iPbZgsr6VBboxPMlpNfEdwfs2M5orOyn1zJCmLhZFmOHyMIsBR3D3LU4pcCNGaHYg83bE
 Hkj7cdwQ531Yxa/JgL5ye5sfzScswF0=
X-Proofpoint-ORIG-GUID: zgnhYvaNnfaL1o4bnkXH405CDQgkI296
X-Proofpoint-GUID: zgnhYvaNnfaL1o4bnkXH405CDQgkI296
X-Authority-Info-Out: v=2.4 cv=QsvLTlyd c=1 sm=1 tr=0 ts=6b09435a
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=M51BFTxLslgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=51JdnUhQRHFq8RItG6ly:22
 a=H7SFQoNpLJNAuO5utOd4:22 a=VwQbUJbxAAAA:8 a=6IIhG1FwllppK0OEA4cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAABTQCruV7s11wGj52PnYSmTdhVMFej4wPR7zGjLnYUeE2c5zUlFZiBnhv1OBvuvt
 F6uA9vL5Qq0PoLlRzVaK9xyQMkp3/m+Ou9VPStWxgousgRb8pfVDw50k2TzxXA4wxwYMpF
 X7arSne5jV6Rbtj3jZ85HShvHU5XNv1B13TRLMmVmvaiF4hoNd2tIYxaFLjKw30JjeDMQL
 aJF1U1MyMPVKTn6vcQlPv0aSRUs06C8Bs1RWbEBIqH0GSIkhiz4gjUGGMjK7Ia6TnukDs2
 3LG0iXEecxWwqkjDyHC0oPaGKxDHFpgQSfHBt4bMADv99tbNTX20WdxNKJs3Mn4giSXeMW
 lGmS9etL6Uh0wD7AycNItiodDkZ83ER3O+723sf+uaES+t38pb3j3KcyDd/GhAQGAGRDrr
 o62jVXH8SlxsjGxyuUXb5HjmRD32Ux+eqIVPt3xVXLEUMTTIcvaqZttxBsOXJHMx9LMcww
 rix1COGGheg9gq6zTRj1ANItKqWse6DctBVGkO28rbG+UM9KYnUs2MMHOOxpDRtt8xz7aR
 En/Ct3FpiIe19iMXP4g47v6gG0ndIw221Ceg7SzlLLnOcOsmpHPf1gjspg2aQcANCojPDq
 Nd8c7wjlIHWcRQOOJAuiifAXRMq+GG9xMJSAOygmUfF0dTg/Xm1aoxc07e39iUN2GJ8Xl8
 KdSlz/zV+Qa92OK7TyBv2OtweGk0j8Po4aLnXVKGqtOCpi7vn0j/wUfBX0Qkk52/6f7Wu1
 SzQ+OZ3pV+wmCQMRUwqLqEYm51Bz00oeyCqZvcdzU/RWpl5SaGvNo/hJoTJgXf7/BY5skj
 Tckoekb2ZfJkSqYwUwOhtftuQg/D520QIJkliqWSSl89Q+bfX7n/ozmlBuPJVF2YauGlcu
 DPGFwXS6hZCY3NUHn42w8hk4cKnrqiHNuMOgCERHe2cnhMJeXQjUG1c1/1xEwLhJI9Mj2+
 46uBtYvkE3mL8hEmUf7X45GQx3LNJanaz848gejhgr7RQPLxADiU5ndJnlNOIwKuiQJRG4
 nTfQBsYkvy4DJZh1EcoI5fePeUe9++FhqdLGkMvMfrBLNpeoPaaK/vPfbE6RkzA3tNiFhN
 Jh9Ed6m2tVRggOtdDC78ibB0Uz4Wd9izGd1jCRis0a51+xjKNbiRQWfL3NyQD8WGxVAUit
 TlWUgPd13rsCQuM4Bv7dS7b29EQgzhPzuq59S38/N+TaxljQ+9Mc826Kurf9uhDqKBXgoT
 DfjAtW0YleK1f6gTqJZD

Each entry of the queue (usbhid->out[]) points to the
struct hid_report it was built from. The queue lives in struct
usbhid_device, which exists as long as usbhid is bound to the USB
interface. The reports only live as long as one HID driver binding:
hid_device_remove() frees them with hid_close_report() right after the
driver has stopped the device.

usbhid_stop() empties the control queue but not the output queue, and
usbhid_start() does not reset it. Output reports that are still queued
when the HID driver is unbound, for example because the device has not
completed its interrupt-OUT transfers, therefore survive a rebind. The
first output report after the next usbhid_start() restarts the queue at
the old tail. hid_submit_out() then reads the stale report which
at this point has already been freed resulting in a use-after-free.

Drain the output queue in usbhid_stop() along with the control queue.
Make hid_irq_out() leave outtail alone when the queue is already empty,
so that the completion of the URB killed right afterwards cannot move
outtail past outhead.

Fixes: a7197c2e4120 ("HID: Handle driver-specific device descriptor in core")
Cc: stable@vger.kernel.org
Signed-off-by: Yannick Müller <mail@ynnk.dev>
---
 drivers/hid/usbhid/hid-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index d7cf2b56e117..af92192fca05 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -452,7 +452,7 @@ static void hid_irq_out(struct urb *urb)
 
 	if (unplug) {
 		usbhid->outtail = usbhid->outhead;
-	} else {
+	} else if (usbhid->outhead != usbhid->outtail) {
 		usbhid->outtail = (usbhid->outtail + 1) & (HID_OUTPUT_FIFO_SIZE - 1);
 
 		if (usbhid->outhead != usbhid->outtail &&
@@ -1260,6 +1260,12 @@ static void usbhid_stop(struct hid_device *hid)
 		usbhid->ctrltail = (usbhid->ctrltail + 1) &
 			(HID_CONTROL_FIFO_SIZE - 1);
 	}
+	while (usbhid->outtail != usbhid->outhead) {
+		kfree(usbhid->out[usbhid->outtail].raw_report);
+		usbhid->out[usbhid->outtail].raw_report = NULL;
+		usbhid->outtail = (usbhid->outtail + 1) &
+			(HID_OUTPUT_FIFO_SIZE - 1);
+	}
 	spin_unlock_irq(&usbhid->lock);
 
 	usb_kill_urb(usbhid->urbin);

base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
-- 
2.47.3

