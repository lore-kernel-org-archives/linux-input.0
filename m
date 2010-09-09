From: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>
Subject: RE: [Patch v2] input:rohm based bu21013 touch panel controller
 driver support
Date: Thu, 9 Sep 2010 15:20:50 +0200
Message-ID: <81C3A93C17462B4BBD7E272753C1057916DE831C23@EXDCVYMBSTM005.EQ1STM.local>
References: <81C3A93C17462B4BBD7E272753C1057916DE831AF4@EXDCVYMBSTM005.EQ1STM.local>
 <4C88CEC1.1010209@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:55957 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753931Ab0IINVA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Sep 2010 09:21:00 -0400
In-Reply-To: <4C88CEC1.1010209@codeaurora.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>

Hi Trilok,

> -----Original Message-----
> From: Trilok Soni [mailto:tsoni@codeaurora.org]
> Sent: Thursday, September 09, 2010 5:41 PM
> To: Naveen Kumar GADDIPATI
> Cc: Dmitry Torokhov; linux-input@vger.kernel.org;
> STEricsson_nomadik_linux


> > +
> > +static struct i2c_driver bu21013_driver = {
> > +       .driver = {
> > +               .name   =       DRIVER_TP,
> > +               .owner  =       THIS_MODULE,
> > +       },
> > +       .probe          =       bu21013_probe,
> > +#ifdef CONFIG_PM
> > +       .suspend        =       bu21013_suspend,
> > +       .resume         =       bu21013_resume,
> > +#endif
> 
> Better to move these suspend and resume to dev_pm_ops.
> 
	How we could dev_pm_ops in i2c driver structure?

Thanks & Regards,
Naveen

