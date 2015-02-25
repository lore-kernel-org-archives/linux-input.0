From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/4] HID: uclogic: Set quirks from inside the driver
Date: Wed, 25 Feb 2015 16:23:34 -0500
Message-ID: <20150225212334.GB3097@mail.corp.redhat.com>
References: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com>
 <1424822730-14938-2-git-send-email-benjamin.tissoires@redhat.com>
 <54EE38E5.5090209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43688 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbbBYVXt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 16:23:49 -0500
Content-Disposition: inline
In-Reply-To: <54EE38E5.5090209@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On Feb 25 2015 or thereabouts, Nikolai Kondrashov wrote:
> On 02/25/2015 02:05 AM, Benjamin Tissoires wrote:
> >Based on a patch from: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
> >
> >Most of the tablets handled by hid-uclogic already uses MULTI_INPUT.
> 
> *use
> 
> >Fot the ones which are not quirked in usbhid/hidquirks, they have a
> 
> *For
> 
> >custom report descriptor which contains only one report per HID
> >interface. For those tablets HID_QUIRK_MULTI_INPUT is transparent.
> >
> >According to https://github.com/DIGImend/tablets, the only problematic
> >tablet currently handled by hid-uclogic is the TWHA60 v3. This tablet
> >presents different report descriptors from the ones currently quirked.
> >This is not a problem per se, given that this tablet is not supported
> >currently in this version (it needs the same command than a Huion to
> 
> *as a Huion
> 
> >start forwarding events).
> 
> Thanks, Benjamin. this will make further merges easier.
> Regardless of the Grammar Nazi comments above (fixing is up to you):

Looks like I will have to send a v2 to fix the 3/4, so I will amend it.

> 
> Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>

Thanks! Appreciated.

Cheers,
Benjamin


