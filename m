From: Jim Gettys <jg@laptop.org>
Subject: Re: How do I find updates to the USB HID usage tables?
Date: Fri, 19 Dec 2008 13:33:00 -0500
Message-ID: <1229711580.9460.166.camel@jg-vaio>
References: <1229008606.14656.347.camel@jg-vaio>
	 <20081211153529.GB13887@kroah.com> <1229011317.14656.355.camel@jg-vaio>
	 <alpine.LRH.1.10.0812112201450.11630@twin.jikos.cz>
	 <1229032115.14656.380.camel@jg-vaio>  <20081211220703.GA24235@kroah.com>
Reply-To: jg@laptop.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:51636
	"EHLO QMTA10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751863AbYLSSdF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Dec 2008 13:33:05 -0500
In-Reply-To: <20081211220703.GA24235@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org


It appears Microsoft is proposing the usages (dunno if they have
formally submitted them to the USB standards folks yet).

There are some documents (dated November) you can find by searching the
Microsoft web site for "multi-touch"; just found them today.  There
wasn't anything when I went looking in October.

The most clearly applicable is:
http://www.microsoft.com/whdc/device/input/DigitizerDrvs_touch.mspx

I'll go over them and confirm that they are consistent with the device I
have...
                          - Jim

On Thu, 2008-12-11 at 14:07 -0800, Greg KH wrote:
> On Thu, Dec 11, 2008 at 04:48:35PM -0500, Jim Gettys wrote:
> > The USB web site on
> > 
> > http://www.usb.org/developers/hidpage/question/
> > 
> > refers to a process for how new values are assigned (answer to question
> > 2.b); it talks about some "HID web page" where some such additions may
> > be put until some annual update of the document: of course, version 1.12
> > is 2004, so who knows what may be lurking on some mythical USB page, if
> > anything...  
> 
> There are no outstanding HID documents currently under review from the
> USB IF that I could find by poking around the member side of usb.org.
> 
> So sorry, I couldn't find anything.
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Jim Gettys <jg@laptop.org>
One Laptop Per Child

