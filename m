From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 08/45] drivers: input: remove duplicate includes
Date: Tue, 5 Dec 2017 10:22:00 -0800
Message-ID: <20171205182200.lqikv7fsxcdld5rk@dtor-ws>
References: <1512439272-15824-1-git-send-email-pravin.shedge4linux@gmail.com>
 <CAO-hwJLM=T35-RFpn=LS=amZmBi9S3eLHVrqsFOs238D3oQexg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJLM=T35-RFpn=LS=amZmBi9S3eLHVrqsFOs238D3oQexg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Pravin Shedge <pravin.shedge4linux@gmail.com>, Nick Dyer <nick@shmanahar.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Colin Ian King <colin.king@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Dec 05, 2017 at 09:15:55AM +0100, Benjamin Tissoires wrote:
> Hi,
> 
> [adding Jiri, the HID maintainer in CC]
> 
> On Tue, Dec 5, 2017 at 3:01 AM, Pravin Shedge
> <pravin.shedge4linux@gmail.com> wrote:
> > These duplicate includes have been found with scripts/checkincludes.pl but
> > they have been removed manually to avoid removing false positives.
> >
> > Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
> > ---
> 
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thank you.

> 
> Cheers,
> Benjamin
> 
> >  drivers/input/rmi4/rmi_f34.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> > index 4cfe970..f1f5ac5 100644
> > --- a/drivers/input/rmi4/rmi_f34.c
> > +++ b/drivers/input/rmi4/rmi_f34.c
> > @@ -11,7 +11,6 @@
> >  #include <linux/rmi.h>
> >  #include <linux/firmware.h>
> >  #include <asm/unaligned.h>
> > -#include <asm/unaligned.h>
> >  #include <linux/bitops.h>
> >
> >  #include "rmi_driver.h"
> > --
> > 2.7.4
> >

-- 
Dmitry
