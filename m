From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v9 15/18] input: cyapa: add gen3 trackpad device read
 firmware image function support
Date: Mon, 10 Nov 2014 11:05:39 +0000
Message-ID: <ad3bf85500174b25a4dc8f796d10d0a3@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1415003590-30485-1-git-send-email-dudl@cypress.com>
 <1415003590-30485-16-git-send-email-dudl@cypress.com>
 <20141110083955.GD39688@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141110083955.GD39688@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dudley Du <dudley.dulixin@gmail.com>
Cc: "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Thanks, Dmitry

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 2014?11?10? 16:40
> To: Dudley Du
> Cc: rydberg@euromail.se; Dudley Du; bleung@google.com;
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v9 15/18] input: cyapa: add gen3 trackpad device =
read
> firmware image function support
>
> On Mon, Nov 03, 2014 at 04:33:07PM +0800, Dudley Du wrote:
> > Add read firmware image function supported for gen3 trackpad device=
,
> > it can be used through debugfs read_fw interface.
>
> Why do we need this? Can we do the same via usespace program accessin=
g
> the i2c device through /dev/i2c-N?

This interface is used to test and debug only. It's defined and require=
d by the chromium projects.

And in the driver side, becase the firmware image read process is done =
based on interrupt signal,
if do this in userspace through /dev/i2c-N, there will be two issues:
1) for gen5, after each command, an interrupt will be asserted, so if t=
hroug /dev/i2c-N,
userspace program cannot get the interrupt signal.
2) and when the interrupt signal assert, driver won't know it=92s a com=
mand signal for image read,
so it will try to process it as data report.
To avoid this, additional interface must be added to mark the image rea=
d status and
block interrupt signal to be process as data report.

>
> Thanks.
>
> --
> Dmitry

This message and any attachments may contain Cypress (or its subsidiari=
es) confidential information. If it has been received in error, please =
advise the sender and immediately delete this message.
