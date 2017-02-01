From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: uinput - fix crash when mixing old and new init
 style
Date: Wed, 1 Feb 2017 09:27:13 -0800
Message-ID: <20170201172713.GD40045@dtor-ws>
References: <20170131231728.GA37933@dtor-ws>
 <20170201084925.GD31658@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170201084925.GD31658@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 01, 2017 at 09:49:25AM +0100, Benjamin Tissoires wrote:
> On Jan 31 2017 or thereabouts, Dmitry Torokhov wrote:
> > If user tries to initialize uinput device mixing old and new style
> > initialization (i.e. using old UI_SET_ABSBIT instead of UI_ABS_SETUP,
> > we forget to allocate input->absinfo and will crash when trying to send
> > absolute events:
> > 
> >         ioctl(ui, UI_DEV_SETUP, &us);
> >         ioctl(ui, UI_SET_EVBIT, EV_ABS);
> >         ioctl(ui, UI_SET_ABSBIT, ABS_X);
> >         ioctl(ui, UI_SET_ABSBIT, ABS_Y);
> >         ioctl(ui, UI_DEV_CREATE, 0);
> 
> Shouldn't we prevent completely the mix of the 2 versions? If the user
> used UI_DEV_SETUP, we should probably prevent the use of UI_SET_ABSBIT
> afterwards, or at least warn it somehow.

Why? If user does not wish to set up parameters of an axis then just
using UI_SET_ABSBIT is fine. In fact, I think it would be weird if we
allowed all UI_SET_*BIT except for ABS.

> 
> But the patch in itself doesn't hurt, so:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks.

-- 
Dmitry
