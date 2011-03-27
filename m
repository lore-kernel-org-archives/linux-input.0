From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input : wacom - report resolution for pen devices
Date: Sun, 27 Mar 2011 12:07:51 -0700
Message-ID: <20110327190751.GA31692@core.coreip.homeip.net>
References: <1301099376-5502-1-git-send-email-pinglinux@gmail.com>
 <AANLkTi=tAt8ZoBur1qdyK3aroquBHGhUnMY458RROHhz@mail.gmail.com>
 <AANLkTinV4KzSkF9eRY8urZ7sM9dxz2pPaQs+vtX52GAF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34976 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195Ab1C0TH4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Mar 2011 15:07:56 -0400
Received: by iwn34 with SMTP id 34so2910040iwn.19
        for <linux-input@vger.kernel.org>; Sun, 27 Mar 2011 12:07:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinV4KzSkF9eRY8urZ7sM9dxz2pPaQs+vtX52GAF@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org

On Sun, Mar 27, 2011 at 11:59:29AM -0700, Ping Cheng wrote:
> On Sun, Mar 27, 2011 at 7:32 AM, Chris Bagwell <chris@cnpbagwell.com> wrote:
> 
> > On Fri, Mar 25, 2011 at 7:29 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> > > Touch resolution is reported to the userland by retrieving
> > > the value from the HID descriptor. But pen resolution is not
> > > since it can not be retrieved. The current Wacom X driver
> > > has a resolution table. To centralize the source of these
> > > values, the resolution entries are added in the wacom_features
> > > struct for x and y coordinates respectively. The values are
> > > then reported to the userland.
> > >
> > > Signed-off-by: Ping Cheng <pingc@wacom.com>
> >
> > I'm glad you gave up on me saying I'd eventually make this change. :-)
> >
> > My hold up was I was debating to myself if it should have separate X/Y
> > resolutions or just a single field.  Its unlikely Wacom will ship
> > unmatched X/Y's.  For what its worth, a  version of this change in my
> > local tree also kept separate X/Y's.
> >
> 
> I thought about that when I worked on the patch too. I decided to have
> separate entries for x and y since it adds flexibility for future devices.
> 

Applied both, altough without Chris's reviwed-by tags as I already pushed
by public branch out...

-- 
Dmitry
