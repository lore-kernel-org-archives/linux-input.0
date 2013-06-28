From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v3] Add OLPC AP-SP input driver
Date: Fri, 28 Jun 2013 13:15:35 -0600
Message-ID: <CAMLZHHSVghT1t1v4RWzYVQ3hv4oLDvvkfVZMnQ5aARDZot13fA@mail.gmail.com>
References: <20130628171958.CC031FAAD5@dev.laptop.org>
	<20130628182000.GA21589@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:64405 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab3F1TPg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jun 2013 15:15:36 -0400
Received: by mail-qa0-f54.google.com with SMTP id n20so820785qaj.13
        for <linux-input@vger.kernel.org>; Fri, 28 Jun 2013 12:15:36 -0700 (PDT)
In-Reply-To: <20130628182000.GA21589@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, paul fox <pgf@laptop.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On Fri, Jun 28, 2013 at 12:20 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>> +static void olpc_apsp_close(struct serio *port)
>> +{
>> +     struct olpc_apsp *priv = port->port_data;
>> +     unsigned int tmp;
>> +
>> +     if (--priv->open_count == 0) {
>
> Both need locking. It looks like you need the song and dance similar to
> what i8042 has to do with it's multiplexed ports. Or ps2mult.c...

I thought they would both be locked already, due to this comment in serio.c:

/* called from serio_driver->connect/disconnect methods under serio_mutex */

Or am I missing something there?

Thanks
Daniel
