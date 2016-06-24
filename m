From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v8 4/4] Input: synaptics-rmi4 - add SMBus support
Date: Fri, 24 Jun 2016 16:35:05 -0700
Message-ID: <20160624233505.GC11719@dtor-ws>
References: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
 <1465484030-28838-5-git-send-email-benjamin.tissoires@redhat.com>
 <20160623230635.GS32561@dtor-ws>
 <20160624071931.GP24234@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36794 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcFXXfJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2016 19:35:09 -0400
Content-Disposition: inline
In-Reply-To: <20160624071931.GP24234@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Jun 24, 2016 at 09:19:32AM +0200, Benjamin Tissoires wrote:
> On Jun 23 2016 or thereabouts, Dmitry Torokhov wrote:
> > On Thu, Jun 09, 2016 at 04:53:50PM +0200, Benjamin Tissoires wrote:
> > > +
> > > +static struct i2c_driver rmi_smb_driver = {
> > > +	.driver = {
> > > +		.owner	= THIS_MODULE,
> > > +		.name	= "rmi4_smbus",
> > > +		.pm	= &rmi_smb_pm,
> > > +		.resume	= rmi_smb_resume,
> > 
> > Why rmi_smb_resume is not part of rmi_smb_pm?
> > 
> 
> This is because rmi_smbus device both have a PS/2 interface and a SMBus
> one. I'll have to check again now that I have a slightly different way
> of binding smbus devices in my tree, but the issue was:
> - having resume part of pm means it will get caught by PM directly
> - the PS/2 node gets also resumed by PM
> - calling PS/2 commands during resume switches the devices back into
>   PS/2 and stops the SMBus communication.
> 
> So it's easier to wait only for the PS/2 PM resume call which will call
> the SMBus resume function when the device is in a proper state.
> 
> I'll send out the updated patch with your comments next week hopefully.

Hmm, I think you will have to walk me through resume process. How do we
tie in PS/2 and I2C on these devices abd have PS/2 code call into this
driver?

Thanks.

-- 
Dmitry
