From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch v2] input:rohm based bu21013 touch panel controller
 driver support
Date: Thu, 9 Sep 2010 08:39:30 -0700
Message-ID: <20100909153930.GA19937@core.coreip.homeip.net>
References: <81C3A93C17462B4BBD7E272753C1057916DE831AF4@EXDCVYMBSTM005.EQ1STM.local>
 <4C88CEC1.1010209@codeaurora.org>
 <81C3A93C17462B4BBD7E272753C1057916DE831C23@EXDCVYMBSTM005.EQ1STM.local>
 <4C88E52B.3020107@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58098 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab0IIPjj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Sep 2010 11:39:39 -0400
Received: by yxp4 with SMTP id 4so659450yxp.19
        for <linux-input@vger.kernel.org>; Thu, 09 Sep 2010 08:39:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C88E52B.3020107@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

On Thu, Sep 09, 2010 at 07:16:19PM +0530, Trilok Soni wrote:
> On 9/9/2010 6:50 PM, Naveen Kumar GADDIPATI wrote:
> > Hi Trilok,
> > 
> >> -----Original Message-----
> >> From: Trilok Soni [mailto:tsoni@codeaurora.org]
> >> Sent: Thursday, September 09, 2010 5:41 PM
> >> To: Naveen Kumar GADDIPATI
> >> Cc: Dmitry Torokhov; linux-input@vger.kernel.org;
> >> STEricsson_nomadik_linux
> > 
> > 
> >>> +
> >>> +static struct i2c_driver bu21013_driver = {
> >>> +       .driver = {
> >>> +               .name   =       DRIVER_TP,
> >>> +               .owner  =       THIS_MODULE,
> >>> +       },
> >>> +       .probe          =       bu21013_probe,
> >>> +#ifdef CONFIG_PM
> >>> +       .suspend        =       bu21013_suspend,
> >>> +       .resume         =       bu21013_resume,
> >>> +#endif
> >>
> >> Better to move these suspend and resume to dev_pm_ops.
> >>
> > 	How we could dev_pm_ops in i2c driver structure?
> > 
> 
> Refer: drivers/input/keyboard/adp5588-keys.c as example.
> 

Hm, indeed I forgot that i2c has been fully wired for dev_pm_ops. I
should enforce its use then. Thank you for reminding Trilok.

I wonder if someone could wire SPI as well...

-- 
Dmitry
