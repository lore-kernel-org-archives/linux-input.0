From: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Tue, 11 May 2010 23:22:22 +0300
Message-ID: <AANLkTim20ALiZiIVGQZyAye-3kUL_i3aYyoOk-P4Z84k@mail.gmail.com>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
	 <20100511060547.GA9644@core.coreip.homeip.net>
	 <AANLkTikA9s6lpO2uDuIup8BwGOYYHQ9yQxS36PBSIttX@mail.gmail.com>
	 <20100511062110.GB9644@core.coreip.homeip.net>
	 <AANLkTiktu7N5IXknkkJ9D5L4z5plhuGvD45IVqJm9zG1@mail.gmail.com>
	 <20100511063309.GC9644@core.coreip.homeip.net>
	 <y2k84144f021005102342m18bce930g53599c9112565f78@mail.gmail.com>
	 <AANLkTinV79HZqS1cktHDsTsHDel-0Nti_Uk4i7mGaRiK@mail.gmail.com>
	 <1273608441.15067.1002.camel@calx>
	 <AANLkTimt-eRCt_HTq7OUwzG1dgRuzJHk1tlgOcq4ocL7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61638 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab0EKUWZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 May 2010 16:22:25 -0400
In-Reply-To: <AANLkTimt-eRCt_HTq7OUwzG1dgRuzJHk1tlgOcq4ocL7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Matt Mackall <mpm@selenic.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Oskar Schirmer <os@emlix.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>, Christoph Lameter <cl@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, David Rientjes <rientjes@google.com>

On Tue, May 11, 2010 at 11:10 PM, Mike Frysinger <vapier.adi@gmail.com> wrote:
>> Make your own slab cache with the alignment flag set, as Pekka already
>> mentioned.
>
> and like i said, that doesnt sound like a reasonable solution when
> every single SPI driver (over 100 atm) out there is affected

Why do you need to do it in every driver? Why not create a cache of
size cache_line_size()*2 or something in the SPI stack and add a
helper function spi_alloc_whatever_this_is_about() for the drivers to
use?
