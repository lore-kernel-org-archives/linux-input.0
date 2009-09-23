From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v3 1/2] Input: Add DaVinci DM365 Keypad support
Date: Wed, 23 Sep 2009 11:50:02 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDA2CC8D@dbde02.ent.ti.com>
References: <1253217996-11548-1-git-send-email-miguel.aguilar@ridgerun.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DD916A60@dbde02.ent.ti.com>
 <4AB39A00.8080405@ridgerun.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DD991DD8@dbde02.ent.ti.com>
 <4AB8D89D.6050409@ridgerun.com> <871vlyev8g.fsf@deeprootsystems.com>
 <20090923034627.GA1458@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47708 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740AbZIWGUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 02:20:17 -0400
In-Reply-To: <20090923034627.GA1458@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>

On Wed, Sep 23, 2009 at 09:16:27, Dmitry Torokhov wrote:
> On Tue, Sep 22, 2009 at 10:37:35AM -0700, Kevin Hilman wrote:
> > Miguel Aguilar <miguel.aguilar@ridgerun.com> writes:
> >
> > > Sekhar,
> > >
> > > If you and Sneha agree I will write driver in terms of davinci instead of dm365.
> > >
> >
> > I add a vote the davinci* naming instead of dm365*.
> >
>
> Can you guarantee that this will be the only keypad implementation for
> davinci?

No. That cannot be guaranteed. Surely there will be attempt to reuse
this before inventing new. A new implementation will be a probably be
a new driver (named after what the new implementation is called).

So, I guess it is better to call this driver "davinci-keyscan" after
what the IP has been called (http://focus.ti.com/lit/ug/sprufi8/sprufi8.pdf).

> If not then I'd say using base model number and updating
> Kconfig text is fine.

But hope the other way is okay too. Miguel has already submitted a new
patch using davinci naming.

Thanks,
Sekhar

