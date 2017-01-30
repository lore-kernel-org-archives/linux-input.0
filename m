From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] HID: cp2112: fix gpio-callback error handling
Date: Mon, 30 Jan 2017 11:26:39 +0100
Message-ID: <20170130102639.3832-2-johan@kernel.org>
References: <20170130102235.3691-1-johan@kernel.org>
 <20170130102639.3832-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170130102639.3832-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-input@vger.kernel.org

In case of a zero-length report, the gpio direction_input callback would
currently return success instead of an errno.

Fixes: 1ffb3c40ffb5 ("HID: cp2112: make transfer buffers DMA capable")
Cc: stable <stable@vger.kernel.org>     # 4.9
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/hid/hid-cp2112.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 3e0b6bad29f2..b22d0f83f8e3 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -213,7 +213,7 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 exit:
 	mutex_unlock(&dev->lock);
-	return ret <= 0 ? ret : -EIO;
+	return ret < 0 ? ret : -EIO;
 }
 
 static void cp2112_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
-- 
2.10.2
