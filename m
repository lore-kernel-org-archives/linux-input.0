From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] add REL_* axes support to the rotary encoder driver
Date: Wed, 15 Apr 2009 22:24:58 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909015F8DFD@mi8nycmail19.Mi8.com>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <20090307170632.GA31096@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE1909015F87BC@mi8nycmail19.Mi8.com> <20090416020836.GB2413@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6ob114.obsmtp.com ([64.18.1.32]:44506 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751029AbZDPCZW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2009 22:25:22 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090416020836.GB2413@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

On Wednesday, April 15, 2009 7:09 PM, Dmitry Torokhov wrote:
>
> Hi,
>
> On Monday 13 April 2009 16:06:24 H Hartley Sweeten wrote:
>> +
>> +	unsigned int	axis;
>> +	unsigned int	pos;
>> +
>> +	unsigned int	irq_a;
>> +	unsigned int	irq_b;
>> +
>> +	unsigned int	abs:1;
>> +	unsigned int	dir:1;
>> +	unsigned int	armed:1;
>
> Doing it this way makes us go from simple store to read/modify/write
> cycle in the interrupt handler.

Didn't think of that. Good catch.

>>
>> +#define ROTARY_ENCODER_REL	(0<<31)
>> +#define ROTARY_ENCODER_ABS	(1<<31)
>
> Meh... How about below instead?

Your changes look good to me.

The only issue I can see is that absolute axis encoders wrap.

If you have an encoder of something like ABS_VOLUME you would probably
want the "pos" to go from 0 to "steps" and then clamp. The encoder
could actually rotate multiple times depending on it's actual line
count, but the effect would be correct.

Regards,
Hartley
