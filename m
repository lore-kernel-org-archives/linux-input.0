From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Support TrackStick of Thinkpad L570
Date: Mon, 4 Dec 2017 10:50:45 +0100
Message-ID: <20171204095045.lp2vuxtxmmjpsjo7@pali>
References: <20171129083358.5063-1-masaki.ota@jp.alps.com>
 <20171201210749.el6q62sc22jshwc5@pali>
 <TYXPR01MB07190FD0598129DE8EE892B3C73C0@TYXPR01MB0719.jpnprd01.prod.outlook.com>
 <20171204091153.q2i355gqbmf7dbvk@pali>
 <TYXPR01MB071970E9BC3BD2CD0F026709C73C0@TYXPR01MB0719.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <TYXPR01MB071970E9BC3BD2CD0F026709C73C0@TYXPR01MB0719.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: Masaki Ota <012nexus@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "aaron.ma@canonical.com" <aaron.ma@canonical.com>, "jaak@ristioja.ee" <jaak@ristioja.ee>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Monday 04 December 2017 09:40:04 Masaki Ota wrote:
> Hi, Pali,
> 
> It does not work in my test result.

Hm.. that is strange, we have dangling pointers in struct alps_data?
Otherwise I have no idea why does not work.

> BTW, other some functions also use both of "struct psmouse" and "struct alps_data" argument.

It does not make sense to pass one structure (via pointers) two times.
And if this "pattern" is already used in code and reason is that one
pointer "does not work" because it is dangling, then it is really wrong.

I know it is irrelevant to your patch, but this problem with dangling
pointer should be fixed, e.g. in next patches (not in this one).

Problems (with memory allocation/pointers) should not be camouflaged.
Memory corruption in kernel can lead to fatal problems.

> I just followed it.

Blindly following bad code is a bad idea. When we see something like
this, we should at least stop and ask question "why is this code pattern
used?".

> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Pali Rohár [mailto:pali.rohar@gmail.com] 
> Sent: Monday, December 04, 2017 6:12 PM
> To: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>
> Cc: Masaki Ota <012nexus@gmail.com>; dmitry.torokhov@gmail.com; benjamin.tissoires@redhat.com; aaron.ma@canonical.com; jaak@ristioja.ee; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] Support TrackStick of Thinkpad L570
> 
> On Monday 04 December 2017 04:48:43 Masaki Ota wrote:
> > Hi, Pali,
> > 
> > I don't get your point.
> > Please modify the code if you have an idea.
> 
> See below
> 
> > Best Regards,
> > Masaki Ota
> > -----Original Message-----
> > From: Pali Rohár [mailto:pali.rohar@gmail.com]
> > Sent: Saturday, December 02, 2017 6:08 AM
> > To: Masaki Ota <012nexus@gmail.com>
> > Cc: dmitry.torokhov@gmail.com; benjamin.tissoires@redhat.com; 
> > aaron.ma@canonical.com; jaak@ristioja.ee; 太田 真喜 Masaki Ota 
> > <masaki.ota@jp.alps.com>; linux-input@vger.kernel.org; 
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] Support TrackStick of Thinkpad L570
> > 
> > On Wednesday 29 November 2017 17:33:58 Masaki Ota wrote:
> > > From: Masaki Ota <masaki.ota@jp.alps.com>
> > > - The issue is that Thinkpad L570 TrackStick does not work. Because the main interface of Thinkpad L570 device is SMBus, so ALPS overlooked PS2 interface Firmware setting of TrackStick. The detail is that TrackStick otp bit is disabled.
> > > - Add the code that checks 0xD7 address value. This value is device number information, so we can identify the device by checking this value.
> > > - If we check 0xD7 value, we need to enable Command mode and after check the value we need to disable Command mode, then we have to enable the device(0xF4 command).
> > > - Thinkpad L570 device number is 0x0C or 0x1D. If it is TRUE, enable ALPS_DUALPOINT flag.
> > > 
> > > Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> > > ---
> > >  drivers/input/mouse/alps.c | 24 +++++++++++++++++++++---
> > >  1 file changed, 21 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c 
> > > index 850b00e3ad8e..6f092bdd9fc5 100644
> > > --- a/drivers/input/mouse/alps.c
> > > +++ b/drivers/input/mouse/alps.c
> > > @@ -2541,13 +2541,31 @@ static int
> > > alps_update_btn_info_ss4_v2(unsigned char otp[][4],  }
> > >  
> > >  static int alps_update_dual_info_ss4_v2(unsigned char otp[][4],
> > > -				       struct alps_data *priv)
> > > +				       struct alps_data *priv,
> > > +					struct psmouse *psmouse)
> > >  {
> 
> You can access psmouse from the priv structure as:
> 
>   struct psmouse *psmouse = priv->psmouse;
> 
> Therefore you do not have to extend function parameters with psmouse pointer as that is already present int alps_data.
> 
> struct alps_data is defined as:
> 
> struct alps_data {
> 	struct psmouse *psmouse;
> 	...
> }
> 
> > >  	bool is_dual = false;
> > > +	int reg_val = 0;
> > > +	struct ps2dev *ps2dev = &psmouse->ps2dev;
> > >  
> > > -	if (IS_SS4PLUS_DEV(priv->dev_id))
> > > +	if (IS_SS4PLUS_DEV(priv->dev_id)) {
> > >  		is_dual = (otp[0][0] >> 4) & 0x01;
> > >  
> > > +		if (!is_dual) {
> > > +			/* For support TrackStick of Thinkpad L/E series */
> > > +			if (alps_exit_command_mode(psmouse) == 0 &&
> > > +				alps_enter_command_mode(psmouse) == 0) {
> > > +				reg_val = alps_command_mode_read_reg(psmouse,
> > > +									0xD7);
> > > +			}
> > > +			alps_exit_command_mode(psmouse);
> > > +			ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
> > > +
> > > +			if (reg_val == 0x0C || reg_val == 0x1D)
> > > +				is_dual = true;
> > > +		}
> > > +	}
> > > +
> > >  	if (is_dual)
> > >  		priv->flags |= ALPS_DUALPOINT |
> > >  					ALPS_DUALPOINT_WITH_PRESSURE;
> > > @@ -2570,7 +2588,7 @@ static int alps_set_defaults_ss4_v2(struct 
> > > psmouse *psmouse,
> > >  
> > >  	alps_update_btn_info_ss4_v2(otp, priv);
> > >  
> > > -	alps_update_dual_info_ss4_v2(otp, priv);
> > > +	alps_update_dual_info_ss4_v2(otp, priv, psmouse);
> > 
> > Now looking at this change... Is there reason why you are passing psmouse parameter there? Because struct alps_data contains psmouse member.
> > 
> > >  
> > >  	return 0;
> > >  }
> > 
> > --
> > Pali Rohár
> > pali.rohar@gmail.com
> 
> --
> Pali Rohár
> pali.rohar@gmail.com

-- 
Pali Rohár
pali.rohar@gmail.com
