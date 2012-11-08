From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Why Cypress does not upstream its trackpad driver?
Date: Thu, 8 Nov 2012 00:54:31 -0800
Message-ID: <20121108085431.GA6658@core.coreip.homeip.net>
References: <CAFub=KTf2dWxM9=saG2JaNJpEioJM8rM3UBG9BkyxRN-+j0psQ@mail.gmail.com>
 <C825ADB6BE8AC2468577BFFCE7DF5B8A1F080FA111@VMBX133.ihostexchange.net>
 <EE629F2C-DD83-403C-AD73-E9ED966EEA91@cypress.com>
 <2208882.BvOrfBvj6F@dtor-d630.eng.vmware.com>
 <C6B11F3154DB7242B32DD96C876EA7847BAFFAFA95@VMBX113.ihostexchange.net>
 <877gpwlpus.fsf@gmail.com>
 <20121108074154.GA4037@core.coreip.homeip.net>
 <C6B11F3154DB7242B32DD96C876EA7847BAFFAFB11@VMBX113.ihostexchange.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41901 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab2KHIyf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Nov 2012 03:54:35 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so1889386pbb.19
        for <linux-input@vger.kernel.org>; Thu, 08 Nov 2012 00:54:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <C6B11F3154DB7242B32DD96C876EA7847BAFFAFB11@VMBX113.ihostexchange.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Solda <dso@cypress.com>
Cc: Ben Gamari <bgamari.foss@gmail.com>, Troy Abercrombia <ta@cypress.com>, Kamal Mostafa <kamal@canonical.com>, Ozan =?utf-8?B?w4dhxJ9sYXlhbg==?= <ozancag@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, customercare <customercare@cypress.com>, "mario_limonciello@dell.com" <mario_limonciello@dell.com>

David,

On Thu, Nov 08, 2012 at 03:09:36AM -0500, David Solda wrote:
> Dmitry,
> 
> The change you are referring to is the one that I was mentioning.
> 
> The "absolute mode" is the only mode of our module that produces
> multiple fingers.  We do not communicate relative position for more
> than one finger.  The 8 byte packet is only used in the Absolute Mode,
> you are right, however, this packet contains the necessary information
> for determining the position of 2 fingers on the Trackpad.  Hence the
> reason why I stated that a Firmware change (complete architectural and
> protocol rewrite) on our side would be need to comply with the 6 byte
> maximum limit.
> 
> So, the only method that I have available right now to upstream
> something that wouldn't be rejected (as you stated below) is either an
> architectural overhaul (which I cannot launch at this time), or single
> finger position tracking only.
> 
> Any other thoughts are appreciated, but the 8 bytes packet is needed
> for our multi-finger detection and communication scheme that is
> implemented.
> 

First of all, please do not top-post.

I thought I was clear that if you need 8-byte packets just change size
in struct ps2dev to be 8 bytes instead of current 6 and as far as I can
see that will solve your problem. There is no need to change firmware,
re-architecture protocol or doing anything else.

Thanks.

-- 
Dmitry
