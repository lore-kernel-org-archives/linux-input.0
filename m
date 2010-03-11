From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Thu, 11 Mar 2010 14:30:34 +1000
Message-ID: <20100311043034.GA30166@barra.bne.redhat.com>
References: <4B75E14A.2050602@seas.upenn.edu>
 <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>
 <4B760D60.6020907@seas.upenn.edu>
 <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>
 <4B96B740.7020208@euromail.se>
 <4B96BAF1.5070209@seas.upenn.edu>
 <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz>
 <5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr>
 <4B96CAD4.4010407@euromail.se>
 <45cc95261003091442t70d08311u13642aac7bc4f3f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:47084 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab0CKEdm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Mar 2010 23:33:42 -0500
Content-Disposition: inline
In-Reply-To: <45cc95261003091442t70d08311u13642aac7bc4f3f3@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Mar 09, 2010 at 11:42:34PM +0100, Mohamed Ikbel Boulabiar wrote:
> > A hierarchy is imposing an unnecessary restriction on the graph of possible
> > relations between point devices. Consider for instance the case of two people,
> > each with one finger on the panel. The hierarchy says panel-person1-finger1 and
> > panel-person2-finger1. Now have them move close enough for the fingers to touch.
> > The hierarchy now says panel-person-(finger1, finger2). Symmetry breaking once more.
> >
> > The main point here is that however the data reaches userland, it will have to
> > be processed intelligibly and collectively. The point of processing could be an
> > MT X Driver, it could be some other input section, but it is has to be done
> > somewhere.
> >
> > Henrik
> 
> 
> The hierarchy applied on multitouch isn't the best example to prove
> benefits of it.
> Hierarchy is useful with some complex input devices that have many
> axes, many buttons some accelerometers, but that are hierarchical from
> the source (integrality/separability ?).
> Then providing them as hierarchy can be useful.

Are we talking about real input devices here or a hypothetical device?
If the former, what are examples for such an input device?

> For multitouch devices, we don't need to make separation inside the
> multitouch protocol itself even for "simpler" devices like "double
> touch".
> 
> The solution maybe to have other handlers to show virtual hierarchical
> devices in another virtual devices folder in addition to the old way.
> The handler read from the usual device file and provide other sources.
> 
> Kernel modules will be then simple providing necessary input. And
> complex handling will be in an additional layer.
> User then will chose from where read the input : the old way or the
> dynamic with handler special ways.
> 
> 
> It should not also be in X.
> If things aren't in the kernel, they shouldn't so be in X by obligation.

Don't forget that X' main functionality aside from displaying wobbly windows
is to be an input multiplexer. If some additional management layer is
needed, why should it be another layer on top of or below X instead of a
part of X itself?

Cheers,
  Peter

