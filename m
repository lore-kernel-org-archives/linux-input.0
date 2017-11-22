From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v4 4/4] HID: multitouch: Combine all left-button events
 in a frame
Date: Wed, 22 Nov 2017 15:08:38 +0100
Message-ID: <20171122140838.GP403@mail.corp.redhat.com>
References: <20171113163259.18150-1-hdegoede@redhat.com>
 <20171113163259.18150-4-hdegoede@redhat.com>
 <20171114080229.GE403@mail.corp.redhat.com>
 <nycvar.YFH.7.76.1711211310230.11505@cbobk.fhfr.pm>
 <e2f18cad-616a-9272-cad4-a3081d016745@redhat.com>
 <nycvar.YFH.7.76.1711221436340.11505@cbobk.fhfr.pm>
 <b325d9fd-3761-fb56-d72f-2f78026af6be@redhat.com>
 <20171122135925.GN403@mail.corp.redhat.com>
 <81f6ddf6-9af6-7968-ea3d-43b6b4087b32@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751249AbdKVOIm (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Nov 2017 09:08:42 -0500
Content-Disposition: inline
In-Reply-To: <81f6ddf6-9af6-7968-ea3d-43b6b4087b32@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

On Nov 22 2017 or thereabouts, Hans de Goede wrote:
> Hi,
> 
> On 22-11-17 14:59, Benjamin Tissoires wrote:
> > On Nov 22 2017 or thereabouts, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 22-11-17 14:37, Jiri Kosina wrote:
> > > > On Wed, 22 Nov 2017, Hans de Goede wrote:
> > > > 
> > > > > > Thanks. Hans, last request for you -- HID_DG_SCANTIME handling has in the
> > > > > > meantime added for forwarding the MSC_TIMESTAMP (commit 29cc309d8bf1).
> > > > > > Could you please respin your patch on top of that (basically just merge
> > > > > > your handling with the one added for MSC_TIMESTAMP) and resend? I'll then
> > > > > > queue it for 4.16. Thanks,
> > > > > 
> > > > > Ok, v5 with this fixed coming up.
> > > > 
> > > > Thanks a lot Hans.
> > > > 
> > > > > Since this fixes 2 touchpad models not working (not being usable at
> > > > > least) it would be nice to get this series into 4.15 rc2/rc3 as a bugfix
> > > > > IMHO.
> > > > 
> > > > Hmm, as this is changing common code paths, I'd prefer not to push it
> > > > before next merge window really.
> > > 
> > > I understand, although we are still pre-rc1, so if you queue this up
> > > for rc2 we won't miss a lot of the testing window, and I don't
> > > think a lot of people with hid-mt touchpads are running -next...
> > > 
> > > Benjamin, what is your take on this?
> > 
> > Well, I think both arguments are valid. I would think the patch series
> > is safe, but we never know.
> > How about we schedule this for 4.16 and get it merged in Fedora
> > 27/rawhide soon, so it gets the testings you want but is still scheduled
> > upstream?
> 
> You mean add it to the 4.15 kernels in rawhide? That would work for me.

Yes. Reverting a broken patch in Fedora is easy enough and given that
the patch is accepted upstream, it's not like it will be a big
difference from upstream.

Cheers,
Benjamin

> 
> Regards,
> 
> Hans
