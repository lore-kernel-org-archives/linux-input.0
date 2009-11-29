From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR 	system?
Date: 29 Nov 2009 12:07:00 +0100
Message-ID: <BDodZBYXqgB@lirc>
References: <m3einiy389.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754377AbZK2MH0@vger.kernel.org>
In-Reply-To: <m3einiy389.fsf@intrepid.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: khc@pm.waw.pl
Cc: awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, jonsmirl@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, maximlevitsky@gmail.com, mchehab@redhat.com, stefanr@s5r6.in-berlin.de, superm1@ubuntu.com
List-Id: linux-input@vger.kernel.org

Hi Krzysztof,

on 28 Nov 09 at 18:21, Krzysztof Halasa wrote:
[...]
>> This remote uses RC-5. But some of the developers must have thought that
>> it may be a smart idea to use 14 bits instead the standard 13 bits for
>> this remote. In LIRC you won't care, because this is configurable and
>> irrecord will figure it out automatically for you. In the proposed kernel
>> decoders I have seen until now, you will have to treat this case specially
>> in the decoder because you expect 13 bits for RC-5, not 14.

> Well, the 14-bit RC5 is de-facto standard for some time now. One of the
> start bits, inverted, now functions as the MSB of the command code.
> 13-bit receiver implementations (at least these aimed at "foreign"
> remotes) are obsolete.

Ah, sorry. I didn't mean the extension of the command code by inverting  
one of the start bits.

The Streamzap really uses one more bit.
In the LIRC world the RC5 start bit which is fixed to "1" is not counted  
as individual bit. So translated to your notation, the Streamzap uses 15  
bits, not 14 like the extended RC-5 or 13 like the original RC-5...

Christoph
