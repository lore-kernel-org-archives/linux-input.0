Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9641A680F
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780119658; cv=none; b=OhsgPFqKSyNnm6CLeQT6WFF2nlaOZ4ecIijssZF+/bQQUdxN4RB+BPLSNflMeYORlyIbvF+oWGRAyk8gD/92I4O6jUYGCHBMq2J05X68uQthnOH6Cd+Wa79ynZ5BDSdOOlpbQo5DNsxydsdFQEnCMPdH39Z0et9ViGLqXBZGLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780119658; c=relaxed/simple;
	bh=PpUoBid5aq59q45iKmTD4IwHC+evK9Uyzay1vXekoKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aX2uRL9N4S8dlffj+COZhuardIiPIqQpE5piEjatB0VploQA6jFaRA6zXHG2X6tME44znKceH2X/Nn0lRx82ujp6pvmRD5oalx9XpYWMCOiol9dul7kUJ08p0eu/rRVG4NUgh9SeLN/6rWVV9ar5jMqnx7eh2wO1Xr2lSwsq+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yld85XzQ; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yld85XzQ"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304b8ced372so5600659eec.0
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 22:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780119657; x=1780724457; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XOZEgRCT5xBH4jATksg2PfnmFltwzZ3oN1tTfeEAMhM=;
        b=Yld85XzQS4OYQkKOnjk6STeitfFYMKeGr4Y7L6tLfkasZ/TDjK1psfjPP/WoOvx9K2
         2QcQkKAy2BSxP6bU1npxpJBcz7m3/nUDlLUZ5wxQC/rAz9YCY26z+PSClR2QBXTsHzfo
         mkqtyJdq0EorWSSPMsUM5Qzzsaa2fzRta59ytZAjV0dozZ/8JdleIuks7+MS2k8Vmg9P
         CfSmbdhJx1yRXfm+6qNOPZcpwZcAv0cIObI9NbgGu9wGPfabpdkcTuFUahK2zxlucNJ8
         oaQ3h8uZDFBKF3wEDSWUjLl0MaSyjBjw8lvvsUbQSGV+3jVYLVXjAlVQHDcaoe+ZgiGG
         XPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780119657; x=1780724457;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOZEgRCT5xBH4jATksg2PfnmFltwzZ3oN1tTfeEAMhM=;
        b=mqJwOh1SfrLa9LeOzCLrO2LbBo0dX2y5I1z46/P0I9OMsw2CM1AiXJWas47f7bb3bj
         RCKJvW2+hX3NhqHX4NdLl/N0UJLWb5t7IIOgssSaQvc3yONiEEfwb1yEBc7zqH06EWP0
         7F3GM0kHljDHgsEglSh0TFsd/VPT8xMsSgDiaiFYQBmCgb6ni/bLM712XKYg2Xkzw52m
         15T7jR7/oBoUK+YAxyu5U53p/sYV6ygWUMyED6vpEvmcOcwXrxSJgAF5rOfAU/P/9mQG
         9RZ04RPq+Gd+XKE043ECz7zP/M+xCobKZzIcD2T210ngzzd+sJqnAs3UZ00VaaVl8zBi
         b7+Q==
X-Gm-Message-State: AOJu0Yx9TBFhkp77DEFbJQBfu8DKYY1YGDdzmgzGZLd84ZBgHYI7rvxD
	idMFkmgGZsl+DpDm2p9npEtRgM7JX/EBl5KenowSbWkM9i1xX+yWXDR8XmBV9g==
X-Gm-Gg: Acq92OHZsCQK93QuY6Z4Vf1tfOXellonS+Y5W+nJG8vbSO/TbuF1y2KUVg+0mVIkNbk
	tdzsC/PTcTf9472AMbnu4DpK+Nhpig703apDmW0lafjH4c6YElmvv64S8XdhdxCQnWO97yP7ro3
	7L+vl3PUbdaeZzlVbp4N38dBexjnhsi+CGCcCuqcaoETbck8sZupPtCgeQFHaAO/Ce9W5ggmmKY
	4K2nYC1PM6JtzUYiMBZiprbauOGcJzDDc3XYEmvaI16mY/aAvZW5N4Aay/ovYT2IzZFOMqHNWym
	PEMerRt2E9thMluoxa2glVuhGTuK2Y1bCWfGi60x7apEdgqZnzlVCaIBS4Btzlzkpa0c2qSL3CF
	bmIEbbfzXamH9ns6L/APEv4+8WYqzZDAoP23+EAuIWJYxT5lAjoO9RdIi2W8fnLvEbGLCIyxTF5
	Fyv2bN0BVFMT7dOzvk5554P59auwpTejYG5WGWZLVJxbHBZ/7w6nCiY6zpQsbzKguPZgKPy8hrT
	qdKt7JAydGcOQ==
X-Received: by 2002:a05:7300:214c:b0:2de:aafb:feff with SMTP id 5a478bee46e88-304fa4a93bamr1369797eec.2.1780119656653;
        Fri, 29 May 2026 22:40:56 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:307d:2a52:8823:4a01])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2bdda4sm3009912eec.2.2026.05.29.22.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 22:40:55 -0700 (PDT)
Date: Fri, 29 May 2026 22:40:52 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ims-pcu - only expose sysfs attributes on control
 interface
Message-ID: <ahp23lj4_vXIeUBl@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When the driver was converted to use the driver core to instantiate device
attributes (via .dev_groups in the usb_driver structure), the attributes
started appearing on all interfaces bound to the driver. Since the ims-pcu
driver manually claims the secondary data interface during probe, the
driver core automatically creates the sysfs attributes for that interface
as well.

However, the driver only supports these attributes on the primary control
interface. Data interfaces lack the necessary descriptors and internal
state to handle these requests, and accessing them can lead to unexpected
behavior or crashes.

Fix this by updating the is_visible() callbacks for both the main and OFN
attribute groups to verify that the interface being accessed is indeed the
control interface.

Fixes: 204d18a7a0c6 ("Input: ims-pcu - use driver core to instantiate device attributes")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 13367ec66936..ddfb88b7c8f5 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1283,6 +1283,9 @@ static umode_t ims_pcu_is_attr_visible(struct kobject *kobj,
 	struct ims_pcu *pcu = usb_get_intfdata(intf);
 	umode_t mode = attr->mode;
 
+	if (intf != pcu->ctrl_intf)
+		return 0;
+
 	if (pcu->bootloader_mode) {
 		if (attr != &dev_attr_update_firmware_status.attr &&
 		    attr != &dev_attr_update_firmware.attr &&
@@ -1534,6 +1537,9 @@ static umode_t ims_pcu_ofn_is_attr_visible(struct kobject *kobj,
 	struct ims_pcu *pcu = usb_get_intfdata(intf);
 	umode_t mode = attr->mode;
 
+	if (intf != pcu->ctrl_intf)
+		return 0;
+
 	/*
 	 * PCU-B devices, both GEN_1 and GEN_2 do not have OFN sensor.
 	 */
-- 
2.54.0.823.g6e5bcc1fc9-goog


-- 
Dmitry
