From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [PATCH v2] Input: wm97xx-core - add retries to wm97xx_read_aux_adc
Date: Thu, 2 Sep 2010 16:16:37 -0400
Message-ID: <1283458597-27348-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.dekaresearch.com ([208.65.175.196]:37079 "EHLO
	dekaexchange07.deka.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756888Ab0IBUXP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 16:23:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, Eric Millbrandt <emillbrandt@dekaresearch.com>

Add logic to wm97xx_read_aux_adc() to retry reading the adc if the
sample failed.  This could occur if the previous sample was still in
the return register or the sample timed-out.  Also avoid a pathologic
failure mode by disabling the digitizer and returning -EBUSY after 5
retries.

Signed-off-by: Eric Millbrandt <emillbrandt@dekaresearch.com>
---

changes since v1
- fix minor style issue, checkpatch.pl now reports no warnings

 drivers/input/touchscreen/wm97xx-core.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index cbfef1e..2419507 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -125,6 +125,8 @@ int wm97xx_read_aux_adc(struct wm97xx *wm, u16 adcsel)
 {
        int power_adc = 0, auxval;
        u16 power = 0;
+       int rc = 0;
+       int timeout = 0;

        /* get codec */
        mutex_lock(&wm->codec_mutex);
@@ -143,7 +145,9 @@ int wm97xx_read_aux_adc(struct wm97xx *wm, u16 adcsel)

        /* Turn polling mode on to read AUX ADC */
        wm->pen_probably_down = 1;
-       wm->codec->poll_sample(wm, adcsel, &auxval);
+
+       while (rc != RC_VALID && timeout++ < 5)
+               rc = wm->codec->poll_sample(wm, adcsel, &auxval);

        if (power_adc)
                wm97xx_reg_write(wm, AC97_EXTENDED_MID, power | 0x8000);
@@ -152,8 +156,11 @@ int wm97xx_read_aux_adc(struct wm97xx *wm, u16 adcsel)

        wm->pen_probably_down = 0;

+       if (timeout >= 5)
+               wm->codec->dig_enable(wm, false);
+
        mutex_unlock(&wm->codec_mutex);
-       return auxval & 0xfff;
+       return (rc == RC_VALID ? auxval & 0xfff : -EBUSY);
 }
 EXPORT_SYMBOL_GPL(wm97xx_read_aux_adc);

--
1.6.3.1

-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
