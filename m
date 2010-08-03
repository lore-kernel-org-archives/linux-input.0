From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH] [resend] Input: i8042 - introduce noaux dmi quirk for
 MSI AE2220
Date: Tue, 3 Aug 2010 15:07:51 +0200
Message-ID: <20100803150751.380199ef@destiny.ordissimo>
References: <20100721181625.286f147c@destiny.ordissimo>
	<20100723161011.GB21546@core.coreip.homeip.net>
	<20100723182619.00e5a176@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:44384 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817Ab0HCNIQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Aug 2010 09:08:16 -0400
Received: by wwf26 with SMTP id 26so862287wwf.1
        for <linux-input@vger.kernel.org>; Tue, 03 Aug 2010 06:08:14 -0700 (PDT)
In-Reply-To: <20100723182619.00e5a176@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Fri, 23 Jul 2010 18:26:19 +0200, Anisse Astier <anisse@astier.eu> wrote :

> On Fri, 23 Jul 2010 09:10:11 -0700, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote :
> 
> > Hi Anisse,
> > 
> > On Wed, Jul 21, 2010 at 06:16:25PM +0200, Anisse Astier wrote:
> > > 
> > > This computer does no have an external PS2 port, and booting without
> > > i8042.noaux induces a 10 second boot delay, until the AUX port detection
> > > timeouts.
> > > 
> > > Signed-off-by: Anisse Astier <anisse@astier.eu>
> > 
> > Sorry for loosing track of this, however, before we add a new type of
> > blacklist (which Linus did not like in the similar scenario with
> > MacBook) could you please send me your DSDT?
> > 
> > Thanks!
> > 
> 
> Sure, please find it in attachment.
> 
> Anisse

Did you learn anything from the DSDT ?

Regards,

Anisse
