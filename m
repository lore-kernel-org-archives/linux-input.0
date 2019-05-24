From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?=
 =?utf-8?B?5aSNOiBbUEFUQ0hdIGlucHV0?= =?utf-8?Q?=3A?= alps-fix the issue the
 special alps trackpoint do not work.
Date: Fri, 24 May 2019 19:32:38 +1000
Message-ID: <20190524093238.GA1119@jelly>
References: <20190521094622.syeub6tcqhbyc7sg@pali>
 <OSBPR01MB4855D744473149D037612506DA000@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <20190522063546.kb74mxeprkauicul@pali>
 <OSBPR01MB48550B43F78BBFBDC20D414DDA000@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <20190522074030.64sy7xt3wnomtxjb@pali>
 <20190523060154.GA10526@jelly>
 <38ec4a40-d51a-aeb1-a5e8-dbaed1142298@canonical.com>
 <20190524053648.GA16379@jelly>
 <d1fd207d-68e1-0b57-f0dc-c254bfc9352c@canonical.com>
 <20190524072648.6zqgz7rpwpcv22pb@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190524072648.6zqgz7rpwpcv22pb@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hui Wang <hui.wang@canonical.com>, Xiaoxiao Liu <xiaoxiao.liu-1@cn.alps.com>, dmitry.torokhov@gmail.com, XiaoXiao Liu <sliuuxiaonxiao@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaojian Cao <xiaojian.cao@cn.alps.com>, "zhangfp1@lenovo.com" <zhangfp1@lenovo.com>
List-Id: linux-input@vger.kernel.org

On Fri, May 24, 2019 at 09:26:48AM +0200, Pali Rohár wrote:
> On Friday 24 May 2019 13:50:53 Hui Wang wrote:
> > On 2019/5/24 下午1:36, Peter Hutterer wrote:
> > > On Fri, May 24, 2019 at 01:25:52PM +0800, Hui Wang wrote:
> > > > On 2019/5/23 下午2:01, Peter Hutterer wrote:
> > > > > On Wed, May 22, 2019 at 09:40:30AM +0200, Pali Rohár wrote:
> > > > > > On Wednesday 22 May 2019 07:30:43 Xiaoxiao Liu wrote:
> > > > > > > Hi Pali,
> > > > > > > 
> > > > > > > Ok, and cannot you set ALPS_DUALPOINT flag based on that
> > > > > > > alps_check_is_trackpoint() result and then update
> > > > > > > alps_process_packet_ss4_v3() code to supports also
> > > > > > > V8 trackpoint packets?
> > > > > > > --> Yes, we can do like so, when we use the v8 method to process the trackpoint , the mouse speed is not ideal.
> > > > > > >         Then we choose the standard mouse driver.
> > > > > > Mouse speed is something which is configurable. Have you configured it
> > > > > > somehow? Also there is libinput project should handle these settings
> > > > > > more properly.
> > > > > > 
> > > > > > Adding Peter Hutterer, maintainer of libinput to loop. I think he could
> > > > > > help with this problem.
> > > > > libinput has a quirk for a magic multiplier on trackpoints. it was the only
> > > > > solution I found that came close to "working" given that every device seems
> > > > > to provide some other random magic data. Doc for it is here:
> > > > > https://wayland.freedesktop.org/libinput/doc/latest/trackpoint-configuration.html
> > > > Hello Peter Hutterer,
> > > > 
> > > > To adjust the trackpoint speed from userspace:
> > > > 
> > > > If the libinput version is lower than 1.9.0, we could set
> > > > POINTINGSTICK_CONST_ACCEL=0.25
> > > > 
> > > > If the libinput version is higher than 1.12.0, we could set
> > > > AttrTrackpointMultiplier=0.25
> > > > 
> > > > But if we use libinput-1.10.0,  how could we adjust the speed?
> > > The LIBINPUT_ATTR_TRACKPOINT_RANGE property, which didn't end up working
> > > well (hence why it got replaced again). See the docs here though:
> > > https://wayland.freedesktop.org/libinput/doc/1.10.0/trackpoints.html
> > > 
> > > Cheers,
> > >     Peter
> > 
> > OK, got it, Thanks.
> 
> Is not here some database where for input device name / id is specified
> that property? So users do not have to invent what is correct value for
> their hardware?

yeah, libinput ships with a quirks database that sets those, but it relies
on users to submit the quirks.
https://gitlab.freedesktop.org/libinput/libinput/tree/master/quirks
There's no "correct" value anyway, if you ask 3 users what the trackpoint
should do you'll get 5 answers :)

Cheers,
   Peter
