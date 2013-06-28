From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Add OLPC AP-SP input driver
Date: Fri, 28 Jun 2013 13:32:43 -0700
Message-ID: <20130628203242.GA22495@core.coreip.homeip.net>
References: <20130628171958.CC031FAAD5@dev.laptop.org>
 <20130628182000.GA21589@core.coreip.homeip.net>
 <CAMLZHHSVghT1t1v4RWzYVQ3hv4oLDvvkfVZMnQ5aARDZot13fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:40790 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab3F1Ucs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 16:32:48 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp16so2698245pbb.14
        for <linux-input@vger.kernel.org>; Fri, 28 Jun 2013 13:32:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMLZHHSVghT1t1v4RWzYVQ3hv4oLDvvkfVZMnQ5aARDZot13fA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, paul fox <pgf@laptop.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Fri, Jun 28, 2013 at 01:15:35PM -0600, Daniel Drake wrote:
> On Fri, Jun 28, 2013 at 12:20 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >> +static void olpc_apsp_close(struct serio *port)
> >> +{
> >> +     struct olpc_apsp *priv = port->port_data;
> >> +     unsigned int tmp;
> >> +
> >> +     if (--priv->open_count == 0) {
> >
> > Both need locking. It looks like you need the song and dance similar to
> > what i8042 has to do with it's multiplexed ports. Or ps2mult.c...
> 
> I thought they would both be locked already, due to this comment in serio.c:
> 
> /* called from serio_driver->connect/disconnect methods under serio_mutex */
> 
> Or am I missing something there?

Hmm, you are right... I'll add a comment there to remind myself.

-- 
Dmitry
