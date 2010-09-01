From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: RE: [RFC] Input: wm97xx-core - Remove save state from
 wm97xx_read_aux_adc()
Date: Wed, 1 Sep 2010 14:46:59 -0400
Message-ID: <0A40042D85E7C84DB443060EC44B3FD3254AA09E7F@dekaexchange07.deka.local>
References: <1283352730-15509-1-git-send-email-emillbrandt@dekaresearch.com>
 <20100901171925.GA22444@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.dekaresearch.com ([208.65.175.196]:4172 "EHLO
	dekaexchange07.deka.local" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751204Ab0IASn5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 1 Sep 2010 14:43:57 -0400
In-Reply-To: <20100901171925.GA22444@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, 1 Sep 2010 at 13:19:25 Mark Brown wrote:
> On Wed, Sep 01, 2010 at 10:52:10AM -0400, Eric Millbrandt wrote:
>
>> Saving the state of the digitizers seems unnecessary since the next
>> sample will rewrite those registers.  It also causes an unnecessary
>> sample to occur if the previous state was a sample.  This will cause
>> the wrong sample to be returned on the next call to
> wm97xx_read_aux_adc().
>
> You need to explain how this interacts with both polling and continuous
> touchscreen modes - saying that it seems unneeded feels a little fuzzy.
> Note that this will also clear the current digitiser configuration before
> it starts the AUXADC so it's not a simple save of the values.

Hi Mark,

You are right; the current digitizer settings do need to be cleared.  I was testing in the polling touchscreen mode and overlooked that fact.  But do we want to restore the POLL bit if it happened to be set?  Continuous mode does not need it and it looks like wm9712_poll_*() will set the POLL bit again when it needs a touchscreen measurement.

Eric

-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-

This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
