From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 2/3] thinkpad_acpi: Support micmute LED
Date: Thu, 22 Aug 2013 16:02:11 +0200
Message-ID: <1377180132-4933-2-git-send-email-Jason@zx2c4.com>
References: <1377180132-4933-1-git-send-email-Jason@zx2c4.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377180132-4933-1-git-send-email-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mjg@redhat.com, rjw@sisk.pl, len.brown@intel.com, dtor@insightbb.com, "Jason A. Donenfeld" <Jason@zx2c4.com>
List-Id: linux-input@vger.kernel.org

The micmute LED is currently unused. This patch allows it to be hooked
up to various LED triggers.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 54d31c0..33b23cb 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -5050,8 +5050,10 @@ static const char * const tpacpi_led_names[TPACPI_LED_NUMLEDS] = {
 	"tpacpi::unknown_led2",
 	"tpacpi::unknown_led3",
 	"tpacpi::thinkvantage",
+	"tpacpi::unknown_led4",
+	"tpacpi::micmute"
 };
-#define TPACPI_SAFE_LEDS	0x1081U
+#define TPACPI_SAFE_LEDS	0x5081U
 
 static inline bool tpacpi_is_led_restricted(const unsigned int led)
 {
@@ -5274,7 +5276,7 @@ static const struct tpacpi_quirk led_useful_qtable[] __initconst = {
 	{ /* Lenovo */
 	  .vendor = PCI_VENDOR_ID_LENOVO,
 	  .bios = TPACPI_MATCH_ANY, .ec = TPACPI_MATCH_ANY,
-	  .quirks = 0x1fffU,
+	  .quirks = 0x5fffU,
 	},
 	{ /* IBM ThinkPads with no EC version string */
 	  .vendor = PCI_VENDOR_ID_IBM,
-- 
1.8.3.2
