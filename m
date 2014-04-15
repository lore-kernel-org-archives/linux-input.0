From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCHv3 05/15] ARM: at91: sam9m10g45ek: Add touchscreen support
 through at91_adc
Date: Tue, 15 Apr 2014 12:28:00 +0200
Message-ID: <1397557690-5650-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1397557690-5650-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397557690-5650-1-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-input@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

at91_adc now supports reading a touchscreen for ADCs without a TSMR register.
Enable touchscreen support through at91_adc. This allows to use both a
touchscreen and the remaining ADC channel at the same time.

Also, lower the clock for the ADC as it allows to have more stable reads and
this is the speed used by atmel_tsadcc.
It lowers the maximum throughput rate from 440000 samples per second to 12958
samples per second. It shouldn't be an issue as the CPU is not able to keep up
reading samples at that frequency.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 arch/arm/mach-at91/at91sam9g45.c        | 2 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 5e6f498db0a8..9d3d544ac19c 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -182,7 +182,7 @@ static struct clk vdec_clk = {
 static struct clk adc_op_clk = {
 	.name		= "adc_op_clk",
 	.type		= CLK_TYPE_PERIPHERAL,
-	.rate_hz	= 13200000,
+	.rate_hz	= 300000,
 };
 
 /* AES/TDES/SHA clock - Only for sam9m11/sam9g56 */
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index ef39078c8ce2..4d775b796ce4 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -315,6 +315,7 @@ static struct at91_adc_data ek_adc_data = {
 	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7),
 	.use_external_triggers = true,
 	.vref = 3300,
+	.touchscreen_type = ATMEL_ADC_TOUCHSCREEN_4WIRE,
 };
 
 /*
-- 
1.8.3.2
