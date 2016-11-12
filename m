From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 0/3] Input: ALPS - Bug fix and cleanup for SS5 hardware
Date: Fri, 11 Nov 2016 17:06:40 -0800
Message-ID: <20161112010640.GA37875@dtor-ws>
References: <20161110151942.GA3969@pali>
 <201611111459.12642@pali>
 <20161112005621.GA20989@dtor-glaptop>
 <201611120203.44330@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35080 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965067AbcKLBGn (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Nov 2016 20:06:43 -0500
Received: by mail-pg0-f65.google.com with SMTP id p66so3047319pga.2
        for <linux-input@vger.kernel.org>; Fri, 11 Nov 2016 17:06:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201611120203.44330@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Paul Donohue <linux-kernel@paulsd.com>, linux-input@vger.kernel.org, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

On Sat, Nov 12, 2016 at 02:03:42AM +0100, Pali Rohár wrote:
> On Saturday 12 November 2016 01:56:21 Dmitry Torokhov wrote:
> > On Fri, Nov 11, 2016 at 02:59:09PM +0100, Pali Rohár wrote:
> > > On Thursday 10 November 2016 17:44:43 Paul Donohue wrote:
> > > > This series includes a bug fix and assorted cleanup for the Alps
> > > > SS5 (SS4 v2) code.
> > > > 
> > > > Changes in v5:
> > > > * Moved TrackStick decoding logic to alps_process_packet_ss4_v2()
> > > > to
> > > > 
> > > >   make the code more consistent with other protocol versions
> > > >   (Suggested by Pali Rohár <pali.rohar@gmail.com>)
> > > > 
> > > > Changes in v4:
> > > > * Fixed patch formatting issues
> > > > * Correct casting issues in macros added in v3
> > > > 
> > > > Changes in v3:
> > > > * Added additional code cleanup to make the code easier to
> > > > understand
> > > > 
> > > >   (Suggested by Pali Rohár <pali.rohar@gmail.com>)
> > > > 
> > > > Changes in v2:
> > > > * For consistency with other Alps functions, check packet bytes
> > > > for
> > > > 
> > > >   packet type rather than adding a flag to alps_fields for packet
> > > > 
> > > > type. (Suggested by Pali Rohár <pali.rohar@gmail.com>)
> > > > 
> > > > Paul Donohue (3):
> > > >   Input: ALPS - Fix TrackStick support for SS5 hardware
> > > >   Input: ALPS - Clean up TrackStick handling for SS5 hardware
> > > >   Input: ALPS - Clean up code for SS5 hardware
> > > >  
> > > >  drivers/input/mouse/alps.c | 59
> > > > 
> > > > +++++++++++++++++++++++++---------------------
> > > > drivers/input/mouse/alps.h | 22 ++++++++++++++++-
> > > > 
> > > >  2 files changed, 53 insertions(+), 28 deletions(-)
> > > 
> > > Whole patch series looks fine.
> > > You can add my Reviewed-by: Pali Rohár <pali.rohar@gmail.com>
> > 
> > FYI: I do not see a dingle email from Paul, only your replies.
> 
> Patches were sent to linux-input@vger.kernel.org ML. Maybe some spam 
> filter ate emails? Btw I added you to receivers of my last sent email.

Yes, I looked there as well and did not see anything but you replies.

Thanks.

-- 
Dmitry
