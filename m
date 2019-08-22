From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/2] HID multitouch: small fixes
Date: Thu, 22 Aug 2019 18:25:05 +0200
Message-ID: <CAO-hwJ+kujRCBw-A8HV7ppLbnD-nkOsqFd3_KgCD9UBR23oq2w@mail.gmail.com>
References: <20190812162326.14253-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812162326.14253-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Fend <Matthias.Fend@wolfvision.net>, Jiri Kosina <jikos@kernel.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 12, 2019 at 6:23 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> First one should prevent us to add more quirks for Win8 devices
> that have a trackstick.
> Second one is a weird device that doesnt work properly in recent
> kernels.

Looks like there is not much traction for this series.

The test suite is still passing, so I applied the series in for-5.4/multitouch

Cheers,
Benjamin

>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (2):
>   HID: multitouch: do not filter mice nodes
>   HID: multitouch: add support for the Smart Tech panel
>
>  drivers/hid/hid-multitouch.c | 37 +++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>
> --
> 2.19.2
>
