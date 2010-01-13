From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH] TiVo USB IR Dongle support
Date: Wed, 13 Jan 2010 09:25:09 -0500
Message-ID: <4B4DD7C5.3020704@redhat.com>
References: <20091206214543.GA5290@acer.drzhang.net> <20091212190143.GA3591@acer.drzhang.net> <20091212233259.GB16760@core.coreip.homeip.net> <20091214220059.GA16776@drzhang.net> <20091214222843.GE2373@core.coreip.homeip.net> <20091216005357.GA23449@drzhang.net> <20100113075308.GB3242@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6028 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891Ab0AMOZO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2010 09:25:14 -0500
In-Reply-To: <20100113075308.GB3242@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chaogui Zhang <czhang@marywood.edu>, linux-input@vger.kernel.org

On 1/13/10 2:53 AM, Dmitry Torokhov wrote:
> Hi Chaogui,
> 
> I was looking at the driver again and I have some concerns with the
> foolowing fragment:
> 
> On Tue, Dec 15, 2009 at 07:53:57PM -0500, Chaogui Zhang wrote:
>> +
>> +	/* The lower 5 bits of the first byte of each packet indicates the size
>> +	 * of the transferred buffer, not including the first byte itself.
>> +	 */
>> +
>> +	length = (remote->in_buffer[0]) & 0x1f;
>> +	for (i = 0; i <= length; i++)
>> +		snprintf(codes + i * 3, 4, "%02x ", remote->in_buffer[i]);
>> +
>> +	/* 0x80 at the end of a regular packet or in a separate packet
>> +	   indicates key release */
>> +
>> +	if (i < TIVOIR_RECV_SIZE && remote->in_buffer[i] == 0x80)
>> +		snprintf(codes + i * 3, 4, "%02x ", remote->in_buffer[i]);
>> +
> 
> So does this mean that 0x80 indicating release is not included in the
> size of the received packet.

This receiver is essentially identical to all the windows media center
transceivers out there (and can in fact be driven as such by simply
adding its device id to the lirc_mceusb driver). They all signal the
start of an incoming packet with an 0x8y header byte, where y is the
number of bytes contained in the packet following the header (but
excluding the header). So the empty packet 0x80 is used to signal the
end of a transmitted IR command.


-- 
Jarod Wilson
jarod@redhat.com
