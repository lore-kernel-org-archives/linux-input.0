From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 4/8] HID: sony: Report DS4 motion sensors through a
 separate device
Date: Mon, 28 Nov 2016 14:53:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611281452280.29400@cbobk.fhfr.pm>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com> <1479938833-26424-5-git-send-email-roderick@gaikai.com> <c7d7015a773b2199ce5187bc1a8939df.squirrel@mungewell.org> <CANndSK=vwg6bTL1RCCaFRYQ9aJX_kQ47g-x6jJR_hHrPLnVH+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932266AbcK1NxV (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 08:53:21 -0500
In-Reply-To: <CANndSK=vwg6bTL1RCCaFRYQ9aJX_kQ47g-x6jJR_hHrPLnVH+w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Wed, 23 Nov 2016, Roderick Colenbrander wrote:

> > We probably all agree that sending Acc/Gyro data across the joystick
> > interface is not the best thing in the world, so I would have some doubts
> > about whether spinning up another separate interface is quite the 'correct
> > thing' either.
> >
> > A while back I did some 'tinkering' on the SixAxis to see if 'we' could
> > use the IIO interface to report accelerometer data.
> > https://patchwork.kernel.org/patch/6589061/

Roderick,

would you have any input on this aspect? I haven't really been actively 
involved in the discussion last year, but my gut feeling is that IIO would 
be the best suited interface for this.

Thanks,

-- 
Jiri Kosina
SUSE Labs

