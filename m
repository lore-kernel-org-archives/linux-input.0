From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Global /dev/input/events device
Date: Fri, 05 Jun 2009 17:10:17 +0200
Message-ID: <1244214617.23850.63.camel@localhost.localdomain>
References: <1244210079.23850.32.camel@localhost.localdomain>
	 <20090605150307.GA14901@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:33973 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbZFEPKx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2009 11:10:53 -0400
In-Reply-To: <20090605150307.GA14901@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

> > so I am working on creating a replacement for the kernel RFKILL input
> > support with a proper daemon in userspace that allows us to implement
> > proper policy support for RFKILL soft switch event buttons.
> > 
> > What I am missing is a /dev/input/events device (similar to the mice
> > device) that combines all events into one to make it easier for
> > application if they really don't care which actual physical or virtual
> > device created that event. Is it possible that we create something like
> > this?
> > 
> 
> I really don't think that creating such device is in out best interest.
> We just went through this with /dev/input/mice and X using legacy
> keybpard driver. Inevitably people start trying to remove certain
> devices from the multiplexed stream coming up with crazy and fragile
> exclusion schemes that only bring more problems in the long run.

I understand that argument, but I don't care about that specific detail
at all. The fact which device send the event is meaningless to me. I
would have to require a filter/mask on that device to be only woken up
for certain event I care about, but that is true for all of them. It is
a major power saving requirement anyway.

> Just have your daemon listen to hotplug/dbus events and select() from
> all devices you are interested in. Then it will be easier later on to
> ignore some devices users feel should not be taken into account.

So I see such a common/global device as pretty useful for simplifying
applications that don't care about the details of multi-device
differences.

Regards

Marcel


