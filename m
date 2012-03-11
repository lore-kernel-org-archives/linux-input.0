From: Oskari Saarenmaa <os@ohmu.fi>
Subject: Re: [PATCH 2/2] Input: sentelic: Absolute mode and multitouch support
 for Cx+ hardware.
Date: Sun, 11 Mar 2012 20:03:04 +0200
Message-ID: <4F5CE8D8.7010408@ohmu.fi>
References: <20120124232254.GB4905@timantti.taisia.fi> <20120128205629.GA23595@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from timantti.taisia.fi ([213.157.67.233]:35275 "EHLO mail.taisia.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808Ab2CKSfh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Mar 2012 14:35:37 -0400
In-Reply-To: <20120128205629.GA23595@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Tai-hwa Liang <avatar@sentelic.com>

Thanks for the review and sorry for the late reply, I was away all 
February without access to the laptop.

28.01.2012 22:56, Dmitry Torokhov kirjoitti:
>> +	case FSP_PKT_TYPE_NOTIFY:
>> +		/* Notify packets are sent with Cx and newer
>> +		 * touchpads if register 0x90 bit 1 is set.
>> +		 */

> Do we need to support the non-absolute mode if we can support absolute
> mode for the device? Users expect to have true multi-touch support
> nowadays, I think we should keep the driver as simple as possible and
> support only absolute mode for MT devices.

This part can be removed as support for it is not enabled anyway in this 
driver, I just left it there as it was the first thing I was able to 
figure out when I started experimenting with the driver & hardware 
before receiving updated documentation for it.  If someone wants to work 
on it it's now properly documented in Documentation/input/sentelic.txt

>> +		if ((packet[0]&  (BIT(4)|BIT(5))) == 0&&  l_btn) {
>> +			/* on pad click, let other components handle this.
>> +			 * NOTE: do not filter out on-pad clicks when
>> +			 * we're in multitouch mode, BIT(5), they are real
>> +			 * clickpad-clicks, not just single finger taps.
>> +			 */
>> +			l_btn = 0;
>
> Hmm, so this is a clickpad device? We need to set clickpad property
> then.

Ok.

>> +		}
>> +
>> +		if (packet[0]&  BIT(5)) {
>> +			/* multitouch mode: two fingers down */
>> +			fingers++;
>> +			if ((packet[0]&  BIT(4)) == 0&&  l_btn&&  r_btn) {
>> +				/* middle-click in multitouch mode */
>> +				l_btn = 0;
>> +				r_btn = 0;
>> +				m_btn = 1;
>> +			}
>
> The middle button emulation should be handled in userspace. Let
> synaptics X driver deal with it.

Does the synaptics driver actually handle this?  This is implemented 
according to the documentation, which says "If bit 1 and 0 are all 1 and 
bit 4 is 0, the middle external button is pressed." but since my 
hardware does not have a "middle external button" I haven't actually 
tested this part.

>> +			if (packet[0]&  BIT(2)) {
>> +				/* right finger down, ignore the event */
>
> Needs better comment.

Ok.

I'll post an updated patch that addresses the above comments.

/ Oskari
