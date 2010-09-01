From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: [RFC] Input: wm97xx-core - Remove save state from wm97xx_read_aux_adc()
Date: Wed, 1 Sep 2010 10:52:10 -0400
Message-ID: <1283352730-15509-1-git-send-email-emillbrandt@dekaresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.dekaresearch.com ([208.65.175.196]:23644 "EHLO
	dekaexchange07.deka.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755437Ab0IAPDl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Sep 2010 11:03:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, Eric Millbrandt <emillbrandt@dekaresearch.com>

Saving the state of the digitizers seems unnecessary since the next
sample will rewrite those registers.  It also causes an unnecessary
sample to occur if the previous state was a sample.  This will cause
the wrong sample to be returned on the next call to wm97xx_read_aux_adc().
---
 drivers/input/touchscreen/wm97xx-core.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index cbfef1e..b4bcb2c 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -138,9 +138,6 @@ int wm97xx_read_aux_adc(struct wm97xx *wm, u16 adcsel)
                wm97xx_reg_write(wm, AC97_EXTENDED_MID, power & 0x7fff);
        }

-       /* Prepare the codec for AUX reading */
-       wm->codec->aux_prepare(wm);
-
        /* Turn polling mode on to read AUX ADC */
        wm->pen_probably_down = 1;
        wm->codec->poll_sample(wm, adcsel, &auxval);
@@ -148,8 +145,6 @@ int wm97xx_read_aux_adc(struct wm97xx *wm, u16 adcsel)
        if (power_adc)
                wm97xx_reg_write(wm, AC97_EXTENDED_MID, power | 0x8000);

-       wm->codec->dig_restore(wm);
-
        wm->pen_probably_down = 0;

        mutex_unlock(&wm->codec_mutex);
--
1.6.3.1

-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
