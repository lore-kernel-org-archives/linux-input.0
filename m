From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] Input: ads7846 - correct the value get from SPI
Date: Tue, 21 Jul 2015 14:52:48 +0300
Message-ID: <55AE3290.60103@compulab.co.il>
References: <1432278136-32457-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090202020006040801040400"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:39838 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169AbbGUNDA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 09:03:00 -0400
In-Reply-To: <1432278136-32457-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Haibo Chen <haibo.chen@freescale.com>, dmitry.torokhov@gmail.com
Cc: jg1.han@samsung.com, pramod.gurav@smartplayin.com, linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------090202020006040801040400
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

Hi,

On 05/22/15 10:02, Haibo Chen wrote:
> According to the touch controller SPEC, SPI return a 16 bit value,
> only 12 bits are valid, they are bit[14-3].
> 
> The value of MISO and MOSI can be configed when SPI in idle mode.
> Currently this touch driver consider the SPI bus set the MOSI and
> MISO in low level when SPI bus in idle mode. So the bit[15] of the
> value get from SPI bus is always 0. But when SPI bus congfig the
> MOSI and MISO in high level when SPI in idle mode, the bit[15] of
> the value get from SPI is always 1, if not mask this bit[15], we may
> get the wrong value.
> 
> This patch mask the invalid bit, and make sure to return the correct
> value nomatter how SPI bus configed.
> 
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
> ---
>  drivers/input/touchscreen/ads7846.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index e4eb8a6..91b335f 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -678,7 +678,7 @@ static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
>  		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
>  		 * padding; built from two 8 bit values written msb-first.
>  		 */
> -		return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
> +		return (be16_to_cpup((__be16 *)t->rx_buf) & 0x7ff8) >> 3;

IIRC, 7845 is the same in regard to SPI bus, so may be we should
also adjust the value in if statement, not just the else part.

We have the attached patch locally, so may you would like to consider
it or a mixture of both...


-- 
Regards,
Igor.

--------------090202020006040801040400
Content-Type: text/x-patch;
 name="0001-input-ads7846-enforce-ADC-output-width.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-input-ads7846-enforce-ADC-output-width.patch"

>From fda22bb445c3866a89ef1ec876516d60f0292f7f Mon Sep 17 00:00:00 2001
From: Andrey Gelman <andrey.gelman@compulab.co.il>
Date: Sun, 26 Oct 2014 17:25:43 +0200
Subject: [PATCH] input: ads7846: enforce ADC output width

Enforce ADC output is 12 bits width.
For no clear reason, on i.MX6-based CM-FX6, we have experienced a
13-th bit set to 1 and therefore all reported values were out of
range.

Signed-off-by: Andrey Gelman <andrey.gelman@compulab.co.il>
[grinberg@compulab.co.il: white space, comment and commit message
adjusted]
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 drivers/input/touchscreen/ads7846.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 5196861..655ae85 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -689,18 +689,22 @@ static int ads7846_no_filter(void *ads, int data_idx, int *val)
 
 static int ads7846_get_value(struct ads7846 *ts, struct spi_message *m)
 {
+	int value;
 	struct spi_transfer *t =
 		list_entry(m->transfers.prev, struct spi_transfer, transfer_list);
 
 	if (ts->model == 7845) {
-		return be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
+		value = be16_to_cpup((__be16 *)&(((char*)t->rx_buf)[1])) >> 3;
 	} else {
 		/*
 		 * adjust:  on-wire is a must-ignore bit, a BE12 value, then
 		 * padding; built from two 8 bit values written msb-first.
 		 */
-		return be16_to_cpup((__be16 *)t->rx_buf) >> 3;
+		value = be16_to_cpup((__be16 *)t->rx_buf) >> 3;
 	}
+
+	/* enforce ADC output is 12 bits width */
+	return value & 0xfff;
 }
 
 static void ads7846_update_value(struct spi_message *m, int val)
-- 
2.3.6


--------------090202020006040801040400--
