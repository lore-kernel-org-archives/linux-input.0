From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR 	system?
Date: 28 Nov 2009 17:47:00 +0100
Message-ID: <BDkdITRHqgB@lirc>
References: <m3r5riy7py.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64823 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbZK1QsW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Nov 2009 11:48:22 -0500
In-Reply-To: <m3r5riy7py.fsf@intrepid.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: khc@pm.waw.pl
Cc: awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, jonsmirl@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, maximlevitsky@gmail.com, mchehab@redhat.com, stefanr@s5r6.in-berlin.de, superm1@ubuntu.com

Hi Krzysztof and Maxim,

on 28 Nov 09 at 16:44, Krzysztof Halasa wrote:
> Maxim Levitsky <maximlevitsky@gmail.com> writes:

>> Generic decoder that lirc has is actually much better and more tolerant
>> that protocol specific decoders that you propose,

> Actually, it is not the case. Why do you think it's better (let alone
> "much better")? Have you at least seen my RC5 decoder?

Nobody here doubts that you can implement a working RC-5 decoder. It's  
really easy. I'll give you an example why Maxim thinks that the generic  
LIRC approach has advantages:

Look at the Streamzap remote (I think Jarod submitted the lirc_streamzap  
driver in his patchset):
http://lirc.sourceforge.net/remotes/streamzap/PC_Remote

This remote uses RC-5. But some of the developers must have thought that  
it may be a smart idea to use 14 bits instead the standard 13 bits for  
this remote. In LIRC you won't care, because this is configurable and  
irrecord will figure it out automatically for you. In the proposed kernel  
decoders I have seen until now, you will have to treat this case specially  
in the decoder because you expect 13 bits for RC-5, not 14.
Well, it can be done. But you'll have to add another IR protocol define  
for RC-5_14, which will become very ugly with many non-standard protocol  
variations.

@Maxim: I think Mauro is right. We need to find an approach that makes  
everybody happy. We should take the time now to discuss all the  
possibilities and choose the best solution. LIRC has lived so long outside  
the kernel, that we can wait another couple of weeks/months until we  
agreed on something which will be a stable API hopefully for many years to  
come.

Christoph
