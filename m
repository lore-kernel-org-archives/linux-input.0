Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF4630F7FF
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817340; cv=none; b=dGj8Ji/gBakkAwNbXdGTtdkXb6NBXc40nyr3uaCZDvhgy9BfKuh4cYUq0GQs2mIhlw3g7eD8M11gAmaZskvUhUDeDkSEsHeAiefaCecS8gDgcJmzkmXzNCKELKgU553cbp4QH3diWd/1ZX0vST9s5OVPbWBVBNcKyO8G3DzAKZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817340; c=relaxed/simple;
	bh=UqKY/MzcnFpIEo0VStzm2PWHkdbFOV+TJY/ZqslFeQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qa0C1ec5VxqcYIYIv/qZ4szYIuDYEkMbu5THfwe9P52A0TNZtLM1fwGpw2FWhmUzV3uq2WcqJsVI/mXprRxuYCBERRshxJaPfBUghPlQV7/HRuYBrdqCND3xf5FOPIyVoiuHkGK5bkDyv2+WTJ/YeCA1saQrAc2MMrgndUsxE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoFxmOA8; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoFxmOA8"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4858a186d5bso296327f8f.2
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2026 14:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788817337; x=1789422137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+tmRRf0zWlKgTs1hoSvPxKFPwPUfj4JYA5rqqyQA7Y=;
        b=EoFxmOA8IjlcjIDPBxDIe6muXdL4KdQu0RGmDpY5aOouKTW70Y/g6gaWzO15erzcae
         j6xW6VAxPP0l/fPRMYliZAIZZZyjgLWS7KYQgrdkk7LFfdrrnun/cvmDyHexkStByEG/
         Er55DGPbZflaXIh2SepyazU22lIS+0CeZH67ZrRXpPtcFrm0th8b0IrZ6nX/toDq6/XD
         FVnDVcay5qnbnzVYNl8YEcc97gIRVJe3GB3iFDTQQ1QU8DDFBP6tVI35uw7vxItFtWc2
         wExlqyHl/7+NAniOoPXaXLLS6xBHXKVV0EStO1L38A8ymYd7L4aK805DIvvhkYLCKcwT
         2JKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817337; x=1789422137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+tmRRf0zWlKgTs1hoSvPxKFPwPUfj4JYA5rqqyQA7Y=;
        b=qvBPNKDmvh9k7DtlXJ4ZbC/fMB2rVClEgHe/mnhVxJ+uWPU/WD38HwSA5j5kiZY478
         F2uTcWaS4gEVaoHWycDMGaSgT725hbnPgFeg+X1DxkZMALBlQKUAADnV/eFtaPGw+ry5
         NEBZS4nNyx2yxNZ4HzR2AbgckSDNd4bhp3XfVH+OOC5Es/2g+cqIze10m1zPSGSEUYw+
         FDvSSawST65V5/BXjJdEYzK1SfmzuzZRQKaVTpTzIZjTeMex1t2sFNuBIWeWqPI6foQN
         31Qw5iwu6rAzVrYlwUBec98btPN6AjJjN5Yqsse1XLsHrhF1RItkFSezW6rhomibMvI6
         w6Hw==
X-Forwarded-Encrypted: i=1; AKwUvBxbW+AcHbiFc+fjXdOLmT6j/7BNkdUWw9aN8hrYcDPQZWRNxLa46YWW3RoRr1pibpkkClC7aJjQFo/C5Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mmTaX+Z/oNSaREaVj7c3ztZdpxiT1cqB63pC+GWoUutm6mA966
	N9a3PXp9+eNz7FVYqp/8o+zjjH3jVQZMU+J2PoH/EgC4rmS+g0TQ4s5hZiWokaevlMDbYQ==
X-Gm-Gg: AYBFou3bN2bsSFnsR9A5Wb7rG5G/TjTtLb9oDa3jUAjc9k/HzjSJ9V05lT09Vm8drwy
	8bw1kqufuZmHuWoeu0lNbm0GhjUjuuKbpxA6X+8f0FjImjk8EiZcmnr4Px6//Wnu1Wf2WhwWB2r
	Ffb8buP8sKk3yAJgBJP8o5bkMs4gMGcyTDcxIW7Cre1AL0SQCD/cdGkWWGTnLIDDSddRU+tCCO4
	2DOHL1x/sUZQvqas7oMVIY4HiJQEvDZJB/Z3K7sjyx8Bzsn4raWNa6FjOtdN2wshyaLoLpAvIM/
	Fm10eB4VXctRjTqBSqmhY4CWaMlSpcxEOhAvbhog3uXKeKz+U3WWvmYgUbB1MrDqzioe8OR7VyK
	mqjOtofd4pZQH8DUOarnXSH6S7qe9QBtpO6ISrUpu9k8u4Y8AUkfaHvawuVmKyHvyZYT6C1Qtlo
	RpCLDM+46bDE/aemLl7ZTB7pIm6CJwvpQIo1WTCAcRVjrlJibMmfkdjgYbwDlx2P8fWBERyygN9
	pnt2QFfG72eJ+7cM6QbmCsbNsyYOFx9MSu053C/re1YBzsotH1IpJn6dvWRe78DbmoSBFQPlVht
	Q4yCcCAMeFNGeQ==
X-Received: by 2002:a05:6000:144e:b0:485:8ad5:dbbb with SMTP id ffacd0b85a97d-485907f1861mr16244420f8f.4.1788817336896;
        Mon, 07 Sep 2026 14:42:16 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885be01bsm30507425f8f.31.2026.09.07.14.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:42:15 -0700 (PDT)
From: Miguel Garcia <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] Input: aiptek - switch to using dev_groups for driver-specific attributes
Date: Mon,  7 Sep 2026 23:42:13 +0200
Message-ID: <20260907214213.1817320-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit f4e7a254299bcdfe7bced700a7d96690b1b9a6f2 upstream.

On 5.15.y, the attributes are removed manually from disconnect after
intfdata has been cleared and the input device unregistered. A concurrent
sysfs callback can therefore observe cleared driver data or use the input
device after unregistration. Letting the driver core manage the group
removes and drains it before the disconnect callback.

The driver core now has the ability to handle the creation and removal
of device-specific sysfs files, let's use it instead of registering and
unregistering attributes by hand.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20220903051119.1332808-3-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Miguel Garcia <miguelgarciaroman8@gmail.com>
---
 drivers/input/tablet/aiptek.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 1581f6ef09279..a2c999631b25e 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -1618,7 +1618,7 @@ static ssize_t show_firmwareCode(struct device *dev, struct device_attribute *at
 
 static DEVICE_ATTR(firmware_code, S_IRUGO, show_firmwareCode, NULL);
 
-static struct attribute *aiptek_attributes[] = {
+static struct attribute *aiptek_dev_attrs[] = {
 	&dev_attr_size.attr,
 	&dev_attr_pointer_mode.attr,
 	&dev_attr_coordinate_mode.attr,
@@ -1642,9 +1642,7 @@ static struct attribute *aiptek_attributes[] = {
 	NULL
 };
 
-static const struct attribute_group aiptek_attribute_group = {
-	.attrs	= aiptek_attributes,
-};
+ATTRIBUTE_GROUPS(aiptek_dev);
 
 /***********************************************************************
  * This routine is called when a tablet has been identified. It basically
@@ -1843,26 +1841,16 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	 */
 	usb_set_intfdata(intf, aiptek);
 
-	/* Set up the sysfs files
-	 */
-	err = sysfs_create_group(&intf->dev.kobj, &aiptek_attribute_group);
-	if (err) {
-		dev_warn(&intf->dev, "cannot create sysfs group err: %d\n",
-			 err);
-		goto fail3;
-        }
-
 	/* Register the tablet as an Input Device
 	 */
 	err = input_register_device(aiptek->inputdev);
 	if (err) {
 		dev_warn(&intf->dev,
 			 "input_register_device returned err: %d\n", err);
-		goto fail4;
+		goto fail3;
         }
 	return 0;
 
- fail4:	sysfs_remove_group(&intf->dev.kobj, &aiptek_attribute_group);
  fail3: usb_free_urb(aiptek->urb);
  fail2:	usb_free_coherent(usbdev, AIPTEK_PACKET_LENGTH, aiptek->data,
 			  aiptek->data_dma);
@@ -1887,7 +1875,6 @@ static void aiptek_disconnect(struct usb_interface *intf)
 		 */
 		usb_kill_urb(aiptek->urb);
 		input_unregister_device(aiptek->inputdev);
-		sysfs_remove_group(&intf->dev.kobj, &aiptek_attribute_group);
 		usb_free_urb(aiptek->urb);
 		usb_free_coherent(interface_to_usbdev(intf),
 				  AIPTEK_PACKET_LENGTH,
@@ -1901,6 +1888,7 @@ static struct usb_driver aiptek_driver = {
 	.probe = aiptek_probe,
 	.disconnect = aiptek_disconnect,
 	.id_table = aiptek_ids,
+	.dev_groups = aiptek_dev_groups,
 };
 
 module_usb_driver(aiptek_driver);
-- 
2.43.0

