From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Trackpoint on Thinkpad X1 Carbon (5th gen)
Date: Tue, 6 Jun 2017 23:34:59 -0700
Message-ID: <20170607063459.GC23434@dtor-ws>
References: <CAEk1YH5dPPQfMEq650cUX1p4QrOUzR0oSSBombtFQLKV--ix2A@mail.gmail.com>
 <CAEk1YH7589yXnMJkmn+NMr45KZruGdW58xXVm-r47uy_W=ynwg@mail.gmail.com>
 <CAKdAkRTcgg2g2mmN3PTKf1ZhKHJ5nsE4z_LDjZ=tOqcoUoZ8Mg@mail.gmail.com>
 <CAEk1YH54DWWonBcMKaz17+O_UOaWFSm-FWZchUpkT+czVwS93Q@mail.gmail.com>
 <KAWPR01MB1092B90F0C1C12D5E3C40DB5C7CA0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <20170606074909.GU1293@mail.corp.redhat.com>
 <20170606174154.GA19288@dtor-ws>
 <KAWPR01MB1092C1EB3F32076C67F72F50C7C80@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35181 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdFGGfC (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 02:35:02 -0400
Received: by mail-pg0-f50.google.com with SMTP id k71so2004664pgd.2
        for <linux-input@vger.kernel.org>; Tue, 06 Jun 2017 23:35:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <KAWPR01MB1092C1EB3F32076C67F72F50C7C80@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Damjan Georgievski <gdamjan@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, Jun 07, 2017 at 01:18:14AM +0000, Masaki Ota wrote:
> Hi, Dmitry,
> 
> About this device, we don't have a way to check whether a device is Trackpoint only or TrackPoint +Touchpad.

I see. Then I guess we are better off keeping it in PS/2 compatibility
mode.

Thank you for looking into this.

> 
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
> Sent: Wednesday, June 07, 2017 2:42 AM
> To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>; Damjan Georgievski <gdamjan@gmail.com>; linux-input@vger.kernel.org
> Subject: Re: Trackpoint on Thinkpad X1 Carbon (5th gen)
> 
> On Tue, Jun 06, 2017 at 09:49:09AM +0200, Benjamin Tissoires wrote:
> > Hi,
> > 
> > On Jun 05 2017 or thereabouts, Masaki Ota wrote:
> > > Hi, Damjan,
> > > 
> > > Latest X1 Carbon system has two TrackPoint venders.
> > > One is Alps, the other is Elantech. ( Touchpad is only Synaptics.)
> > > 
> > > To detect the device, we can send "E1" command by using pass-through.
> > > The device response is as below.
> > > If Alps, E1 -> 02
> > > If Elantech, E1-> 01
> 
> Masaki, is there a way to for ALPS driver to determine whether we are dealing with a trackpoint-only or a touchpad + trackpoint combo?
> 
> > > 
> > > It's a spec, but I have not checked it.
> > 
> > Thanks. This made me realize that we have a difference between the 
> > PS/2 handling of the touchpad and the RMI4 use: in the PS/2 protocol, 
> > we mark the pass-through device as such by using SERIO_PS_PSTHRU.
> > While in RMI4, we mark it as if it was a platform device, meaning we 
> > check on every protocol.
> > 
> > Damjan, would you mind trying the following change:
> > diff --git a/drivers/input/rmi4/rmi_f03.c 
> > b/drivers/input/rmi4/rmi_f03.c index 77dad04..ad71a5e 100644
> > --- a/drivers/input/rmi4/rmi_f03.c
> > +++ b/drivers/input/rmi4/rmi_f03.c
> > @@ -146,7 +146,7 @@ static int rmi_f03_register_pt(struct f03_data *f03)
> >         if (!serio)
> >                 return -ENOMEM;
> >  
> > -       serio->id.type = SERIO_8042;
> > +       serio->id.type = SERIO_PS_PSTHRU;
> 
> No, you do not want to do this. psmouse-base has more logic than just selecting protocols to probe keyed off SERIO_PS_PSTHRU.
> 
> Also, if we are not seeing ALPS and Elantech devices behind pass-through ports we need to add them to the list of devices probed on pass-through ports anyway. Although, since we do not handle Elantech or ALPS tracksticks any differently than generic mouse (unlike IBM Trackpoints that we know how to control enhanced features), maybe not probing them as ALPS and Elantech will allow us to keep faster probing...
> 
> >         serio->write = rmi_f03_pt_write;
> >         serio->port_data = f03;
> > 
> > ---
> > 
> > If this gives equal results than when using synaptics_intertouch=0, 
> > then I guess this will be a good candidate for an rc.
> > 
> > Cheers,
> > Benjamin
> > 
> > > 
> > > By the way, TrackPoint speed might be different between Alps and Elan.
> > > And Middle Button Click behavior without a driver is the same as Mouse middle click.
> > > 
> > > Best Regards,
> > > Masaki Ota
> > > -----Original Message-----
> > > From: Damjan Georgievski [mailto:gdamjan@gmail.com]
> > > Sent: Friday, June 02, 2017 7:47 PM
> > > To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input@vger.kernel.org; Benjamin Tissoires 
> > > <benjamin.tissoires@redhat.com>; 太田 真喜 Masaki Ota 
> > > <masaki.ota@jp.alps.com>
> > > Subject: Re: Trackpoint on Thinkpad X1 Carbon (5th gen)
> > > 
> > > On 30 May 2017 at 19:24, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > On Tue, May 23, 2017 at 11:12 AM, Damjan Georgievski <gdamjan@gmail.com> wrote:
> > > >> On 19 May 2017 at 22:12, Damjan Georgievski <gdamjan@gmail.com> wrote:
> > > >>> Hi all,
> > > >>> the trackpoint on the  Thinkpad X1 Carbon (5th gen) (model 20HQ) 
> > > >>> is recognised as:
> > > >>> "ImPS/2 Generic Wheel Mouse" while typically it should be 
> > > >>> "TPPS/2 IBM TrackPoint".
> > > >>
> > > >> the following patch[1] adds the X1 Carbon gen 5 to work with the 
> > > >> rmi4_smbus support, there are some issues though:
> > > >> - the touchpad _seems_ to be working a bit better (at least 
> > > >> that's what I feel like)
> > > >> - the trackpoint moves too fast
> > > >> - middle click scrolling is not enabled and can't be set with 
> > > >> xinput
> > > >>
> > > >> Can I do someting to improve/test the trackpoint issues, before 
> > > >> submiting this for merging?
> > > >>
> > > >> ps.
> > > >> also, when this is aplied the touchpad and trackpoint are 
> > > >> recognized as
> > > >>> ⎜   ↳ AlpsPS/2 ALPS DualPoint Stick             id=12   [slave  pointer  (2)]
> > > >>> ⎜   ↳ AlpsPS/2 ALPS DualPoint TouchPad          id=14   [slave  pointer  (2)]
> > > >
> > > > This is surprising that device on F03 pass-through port managed to 
> > > > respond to ALPS queries...
> > > 
> > > 
> > > actually the touchpad seems to be recognized as
> > > ⎜   ↳ Synaptics TM3289-002                      id=12   [slave  pointer  (2)]
> > > 
> > > and the other two ALPS devices are the trackpoint and its buttons 
> > > (which I beleive are connected to the touchpad)
> > > 
> > > 
> > > > Masaki, is there a chance to make ALPS detection more robust here 
> > > > as I do not believe we are dealing with ALPS device here.
> > > 
> > > 
> > > Is there anything else I can test?
> > > 
> > > 
> > > 
> > > --
> > > damjan
> 
> --
> Dmitry

-- 
Dmitry
