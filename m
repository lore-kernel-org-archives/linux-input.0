From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: synaptics - Add PNP ID for ThinkPad P50 to SMBus
Date: Thu, 29 Nov 2018 12:16:29 +0100
Message-ID: <CAO-hwJKLaM=RgfdR_c_MF_rCdJ=CPrbFRRST4KYb6czqsAORBA@mail.gmail.com>
References: <20181121201622.20815-1-lyude@redhat.com> <20181128034720.GB21318@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128034720.GB21318@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Lyude Paul <lyude@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, edvard.holst@gmail.com, arkadiusz.hiler@intel.com, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 28, 2018 at 4:47 AM Peter Hutterer <peter.hutterer@who-t.net> wrote:
>
> On Wed, Nov 21, 2018 at 03:16:20PM -0500, Lyude Paul wrote:
> > Noticed the other day the trackpoint felt different on my P50, then
> > realized it was because rmi4 wasn't loading for this machine
> > automatically. Suspend/resume, hibernate, and everything else seem to
> > work perfectly fine on here.
> >
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
>
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>
> Cheers,
>    Peter
>
> > ---
> >  drivers/input/mouse/synaptics.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index 5e85f3cca867..c42813d50591 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -170,6 +170,7 @@ static const char * const smbus_pnp_ids[] = {
> >       "LEN0048", /* X1 Carbon 3 */
> >       "LEN0046", /* X250 */
> >       "LEN004a", /* W541 */
> > +     "LEN005b", /* P50 */
> >       "LEN0071", /* T480 */
> >       "LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
> >       "LEN0073", /* X1 Carbon G5 (Elantech) */
> > --
> > 2.19.1
> >
