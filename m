From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR
	system?
Date: Tue, 8 Dec 2009 08:34:26 -0500
Message-ID: <9e4733910912080534m1fe8c5bakb9219c6a55f0bcaa@mail.gmail.com>
References: <20091204220708.GD25669@core.coreip.homeip.net>
	 <20091206065512.GA14651@core.coreip.homeip.net>
	 <4B1B99A5.2080903@redhat.com> <m3638k6lju.fsf@intrepid.localdomain>
	 <9e4733910912060952h4aad49dake8e8486acb6566bc@mail.gmail.com>
	 <m3skbn6dv1.fsf@intrepid.localdomain>
	 <9e4733910912061323x22c618ccyf6edcee5b021cbe3@mail.gmail.com>
	 <4B1D934E.7030103@redhat.com>
	 <9e4733910912071628x3f3eba82r4c964982f9d8c5a4@mail.gmail.com>
	 <4B1E35D6.6000602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:46828 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818AbZLHNeW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Dec 2009 08:34:22 -0500
In-Reply-To: <4B1E35D6.6000602@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, hermann pitton <hermann-pitton@arcor.de>, Christoph Bartelmus <lirc@bartelmus.de>, awalls@radix.net, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, superm1@ubuntu.com

On Tue, Dec 8, 2009 at 6:17 AM, Mauro Carvalho Chehab
<mchehab@redhat.com> wrote:
> Jon Smirl wrote:
>> On Mon, Dec 7, 2009 at 6:44 PM, Mauro Carvalho Chehab
>> <mchehab@redhat.com> wrote:
>
>>>> Where is the documentation for the protocol?
>>> I'm not sure what you're meaning here. I've started a doc about IR =
at the media
>>
>> What is the format of the pulse stream data coming out of the lirc d=
evice?
>
> AFAIK, it is at:
> =A0 =A0 =A0 =A0http://www.lirc.org/html/index.html
>
> It would be nice to to add it to DocBook after integrating the API in=
 kernel.
>

The point of those design review questions was to illustrate that the
existing LIRC system is only partially designed. Subsystems need to be
fully designed before they get merged.

=46or example 36-40K and 56K IR signals are both in use. It is a simple
matter to design a receiver (or buy two receivers)  that would support
both these frequencies. But the current LIRC model only supports  a
single IR receiver. Adjusting it to support two receivers is going to
break the ABI.

My choice would be to just tell the person with the 56K remote to just
buy a new 38K remote, but other people are against that choice. That
forces us into designing a system that can handle multiple receivers.
There is a parallel problem with baseband encoded IR signals.

We need to think about all of these use cases before designing the
ABI.  Only after we think we have a good ABI design should code start
being merged. Of course we may make mistakes and have to fix the ABI,
but there is nothing to be gained by merging the existing ABI if we
already know it has problems.

--=20
Jon Smirl
jonsmirl@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
