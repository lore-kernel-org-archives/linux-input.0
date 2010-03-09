From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 9 Mar 2010 23:42:34 +0100
Message-ID: <45cc95261003091442t70d08311u13642aac7bc4f3f3@mail.gmail.com>
References: <4B75E14A.2050602@seas.upenn.edu> <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>
	<4B760D60.6020907@seas.upenn.edu> <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>
	<4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu>
	<alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz> <5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr>
	<4B96CAD4.4010407@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:51229 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab0CIWm4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 17:42:56 -0500
Received: by bwz1 with SMTP id 1so4431916bwz.21
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 14:42:54 -0800 (PST)
In-Reply-To: <4B96CAD4.4010407@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Mar 9, 2010 at 11:25 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> One would be separation of concerns. If I'm interested in single touch
>> events, I'd be better off with no "multitouch noise". If I'm interested
>> in low level events, I'd be better off without the interference created
>> by all sorts of "clever" event emulation in drivers. An easy way to do
>> this is to have a different input node for each protocol.
>
> Keeping backward compatibility with single-touch userland does not really
> clutter the driver -- adding single-touch events to a clean multi-touch driver
> is just a handful of lines.
>
> [snip]
>
>> On another note, having multiple input nodes is a relevant question when
>> dealing with multitouch anyway. Let me take an example: consider two
>> users, each interacting with their own application in its own window but
>> on the same display. Now, consider these two input possibilities: either
>> each has their own mouse, or they both use the same dual-touch panel. In
>> the first case, each app can open its own input node; in the second,
>> they need to share the same device and perform some filtering to extract
>> the events they want (user1 or user2). The symmetry breaking between the
>> two situations is not satisfactory: you need to change the code in the
>> apps.
>
> Symmetry is also restored by passing all single-input devices as MT packets.
>
>> With this regard, I am a big fan of the idea of having hierarchical
>> devices, just like with have hierarchical file systems. Each finger on
>> the dual-touch panel would be a device, child of the panel device. Each
>> would be equivalent to a mouse, and voila, the symmetry is restored.
>> Conceptually, saying (panel/finger1, any event) or (panel, finger1
>> events) are equivalent; but in the first case the routing is done by the
>> OS and in the second case it has to be done by the app, which breaks
>> reusability. There are other interesting perspectives, but I don't want
>> to get carried away too much.
>
> A hierarchy is imposing an unnecessary restriction on the graph of possible
> relations between point devices. Consider for instance the case of two people,
> each with one finger on the panel. The hierarchy says panel-person1-finger1 and
> panel-person2-finger1. Now have them move close enough for the fingers to touch.
> The hierarchy now says panel-person-(finger1, finger2). Symmetry breaking once more.
>
> The main point here is that however the data reaches userland, it will have to
> be processed intelligibly and collectively. The point of processing could be an
> MT X Driver, it could be some other input section, but it is has to be done
> somewhere.
>
> Henrik


The hierarchy applied on multitouch isn't the best example to prove
benefits of it.
Hierarchy is useful with some complex input devices that have many
axes, many buttons some accelerometers, but that are hierarchical from
the source (integrality/separability ?).
Then providing them as hierarchy can be useful.


For multitouch devices, we don't need to make separation inside the
multitouch protocol itself even for "simpler" devices like "double
touch".

The solution maybe to have other handlers to show virtual hierarchical
devices in another virtual devices folder in addition to the old way.
The handler read from the usual device file and provide other sources.

Kernel modules will be then simple providing necessary input. And
complex handling will be in an additional layer.
User then will chose from where read the input : the old way or the
dynamic with handler special ways.


It should not also be in X.
If things aren't in the kernel, they shouldn't so be in X by obligation.

ik.
