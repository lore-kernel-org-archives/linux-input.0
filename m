From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBbUEFUQ0hdIGlucHV0?= =?utf-8?Q?=3A?= alps-fix the issue the
 special alps trackpoint do not work.
Date: Fri, 24 May 2019 15:36:48 +1000
Message-ID: <20190524053648.GA16379@jelly>
References: <20190520110149.27107-1-sliuuxiaonxiao@gmail.com>
 <OSBPR01MB485510A2A32CD9D2CE5EF7A1DA070@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <345b62e1-407e-7a03-9b03-486bbf5a0a8e@canonical.com>
 <20190521094622.syeub6tcqhbyc7sg@pali>
 <OSBPR01MB4855D744473149D037612506DA000@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <20190522063546.kb74mxeprkauicul@pali>
 <OSBPR01MB48550B43F78BBFBDC20D414DDA000@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <20190522074030.64sy7xt3wnomtxjb@pali>
 <20190523060154.GA10526@jelly>
 <38ec4a40-d51a-aeb1-a5e8-dbaed1142298@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <38ec4a40-d51a-aeb1-a5e8-dbaed1142298@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hui Wang <hui.wang@canonical.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Xiaoxiao Liu <xiaoxiao.liu-1@cn.alps.com>, dmitry.torokhov@gmail.com, XiaoXiao Liu <sliuuxiaonxiao@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaojian Cao <xiaojian.cao@cn.alps.com>, "zhangfp1@lenovo.com" <zhangfp1@lenovo.com>
List-Id: linux-input@vger.kernel.org

On Fri, May 24, 2019 at 01:25:52PM +0800, Hui Wang wrote:
> 
> On 2019/5/23 下午2:01, Peter Hutterer wrote:
> > On Wed, May 22, 2019 at 09:40:30AM +0200, Pali Rohár wrote:
> > > On Wednesday 22 May 2019 07:30:43 Xiaoxiao Liu wrote:
> > > > Hi Pali,
> > > > 
> > > > Ok, and cannot you set ALPS_DUALPOINT flag based on that
> > > > alps_check_is_trackpoint() result and then update
> > > > alps_process_packet_ss4_v3() code to supports also
> > > > V8 trackpoint packets?
> > > > --> Yes, we can do like so, when we use the v8 method to process the trackpoint , the mouse speed is not ideal.
> > > >        Then we choose the standard mouse driver.
> > > Mouse speed is something which is configurable. Have you configured it
> > > somehow? Also there is libinput project should handle these settings
> > > more properly.
> > > 
> > > Adding Peter Hutterer, maintainer of libinput to loop. I think he could
> > > help with this problem.
> > libinput has a quirk for a magic multiplier on trackpoints. it was the only
> > solution I found that came close to "working" given that every device seems
> > to provide some other random magic data. Doc for it is here:
> > https://wayland.freedesktop.org/libinput/doc/latest/trackpoint-configuration.html
> 
> Hello Peter Hutterer,
> 
> To adjust the trackpoint speed from userspace:
> 
> If the libinput version is lower than 1.9.0, we could set
> POINTINGSTICK_CONST_ACCEL=0.25
> 
> If the libinput version is higher than 1.12.0, we could set
> AttrTrackpointMultiplier=0.25
> 
> But if we use libinput-1.10.0,  how could we adjust the speed?

The LIBINPUT_ATTR_TRACKPOINT_RANGE property, which didn't end up working
well (hence why it got replaced again). See the docs here though:
https://wayland.freedesktop.org/libinput/doc/1.10.0/trackpoints.html

Cheers,
   Peter

> > 
> > There are also different speeds depending on which xorg driver you'd use (or
> > libinput/Wayland), so a "mouse speed is not ideal" is almost a guarantee,
> > given a large enough variety of setups :) That's why we have the speed
> > toggle, but I'm happy to hear any suggestions on how to make the trackpoint
> > more useful (in libinput anyway).
> > 
> > > I do not think it is a good idea to force back to generic PS/2 mouse
> > > driver for touchpads and trackpoints. Native drivers for touchpads and
> > > trackpoints supports multitouch, absolute reporting and lot of other
> > > things... Also calculation of mouse speed from absolute positions on
> > > touchpads can be more easily fixed as from emulated relative movements.
> > Yeah, agree. Using PS/2 mouse drivers means you lose *all* the extra
> > features touchpads have like palm detection, tapping, scrolling, gestures,
> > etc.
> > 
> > Cheers,
> >     Peter
> > 
> > > Dmitry, what is your opinion about this problem? What should psmouse.ko
> > > do in this situation? Disallow usage of absolute mode and force bare
> > > PS/2 relative mode?
> > 
