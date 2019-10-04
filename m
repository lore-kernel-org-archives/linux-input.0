From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v7 6/8] Input: icn8505 - Switch to firmware_request_platform for retreiving the fw
Date: Fri,  4 Oct 2019 16:50:54 +0200
Message-ID: <20191004145056.43267-7-hdegoede@redhat.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org, platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Unfortunately sofar we have been unable to get permission to redistribute
icn8505 touchscreen firmwares in linux-firmware. This means that people
need to find and install the firmware themselves before the touchscreen
will work

Some UEFI/x86 tablets with an icn8505 touchscreen have a copy of the fw
embedded in their UEFI boot-services code.

This commit makes the icn8505 driver use the new firmware_request_platform
function, which will fallback to looking for such an embedded copy when
direct filesystem lookup fails. This will make the touchscreen work OOTB
on devices where there is a fw copy embedded in the UEFI code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/chipone_icn8505.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/chipone_icn8505.c b/drivers/input/touchscreen/chipone_icn8505.c
index c768186ce856..f9ca5502ac8c 100644
--- a/drivers/input/touchscreen/chipone_icn8505.c
+++ b/drivers/input/touchscreen/chipone_icn8505.c
@@ -288,7 +288,7 @@ static int icn8505_upload_fw(struct icn8505_data *icn8505)
 	 * we may need it at resume. Having loaded it once will make the
 	 * firmware class code cache it at suspend/resume.
 	 */
-	error = request_firmware(&fw, icn8505->firmware_name, dev);
+	error = firmware_request_platform(&fw, icn8505->firmware_name, dev);
 	if (error) {
 		dev_err(dev, "Firmware request error %d\n", error);
 		return error;
-- 
2.23.0
