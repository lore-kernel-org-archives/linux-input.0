From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= input: alps-fix the issue alps
 cs19 trackstick do not work.
Date: Tue, 11 Jun 2019 10:45:07 -0700
Message-ID: <20190611174507.GF143729@dtor-ws>
References: <OSBPR01MB4855A2A30A4F5E6BDCFE715FDA130@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <20190610104310.qa5snt7jpcljodfv@pali>
 <OSBPR01MB485504868362073ED434F82FDAED0@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <ed65f8af-fefb-3c40-e7b1-dde3605f30e3@canonical.com>
 <5587ddb9-fb5f-03db-ac11-a696c85c5f2f@canonical.com>
 <20190611072333.nd4va4q2m5epmukc@pali>
 <20190611170707.GA143729@dtor-ws>
 <20190611171707.tydk7rsmtzmjohky@pali>
 <20190611173228.GD143729@dtor-ws>
 <20190611173856.jjwoagud6doxvpy3@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190611173856.jjwoagud6doxvpy3@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hui Wang <hui.wang@canonical.com>, Xiaoxiao Liu <xiaoxiao.liu-1@cn.alps.com>, XiaoXiao Liu <sliuuxiaonxiao@gmail.com>, "peter.hutterer@who-t.net" <peter.hutterer@who-t.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaojian Cao <xiaojian.cao@cn.alps.com>, "zhangfp1@lenovo.com" <zhangfp1@lenovo.com>, Naoki Saito <naoki.saito@alpsalpine.com>, Hideo Kawase <hideo.kawase@alpsalpine.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 11, 2019 at 07:38:56PM +0200, Pali Rohár wrote:
> On Tuesday 11 June 2019 10:32:28 dmitry.torokhov@gmail.com wrote:
> > On Tue, Jun 11, 2019 at 07:17:07PM +0200, Pali Rohár wrote:
> > > On Tuesday 11 June 2019 10:07:07 dmitry.torokhov@gmail.com wrote:
> > > > On Tue, Jun 11, 2019 at 09:23:33AM +0200, Pali Rohár wrote:
> > > > > On Tuesday 11 June 2019 12:32:33 Hui Wang wrote:
> > > > > > On 2019/6/11 上午11:23, Hui Wang wrote:
> > > > > > > On 2019/6/11 上午11:05, Xiaoxiao Liu wrote:
> > > > > > > > Hi Pali,
> > > > > > > > 
> > > > > > > > I discussed with our FW team about this problem.
> > > > > > > > We think the V8 method means a touchpad feature  and does not fit
> > > > > > > > the CS19 trackpoint device.
> > > > > > > > CS19 TrackPoint needn't  use any Absolute (Raw) mode and is usually
> > > > > > > > use standard mouse data.
> > > > > > > > CS19 TrackPoint device is a completely different device with
> > > > > > > > DualPoint device of Dell/HP.
> > > > > > > > CS19 TrackPoint device is independent  of Touchpad. (Touchpad is
> > > > > > > > connecting by I2C, TrackPoint is directly connecting with PS2 port.)
> > > > > > > > And it has completely another FW.
> > > > > > > > 
> > > > > > > > So we think it is better to use the mouse mode for CS19 trackpoint.
> > > > > > > 
> > > > > > > Maybe here is some mis-understanding,  the mouse mode here doesn't mean
> > > > > > > we use psmouse-base.c for cs19 (bare ps/2 mouse), we plan to use
> > > > > > > trackpoint.c to drive this HW, so this trackpoint has all features a
> > > > > > > trackpoint should have.
> > > > > > > 
> > > > > > And I sent a patch one month ago to let the the trackpoint.c to drive this
> > > > > > HW: https://www.spinics.net/lists/linux-input/msg61341.html, maybe that
> > > > > > patch is reference.
> > > > > 
> > > > > So instead of creating blacklist, you should check for TP_VARIANT_ALPS
> > > > > in alps.c and disallow its usage.
> > > > > 
> > > > > Or maybe better, move trackpoint.c detect code before alsp.c detect code
> > > > > in psmouse-base. And no changes in alps.c are needed.
> > > > 
> > > > I'd be very cautions of moving around the protocol detection. It is very
> > > > fragile, so if we can detect trackpoint-only case in alps.c and skip on
> > > > to trackpoint I would prefer it.
> > > 
> > > The main problem is that proposed trackpoint-only check in alps.c is
> > > basically what trackpoint.c is doing for checking if device is
> > > trackpoint (via function trackpoint_start_protocol()).
> > > 
> > > So I'm not sure now what is the best solution...
> > 
> > Unfortunately currently trackpoint is being probed only after we tried
> > Elan, Genius, and Logitech PS2++ protocols, and I am not sure if moving
> > trackpoint around will disturb them or not.
> > 
> > I do not think there is much code duplication by pulling limited version
> > of trackpoint detection code into alps.c and then have it bail out when
> > it sees trackpoint-only device so trackpoint.c can handle it properly.
> 
> Ok. Seems that it is the best solution.
> 
> The last question is, should be use ALPS or Trackpoint protocol? Because
> it looks like that device can be configured to one or other.
> 
> What are pros and cons of these two protocols?

As far as I know the device implements trackpoint protocol, although not
complete version. Several manufacturers started making trackponts once
IBM/Lenovo patents on the original one expired (I think).

The data stream is regular relative PS/2, bit it allows controlling
device behavior a bit, such as press-to-select option and device
sensitivity. IBM/Lenovo version has many more parameters.

Thanks.

-- 
Dmitry
