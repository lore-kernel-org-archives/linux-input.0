From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/8] PS
Date: Fri, 10 Mar 2017 12:25:21 -0800
Message-ID: <20170310202521.GC35542@dtor-ws>
References: <20170309221644.17035-1-dmitry.torokhov@gmail.com>
 <20170310155735.GA706@mail.corp.redhat.com>
 <20170310175206.GA21811@dtor-ws>
 <20170310180422.GB1221@mail.corp.redhat.com>
 <20170310181030.GC21811@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35758 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdCJUZZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 15:25:25 -0500
Content-Disposition: inline
In-Reply-To: <20170310181030.GC21811@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Mar 10, 2017 at 10:10:30AM -0800, Dmitry Torokhov wrote:
> On Fri, Mar 10, 2017 at 07:04:22PM +0100, Benjamin Tissoires wrote:
> > On Mar 10 2017 or thereabouts, Dmitry Torokhov wrote:
> > > On Fri, Mar 10, 2017 at 04:57:35PM +0100, Benjamin Tissoires wrote:
> > > > Hi Dmitry,
> > > > 
> > > > On Mar 09 2017 or thereabouts, Dmitry Torokhov wrote:
> > > > > Hi,
> > > > > 
> > > > > This is refresh of Benjamin's patches trying to bridge PS/2 and SMbus
> > > > > devices for better support of Synaptics RMI4 touchpads (and Elans later).
> > > > 
> > > > Thanks!
> > > > 
> > > > I have some issues/comments and am still working on those. Here are some
> > > > general comments:
> > > > 
> > > > > 
> > > > > The main difference is that we do not have platform device, as it only
> > > > > adds another indirection level, and have psmouse create SMBus companion
> > > > 
> > > > The purpose of having the platform device was to not have dependency
> > > > between psmouse and I2C. Right now I think that patch 6/8 will fail to
> > > > compile if I2C=m and PSMOUSE=y (I may be wrong).
> > > 
> > > This is taken care by the following guards in users if MOUSE_PS2_SMBUS:
> > > 
> > > depends on I2C=y || I2C=MOUSE_PS2
> > 
> > I can see this guards for MOUSE_PS2_SYNAPTICS_SMBUS, but not for
> > MOUSE_PS2_SMBUS. So unless I am completely missing the point, if users
> > disable SYNAPTICS_SMBUS but keep PS2_SMBUS there might be a problem.
> 
> Hmm, I'll need to play with this. MOUSE_PS2_SMBUS is not user visible.
> Might end up adding condition there as well, or doing somethign more
> elaborate, like Arnd did for RMI_F03_SERIO.

So if I disable MOUSE_PS2_SYNAPTICS_SMBUS then MOUSE_PS2_SMBUS
disappears from .config, so I think we are good.

Thanks.

-- 
Dmitry
