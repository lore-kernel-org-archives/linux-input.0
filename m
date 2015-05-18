From: Evgeniy Dushistov <dushistov@mail.ru>
Subject: [PATCH] [RFC] ads7846: force driver to work with ads7845
Date: Mon, 18 May 2015 15:55:00 +0300
Message-ID: <20150518125500.GA22524@fifteen>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>, Dmitry Torokhov <dtor@mail.ru>
Cc: Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

CC me please, I'm not subscribed to any linux-kernel list.

Hi,
recently I have ads7845 device connected to my beagleboard,
and I try to use ads7846 to work with it.
But it fails, it show completely wrong x/y.

But, after I disabled almost all code that related to ads7845 ("== 7845"),
except determination of amount of pressure force,
all start works as expected,
I found such commit:

>commit 3eac5c7e44f35eb07f0ecb28ce60f15b2dda1932
>Author: Anatolij Gustschin <agust@denx.de>
>...
>ADS7845 is a controller for 5-wire touch screens and somewhat
>different from 7846. It requires three serial communications to
>accomplish one complete conversion.
>...

But according to datasheets:
http://www.ti.com/lit/ds/symlink/ads7846.pdf
http://www.ti.com/lit/ds/symlink/ads7845.pdf

ads7845(page 8) and ads7846 (page 12) have
identical digital interfaces, I attach quotes
from them in text from to this email.

So why spi negotiation for ads7845 require special code,
except
>Z1-/Z2- position measurement

Was this commit tested? May be you test
in some special mode, like 15 vs 16 bits?

Here is working for me patch (it against 3.16,
but applied to Linus's git master also).

ads7846: fix to force ads7846 driver works with ads7845
 device

Signed-off-by: Evgneiy A. Dushistov <dushistov@mail.ru>
---
 drivers/input/touchscreen/ads7846.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index da201b8..27f4796 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -17,6 +17,9 @@
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
+#define VERBOSE_DEBUG
+#define DEBUG
+
 #include <linux/types.h>
 #include <linux/hwmon.h>
 #include <linux/err.h>
@@ -671,14 +674,14 @@ static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
 	struct spi_transfer *t =
 		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
 
-	if (ts->model == 7845) {
+	if (0/*ts->model == 7845*/) {
 		return be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
 	} else {
 		/*
 		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
 		 * padding; built from two 8 bit values written msb-first.
 		 */
-		return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
+		return (be16_to_cpup((__be16 *)t->rx_buf) & 0x7fff) >> 3;
 	}
 }
 
@@ -755,14 +758,12 @@ static void ads7846_report_state(struct ads7846 *ts)
 	 * from on-the-wire format as part of debouncing to get stable
 	 * readings.
 	 */
+	x = packet->tc.x;
+	y = packet->tc.y;
 	if (ts->model == 7845) {
-		x = *(u16 *)packet->tc.x_buf;
-		y = *(u16 *)packet->tc.y_buf;
 		z1 = 0;
 		z2 = 0;
 	} else {
-		x = packet->tc.x;
-		y = packet->tc.y;
 		z1 = packet->tc.z1;
 		z2 = packet->tc.z2;
 	}
@@ -995,7 +996,7 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
+	if (0/*ts->model == 7845*/) {
 		packet->read_y_cmd[0] = READ_Y(vref);
 		packet->read_y_cmd[1] = 0;
 		packet->read_y_cmd[2] = 0;
@@ -1040,7 +1041,7 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
+	if (0/*ts->model == 7845*/) {
 		x++;
 		packet->read_x_cmd[0] = READ_X(vref);
 		packet->read_x_cmd[1] = 0;
@@ -1149,7 +1150,7 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 	spi_message_init(m);
 	m->context = ts;
 
-	if (ts->model == 7845) {
+	if (0/*ts->model == 7845*/) {
 		x++;
 		packet->pwrdown_cmd[0] = PWRDOWN;
 		packet->pwrdown_cmd[1] = 0;
@@ -1408,7 +1409,7 @@ static int ads7846_probe(struct spi_device *spi)
 	 * Take a first sample, leaving nPENIRQ active and vREF off; avoid
 	 * the touchscreen, in case it's not connected.
 	 */
-	if (ts->model == 7845)
+	if (0/*ts->model == 7845*/)
 		ads7845_read12_ser(&spi->dev, PWRDOWN);
 	else
 		(void) ads7846_read12_ser(&spi->dev, READ_12BIT_SER(vaux));
-- 
2.3.6

-- 
/Evgeniy

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="1_1.txt"
Content-Transfer-Encoding: 8bit

ads7845(page 8):

Figure 5 shows the typical operation of the ADS7845’s digital
interface. This diagram assumes that the source of the digital signals
is a microcontroller or digital signal processor with a basic serial
interface. Each communication between the processor and the converter
consists of 8 clock cycles. 

One complete conversion can be accomplished
with three serial communications, for a total of 24 clock cycles on the
DCLK input.  

The first 8 clock cycles are used to provide the control byte
via the DIN pin. When the converter has enough information about
the following conversion to set the input multiplexer, switches, and
reference inputs appropriately, 

the converter enters the acquisition (sample) mode and, 
if needed, the internal switches are turned on. After three more 
clock cycles, the control byte is complete and the converter
enters the conversion mode. 
At this point, the input sample/hold goes into the 
hold mode and the internal switches may turn off. 
The next 12 clock cycles accomplish the actual analog-to-digital conversion. If the
conversion is ratiometric (SER/DFR LOW), the internal switches are on
during the conversion. A 13th clock cycle is needed for the last bit of
the conversion result. Three more clock cycles are needed to complete
the last byte (DOUT will be LOW). These will be ignored by the converter.

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2_1.txt"

ads7846(page 12):

Figure 9 shows the typical operation of the ADS7846 digital
interface. This diagram assumes that the source of the digital signals
is a microcontroller or digital signal processor with a basic serial
interface. Each communication between the processor and the converter,
such as SPI/SSI or MicrowireTM synchronous serial interface, consists
of eight clock cycles. 

One complete conversion can be accomplished
with three serial communications for a total of 24 clock cycles on the
DCLK input.

The first eight clock cycles are used to provide the control byte
via the DIN pin. When the converter has enough information about the
following conversion to set the input multiplexer and reference inputs
appropriately, 

the converter enters the acquisition (sample) mode and,
if needed, the touch panel drivers are turned on. After three more
clock cycles, the control byte is complete and the converter
enters the conversion mode. 
At this point, the input sample-and-hold goes into the
hold mode and the touch panel drivers turn off (in single-ended mode). 
The next 12 clock cycles accomplish the actual analog-to-digital conver-
sion. If the conversion is ratiometric (SER/DFR = 0), the drivers are on
during the conversion and a 13th clock cycle is needed for the last bit
of the conversion result. Three more clock cycles are needed to complete
the last byte (DOUT will be low), which are ignored by the converter.

--dDRMvlgZJXvWKvBx--
