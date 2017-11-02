From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?=
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH 3/3] HID: cp2112: fix broken gpio_direction_input callback
Date: Thu,  2 Nov 2017 12:12:44 +0100
Message-ID: <1509621164-28830-3-git-send-email-sebastien.szymanski@armadeus.com>
References: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509621164-28830-1-git-send-email-sebastien.szymanski@armadeus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Julien Boibessot <julien.boibessot@armadeus.com>, =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
List-Id: linux-input@vger.kernel.org

When everything goes smoothly, ret is set to 0 which makes the function
to return EIO error.

Fixes: 8e9faa15469e ("HID: cp2112: fix gpio-callback error handling")
Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 drivers/hid/hid-cp2112.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 28e3c18..f7754a6 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -205,12 +205,13 @@ static int cp2112_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 	ret = hid_hw_raw_request(hdev, CP2112_GPIO_CONFIG, buf,
 				 CP2112_GPIO_CONFIG_LENGTH, HID_FEATURE_REPORT,
 				 HID_REQ_SET_REPORT);
-	if (ret < 0) {
+	if (ret != CP2112_GPIO_CONFIG_LENGTH) {
 		hid_err(hdev, "error setting GPIO config: %d\n", ret);
 		goto exit;
 	}
 
-	ret = 0;
+	mutex_unlock(&dev->lock);
+	return 0;
 
 exit:
 	mutex_unlock(&dev->lock);
-- 
2.7.3
