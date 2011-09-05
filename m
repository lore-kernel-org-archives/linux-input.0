From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v5 7/8] Input: elantech - add v3 hardware support
Date: Mon, 5 Sep 2011 16:47:40 +0800
Message-ID: <CAGS+omDHEYL8camJ+=z5enBgKNJGWokCV8avzH8b18uLQsg38g@mail.gmail.com>
References: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
 <1315189007-2179-8-git-send-email-jj_ding@emc.com.tw> <CAGS+omCTDb-y7Gut=KgU5wz70R9=75gkmruYpOOS5JUECOK_UA@mail.gmail.com>
 <874o0rqxbq.fsf@emc.com.tw> <CAGS+omBeU1XczFgp23c+cPKAHn5EqOp1AbxYXuJQ55TKYGO7Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:18256 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574Ab1IEIsE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Sep 2011 04:48:04 -0400
Received: from hpaq11.eem.corp.google.com (hpaq11.eem.corp.google.com [172.25.149.11])
	by smtp-out.google.com with ESMTP id p858m27j019177
	for <linux-input@vger.kernel.org>; Mon, 5 Sep 2011 01:48:02 -0700
Received: from iagz35 (iagz35.prod.google.com [10.12.227.35])
	by hpaq11.eem.corp.google.com with ESMTP id p858lieh029121
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 5 Sep 2011 01:48:00 -0700
Received: by iagz35 with SMTP id z35so6746823iag.20
        for <linux-input@vger.kernel.org>; Mon, 05 Sep 2011 01:48:00 -0700 (PDT)
In-Reply-To: <CAGS+omBeU1XczFgp23c+cPKAHn5EqOp1AbxYXuJQ55TKYGO7Fw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Hi JJ,

On Mon, Sep 5, 2011 at 4:39 PM, Daniel Kurtz <djkurtz@chromium.org> wrote:
> Hi JJ,
>
> On Mon, Sep 5, 2011 at 3:10 PM, JJ Ding <jj_ding@emc.com.tw> wrote:
>> Hi Daniel,
>>
>> On Mon, 5 Sep 2011 12:35:28 +0800, Daniel Kurtz <djkurtz@chromium.org> wrote:
>>> Hi JJ,
>>>
>>> On Mon, Sep 5, 2011 at 10:16 AM, JJ Ding <jj_ding@emc.com.tw> wrote:
>>> > diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
>>> > index 2ae7c49..c4ceefd 100644
>>> > --- a/drivers/input/mouse/elantech.c
>>> > +++ b/drivers/input/mouse/elantech.c
>>> > @@ -108,6 +108,16 @@ static int elantech_read_reg(struct psmouse *psmouse, unsigned char reg,
>>> >                        rc = -1;
>>> >                }
>>> >                break;
>>> > +
>>> > +       case 3:
>>> > +               if (elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
>>> > +                   elantech_ps2_command(psmouse, NULL, ETP_REGISTER_READWRITE) ||
>>> > +                   elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
>>> > +                   elantech_ps2_command(psmouse, NULL, reg) ||
>>> > +                   elantech_ps2_command(psmouse, param, PSMOUSE_CMD_GETINFO)) {
>>> > +                       rc = -1;
>>> > +               }
>>> > +               break;
>>> >        }
>>> >
>>> >        if (rc)
>>> > @@ -154,6 +164,18 @@ static int elantech_write_reg(struct psmouse *psmouse, unsigned char reg,
>>> >                        rc = -1;
>>> >                }
>>> >                break;
>>> > +
>>> > +       case 3:
>>> > +               if (elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
>>> > +                   elantech_ps2_command(psmouse, NULL, ETP_REGISTER_READWRITE) ||
>>> > +                   elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
>>> > +                   elantech_ps2_command(psmouse, NULL, reg) ||
>>> > +                   elantech_ps2_command(psmouse, NULL, ETP_PS2_CUSTOM_COMMAND) ||
>>> > +                   elantech_ps2_command(psmouse, NULL, val) ||
>>> > +                   elantech_ps2_command(psmouse, NULL, PSMOUSE_CMD_SETSCALE11)) {
>>> > +                       rc = -1;
>>> > +               }
>>> > +               break;
>>> >        }
>>> >
>>> >        if (rc)
>>> > @@ -350,6 +372,84 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
>>> >        input_sync(dev);
>>> >  }
>>> >
>>> > +/*
>>> > + * Interpret complete data packets and report absolute mode input events for
>>> > + * hardware version 3. (12 byte packets for two fingers)
>>> > + */
>>> > +static void elantech_report_absolute_v3(struct psmouse *psmouse,
>>> > +                                       int packet_type)
>>> > +{
>>> > +       struct input_dev *dev = psmouse->dev;
>>> > +       struct elantech_data *etd = psmouse->private;
>>> > +       unsigned char *packet = psmouse->packet;
>>> > +       unsigned int fingers = 0, x1 = 0, y1 = 0, x2 = 0, y2 = 0;
>>> > +       unsigned int width = 0, pres = 0;
>>> > +
>>> > +       /* byte 0: n1  n0   .   .   .   .   R   L */
>>> > +       fingers = (packet[0] & 0xc0) >> 6;
>>> > +
>>> > +       switch (fingers) {
>>> > +       case 3:
>>> > +       case 1:
>>> > +               /*
>>> > +                * byte 1:  .   .   .   .  x11 x10 x9  x8
>>> > +                * byte 2: x7  x6  x5  x4  x4  x2  x1  x0
>>> > +                */
>>> > +               x1 = ((packet[1] & 0x0f) << 8) | packet[2];
>>> > +               /*
>>> > +                * byte 4:  .   .   .   .  y11 y10 y9  y8
>>> > +                * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
>>> > +                */
>>> > +               y1 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>> > +               break;
>>> > +
>>> > +       case 2:
>>> > +               if (packet_type == PACKET_V3_HEAD) {
>>> > +                       /*
>>> > +                        * byte 1:   .    .    .    .  ax11 ax10 ax9  ax8
>>> > +                        * byte 2: ax7  ax6  ax5  ax4  ax3  ax2  ax1  ax0
>>> > +                        */
>>> > +                       etd->prev_x = ((packet[1] & 0x0f) << 8) | packet[2];
>>> > +                       /*
>>> > +                        * byte 4:   .    .    .    .  ay11 ay10 ay9  ay8
>>> > +                        * byte 5: ay7  ay6  ay5  ay4  ay3  ay2  ay1  ay0
>>> > +                        */
>>> > +                       etd->prev_y = etd->y_max -
>>> > +                               (((packet[4] & 0x0f) << 8) | packet[5]);
>>> > +                       /*
>>> > +                        * wait for next packet
>>> > +                        */
>>> > +                       return;
>>> > +               }
>>> > +
>>> > +               /* packet_type == PACKET_V3_TAIL */
>>> > +               x1 = etd->prev_x;
>>> > +               y1 = etd->prev_y;
>>> > +               x2 = ((packet[1] & 0x0f) << 8) | packet[2];
>>> > +               y2 = etd->y_max - (((packet[4] & 0x0f) << 8) | packet[5]);
>>> > +               break;
>>> > +       }
>>> > +
>>> > +       pres = (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
>>> > +       width = ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
>>> > +
>>> > +       input_report_key(dev, BTN_TOUCH, fingers != 0);
>>> > +       if (fingers != 0) {
>>> > +               input_report_abs(dev, ABS_X, x1);
>>> > +               input_report_abs(dev, ABS_Y, y1);
>>> > +       }
>>> > +       elantech_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
>>>
>>> Originally, v3 was using semi-mt, which reported corner coordinates of
>>> a box containing at least two of the N touches on the touchpad.  I
>>> thought this was due to hardware limitation.
>>>
>>> If the hardware really can report true positions for (up to) 3
>>> contacts, then using pure MT-B is a good approach.  This driver still
>>> seems to mix semi-mt and MT-B together a bit.
>>>
>>> Can you report all three contacts in their own slots, 0, 1 and 2,
>>> instead of just reoprting two of them with 0,1?
>>>
>>> Also, when reporting the 'legacy single touch' coordinate (ABS_X,
>>> ABS_Y), please use:
>>> input_mt_report_pointer_emulation(), instead of always reporting the
>>> last (x1,y1).  Otherwise the single touch point will bounce back and
>>> forth between 1st and 3rd touch.
>>
>> v3 can only track the true positions of two fingers. With 3 finger
>> touch, it reports the lowest value of x and the biggest value of y,
>> among the three fingers. v3 changed the protocol so it could report
>> 2-finger touch data w/o reduced resolution and improved the hardware to
>> truly track 2 fingers independently, otherwise it's pretty much the same
>> as v2.
>
>
> If I read this code correctly, it looks like in the 3-finger case,
> (x1,y1) as reported in the (ABS_X, ABS_Y), and in the call to
> elantech_report_semi_mt_data() will bounce back and forth between the
> 1st finger and 3rd finger ("lowest value of x and the biggest value of
> y").  Won't this be very confusing for userspace (i.e.
> xf86-input=synaptics)?

Oh, never mind.  Sorry for the confusion.  I guess in the 3-finger
case, you only get "3-finger" packets containing the single ("lowest
value of x and the biggest value of y") bounding box coordinate, not
V3_HEAD/V3_TAIL packets.
I believe this shouldn't be reported as MT-B slot 0, though.  If
anything, perhaps you should use MT-B slot 2 for this coordinate?
It's not really the third finger, but at least it won't be considered
a continuation of the motion of the first finger.
I guess you really have no choice but to use it as the (ABS_X, ABS_Y)
coordinate.

-Dan
