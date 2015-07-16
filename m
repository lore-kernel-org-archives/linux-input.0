From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input - elantech: force a resolution of 31 u/mm
Date: Thu, 16 Jul 2015 10:40:09 -0700
Message-ID: <20150716174009.GB32571@dtor-ws>
References: <20150710003244.GA25437@jelly.redhat.com>
 <CANq1E4S0esqdku=SuVqV=78qWMEt66U3Lia7CdPeCUgHX8UXwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANq1E4S0esqdku=SuVqV=78qWMEt66U3Lia7CdPeCUgHX8UXwQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Duson Lin <dusonlin@emc.com.tw>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 14, 2015 at 07:59:47PM +0200, David Herrmann wrote:
> Hi
> 
> On Fri, Jul 10, 2015 at 2:32 AM, Peter Hutterer
> <peter.hutterer@who-t.net> wrote:
> > All Elantech touchpads pre-v4 with dynamic resolution queries have a fixed
> > resolution of 800dpi -> 31.49 units/mm. Set this statically, so userspace does
> > not have to guess.
> >
> > Cc: Duson Lin <dusonlin@emc.com.tw>
> > Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> > ---
> >  drivers/input/mouse/elantech.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> I think this is much nicer than having to work around this in
> user-space. Much appreciated!
> 
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Applied, thank you.

-- 
Dmitry
