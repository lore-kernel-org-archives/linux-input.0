From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v3 1/2] Input: Add DaVinci DM365 Keypad support
Date: Wed, 23 Sep 2009 20:43:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDA2D112@dbde02.ent.ti.com>
References: <1253217996-11548-1-git-send-email-miguel.aguilar@ridgerun.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DD916A60@dbde02.ent.ti.com>
 <4AB39A00.8080405@ridgerun.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DD991DD8@dbde02.ent.ti.com>
 <4AB8D89D.6050409@ridgerun.com> <871vlyev8g.fsf@deeprootsystems.com>
 <20090923034627.GA1458@core.coreip.homeip.net>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDA2CC8D@dbde02.ent.ti.com>
 <4ABA378B.2070800@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57075 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbZIWPNu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Sep 2009 11:13:50 -0400
In-Reply-To: <4ABA378B.2070800@ridgerun.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>

On Wed, Sep 23, 2009 at 20:28:19, Miguel Aguilar wrote:
> Sekhar,
>
> Nori, Sekhar wrote:
> > On Wed, Sep 23, 2009 at 09:16:27, Dmitry Torokhov wrote:
> >> On Tue, Sep 22, 2009 at 10:37:35AM -0700, Kevin Hilman wrote:
> >>> Miguel Aguilar <miguel.aguilar@ridgerun.com> writes:
> >>>
> >>>> Sekhar,
> >>>>
> >>>> If you and Sneha agree I will write driver in terms of davinci instead of dm365.
> >>>>
> >>> I add a vote the davinci* naming instead of dm365*.
> >>>
> >> Can you guarantee that this will be the only keypad implementation for
> >> davinci?
> >
> > No. That cannot be guaranteed. Surely there will be attempt to reuse
> > this before inventing new. A new implementation will be a probably be
> > a new driver (named after what the new implementation is called).
> >
> > So, I guess it is better to call this driver "davinci-keyscan" after
>
> [MA] Do you think that it is better naming this driver as Key Scan instead of
> Keypad?

Yes.

Thanks,
Sekhar

