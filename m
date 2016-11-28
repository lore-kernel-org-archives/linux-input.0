From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: touchscreen: sample averaging for imx6ul_tsc
Date: Sun, 27 Nov 2016 20:46:09 -0800
Message-ID: <20161128044609.GC2821@dtor-ws>
References: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
 <1480232698-23075-2-git-send-email-guy.shapiro@mobi-wize.com>
 <CAOMZO5CCtLdH9_5vGXfqg1rAizngVc_EWaoE+JfcfTrMmJT4xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33390 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753763AbcK1EqN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 27 Nov 2016 23:46:13 -0500
Content-Disposition: inline
In-Reply-To: <CAOMZO5CCtLdH9_5vGXfqg1rAizngVc_EWaoE+JfcfTrMmJT4xA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Guy Shapiro <guy.shapiro@mobi-wize.com>, Fabio Estevam <fabio.estevam@freescale.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Haibo Chen <haibo.chen@freescale.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, linux-input@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sun, Nov 27, 2016 at 10:39:10AM -0200, Fabio Estevam wrote:
> On Sun, Nov 27, 2016 at 5:44 AM, Guy Shapiro <guy.shapiro@mobi-wize.com> wrote:
> > The i.MX6UL internal touchscreen controller contains an option to
> > average upon samples. This feature reduces noise from the produced
> > touch locations.
> >
> > This patch adds sample averaging support to the imx6ul_tsc device
> > driver.
> >
> > Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Folded the binding patch into this one and applied, thank you.

-- 
Dmitry
