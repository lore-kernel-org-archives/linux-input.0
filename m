From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] Input: synaptics - reject out of range position values
Date: Sat, 9 Jun 2012 14:43:18 +0800
Message-ID: <CAGS+omAoDG4rXj+X2Xmve4AvgpCGgREL3gxcY5D8bX8Sqm5P1A@mail.gmail.com>
References: <1337353224-12333-1-git-send-email-seth.forshee@canonical.com>
 <20120606153538.GC23884@thinkpad-t410> <CAGS+omBQ0PLvjRFVWrSSm1v3fegO5V968s7kLT3hGj3+Bhoebg@mail.gmail.com>
 <20120607195658.GB15138@thinkpad-t410> <20120608165313.GA27117@thinkpad-t410>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:44394 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab2FIGnj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jun 2012 02:43:39 -0400
Received: by qcro28 with SMTP id o28so1201246qcr.19
        for <linux-input@vger.kernel.org>; Fri, 08 Jun 2012 23:43:38 -0700 (PDT)
In-Reply-To: <20120608165313.GA27117@thinkpad-t410>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Sat, Jun 9, 2012 at 12:53 AM, Seth Forshee
<seth.forshee@canonical.com> wrote:
>
> On Thu, Jun 07, 2012 at 02:56:58PM -0500, Seth Forshee wrote:
> > > Or, alternatively, we could actually report negative values to
> > > userspace in this case:
> > >
> > > y =3D (y <=3D 6143) ? y : (y - 8192);
> >
> > Well, they won't be negative anymore when userspace sees them ;)
> >
> > But yeah, either of these should work. I don't feel like it's neces=
sary
> > since this is apparently a one-off problem on aging hardware, and s=
ince
> > Windows also doesn't seem to be using the portion of the touchpad
> > reporting the out of range values (although humorously I can get th=
e
> > pointer to jump sometimes under Windows too). Between the two
> > implementations you suggest I'd feel more comfortable with the latt=
er,
> > as it should leave the values reported unchanged for other hardware=
=2E
> >
> > I do have one question I'd still like to clear up. Am I correct in
> > interpreting the Synaptics documentation to say that the touchpads
> > should never report values greater than 6143, even for models that
> > report the maximum possible x/y values? That's what I think it's sa=
ying,
> > but I also feel like there's a little ambiguity on the point. Espec=
ially
> > since I'm already seeing values outside of the documented range :)
>
> The following is working fine for me, if you think this would be
> preferable. The only downside I see is that if there are touchpads ou=
t
> there that exceed 6143 then this is likely to cause them to start
> behaving oddly.
>
>
> From 2664e38cbebe7e9de652d22d9bc408dd210e6c0b Mon Sep 17 00:00:00 200=
1
> From: Seth Forshee <seth.forshee@canonical.com>
> Date: Fri, 8 Jun 2012 10:19:39 -0500
> Subject: [PATCH] Input: synaptics - handle negative values on the y a=
xis
>
> The touchpad on the Acer Aspire One D250 will report out of range val=
ues
> in the extreme lower portion of the touchpad. These appear as abrupt
> changes in the values reported by the hardware from very low values t=
o
> very high values, which can cause unexpected vertical jumps in the
> position of the mouse pointer.
>
> What seems to be happening is that the value is wrapping to a negativ=
e
> 13-bit value, which is being truncated to the 12-bit range reported i=
n
> the touchpad packets. In order to deal with this, convert values outs=
ide
> the maximum y axis value specified by synaptics to the appropriate
> negative value.
>
> BugLink: http://bugs.launchpad.net/bugs/1001251
> Cc: stable@vger.kernel.org
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
> =A0drivers/input/mouse/synaptics.c | =A0 10 ++++++++++
> =A01 file changed, 10 insertions(+)
>
> diff --git a/drivers/input/mouse/synaptics.c
> b/drivers/input/mouse/synaptics.c
> index e07eb9b..7dc1bd5 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -40,6 +40,7 @@
> =A0* Note that newer firmware allows querying device for maximum usea=
ble
> =A0* coordinates.
> =A0*/
> +#define YMAX 6143
> =A0#define XMIN_NOMINAL 1472
> =A0#define XMAX_NOMINAL 5472
> =A0#define YMIN_NOMINAL 1408
> @@ -555,6 +556,15 @@ static int synaptics_parse_hw_state(const unsign=
ed
> char buf[],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hw->right =3D (buf[0] & 0x02) ? 1 : 0;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Some Synaptics touchpads have been known to wrap n=
egative
> + =A0 =A0 =A0 =A0* on the y axis. These appear to be a 13-bit negativ=
e numbers
> + =A0 =A0 =A0 =A0* truncated to a 12-bit value. To work around this, =
treat any
> + =A0 =A0 =A0 =A0* value above the upper limit defined by Synaptics a=
s actually
> + =A0 =A0 =A0 =A0* being a negative 13-bit value.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 hw->y =3D (hw->y <=3D YMAX) ? hw->y : (hw->y - 8192);
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> --
> 1.7.9.5
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
