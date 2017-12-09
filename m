From: Tomasz Kramkowski <tk@the-tk.com>
Subject: Re: [PATCH] HID: elecom: rewrite report fixup for EX-G and future
 mice
Date: Sat, 9 Dec 2017 17:23:11 +0000
Message-ID: <20171209172311.GA5570@gaia.local>
References: <20171204205550.2621-1-tk@the-tk.com>
 <20171205201307.GA13831@gaia.local>
 <nycvar.YFH.7.76.1712071103120.3572@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:56608 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdLIRXT (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 9 Dec 2017 12:23:19 -0500
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1712071103120.3572@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>, Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.eu>, Alex Manoussakis <amanou@gnu.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 07, 2017 at 11:04:37AM +0100, Jiri Kosina wrote:
> On Tue, 5 Dec 2017, Tomasz Kramkowski wrote:
> 
> > On Mon, Dec 04, 2017 at 08:55:50PM +0000, Tomasz Kramkowski wrote:
> > > +static void mouse_button_fixup(struct hid_device *hdev,
> > > +			       __u8 *rdesc, unsigned int *rsize,
> > > +			       int nbuttons)
> > 
> > I've just remembered what has been bugging me yesterday when I was
> > reviewing this patch. I had come to the realisation (and then
> > subsequently forgotten) that this function should probably return __u8 *
> > and also get assigned to rdesc on the other end. It seems to me that it
> > makes most sense to allow for the possibility (although slim) of this
> > function eventually being expanded to actually replace the report
> > descriptor 
> 
> Sure, but you can extend the API of mouse_button_fixup() once such need 
> arises; no need to pass data pointers around without having actual use for 
> them.

Alright, that's fine. Anything else to change before I send a v2? Also,
would you like v2 in-reply-to the root of this thread or as its own
thread?

-- 
Tomasz Kramkowski | GPG: 40B037BA0A5B8680 | Web: https://the-tk.com/
