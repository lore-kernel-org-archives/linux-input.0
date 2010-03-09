From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Wed, 10 Mar 2010 00:08:51 +0100
Message-ID: <4B96D503.50707@euromail.se>
References: <4B75E14A.2050602@seas.upenn.edu> <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu> 	<4B760D60.6020907@seas.upenn.edu> <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz> 	<4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu> 	<alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz> <5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr> 	<4B96CAD4.4010407@euromail.se> <45cc95261003091442t70d08311u13642aac7bc4f3f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:40958 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755180Ab0CIXJj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 18:09:39 -0500
In-Reply-To: <45cc95261003091442t70d08311u13642aac7bc4f3f3@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

Mohamed Ikbel Boulabiar wrote:

> The hierarchy applied on multitouch isn't the best example to prove
> benefits of it.
> Hierarchy is useful with some complex input devices that have many
> axes, many buttons some accelerometers, but that are hierarchical from
> the source (integrality/separability ?).
> Then providing them as hierarchy can be useful.

I believe I see your's and Stephane's point. But while you argue about how to
get the devices to userspace in a clean fashion, I argue about how to process
arbitrary collection of devices in a clean fashion, once they get there.

> The solution maybe to have other handlers to show virtual hierarchical
> devices in another virtual devices folder in addition to the old way.
> The handler read from the usual device file and provide other sources.
> 
> Kernel modules will be then simple providing necessary input. And
> complex handling will be in an additional layer.
> User then will chose from where read the input : the old way or the
> dynamic with handler special ways.

I still have a feeling that the most workable, generic structure to impose on
input devices in general, is the empty set.

> It should not also be in X.
> If things aren't in the kernel, they shouldn't so be in X by obligation.

I completely agree -- the recent movement around xorg input, hal and udev
clearly shows how badly input needs its own layer.

Henrik

