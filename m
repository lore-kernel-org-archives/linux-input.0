From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= input: alps-fix
 the issue alps cs19 trackstick do not work.
Date: Tue, 28 May 2019 09:18:24 +0200
Message-ID: <20190528071824.jimhixhtsynzwixe@pali>
References: <20190527094422.7558-1-sliuuxiaonxiao@gmail.com>
 <20190527100913.sgxrjrmphsjfmcdb@pali>
 <OSBPR01MB4855F61AE28B883CDD87F781DA1E0@OSBPR01MB4855.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4855F61AE28B883CDD87F781DA1E0@OSBPR01MB4855.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiaoxiao Liu <xiaoxiao.liu-1@cn.alps.com>
Cc: XiaoXiao Liu <sliuuxiaonxiao@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "peter.hutterer@who-t.net" <peter.hutterer@who-t.net>, "hui.wang@canonical.com" <hui.wang@canonical.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaojian Cao <xiaojian.cao@cn.alps.com>, "zhangfp1@lenovo.com" <zhangfp1@lenovo.com>, Naoki Saito <naoki.saito@alpsalpine.com>
List-Id: linux-input@vger.kernel.org

On Tuesday 28 May 2019 01:37:14 Xiaoxiao Liu wrote:
> Add Saito-san.
> 
> Hi Hui,
> Does it mean that your device (reported to kernel) sends only trackstick packets and not touchpad?
>    	-> Yes.

Ok, I think this answers all questions.

So your patch is not correct as it registers "fake" touchpad device even
there is no touchpad at all.

You should fix your patch to not register touchpad input device, in your
case it should register only trackstick device. I suggest to add some
flag which would indicate such device (e.g. ALPS_ONLY_TRACKSTICK).

Also currently kernel exports following names when device has both
trackstick and touchpad: "DualPoint Stick" and "DualPoint TouchPad".
And it exports name "GlidePoint" for touchpad-only device. So to be
consistent you need to also modify this code for trackstick-only device.

-- 
Pali Rohár
pali.rohar@gmail.com
