From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v3] xen,input: add xen-kbdfront module parameter for
 setting resolution
Date: Wed, 12 Apr 2017 18:04:30 +0200
Message-ID: <fd644d8b-3cf2-239b-d9f7-c6745b3fc1b3@suse.com>
References: <20170411123037.31733-1-jgross@suse.com>
 <20170412151641.GA6297@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752497AbdDLQEd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Apr 2017 12:04:33 -0400
In-Reply-To: <20170412151641.GA6297@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, boris.ostrovsky@oracle.com, andr2000@gmail.com

On 12/04/17 17:16, Dmitry Torokhov wrote:
> Hi Juergen,
> 
> On Tue, Apr 11, 2017 at 02:30:37PM +0200, Juergen Gross wrote:
>> Add a parameter for setting the resolution of xen-kbdfront in order to
>> be able to cope with a (virtual) frame buffer of arbitrary resolution.
>>
>> While at it remove the pointless second reading of parameters from
>> Xenstore in the device connection phase: all parameters are available
>> during device probing already and that is where they should be read.
>>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> ---
>> V3: - merged the two patches
>>     - read Xenstore parameters during probing of the device only
> 
> I guess 2 module parameters are not big deal, but could you tell me why
> you can't always have them specified in Xenstore?

This will depend on Xen version then. I'd prefer to have a way to
specify the resolution in case a new kernel is running as a guest
of an old Xen version.

> Also, I still think you are going in the wrong direction here. Can your
> framebuffer size change after booting the guest? If it can, you have to
> reconcile the new size and the coordinates reported by the pointing
> device, and I think guest should be doing it. If you look, for example,
> at vmmouse driver, they do not try to match coordinates it reports to
> the screen.

I'm no expert in input driver interface. Can you tell me how the mouse
pointer is positioned in case of the vmmouse driver? Are the real limits
used just the minimum of pointing device and screen size limits? So
specifying a size of 0xffff * 0xffff like the vmmouse driver does will
work with any screen size being smaller than that?


Juergen
