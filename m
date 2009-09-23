From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] Input: Add DaVinci DM365 Keypad support
Date: Tue, 22 Sep 2009 20:46:27 -0700
Message-ID: <20090923034627.GA1458@core.coreip.homeip.net>
References: <1253217996-11548-1-git-send-email-miguel.aguilar@ridgerun.com> <B85A65D85D7EB246BE421B3FB0FBB59301DD916A60@dbde02.ent.ti.com> <4AB39A00.8080405@ridgerun.com> <B85A65D85D7EB246BE421B3FB0FBB59301DD991DD8@dbde02.ent.ti.com> <4AB8D89D.6050409@ridgerun.com> <871vlyev8g.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:63068 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZIWDq3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 23:46:29 -0400
Received: by qw-out-2122.google.com with SMTP id 5so141939qwd.37
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2009 20:46:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <871vlyev8g.fsf@deeprootsystems.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>, "Nori, Sekhar" <nsekhar@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>

On Tue, Sep 22, 2009 at 10:37:35AM -0700, Kevin Hilman wrote:
> Miguel Aguilar <miguel.aguilar@ridgerun.com> writes:
> 
> > Sekhar,
> >
> > If you and Sneha agree I will write driver in terms of davinci instead of dm365.
> >
> 
> I add a vote the davinci* naming instead of dm365*.
> 

Can you guarantee that this will be the only keypad implementation for
davinci? If not then I'd say using base model number and updating
Kconfig text is fine.

-- 
Dmitry
