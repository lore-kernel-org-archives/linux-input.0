From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Thu, 11 Mar 2010 06:36:26 +0100
Message-ID: <45cc95261003102136h3f034c58nedffac6f7a27018b@mail.gmail.com>
References: <4B75E14A.2050602@seas.upenn.edu> <4B760D60.6020907@seas.upenn.edu>
	<alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz> <4B96B740.7020208@euromail.se>
	<4B96BAF1.5070209@seas.upenn.edu> <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz>
	<5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr> <4B96CAD4.4010407@euromail.se>
	<45cc95261003091442t70d08311u13642aac7bc4f3f3@mail.gmail.com>
	<20100311043034.GA30166@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:57870 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0CKFgs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Mar 2010 00:36:48 -0500
Received: by bwz1 with SMTP id 1so5667576bwz.21
        for <linux-input@vger.kernel.org>; Wed, 10 Mar 2010 21:36:46 -0800 (PST)
In-Reply-To: <20100311043034.GA30166@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Thu, Mar 11, 2010 at 5:30 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> On Tue, Mar 09, 2010 at 11:42:34PM +0100, Mohamed Ikbel Boulabiar wro=
te:
>> > A hierarchy is imposing an unnecessary restriction on the graph of=
 possible
>> > relations between point devices. Consider for instance the case of=
 two people,
>> > each with one finger on the panel. The hierarchy says panel-person=
1-finger1 and
>> > panel-person2-finger1. Now have them move close enough for the fin=
gers to touch.
>> > The hierarchy now says panel-person-(finger1, finger2). Symmetry b=
reaking once more.
>> >
>> > The main point here is that however the data reaches userland, it =
will have to
>> > be processed intelligibly and collectively. The point of processin=
g could be an
>> > MT X Driver, it could be some other input section, but it is has t=
o be done
>> > somewhere.
>> >
>> > Henrik
>>
>>
>> The hierarchy applied on multitouch isn't the best example to prove
>> benefits of it.
>> Hierarchy is useful with some complex input devices that have many
>> axes, many buttons some accelerometers, but that are hierarchical fr=
om
>> the source (integrality/separability ?).
>> Then providing them as hierarchy can be useful.
>
> Are we talking about real input devices here or a hypothetical device=
?
> If the former, what are examples for such an input device?

What's the meaning of a hypothetical device ?
Please note that here I speak about former input as to be handled by th=
e kernel.
If there is more complex handling it can be treated outside and
virtual device files are created (to handle these hierarchical
concepts).
To eliminate misunderstanding, virtual device files represent what
St=E9phane first suggested as moving multitouch input (as reported from
the kernel) to 2 mouse-like input reporting files.


>> For multitouch devices, we don't need to make separation inside the
>> multitouch protocol itself even for "simpler" devices like "double
>> touch".
>>
>> The solution maybe to have other handlers to show virtual hierarchic=
al
>> devices in another virtual devices folder in addition to the old way=
=2E
>> The handler read from the usual device file and provide other source=
s.
>>
>> Kernel modules will be then simple providing necessary input. And
>> complex handling will be in an additional layer.
>> User then will chose from where read the input : the old way or the
>> dynamic with handler special ways.
>>
>>
>> It should not also be in X.
>> If things aren't in the kernel, they shouldn't so be in X by obligat=
ion.
>
> Don't forget that X' main functionality aside from displaying wobbly =
windows
> is to be an input multiplexer. If some additional management layer is
> needed, why should it be another layer on top of or below X instead o=
f a
> part of X itself?


Ok, I know you represent now all the input handling in X.
So I should have predicted such questions. :)

The X evidence that it works as input multiplexer can't stay until the
end of time.
The number of projects emerging and that only use the Linux kernel
without X aren't few.
Why I should have access to advanced multi-touch handling ONLY in X
meaning I should install also all the package ?
Meaning in another software that should take care "mainly" of graphics.

I will here cite some things about the past and what's is being done no=
w :
The graphics handling itself, wasn't done before in X ? And now isn't
everybody tried to pull it out of it and putting it in the Linux
kernel ? KMS: Kernel Mode Setting ? Isn't now better to have such
handling done in kernel and have early access to graphics card without
having the screen flashing many times disturbing users ? Isn't the
switching to VT now better ?

It's true that when X was first designed, its main functionalities
were handling input&graphics in 'all' unix systems (which by case
still remembers me Multics cause of failure...).
Now the world changed and we should think about what system would be
at least in the next 5 years.

Many projects tried to replace X, from Framebuffer to Wayland without
forgetting all other dead projects.
Why ? ;-)

Please don't see this as an attack to X.org, but otherwise a different
point of view.

When I've proposed, I have said that it can't be in X "by obligation".
I have thoughts that is may be an additional layer, until many people
decide to include it in the kernel if things become working great.
This can help much embedded application that use FB or a display
server but needs multi-touch and advanced input handling.
Specially when comparing the number of people developing X, to those
developing the Kernel.
In other non-Linux systems, multi-touch is handled by a completely new
input server.




Anyway, forget all what I have said.
How do you want to deal with multitouch and new input handling in X and=
 why ?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
