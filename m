Received: from outbound.st.icloud.com (st-2002e-snip4-2.eps.apple.com [57.103.78.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB58B57C720
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972797; cv=none; b=KqYwU8yohXa8fBV1CwHsimdLVADGZqiqjchziuthT4nSzWp+oQ4rgkxSXGhwwYZjR28g0T+QUV87t/CT236d3RU0+uDGaH15U+vkAOdP5SYi3BL7fB0WuK91jrFafvHbiulWvzS4jvq57xcKi6z4dQ+KG/luJRGKYe2hl+IjGIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972797; c=relaxed/simple;
	bh=ClxCZ+U5uBVjSXjXT29fkb98pvhYMY8loT5OeY8e7GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn0zLnnVoyjwCK/RQhtKBjAC8wM7A/FDuso2nFdX9716nPjdNUDHE5kOI1Z53smDfFpTW5Xr6Eyu6gQgSh/X5sFwfrAvqemWSqr6JZLSwap5BAv19/QhonmBg9Xn6fztVsUF+3wXpwlb+6oRN2tPKoJMk+LQQJq1goT3MN96mNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Rq3KOKPX; arc=none smtp.client-ip=57.103.78.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Rq3KOKPX"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id 79C581800230;
	Wed, 09 Sep 2026 16:53:12 +0000 (UTC)
X-ICL-RepId: 01a08716-7a91-7950-af9b-d9babe76472c
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQBOHVUZWQdDF0kFWRcOVk1aFV4MTRFdMFAbXwJCDxwTVhUTC1NWWxNVF0YJGQhdHRkKUFAPS1oVVRcOAkIfUB9MFldDRB8cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQC1kCQg9ICl0OWgRFC00EQwReAEUATx5ZGghfHVgCSQJ3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1788972793; x=1791564793; bh=V+1PgNjD/RjNsANywNjm7teD8U9b9ihSOKxgbsyAB6I=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Rq3KOKPXlgU5jAcJnDNKzKNoDw76k39jNzNc/mXJVSfFIvvMuyedO3vHJCzOZfidzysuNZEMkRs3Dr/Rm8rWc3smVCpJla76FhbyQ6vWvR6d0zL1xsJfKk0qy+spQcfbOjph4lTUdvHEskg4tuDY/tP3MF8AlWcmKEgk6ICgYSLONLgWvGa6QH5At3L2QieL2Xgq6/b9GSgLaVhIXdlSud2nyx5WFikduzeV5TeVo/aip6odGE4YDdn0tjpYxGwMxx0l5PTFH3N6siBgdmepr2SkInV6yV4qkVOaHFtiMCPn40Kd+Xc61TiUFbzalkL/x1tR7I3T2/jMX8tYjVnhSg==
Received: from komputa (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id 7AB1B1801E97;
	Wed, 09 Sep 2026 16:53:11 +0000 (UTC)
From: Cristian Mazzotta <cmmazzo@icloud.com>
To: aer@tuxedocomputers.com
Cc: W_Armin@gmx.de,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wse@tuxedocomputers.com,
	Cristian Mazzotta <cmmazzo@icloud.com>
Subject: [PATCH 3/4] HID: lamparray: transfer control when use_leds_uapi changes
Date: Wed,  9 Sep 2026 11:52:56 -0500
Message-ID: <20260909165257.352597-4-cmmazzo@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909165257.352597-1-cmmazzo@icloud.com>
References: <a62d1907-73cb-4cfd-98b1-7cdce3b37541@tuxedocomputers.com>
 <20260909165257.352597-1-cmmazzo@icloud.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kmqvgm5wbnTPgxJ97kpo-lxZeAnMVDKH
X-Authority-Info-Out: v=2.4 cv=c9mmgB9l c=1 sm=1 tr=0 ts=6aa18ef8
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=zMoZyIPnO1cA:10 a=VkNPw1HP01LnGYTKEx00:22 a=v3ZZPjhaAAAA:8
 a=AIMLDBJ1DqCETsLGAtUA:9 a=Uh4tPsEYL5Xn7yYgV4Nn:22 a=djM25Df-3sMe0xqo8c8Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4OCBTYWx0ZWRfX8B+tqO8YtYSm
 ovPQB3OQge3+fQIM7NmAQV/q0pVY2iafLcLxgyIqFK9L5/DP3h9jfAc/WVh7mCmfq2OiJMiMqAd
 EqEzNPMOn2LXAHPeN4f88LvYFM1uCLF4BN0Ud0cpqMhEXbNoaBMOF2wwomT2qNlRDOxwlYAp3Kx
 43MlLKUf5MmIbgdNKlfwOyT6OY1RikD/39w6jSR1EKMz/CCbuH/ZndMITvZd4QIxKbeB/NxaxC/
 y8fWShAfk/c2qYxk8NgzEBGxBv0rfup4kz+nGiA6RtY2BjsYJKaUbW8AJmOm8D39caSfh/8cbBK
 6QHi8gWbWr4l5HUga4dfZ58Rpiua+Tkk7ygu6IYuux4i8uaIs5OrIJ8H3eKYtQ=
X-Proofpoint-ORIG-GUID: kmqvgm5wbnTPgxJ97kpo-lxZeAnMVDKH
X-JNJ: AAAAAAABp2YrVvI5J3fKL1i2q2l5GYnNg3tASUjztMli2waEPmHj8UR0tvWMFn8GJdvrNYEmNe0+o2XYtvFiphIL377En+3FWgJgoN3xcPqPp7NRjnrPKivLL2+BBg1vN/PQCgbeQ6JQTofoa2TJMM56MbKACo128uunKSKuZG1Ut74btyjhEl5LEt6pdO7WUYU4dNVsdfwrHEGEM3Hy79zC4auQfhD/NB2ek3XGR/liuylpvgmaX0bRhY/VYNqwU7zqYtmI1w9uy/OzRNiSFR9p+S1aFzmKDnY6JY0Jy1+zDj2XoH6BYnFPS5VvXflZ+s5w6hgSaFc+3CJfaroskxyzc4BKMRd9vwK6VuylJVwCoenM20Mk8lzidCN6UiYAsagWXDjxjCnJiiCRe2g/9h5UJPqHTUXt4Jvij66v0hTCKPFi1fN2c6MDbxtfNwE9+ofx2I8rtKjDoqzNLuI1MW+dmhLL9ur9muwQljxUicLiMhzMYCRD9mgPxVfp+QcRqYrvpGEPgFHTM8++XJiculDgPVHCmn63KNI0z/EuoEai3UbV2q9ZBEadVmo5efOkjKCOrhIDL1wONFx3l+f1trbBvEvGtRG+iq/YlZp2glUzRV0CZMcbfhslwiYtoAlJVtQQzym2t6q6SlJyIRU4u1hbmlqEQ8qgofH2eaCLzDjpSqqNuiuFAX3FVGdtK7BkrswUivvFJ8RniV0nnb57hzp0V4Q/hyXNgQ5VoP3hKuzHYMkk356KLw8ttoJW39WXLmvadUD/lF3nQvxQnY+KpOCgqRc9YWhXqx2Ipg==

Autonomous mode is disabled once in lamparray_register() and never
changed again. Writing 0 to use_leds_uapi unregisters the LED class
device but leaves the device under host control, and writing 1
re-registers the class device without taking the device back, so lamp
updates sent afterwards are ignored.

On an Acer Predator PT14-52T (USB keyboard 05AF:767A) the device stays
with whatever last drove it: after writing 0, running a userspace tool
that sets a hardware effect, then writing 1, the LED class device
reports the cached values despite the hardware still running an effect.
Reading AutonomousMode back returns the last value written by the host
rather than the state the device is actually in, so the driver cannot
detect this.

Disable autonomous mode before registering the LED class device and
re-enable it after unregistering, so control is handed over in both
directions. Unregister the class device before handing the hardware
back, so userspace cannot write lamp updates to a device that is no
longer accepting them.

Failure to re-enable autonomous mode on the disable path is logged but
not propagated since the class device is already gone and the write
has otherwise succeeded. The restore failure path drops back to
hid_warn() for the same reason: it is recoverable, and the attribute
reverts to its previous value.

Signed-off-by: Cristian Mazzotta <cmmazzo@icloud.com>
---
 drivers/hid/hid-lamparray.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
index 70c596f292a2..bbde006d119b 100644
--- a/drivers/hid/hid-lamparray.c
+++ b/drivers/hid/hid-lamparray.c
@@ -659,25 +659,43 @@ static ssize_t use_leds_uapi_store(struct device *dev,
 	ldev->use_leds_uapi = val;
 	mutex_unlock(&ldev->dev_lock);
 
+	/*
+	 * Take the device out of autonomous mode before exposing the LED
+	 * class device, and hand it back afterwards, so that control is
+	 * transferred in both directions rather than only at probe.
+	 */
 	if (val == 1) {
+		ret = lamparray_hw_set_autonomous(ldev, false);
+		if (ret)
+			goto err_revert;
 		ret = lamparray_register_led(ldev);
 		if (ret) {
-			mutex_lock(&ldev->dev_lock);
-			ldev->use_leds_uapi = old_val;
-			mutex_unlock(&ldev->dev_lock);
-			return ret;
+			lamparray_hw_set_autonomous(ldev, true);
+			goto err_revert;
 		}
 		ret = lamparray_restore_state(ldev);
 		if (ret) {
-			hid_err(ldev->hdev, "Could not restore state: %d\n", ret);
-			return ret;
+			hid_warn(ldev->hdev, "Could not restore state: %d\n", ret);
+			lamparray_unregister_led(ldev);
+			lamparray_hw_set_autonomous(ldev, true);
+			goto err_revert;
 		}
-
 	} else {
 		lamparray_unregister_led(ldev);
+		ret = lamparray_hw_set_autonomous(ldev, true);
+		if (ret) {
+			hid_warn(ldev->hdev, "Could not enable autonomous mode: %d\n", ret);
+			return count;
+		}
 	}
 
 	return count;
+
+err_revert:
+	mutex_lock(&ldev->dev_lock);
+	ldev->use_leds_uapi = old_val;
+	mutex_unlock(&ldev->dev_lock);
+	return ret;
 }
 static DEVICE_ATTR_RW(use_leds_uapi);
 
-- 
2.55.0

