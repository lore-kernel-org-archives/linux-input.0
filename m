From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was: Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: 25 Nov 2009 18:20:00 +0100
Message-ID: <BDZb9P9ZjFB@christoph>
References: <m3fx827dgi.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:55436 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340AbZKYRXN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2009 12:23:13 -0500
In-Reply-To: <m3fx827dgi.fsf@intrepid.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: khc@pm.waw.pl
Cc: awalls@radix.net, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com

Hi,

on 25 Nov 09 at 17:53, Krzysztof Halasa wrote:
> Jarod Wilson <jarod@wilsonet.com> writes:
[...]
>> nimble. If we can come up with a shiny new way that raw IR can be
>> passed out through an input device, I'm pretty sure lirc userspace can
>> be adapted to handle that.

As Trent already pointed out, adding support for raw IR through an input  
device would require a new interface too. You just put the label "input  
device" on it. This does not make much sense for me.

> Lirc can already handle input layer. Since both ways require userspace
> changes,

I'm not sure what two ways you are talking about. With the patches posted  
by Jarod, nothing has to be changed in userspace.
Everything works, no code needs to be written and tested, everybody is  
happy.

We had exactly the same discussion around one year ago. I've seen no new  
arguements in the current discussion and nobody came up with this shiny  
new way of integrating LIRC into the input layer since last year. Maybe  
it's about time to just accept that the LIRC interface is the way to go.

Can we finally get the patch integrated, please?

Christoph
