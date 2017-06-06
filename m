From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: Trackpoint on Thinkpad X1 Carbon (5th gen)
Date: Tue, 6 Jun 2017 09:49:09 +0200
Message-ID: <20170606074909.GU1293@mail.corp.redhat.com>
References: <CAEk1YH5dPPQfMEq650cUX1p4QrOUzR0oSSBombtFQLKV--ix2A@mail.gmail.com>
 <CAEk1YH7589yXnMJkmn+NMr45KZruGdW58xXVm-r47uy_W=ynwg@mail.gmail.com>
 <CAKdAkRTcgg2g2mmN3PTKf1ZhKHJ5nsE4z_LDjZ=tOqcoUoZ8Mg@mail.gmail.com>
 <CAEk1YH54DWWonBcMKaz17+O_UOaWFSm-FWZchUpkT+czVwS93Q@mail.gmail.com>
 <KAWPR01MB1092B90F0C1C12D5E3C40DB5C7CA0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58268 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751285AbdFFHtQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 6 Jun 2017 03:49:16 -0400
Content-Disposition: inline
In-Reply-To: <KAWPR01MB1092B90F0C1C12D5E3C40DB5C7CA0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>, Damjan Georgievski <gdamjan@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi,

On Jun 05 2017 or thereabouts, Masaki Ota wrote:
> Hi, Damjan,
> 
> Latest X1 Carbon system has two TrackPoint venders.
> One is Alps, the other is Elantech. ( Touchpad is only Synaptics.)
> 
> To detect the device, we can send "E1" command by using pass-through.
> The device response is as below.
> If Alps, E1 -> 02
> If Elantech, E1-> 01
> 
> It's a spec, but I have not checked it.

Thanks. This made me realize that we have a difference between the PS/2
handling of the touchpad and the RMI4 use: in the PS/2 protocol, we
mark the pass-through device as such by using SERIO_PS_PSTHRU.
While in RMI4, we mark it as if it was a platform device, meaning we
check on every protocol.

Damjan, would you mind trying the following change:
diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index 77dad04..ad71a5e 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -146,7 +146,7 @@ static int rmi_f03_register_pt(struct f03_data *f03)
        if (!serio)
                return -ENOMEM;
 
-       serio->id.type = SERIO_8042;
+       serio->id.type = SERIO_PS_PSTHRU;
        serio->write = rmi_f03_pt_write;
        serio->port_data = f03;

---

If this gives equal results than when using synaptics_intertouch=0, then
I guess this will be a good candidate for an rc.

Cheers,
Benjamin

> 
> By the way, TrackPoint speed might be different between Alps and Elan.
> And Middle Button Click behavior without a driver is the same as Mouse middle click.
> 
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Damjan Georgievski [mailto:gdamjan@gmail.com] 
> Sent: Friday, June 02, 2017 7:47 PM
> To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org; Benjamin Tissoires <benjamin.tissoires@redhat.com>; 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>
> Subject: Re: Trackpoint on Thinkpad X1 Carbon (5th gen)
> 
> On 30 May 2017 at 19:24, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Tue, May 23, 2017 at 11:12 AM, Damjan Georgievski <gdamjan@gmail.com> wrote:
> >> On 19 May 2017 at 22:12, Damjan Georgievski <gdamjan@gmail.com> wrote:
> >>> Hi all,
> >>> the trackpoint on the  Thinkpad X1 Carbon (5th gen) (model 20HQ) is 
> >>> recognised as:
> >>> "ImPS/2 Generic Wheel Mouse" while typically it should be "TPPS/2 
> >>> IBM TrackPoint".
> >>
> >> the following patch[1] adds the X1 Carbon gen 5 to work with the 
> >> rmi4_smbus support, there are some issues though:
> >> - the touchpad _seems_ to be working a bit better (at least that's 
> >> what I feel like)
> >> - the trackpoint moves too fast
> >> - middle click scrolling is not enabled and can't be set with xinput
> >>
> >> Can I do someting to improve/test the trackpoint issues, before 
> >> submiting this for merging?
> >>
> >> ps.
> >> also, when this is aplied the touchpad and trackpoint are recognized 
> >> as
> >>> ⎜   ↳ AlpsPS/2 ALPS DualPoint Stick             id=12   [slave  pointer  (2)]
> >>> ⎜   ↳ AlpsPS/2 ALPS DualPoint TouchPad          id=14   [slave  pointer  (2)]
> >
> > This is surprising that device on F03 pass-through port managed to 
> > respond to ALPS queries...
> 
> 
> actually the touchpad seems to be recognized as
> ⎜   ↳ Synaptics TM3289-002                      id=12   [slave  pointer  (2)]
> 
> and the other two ALPS devices are the trackpoint and its buttons (which I beleive are connected to the touchpad)
> 
> 
> > Masaki, is there a chance to make ALPS detection more robust here as I 
> > do not believe we are dealing with ALPS device here.
> 
> 
> Is there anything else I can test?
> 
> 
> 
> --
> damjan
