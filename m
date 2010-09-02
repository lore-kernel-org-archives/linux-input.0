From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: RE: [RFC] Input: wm97xx-core - Remove save state from
 wm97xx_read_aux_adc()
Date: Thu, 2 Sep 2010 11:32:29 -0400
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3254AA09E84@dekaexchange07.deka.local>
References: <1283352730-15509-1-git-send-email-emillbrandt@dekaresearch.com>
 <20100901171925.GA22444@rakim.wolfsonmicro.main>
 <0A40042D85E7C84DB443060EC44B3FD3254AA09E7F@dekaexchange07.deka.local>
 <20100901184650.GH22444@rakim.wolfsonmicro.main>
 <0A40042D85E7C84DB443060EC44B3FD3254AA09E80@dekaexchange07.deka.local>
 <20100902144035.GB5809@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.dekaresearch.com ([208.65.175.196]:25987 "EHLO
	dekaexchange07.deka.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751675Ab0IBP31 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 11:29:27 -0400
In-Reply-To: <20100902144035.GB5809@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, 2 Sep 2010 at 10:40:35 Mark Brown wrote:
> On Wed, Sep 01, 2010 at 03:17:27PM -0400, Eric Millbrandt wrote:
>
>> The problem there is the return value of poll_sample currently is not
>> being checked, so wm97xx_read_aux_adc() is returning invalid data.
>> That could be fixed to either keep polling until RC_VALID or a timeout
>> is hit is returned or return an error to the calling function and
>> letting it decide what to do.  I don't like the second option because
>> it creates a pathologic failure:
>
> I think (without having thought through it all so I may have missed
> something) that the best thing for the pathalogical case is to have a
> limited number of goes at restoring things and then just stop the
> digitiser - that will leave things restored while still providing a
> guaranteed exit case which should be recoverable (since
> everything will be halted).  Does that seem sensible to you?
>

It does.  So I will modify wm97xx_read_aux_adc() to do the following:

-Call poll_sample()
-If the return value is not RC_VALID call poll_sample() again
-If after 5 tries (I'm not sure how many samples can be queued) we have
not succeeded, stop the digitizer and return -1.
-Otherwise return auxadc.

If this sounds reasonable I will create a patch for review.


-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
