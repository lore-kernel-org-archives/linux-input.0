From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiDnrZTlpI06IFtQQVRDSA==?= =?utf-8?Q?=5D?= input: alps-fix the
 issue alps cs19 trackstick do not work.
Date: Mon, 17 Jun 2019 09:49:02 +0200
Message-ID: <20190617074902.bg2emodbmjkkfldd@pali>
References: <20190610104310.qa5snt7jpcljodfv@pali>
 <OSBPR01MB485504868362073ED434F82FDAED0@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <ed65f8af-fefb-3c40-e7b1-dde3605f30e3@canonical.com>
 <5587ddb9-fb5f-03db-ac11-a696c85c5f2f@canonical.com>
 <20190611072333.nd4va4q2m5epmukc@pali>
 <20190611170707.GA143729@dtor-ws>
 <20190611171707.tydk7rsmtzmjohky@pali>
 <20190611173228.GD143729@dtor-ws>
 <20190611173856.jjwoagud6doxvpy3@pali>
 <OSBPR01MB4855BD8471A591BD75BDECA0DAEB0@OSBPR01MB4855.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4855BD8471A591BD75BDECA0DAEB0@OSBPR01MB4855.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiaoxiao Liu <xiaoxiao.liu-1@cn.alps.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Hui Wang <hui.wang@canonical.com>, XiaoXiao Liu <sliuuxiaonxiao@gmail.com>, "peter.hutterer@who-t.net" <peter.hutterer@who-t.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaojian Cao <xiaojian.cao@cn.alps.com>, "zhangfp1@lenovo.com" <zhangfp1@lenovo.com>, Naoki Saito <naoki.saito@alpsalpine.com>, Hideo Kawase <hideo.kawase@alpsalpine.com>
List-Id: linux-input@vger.kernel.org

On Monday 17 June 2019 01:29:17 Xiaoxiao Liu wrote:
> Hi Pali,
> 
> Since design architecture change of CS19, input device connection has been changed to below architecture, 
> Touchpad has been moved to I2C connection.
> 
>   kernel/host  <--PS/2-->  EC  <--PS/2-->  external PS/2 mouse
>            |                 |
>            |                <--PS/2-->  trackstick
>                |
>                 <--I2C-->  Touchpad

Hi, thank you for explanation!

So in our case, ALPS device should not be put into passthrough mode as
there is no device after it.

> In the past TrackPoint does not show in the device list because of TrackPoint was hidden device of Touchpad.
> But from CS19, TrackPoint is directly connecting with PS2 port, 
> 3 bytes packet does not need to take affect by other vendors Touchpad format. 
> So alps.c is no need for CS19 device.

So if trackpoint.c driver is working fine with this configuration, it is
just needed to instruct alps.c to not take this device.

> Best Regards
> Shona
> -----邮件原件-----
> 发件人: Pali Rohár <pali.rohar@gmail.com> 
> 发送时间: Wednesday, June 12, 2019 1:39 AM
> 收件人: dmitry.torokhov@gmail.com
> 抄送: Hui Wang <hui.wang@canonical.com>; 劉 曉曉 Xiaoxiao Liu <xiaoxiao.liu-1@cn.alps.com>; XiaoXiao Liu <sliuuxiaonxiao@gmail.com>; peter.hutterer@who-t.net; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; 曹 曉建 Xiaojian Cao <xiaojian.cao@cn.alps.com>; zhangfp1@lenovo.com; 斉藤 直樹 Naoki Saito <naoki.saito@alpsalpine.com>; 川瀬 英夫 Hideo Kawase <hideo.kawase@alpsalpine.com>
> 主题: Re: 答复: 答复: 答复: [PATCH] input: alps-fix the issue alps cs19 trackstick do not work.
> 
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
> > > > > > > > We think the V8 method means a touchpad feature  and does 
> > > > > > > > not fit the CS19 trackpoint device.
> > > > > > > > CS19 TrackPoint needn't  use any Absolute (Raw) mode and 
> > > > > > > > is usually use standard mouse data.
> > > > > > > > CS19 TrackPoint device is a completely different device 
> > > > > > > > with DualPoint device of Dell/HP.
> > > > > > > > CS19 TrackPoint device is independent  of Touchpad. 
> > > > > > > > (Touchpad is connecting by I2C, TrackPoint is directly 
> > > > > > > > connecting with PS2 port.) And it has completely another FW.
> > > > > > > > 
> > > > > > > > So we think it is better to use the mouse mode for CS19 trackpoint.
> > > > > > > 
> > > > > > > Maybe here is some mis-understanding,  the mouse mode here 
> > > > > > > doesn't mean we use psmouse-base.c for cs19 (bare ps/2 
> > > > > > > mouse), we plan to use trackpoint.c to drive this HW, so 
> > > > > > > this trackpoint has all features a trackpoint should have.
> > > > > > > 
> > > > > > And I sent a patch one month ago to let the the trackpoint.c 
> > > > > > to drive this
> > > > > > HW: https://www.spinics.net/lists/linux-input/msg61341.html, 
> > > > > > maybe that patch is reference.
> > > > > 
> > > > > So instead of creating blacklist, you should check for 
> > > > > TP_VARIANT_ALPS in alps.c and disallow its usage.
> > > > > 
> > > > > Or maybe better, move trackpoint.c detect code before alsp.c 
> > > > > detect code in psmouse-base. And no changes in alps.c are needed.
> > > > 
> > > > I'd be very cautions of moving around the protocol detection. It 
> > > > is very fragile, so if we can detect trackpoint-only case in 
> > > > alps.c and skip on to trackpoint I would prefer it.
> > > 
> > > The main problem is that proposed trackpoint-only check in alps.c is 
> > > basically what trackpoint.c is doing for checking if device is 
> > > trackpoint (via function trackpoint_start_protocol()).
> > > 
> > > So I'm not sure now what is the best solution...
> > 
> > Unfortunately currently trackpoint is being probed only after we tried 
> > Elan, Genius, and Logitech PS2++ protocols, and I am not sure if 
> > moving trackpoint around will disturb them or not.
> > 
> > I do not think there is much code duplication by pulling limited 
> > version of trackpoint detection code into alps.c and then have it bail 
> > out when it sees trackpoint-only device so trackpoint.c can handle it properly.
> 
> Ok. Seems that it is the best solution.
> 
> The last question is, should be use ALPS or Trackpoint protocol? Because it looks like that device can be configured to one or other.
> 
> What are pros and cons of these two protocols?
> 
> --
> Pali Rohár
> pali.rohar@gmail.com

-- 
Pali Rohár
pali.rohar@gmail.com
