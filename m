From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH 1/3] Input: DaVinci Key Scan Driver
Date: Fri, 25 Sep 2009 20:01:19 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB36C3@dbde02.ent.ti.com>
References: <1253811202-21407-1-git-send-email-miguel.aguilar@ridgerun.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301DDAB3271@dbde02.ent.ti.com>
 <4ABCD1E8.5000200@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56706 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbZIYOb2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2009 10:31:28 -0400
In-Reply-To: <4ABCD1E8.5000200@ridgerun.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Cc: "Narnakaje, Snehaprabha" <nsnehaprabha@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "santiago.nunez@ridgerun.com" <santiago.nunez@ridgerun.com>, "todd.fischer@ridgerun.com" <todd.fischer@ridgerun.com>, "clark.becker@ridgerun.com" <clark.becker@ridgerun.com>

On Fri, Sep 25, 2009 at 19:51:28, Miguel Aguilar wrote:
> Nori, Sekhar wrote:
> > On Thu, Sep 24, 2009 at 22:23:22, miguel.aguilar@ridgerun.com wrote:
> >> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> >>
> >> Adds the driver for enabling key scan support for DaVinci platforms.
> >>
> >> DM365 is the only platform that uses this driver at the moment.
> >>
> >> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> >> ---
> >
> > [...]
> >
> >> +
> >> +/* Initializing the kp Module */
> >> +static void davinci_ks_initialize(struct davinci_ks *davinci_ks)
> >> +{
> >> +     u32 strobe = davinci_ks->pdata->strobe;
> >> +     u32 interval = davinci_ks->pdata->interval;
> >> +
> >> +     /* Enable all interrupts */
> >> +     davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL, DAVINCI_KEYSCAN_INTENA);
> >> +
> >> +     /* Clear interrupts if any */
> >> +     davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_INT_ALL, DAVINCI_KEYSCAN_INTCLR);
> >> +
> >> +     /* Setup the scan period = strobe + interval */
> >> +     davinci_ks_write(davinci_ks, strobe, DAVINCI_KEYSCAN_STRBWIDTH);
> >> +     davinci_ks_write(davinci_ks, interval, DAVINCI_KEYSCAN_INTERVAL);
> >> +     davinci_ks_write(davinci_ks, 0x01, DAVINCI_KEYSCAN_CONTTIME);
> >> +
> >> +     /* Enable Keyscan module and enable */
> >> +     davinci_ks_write(davinci_ks, DAVINCI_KEYSCAN_AUTODET | DAVINCI_KEYSCAN_KEYEN,
> >> +                     DAVINCI_KEYSCAN_KEYCTRL);
> >
> > We seem to be hardcoded to the 4x4 matrix type here.
> > Some DM365 boards could use 5x3 matrix.
> >
> > Thanks,
> > Sekhar
> >
>
> [MA] I will add a platform option for matrix type to choose 4x4 or 5x3 matrix.
> What do think about this?
>

Sounds good. I am not sure if any other piece of code
needs to change though.

Thanks,
Sekhar

