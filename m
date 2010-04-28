From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Reset ps/2 port  should psmouse_probe fail before
 retrying
Date: Wed, 28 Apr 2010 10:07:21 -0700
Message-ID: <20100428170721.GA6608@core.coreip.homeip.net>
References: <1271723857.6652.6.camel@lovely>
 <20100422215517.GB28213@core.coreip.homeip.net>
 <1271983668.16254.44.camel@lovely>
 <201004230953.52447.dmitry.torokhov@gmail.com>
 <4BD1EB1C.1070200@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48885 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753862Ab0D1RHa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Apr 2010 13:07:30 -0400
Received: by wye20 with SMTP id 20so938840wye.19
        for <linux-input@vger.kernel.org>; Wed, 28 Apr 2010 10:07:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BD1EB1C.1070200@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>, Christopher Heiny <cheiny@synaptics.com>

On Fri, Apr 23, 2010 at 02:46:52PM -0400, Peter M. Petrakis wrote:
> Here are the dmesg boot logs with i8042.debug. 
> 
> On 04/23/2010 12:53 PM, Dmitry Torokhov wrote:
> > On Thursday 22 April 2010 05:47:48 pm Christoph Fritz wrote:
> >> Am Donnerstag, den 22.04.2010, 14:55 -0700 schrieb Dmitry Torokhov:
> >>> On Thu, Apr 22, 2010 at 05:48:21PM -0400, Peter M. Petrakis wrote:
> >>>> Hi,
> >>>>
> >>>> This one is a winner. with regards to your follow up. I wouldn't
> >>>> want to reset something unless we have cause to. This code
> >>>> seems to be doing the right thing e.g. I see "unable to query
> >>>> synaptics hardware" followed by it's (re)discovery on return
> >>>> from S3.
> >>>>
> >>>> When it's fully supported by the Synaptics driver, the initial
> >>>> reconnect will succeed and we'll never get to this additional
> >>>> failsafe code which is essentially a catch all for the bleeding
> >>>> edge.
> >>>
> >>> I am confused here... what protocol does the kernel select upon fresh
> >>> boot?
> >>
> >> Peter's dmesg:
> >>
> >> [    7.428561] Unable to query Synaptics hardware.
> >>
> >>  It's plain PS/2 or IMPS/2 because this bleeding edge device fails
> >> somewehre in synaptics_query_hardware(). Most likely the test on
> >> priv->identity.
> > 
> > Ah, I missed that. Peter, could you boot with i8042.debug so we could see 
> > where exactly Synaptics detection fails?
> > 

Indeed, capability request returns "d0 00 73" whereas we expect 0x47 in
the middle byte.

Peter, please make sure that you do not have touchpad disabled in BIOS
(at least other Dells that I seen had similar options).

Cristofer, do you know by any chance why touchpad reporing firmware 7.5
would return such unexpected answer to 0x02 query?

Thanks!

-- 
Dmitry
