Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961D3AD525
	for <linux-input@vger.kernel.org>; Sat,  6 Jun 2026 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748303; cv=none; b=MjUq0DT+7vqsoZBrtDcBsZnRnjYABjBtlMAjuNZwLSBqktulGEwq7rEC6hl7VoUKt+mi8zTV9mTALhIae9HCZSixNZtGrCo1kG/Y82VFt2erf6J4y++M7WVf6rOyZ2fMFC7G5bKJSAntuywH3afI80gvZzEaN0AzoTnVTp1WLYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748303; c=relaxed/simple;
	bh=+8Th2tqSkkRp9mu4UcTUml9XGNx1UT/wjthRD1B0siU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmxQydGWqX32wLLb+x2vY+OD84ozRdCxKNdEfwg5VmirNbKw/cGuPPpbrUrFptm11n//yOn2n2uzILX+UEGe3MqKus+W+yueWpI4UncgeUFmMeL2Uxw7FR5wC+cGHyqaO+hPQGzJi5MCGyqvSeH2CSkwfQ84OBaWrG/dfZ7cbmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ny0nN/Nf; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ny0nN/Nf"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f626a65so1197746b3a.2
        for <linux-input@vger.kernel.org>; Sat, 06 Jun 2026 05:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780748301; x=1781353101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpfDjdD9Z/m5BcMHs2GpePEiDHhCu6+UBKXmA/fcyZA=;
        b=ny0nN/Nf32cnjEfsUqMnGD9qt4DiAjxuG/evcLBo+77f/cuMXfGhNMwaF2AePHXKx0
         VDC7ChY37MB+aOcP/CsaTqGU/GK+flXpHmVvdUtoZiNoSzQR/tG9ID5G8P9raQI8VxNF
         BqV11Bc+SFRkP+u475YwGnFExTEXjALu1nJ0l/Hdj5c5COVtM3LPb08O843qN5sDyBlL
         UFHdErwsK4STfleGUty3R8a8JYvOsh15bRANAN4A8LfiQrC7LQQa8XZJgJqVif0Avd+S
         v8EZWDJNwVNRiEP/1d8huMFEJrOJX7VTsi8Avv15em5EYgfOsYQa4UpcrHw549yMZ5EG
         t1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748301; x=1781353101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QpfDjdD9Z/m5BcMHs2GpePEiDHhCu6+UBKXmA/fcyZA=;
        b=rGKuY0aHONfFX3GpIGw7dVc6dMbAqv2ArB2DzhOo1zNfohRe3jKC+gpAKRGY3EmZs+
         hHW7zgttA3lVjhUbC1I05C/CFIkHTr64dQK3jq4mho5jBEYACq4SYLIWatGvcJNVobZD
         YRHzoVNXTNlOWiQoevoCBUCPDUfjsRhSysqdP4JuSDkViO8JeDhaBW4DLwHuFE30jIGT
         f1CwrtP6ae69JGful9Xx6QJgJepx1mTFpBQEsDcTSGDS/zVFrlUGZctBoRMgVdyjtKf9
         aMzFzo52dYv+z6AoeZat3uPn3WSz9UXvxiIuhAvx3rufIo8wX9gqwLTq379DCKH0WSWZ
         pirA==
X-Gm-Message-State: AOJu0YzuxfPXKhgcZHAk2oNLm36360uOAM8Vb8fp4IYPua0B9LMy9jf/
	vS443q7WFKDPADYiWY4bjJiiUDHSXKeLEGN8ezvcwPBlbMx9hEdEcniu
X-Gm-Gg: Acq92OHMgmCdHUtezMmCBD8bDB89rGbyXUIHHud6euz7QX2d/1+nDQU1y79jcqI+3Sz
	VCsQqAUkK2lQw49FlKmT8Suqy0apZrtmcK6Cl9IK8MkfRxBWiBZVp7Pl9JQFFtcwQSxfaXPn6gx
	mvAA0vfyB4aptG79NwF9RbMdx3YWV0QrZ1w8a6XygvvW6+zUm/xaScfeNT412Qnccsm/OTY9nSY
	towG8B8ivUD6R2NmseuCTTO3YFFWFZCokp9o/zReG5vNXlZHebfzgMpHRfbunkd577Ly17h05G0
	V45qOdEFhF2XLP9vsX0w8OqatTnx5P90gjA+Vt7y/hHKTFSlLaur09V2g258C2Axd6BBBGcziwi
	YsBDH6cl2gsrU79Cj3HxUqlF1Mqgn8ZDl1a6rfgy5jcZLGmLZTuUfLo/ESkvXiXOJI6CHIPb8+w
	NCyxuRPbqbjoQHOxjFs5Y+xRsiwkkhUQd4ZiErHPbYi4kXURP35M7fCi7L9i4=
X-Received: by 2002:a05:6a00:4fc9:b0:842:5931:7b8c with SMTP id d2e1a72fcca58-842b0e20598mr8198084b3a.1.1780748301163;
        Sat, 06 Jun 2026 05:18:21 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm15253532b3a.61.2026.06.06.05.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:18:20 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:47:48 +0530
Subject: [PATCH 7/7] iio: pressure: hid-sensor-press: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-6-june-hid-iio-correct-usage-id-v1-7-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/pressure/hid-sensor-press.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index a039b99d9851..3e47a10d72a8 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -155,7 +155,7 @@ static const struct iio_info press_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int press_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -176,7 +176,7 @@ static int press_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -204,7 +204,7 @@ static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int press_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct press_state *st)
 {
 	int ret;

-- 
2.34.1

