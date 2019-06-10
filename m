From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRD?= =?utf-8?Q?H?=
 =?utf-8?Q?=5D?= input: alps-fix the issue alps cs19 trackstick do not work.
Date: Mon, 10 Jun 2019 12:43:10 +0200
Message-ID: <20190610104310.qa5snt7jpcljodfv@pali>
References: <20190527094422.7558-1-sliuuxiaonxiao@gmail.com>
 <20190527100913.sgxrjrmphsjfmcdb@pali>
 <OSBPR01MB4855F61AE28B883CDD87F781DA1E0@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <20190528071824.jimhixhtsynzwixe@pali>
 <OSBPR01MB48556FD88D7F7D5F91CB5579DA1E0@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <OSBPR01MB4855707AC8ABB7CFBE5BBBD5DA130@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <OSBPR01MB4855A2A30A4F5E6BDCFE715FDA130@OSBPR01MB4855.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4855A2A30A4F5E6BDCFE715FDA130@OSBPR01MB4855.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiaoxiao Liu <xiaoxiao.liu-1@cn.alps.com>
Cc: XiaoXiao Liu <sliuuxiaonxiao@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "peter.hutterer@who-t.net" <peter.hutterer@who-t.net>, "hui.wang@canonical.com" <hui.wang@canonical.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaojian Cao <xiaojian.cao@cn.alps.com>, "zhangfp1@lenovo.com" <zhangfp1@lenovo.com>, Naoki Saito <naoki.saito@alpsalpine.com>, Hideo Kawase <hideo.kawase@alpsalpine.com>
List-Id: linux-input@vger.kernel.org

On Monday 10 June 2019 10:03:51 Xiaoxiao Liu wrote:
> Hi Pali,

Hi!

> We register our CS19 device as ALPS_ONLY_TRACKSTICK device.
> And let the V8 protocol function support the process of ALPS_ONLY_TRACKSTICK device. 
> 
> I want to confirm if this solution OK?

Yes, it is fine. Just make sure that touchapad input device is not
registered when this ALPS_ONLY_TRACKSTICK flag is set. So userspace
would not see any fake/unavailable touchpad input device.

> Xiaoxiao.Liu

-- 
Pali Rohár
pali.rohar@gmail.com
