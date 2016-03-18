From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wiimote: Fix wiimote mp scale linearization
Date: Fri, 18 Mar 2016 17:37:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603181734540.3656@cbobk.fhfr.pm>
References: <1458147581-4126-1-git-send-email-cyan.ogilvie@gmail.com> <CANq1E4SOSEoUrS6urxb98LD5VGmGSb5+FmaUb5-E6FsTTVMuBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANq1E4SOSEoUrS6urxb98LD5VGmGSb5+FmaUb5-E6FsTTVMuBw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Cyan Ogilvie <cyan.ogilvie@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, 17 Mar 2016, David Herrmann wrote:

> > @@ -2070,15 +2072,15 @@ static void wiimod_mp_in_mp(struct wiimote_data *wdata, const __u8 *ext)
> >         z -= 8192;
> >
> >         if (!(ext[3] & 0x02))
> > -               x *= 18;
> > +               x = (x * 2000 * 9) / 440;
> >         else
> >                 x *= 9;
> >         if (!(ext[4] & 0x02))
> > -               y *= 18;
> > +               y = (y * 2000 * 9) / 440;
> >         else
> >                 y *= 9;
> >         if (!(ext[3] & 0x01))
> > -               z *= 18;
> > +               z = (z * 2000 * 9) / 440;
> 
> So 2000/440 ~= 4.5, so this is exactly what the initial comment said.
> Patch looks good to me:
> 
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Appplied to for-4.6/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
