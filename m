From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH v3 2/5] input: synaptics - change default width value of cr48 sensors
Date: Mon, 23 Mar 2015 22:17:02 +0100
Message-ID: <1962533.LEt6rqGP9j@xps13>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com> <1427035436-2168-3-git-send-email-gabriele.mzt@gmail.com> <CAN+gG=H7KUsuCgdNDpra8pqS3xcxrXBDHr0FG+tVgqFHWDJV5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=H7KUsuCgdNDpra8pqS3xcxrXBDHr0FG+tVgqFHWDJV5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Maxwell Anselm <silverhammermba@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Hans de Goede <hdegoede@redhat.com>, grafi@grafi.jp, Oliver Neukum <oneukum@suse.de>
List-Id: linux-input@vger.kernel.org

On Monday 23 March 2015 16:48:15 Benjamin Tissoires wrote:
> On Sun, Mar 22, 2015 at 10:43 AM, Gabriele Mazzotta
> <gabriele.mzt@gmail.com> wrote:
> > The minimum value these sensors can report is 4, so this should be the
> > value used when W is not reporting the width.
> >
> > Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> > ---
> >  drivers/input/mouse/synaptics.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> > index 133e488..a7a0e73 100644
> > --- a/drivers/input/mouse/synaptics.c
> > +++ b/drivers/input/mouse/synaptics.c
> > @@ -1018,7 +1018,7 @@ static void synaptics_process_packet(struct psmouse *psmouse)
> >
> >         if (hw.z > 0 && hw.x > 1) {
> >                 num_fingers = 1;
> > -               finger_width = 5;
> > +               finger_width = 4;
> 
> I am not sure about this change. It looks benign, but I don't get how
> changing the local variable finger_width can change anything in the
> CR48 processing.

I fail to remember why I did this exactly. I think the reason why I did this
was that before e9e8520f229b ("Input: synaptics - use in-kernel tracking for
reporting mt data") cr48 sensors used ABS_TOOL_WIDTH for all the fingers. If
you had two fingers on the touchpad it was possible for the kernel to emit
fake width variations in case you lifted one (5->4) and brought it back
on the touchpad (4->5). I'm actually not sure of this as I have an Image
Sensor, but even if it's correct, it should no longer be a problem since
multiple slots are used and so 5 would only be used for the second slot.

> Except for this one (which could be dropped IMO), the *rest* of the series is:
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Thanks for pushing this Gabriele.
> 
> Cheers,
> Benjamin
> 
> >                 if (SYN_CAP_EXTENDED(priv->capabilities)) {
> >                         switch (hw.w) {
> >                         case 0 ... 1:
> > --
> > 2.1.4
> >
