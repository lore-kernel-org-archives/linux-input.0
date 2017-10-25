From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 1/2] Input: synaptics-rmi4 - RMI4 can also use SMBUS
 version 3
Date: Wed, 25 Oct 2017 09:31:55 +0200
Message-ID: <20171025073155.GE13605@mail.corp.redhat.com>
References: <20171006140630.6398-1-yiannis.marangos@gmail.com>
 <20171006140630.6398-2-yiannis.marangos@gmail.com>
 <20171010175707.xtdgimmnju7cjlom@dystopia.localdomain>
 <20171024181924.ib3oybrxdq42h5f3@dtor-ws>
 <4b3f9306-785d-155d-f23f-54acf7852da5@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbdJYHcB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Oct 2017 03:32:01 -0400
Content-Disposition: inline
In-Reply-To: <4b3f9306-785d-155d-f23f-54acf7852da5@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yiannis Marangos <yiannis.marangos@gmail.com>, linux-input@vger.kernel.org

On Oct 24 2017 or thereabouts, Andrew Duggan wrote:
> Hi Dmitry,
> 
> On 10/24/2017 11:19 AM, Dmitry Torokhov wrote:
> > On Tue, Oct 10, 2017 at 09:04:20PM +0300, Yiannis Marangos wrote:
> > > Hi guys,
> > > 
> > > As I understand the second part of the patchset will take a while until it get
> > > merged. Is it possible to merge the first part only? Without this, LEN0073 users
> > > can not use psmouse.synaptics_intertouch=1 as a workaround. LEN0073 is not
> > > usable at all unless users patch the kernel manually.
> > Benjamin, Andrew, any comments/objections on expanding the acceptable
> > version range?
> 
> I didn't comment earlier since I didn't have any specific info about SMBus
> v3. But, looking at the spec for v3 it sounds like our v2 touchpads should
> be compatible with a v3 bus.
> 
> "This version of the specification is a superset of previous versions, 1.0,
> 1.1, and 2.0. The intent is that all devices compliant with these previous
> versions are compliant with this version."
> 
> From http://smbus.org/specs/SMBus_3_0_20141220.pdf pg 8 section 1.3.
> 
> Based on that quote and the fact that it seems to work for Yiannis makes me
> think that this change is probably ok.
> 

I concur. I thought the version was Synaptics' one, but if it is the
SMBus protocol they are following, allowing v3 is OK.

Aceked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> Andrew
> 
> > Thanks.
> > 
> 
