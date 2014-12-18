From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] alps: v7: Document the v7 touchpad packet protocol
Date: Thu, 18 Dec 2014 10:04:39 -0800
Message-ID: <20141218180439.GB34618@dtor-ws>
References: <1417613268-13674-1-git-send-email-hdegoede@redhat.com>
 <CAN+gG=FMY8Mna0vAx16_6qiK9jXOhGGPaCLrAvM4z1-CUOFzUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:49227 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbaLRSEo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Dec 2014 13:04:44 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so1199644igi.5
        for <linux-input@vger.kernel.org>; Thu, 18 Dec 2014 10:04:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAN+gG=FMY8Mna0vAx16_6qiK9jXOhGGPaCLrAvM4z1-CUOFzUQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Fri, Dec 05, 2014 at 04:58:00PM -0500, Benjamin Tissoires wrote:
> On Wed, Dec 3, 2014 at 8:27 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> > Add a table documenting where all the bits are in the v7 touchpad packets.
> >
> > Cc: stable@vger.kernel.org # 3.17
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> 
> Hi Hans,
> 
> I tested yesterday the series on a Toshiba W50-A and a Z30-A if my
> memory is accurate. Internal QA tested these on a Dell M4700 (don't
> know if it has a v7 touchpad though).
> Both tests were conclusive, i.e. they fixes the spurious release when
> right-clicking.
> 
> Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> I am not confident enough with the code to review 3/4 and 4/4, but
> they look sane to me.

Applied all, thank you.

-- 
Dmitry
