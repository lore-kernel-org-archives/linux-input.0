From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Global /dev/input/events device
Date: Fri, 5 Jun 2009 08:03:08 -0700
Message-ID: <20090605150307.GA14901@dtor-d630.eng.vmware.com>
References: <1244210079.23850.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:54159 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbZFEPDO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2009 11:03:14 -0400
Received: by rv-out-0506.google.com with SMTP id f9so672374rvb.1
        for <linux-input@vger.kernel.org>; Fri, 05 Jun 2009 08:03:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1244210079.23850.32.camel@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-input@vger.kernel.org

Hi Marcel,

On Fri, Jun 05, 2009 at 03:54:39PM +0200, Marcel Holtmann wrote:
> Hi Dmitry,
> 
> so I am working on creating a replacement for the kernel RFKILL input
> support with a proper daemon in userspace that allows us to implement
> proper policy support for RFKILL soft switch event buttons.
> 
> What I am missing is a /dev/input/events device (similar to the mice
> device) that combines all events into one to make it easier for
> application if they really don't care which actual physical or virtual
> device created that event. Is it possible that we create something like
> this?
> 

I really don't think that creating such device is in out best interest.
We just went through this with /dev/input/mice and X using legacy
keybpard driver. Inevitably people start trying to remove certain
devices from the multiplexed stream coming up with crazy and fragile
exclusion schemes that only bring more problems in the long run.

Just have your daemon listen to hotplug/dbus events and select() from
all devices you are interested in. Then it will be easier later on to
ignore some devices users feel should not be taken into account.

-- 
Dmitry
