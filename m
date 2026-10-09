Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA23955C9;
	Fri,  9 Oct 2026 04:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518589; cv=none; b=JibzgYhcIOYQLNnPgZkVYo+/z0EXDpiGLftzTNvd9yW1E4jn1qYLV7/BieVVKUUJLZFuUIgwVYpr4rFuj2DWEy7nDZyOwY9DO6hlkqyptiS0FStGI5atyJkh/v3vi72FRRIh7G6//1zXXV7ivreU7NicI68zl+x8UVY4TffCk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518589; c=relaxed/simple;
	bh=bt+j5oOUx9wDTb+5qlSVDSKdo/Ckz750QTVjjbM7enY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ov5NaXHG741+LNremlxq6F/AEljMRZ5Q6RLQzaqHKipVz3CHQN31iwWxdPv39Yab49uce39+G9zDyk/8R3eEkoT7waErBDSoRvEqpZZt2ym68dmGdIwD6wrs11t6B5GQL1DjxO05ZaX25onMWs3Q/hk2sErbvxRATFCJHTuj7Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAD3_jxzZ8hqQFwbCg--.2398S2;
	Fri, 09 Oct 2026 12:03:00 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Ville Syrjala <syrjala@sci.fi>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ati_remote2 - fix type confusion in device attribute handlers
Date: Fri,  9 Oct 2026 12:03:02 +0800
Message-Id: <20261009040302.3087205-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3_jxzZ8hqQFwbCg--.2398S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1xGr4rGw13tw15GF15urg_yoW5AFy7pF
	4DGayUKr4UJFn7WanFyr48Za4S9w18Ca4FkF1Iyw4S9rn7Ga4fXFy0yry3A3yrCrWFkr15
	J3Z8Kw1UWayrGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr
	1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUgeHgUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQPA2rIJHz+tgAAs2

The channel_mask and mode_mask attributes are instantiated by the driver
core through struct usb_driver::dev_groups, so they are attached to the
usb_interface bound to the driver, not to the usb_device.  The four
show/store handlers still call to_usb_device(dev), which applies the
struct usb_device container_of() to a struct usb_interface::dev and thus
produces a bogus usb_device pointer.  usb_ifnum_to_if() reads that
pointer as udev->actconfig and dereferences it, and its result is passed
to usb_get_intfdata() without any NULL check, so reading or writing the
world-readable attributes can crash the kernel.

Use to_usb_interface(dev) so the handlers recover the interface that the
attributes belong to, matching the other drivers converted to dev_groups.

Fixes: b20d6bf8014b ("Input: ati-remote2 - use driver core to instantiate device attributes")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/input/misc/ati_remote2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 8db2dca84975..3e0f874e9b16 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -672,8 +672,7 @@ static ssize_t ati_remote2_show_channel_mask(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	struct usb_device *udev = to_usb_device(dev);
-	struct usb_interface *intf = usb_ifnum_to_if(udev, 0);
+	struct usb_interface *intf = to_usb_interface(dev);
 	struct ati_remote2 *ar2 = usb_get_intfdata(intf);
 
 	return sprintf(buf, "0x%04x\n", ar2->channel_mask);
@@ -683,8 +682,7 @@ static ssize_t ati_remote2_store_channel_mask(struct device *dev,
 					      struct device_attribute *attr,
 					      const char *buf, size_t count)
 {
-	struct usb_device *udev = to_usb_device(dev);
-	struct usb_interface *intf = usb_ifnum_to_if(udev, 0);
+	struct usb_interface *intf = to_usb_interface(dev);
 	struct ati_remote2 *ar2 = usb_get_intfdata(intf);
 	unsigned int mask;
 	int r;
@@ -720,8 +718,7 @@ static ssize_t ati_remote2_show_mode_mask(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
 {
-	struct usb_device *udev = to_usb_device(dev);
-	struct usb_interface *intf = usb_ifnum_to_if(udev, 0);
+	struct usb_interface *intf = to_usb_interface(dev);
 	struct ati_remote2 *ar2 = usb_get_intfdata(intf);
 
 	return sprintf(buf, "0x%02x\n", ar2->mode_mask);
@@ -731,8 +728,7 @@ static ssize_t ati_remote2_store_mode_mask(struct device *dev,
 					   struct device_attribute *attr,
 					   const char *buf, size_t count)
 {
-	struct usb_device *udev = to_usb_device(dev);
-	struct usb_interface *intf = usb_ifnum_to_if(udev, 0);
+	struct usb_interface *intf = to_usb_interface(dev);
 	struct ati_remote2 *ar2 = usb_get_intfdata(intf);
 	unsigned int mask;
 	int err;
-- 
2.25.1

