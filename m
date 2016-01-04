From: Lyude <cpaul@redhat.com>
Subject: Re: [PATCH] HID: wacom: Fix deadlock on proximity in events with
 the Intuos Draw
Date: Mon, 04 Jan 2016 10:33:27 -0500
Message-ID: <1451921607.21146.0.camel@redhat.com>
References: <1451495307-11600-1-git-send-email-cpaul@redhat.com>
	 <CANRwn3SFCvZ+6EQ1D5az41oXfEXYKdPic2E+rzCpcZ4oo6X4UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37529 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751308AbcADPd2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Jan 2016 10:33:28 -0500
In-Reply-To: <CANRwn3SFCvZ+6EQ1D5az41oXfEXYKdPic2E+rzCpcZ4oo6X4UQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, linux-kernel@vger.kernel.org

Yep! That's definitely the same as this one. Glad to hear it still was =
useful
even if it's obsolete :).



On Wed, 2015-12-30 at 12:39 -0800, Jason Gerecke wrote:
> Is this a fix for the same bug addressed in http://linux.kernel.narki=
ve.com/zU
> Iw13xt/patch-hid-usbhid-hid-core-fix-recursive-deadlock
> I think Ping was going to work on something similar to this for the "=
input-
> wacom" backports (since we can't rely on a fixed hid_ctrl being prese=
nt) after
> returning from vacation, but if you've already written it... :)
> On Dec 30, 2015 9:08 AM, "Lyude" <cpaul@redhat.com> wrote:
> > Unfortunately, when we have an Intuos Draw connected using a USB
> > connection, wacom's IRQ handler will be called while the lock for t=
he
> > usbhid driver is held by hid_ctrl. This means when we try to schedu=
le a
> > new proximity event in wacom_intuos_schedule_prox_event() by callin=
g
> > hid_hw_request(), we'll try to take the lock a second time which
> > deadlocks the system. This patch fixes that behavior by initializin=
g a
> > worker when we have a INTUOSHT2 device connected, and using that wo=
rker
> > to schedule the proximity event instead.
> >=20
> > Signed-off-by: Lyude <cpaul@redhat.com>
> > ---
> > =C2=A0drivers/hid/wacom_wac.c | 9 +++++++--
> > =C2=A0drivers/hid/wacom_wac.h | 1 +
> > =C2=A02 files changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index 01a4f05..b59ded6 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> > @@ -433,8 +433,10 @@ exit:
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 return retval;
> > =C2=A0}
> >=20
> > -static void wacom_intuos_schedule_prox_event(struct wacom_wac *wac=
om_wac)
> > +static void wacom_intuos_schedule_prox_event(struct work_struct *w=
ork)
> > =C2=A0{
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct wacom_wac *wacom_wac =3D
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0container_o=
f(work, struct wacom_wac,
> > intuos_prox_event_worker);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct wacom *wacom =3D container_of(wa=
com_wac, struct wacom,
> > wacom_wac);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hid_report *r;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hid_report_enum *re;
> > @@ -624,7 +626,7 @@ static int wacom_intuos_inout(struct wacom_wac =
*wacom)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* don't report other events if we don'=
t know the ID */
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!wacom->id[idx]) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* but resc=
hedule a read of the current tool */
> > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wacom_intuo=
s_schedule_prox_event(wacom);
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_wo=
rk(&wacom->intuos_prox_event_worker);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> >=20
> > @@ -2675,6 +2677,9 @@ int wacom_setup_pen_input_capabilities(struct
> > input_dev *input_dev,
> >=20
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (feature=
s->type =3D=3D INTUOSHT2) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 wacom_setup_basic_pro_pen(wacom_wac);
> > +
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0INIT_WORK(&wacom_wac->intuos_prox_event_worker,
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wacom_intuos_schedu=
le_prox_event);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 __clear_bit(ABS_MISC, input_dev->absbit);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 __set_bit(BTN_TOOL_PEN, input_dev->keybit);
> > diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> > index 877c24a..c24cfdc 100644
> > --- a/drivers/hid/wacom_wac.h
> > +++ b/drivers/hid/wacom_wac.h
> > @@ -237,6 +237,7 @@ struct wacom_wac {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ps_connected;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 bt_features;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 bt_high_speed;
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct work_struct intuos_prox_event_wo=
rker;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct hid_data hid_data;
> > =C2=A0};
> >=20
> > --
> > 2.5.0
> >=20
> >=20
--=20
Cheers,
	Lyude

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
