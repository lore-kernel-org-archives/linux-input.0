From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Reset ps/2 port  should psmouse_probe fail before retrying
Date: Thu, 29 Apr 2010 10:46:48 -0700
Message-ID: <201004291046.49870.dmitry.torokhov@gmail.com>
References: <1271723857.6652.6.camel@lovely> <4BD897D4.4060405@canonical.com> <1272560268.3987.12.camel@lovely>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34236 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759401Ab0D3TBU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Apr 2010 15:01:20 -0400
Received: by wwb34 with SMTP id 34so423009wwb.19
        for <linux-input@vger.kernel.org>; Fri, 30 Apr 2010 12:01:18 -0700 (PDT)
In-Reply-To: <1272560268.3987.12.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: "Peter M. Petrakis" <peter.petrakis@canonical.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>, Christopher Heiny <cheiny@synaptics.com>

On Thursday 29 April 2010 09:57:48 am Christoph Fritz wrote:
> On Wed, 2010-04-28 at 16:17 -0400, Peter M. Petrakis wrote:
> > Dmitry,
> > 
> > This Dell in question do not have an option to disable the
> > touchpad. The BIOS options are unremarkable.
> > 
> > Peter
> > 
> > On 04/28/2010 01:07 PM, Dmitry Torokhov wrote:
> > > On Fri, Apr 23, 2010 at 02:46:52PM -0400, Peter M. Petrakis wrote:
> > >> Here are the dmesg boot logs with i8042.debug.
> > >> 
> > >> On 04/23/2010 12:53 PM, Dmitry Torokhov wrote:
> > >>> On Thursday 22 April 2010 05:47:48 pm Christoph Fritz wrote:
> > >>>> Am Donnerstag, den 22.04.2010, 14:55 -0700 schrieb Dmitry Torokhov:
> > >>>>> On Thu, Apr 22, 2010 at 05:48:21PM -0400, Peter M. Petrakis wrote:
> > >>>>>> Hi,
> > >>>>>> 
> > >>>>>> This one is a winner. with regards to your follow up. I wouldn't
> > >>>>>> want to reset something unless we have cause to. This code
> > >>>>>> seems to be doing the right thing e.g. I see "unable to query
> > >>>>>> synaptics hardware" followed by it's (re)discovery on return
> > >>>>>> from S3.
> > >>>>>> 
> > >>>>>> When it's fully supported by the Synaptics driver, the initial
> > >>>>>> reconnect will succeed and we'll never get to this additional
> > >>>>>> failsafe code which is essentially a catch all for the bleeding
> > >>>>>> edge.
> > >>>>> 
> > >>>>> I am confused here... what protocol does the kernel select upon
> > >>>>> fresh boot?
> > >>>> 
> > >>>> Peter's dmesg:
> > >>>> 
> > >>>> [    7.428561] Unable to query Synaptics hardware.
> > >>>> 
> > >>>>  It's plain PS/2 or IMPS/2 because this bleeding edge device fails
> > >>>> 
> > >>>> somewehre in synaptics_query_hardware(). Most likely the test on
> > >>>> priv->identity.
> > >>> 
> > >>> Ah, I missed that. Peter, could you boot with i8042.debug so we could
> > >>> see where exactly Synaptics detection fails?
> > > 
> > > Indeed, capability request returns "d0 00 73" whereas we expect 0x47 in
> > > the middle byte.
> 
> The synaptics docu [1] about "information queries" is a bit imprecise in
> my view. It's clear to get "Identify TouchPad" with "E8 00 E8 00 E8 00
> E8 00 E9". But as I understand it, to get "Read Capabilities" we should
> do "E8 02 E8 02 E8 02 E8 02 E9" instead of "E8 00 E8 00 E8 00 E8 02 E9".

No, E8 sequence is described very clearly in p 4.2 of the interfacing
guide. 02 02 02 02 would correspond to 0xaa I believe.

-- 
Dmitry
