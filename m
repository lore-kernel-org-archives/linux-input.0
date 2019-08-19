From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH] HID: wacom: correct misreported EKR ring values
Date: Mon, 19 Aug 2019 10:20:30 -0700
Message-ID: <1566235230-11617-1-git-send-email-aaron.skomra@wacom.com>
References: <20190817181109.33F1B2173B@mail.kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190817181109.33F1B2173B@mail.kernel.org>
Sender: stable-owner@vger.kernel.org
To: sashal@kernel.org, linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com, ping.cheng@wacom.com, jason.gerecke@wacom.com
Cc: Aaron Armstrong Skomra <aaron.skomra@wacom.com>, "# v4 . 3+" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

The EKR ring claims a range of 0 to 71 but actually reports
values 1 to 72. The ring is used in relative mode so this
change should not affect users.

Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>
Fixes: 72b236d60218f ("HID: wacom: Add support for Express Key Remote.")
Cc: <stable@vger.kernel.org> # v4.3+
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
My first attempt at sending this 
patch specifically targeted to v4.9.189

neglected the "in-reply-to" in git send-email. My apologies.

 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6c3bf8846b52..949761dd29ca 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -819,7 +819,7 @@ static int wacom_remote_irq(struct wacom_wac *wacom_wac, size_t len)
 	input_report_key(input, BTN_BASE2, (data[11] & 0x02));
 
 	if (data[12] & 0x80)
-		input_report_abs(input, ABS_WHEEL, (data[12] & 0x7f));
+		input_report_abs(input, ABS_WHEEL, (data[12] & 0x7f) - 1);
 	else
 		input_report_abs(input, ABS_WHEEL, 0);
 
-- 
2.17.1
