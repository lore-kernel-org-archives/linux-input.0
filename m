Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE393AEF2E
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 05:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745530; cv=none; b=C2S5CKx5HK6GyfjEweq7iZlPid+2q+syyQIKlnH+J52PUhaTn7fOkvyFi04HYJInOuQqBIcqvVhwu5W13XUxS3AGJtviXn1Id637H4zxlCjP3TZ52Fw8WLmYNcMt2pdMMdJC3YVrs1qqkHz0v8/eo4RvGwrYpqMTVlQoD7E5i58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745530; c=relaxed/simple;
	bh=mVZKYZ5RQngGFM3QbYSpefMNSi76MF6IjaQzPsyX+Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KKbD3a853pxv1md8eeK77PqkmQz+4Jbf0p03nhfUcw/7anuHZSsH1VNJpguz2wM18/wD09OH2YvHBxNcW86dlQTuErNeaqg+stnDLQ6UaqGhwXz4Ltb0c4fd+R6aauj8at/csOrgJDD4OnNyhfcqrXnZaZjZlFY9HRADoM6GA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfgY14de; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfgY14de"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34c0b552ccfso571388eec.3
        for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 22:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790745528; x=1791350328; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gB3RSmmxTuZvY13a4OJmrWrVo3q4uhhENWZDBtXDYhQ=;
        b=PfgY14deA1oW53vtBxlkkKzAI9PYxLNVP42HMV7nykmq+boLCk8g4CvfzWCj6SWZ3x
         7QtAh5TqNF2jGg6evkqkLB7d87b8BszoXMxDm1YHGfP3OpqdD/1OAB+A3sxGZjaUQMbt
         VLP/qdv2+3TTc/ntymh9rrVin6SwErn1UhJhM34Xy5niXTMhNkiF02t4sG1L3BcvsyCY
         A83FVHWQ0YDrh0LnmfujOzUm4xE4r0DuGs6Tz57/8gJ5pURb63BRzKbuOQ9PL6zFtMDm
         3W2aRm9icbEW0Ab2JQNHu+ZAvxh1ybAw4tVEvE9jd5O62fGAk/vB/mCcVpuybz83Lz/O
         5zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790745528; x=1791350328;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gB3RSmmxTuZvY13a4OJmrWrVo3q4uhhENWZDBtXDYhQ=;
        b=thBZDuq43SuthVLOxA6zzDeUHUzvJEF2bVdTvOzkCUABM8C7UCaJ2oINaQdcvB+0+J
         cETcPezPLwffVhTaBnazQE94IpnYJIfcq0mUDnRSl9Q8ia7A66o+svl7/CriiUgFrQ0T
         /7gwqd2Z6N3HpOwn1qDE+zYj2+q5TzgJhZ+OwUGjPtPp/1KCl7o9sdj53rOHC77SZPbB
         7YKS/9+LkXXoSijZ0rWIzVemPVUmFqPXBXw+rDCn2Q/dEGYA85IqSY6ZqdmA6z38CfSp
         8wpO0XNrL4BR8fB04Hnuk7cZU+QgP+uVtXA9SWcvBh0xiL687grjrOtqkV3omhrrOwWl
         63Pw==
X-Gm-Message-State: AFq9FYII04FVTUlcnxwjwP2eThJOlj+AGkGt1tnwYgtXkBGk1x7+gwgR
	pz8XmRRTqoTtXxb2WI4JHl0q1k7y1Sdo44V0WgA46PUBAJwUq5ena7HVEFiqCdiB
X-Gm-Gg: AYBFou1R3eJ+TcuE5Fa1GtvKhpUEI4dSnKCYCiUKtXPi7HBTyVDyPyKkFyJr3fHuXIJ
	X5+YCaiQ3kvMLNXRPBRvEgrHG9wEI2mna6iCw1Qxd/HEhiprfopRPOTmoafkSyTnAcJaAz4N/zO
	biWlNSy9c1W+5xI/TgIDptkCl0+wmkbU5rx9UtIvtHwycH8pJWR/zmQwnDAQ8I8Czg759RT7Fed
	owrIxAMxpaQvrROpwVYC/3nJZ24VjEkut0cNI9QoRAS1VggC1Z27tYs7sB986074z+dmAJstzGO
	xr9/dFJ897HjOOaWQs8HJ3KA458EQPD7iZYiTICrNoyyyvS5Vit0HlKk8/UitwLZqKqhlMsIcxJ
	fcRhyI7FEIMOIA01836FxdlunZNApbuN3IDQYGxqipjvD1kQFNgfVw1TZMsXPZTA+04//LA8HoK
	+/+uTvd2/4ffIoXlNo1/iZ84+cvHThU2ESLB/YmviuPyvt7Voin9m+Ix5ctNEGPefoDCfVFNWdQ
	+N+8eDDKNEQuIVaFmqNOPsAofyVdF06r7cdqAUmD7ASsClzbrs=
X-Received: by 2002:a05:7300:598c:b0:343:4a95:f120 with SMTP id 5a478bee46e88-34cdc8bdef4mr567282eec.25.1790745527671;
        Tue, 29 Sep 2026 22:18:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:101a:5ce6:a15e:d8ca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf4a63ac9sm898281eec.10.2026.09.29.22.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 22:18:47 -0700 (PDT)
Date: Tue, 29 Sep 2026 22:18:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: s6sy761 - fix error handling in power management paths
Message-ID: <arya1u_Rqtt85lyc@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In s6sy761_power_on(), if any of the I2C operations or status checks
fail after enabling the regulators, the function returns an error while
leaving the regulators enabled. Conversely, in s6sy761_resume(), if
powering on the controller fails, enable_irq() is skipped while the PM
core still marks the device as resumed. A subsequent system suspend or
driver unbind then invokes s6sy761_power_off() again, attempting to
disable already disabled regulators and incrementing the IRQ disable
depth a second time, which leaves the interrupt permanently disabled on
later resumes. Additionally, if restoring sensing in s6sy761_resume()
fails, the controller is left powered on.

Track whether the controller is powered up with a powered_up flag,
unwind regulator enablement on error in s6sy761_power_on(), move
disable_irq() to s6sy761_suspend() so it is only called during system
sleep when the controller is powered up, and power off the controller
if restoring sensing fails during resume.

Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/s6sy761.c | 59 +++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
index 899c179fb2d3..a770628d2b94 100644
--- a/drivers/input/touchscreen/s6sy761.c
+++ b/drivers/input/touchscreen/s6sy761.c
@@ -108,6 +108,8 @@ struct s6sy761_data {
 
 	u16 devid;
 	u8 tx_channel;
+
+	bool powered_up;
 };
 
 /*
@@ -307,32 +309,41 @@ static int s6sy761_power_on(struct s6sy761_data *sdata)
 					    S6SY761_EVENT_SIZE,
 					    buffer);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulators;
 
 	event = (buffer[0] >> 2) & 0xf;
 
 	if ((event != S6SY761_EVENT_INFO &&
 	     event != S6SY761_EVENT_VENDOR_INFO) ||
 	    buffer[1] != S6SY761_INFO_BOOT_COMPLETE) {
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_disable_regulators;
 	}
 
 	ret = i2c_smbus_read_byte_data(sdata->client, S6SY761_BOOT_STATUS);
 	if (ret < 0)
-		return ret;
+		goto err_disable_regulators;
 
 	/* for some reasons the device might be stuck in the bootloader */
-	if (ret != S6SY761_BS_APPLICATION)
-		return -ENODEV;
+	if (ret != S6SY761_BS_APPLICATION) {
+		ret = -ENODEV;
+		goto err_disable_regulators;
+	}
 
 	/* enable touch functionality */
 	ret = i2c_smbus_write_word_data(sdata->client,
 					S6SY761_TOUCH_FUNCTION,
 					S6SY761_MASK_TOUCH);
 	if (ret)
-		return ret;
+		goto err_disable_regulators;
 
+	sdata->powered_up = true;
 	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(sdata->regulators),
+			       sdata->regulators);
+	return ret;
 }
 
 static int s6sy761_hw_init(struct s6sy761_data *sdata,
@@ -381,9 +392,11 @@ static void s6sy761_power_off(void *data)
 {
 	struct s6sy761_data *sdata = data;
 
-	disable_irq(sdata->client->irq);
-	regulator_bulk_disable(ARRAY_SIZE(sdata->regulators),
-						sdata->regulators);
+	if (!sdata->powered_up)
+		return;
+
+	regulator_bulk_disable(ARRAY_SIZE(sdata->regulators), sdata->regulators);
+	sdata->powered_up = false;
 }
 
 static int s6sy761_probe(struct i2c_client *client)
@@ -492,11 +505,24 @@ static int s6sy761_suspend(struct device *dev)
 {
 	struct s6sy761_data *sdata = dev_get_drvdata(dev);
 
-	s6sy761_power_off(sdata);
+	if (sdata->powered_up) {
+		disable_irq(sdata->client->irq);
+		s6sy761_power_off(sdata);
+	}
 
 	return 0;
 }
 
+static int s6sy761_restore_sense(struct s6sy761_data *sdata)
+{
+	guard(mutex)(&sdata->input->mutex);
+
+	if (!input_device_enabled(sdata->input))
+		return 0;
+
+	return i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
+}
+
 static int s6sy761_resume(struct device *dev)
 {
 	struct s6sy761_data *sdata = dev_get_drvdata(dev);
@@ -506,15 +532,16 @@ static int s6sy761_resume(struct device *dev)
 	if (err)
 		return err;
 
-	enable_irq(sdata->client->irq);
-
-	guard(mutex)(&sdata->input->mutex);
+	err = s6sy761_restore_sense(sdata);
+	if (err)
+		goto err_power_off;
 
-	if (!input_device_enabled(sdata->input))
-		return 0;
+	enable_irq(sdata->client->irq);
 
-	err = i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
+	return 0;
 
+err_power_off:
+	s6sy761_power_off(sdata);
 	return err;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


-- 
Dmitry
