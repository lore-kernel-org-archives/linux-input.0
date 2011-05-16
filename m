From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] input: Add Nintendo extension controller driver
Date: Mon, 16 May 2011 17:04:04 -0600
Message-ID: <BANLkTikfNZtP8DXH99RJE8H4pgZm4b9mjg@mail.gmail.com>
References: <20110516214608.17011.3075.stgit@ponder> <20110516215110.GE16731@trinity.fluff.org>
 <20110516224353.GA19481@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63338 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511Ab1EPXEY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 19:04:24 -0400
In-Reply-To: <20110516224353.GA19481@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ben Dooks <ben@trinity.fluff.org>, simon@mungewell.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, OliverNeukumoliver@neukum.org

On Mon, May 16, 2011 at 4:43 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, May 16, 2011 at 10:51:10PM +0100, Ben Dooks wrote:
>> On Mon, May 16, 2011 at 03:46:08PM -0600, Grant Likely wrote:
>> > +
>> > + =A0 /*
>> > + =A0 =A0* DMA buffer, with padding to give it its own cache line =
so that
>> > + =A0 =A0* the DMA streaming works on non-coherent architectures.
>> > + =A0 =A0* Question: Is this the proper pattern, and is this reall=
y necessary?
>> > + =A0 =A0*/
>> > + =A0 uint8_t pad1[L1_CACHE_BYTES];
>> > + =A0 uint8_t buf[6];
>> > + =A0 uint8_t pad2[L1_CACHE_BYTES];
>> > +};
>>
>> I think there's an attribute to do this, starting with an __ defined
>> in the kernel.
>>
>
> Yes, it is called "____cacheline_aligned".

=46ixed and tested, thanks.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
