From: Gustavo Padovan <padovan-Y3ZbgMPKUGA34EUeqzHoZw@public.gmane.org>
Subject: Re: [PATCH] Bluetooth: hidp: Add support for NO_INIT_REPORTS quirk
Date: Fri, 2 Sep 2011 15:20:44 -0300
Message-ID: <20110902182044.GG12684@joana>
References: <1314358032-23513-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1314358032-23513-1-git-send-email-dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi David,

* David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org> [2011-08-26 13:27:12 +0200]:

> During setup the host initializes all HID reports. Some devices do not
> support this. If this quirk is set, we skip the initialization.
> See also usbhid_init_reports() for this quirk.
> 
> Signed-off-by: David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
> ---
>  net/bluetooth/hidp/core.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

Applied, Thanks.

	Gustavo
