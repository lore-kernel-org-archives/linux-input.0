From: Hui Wang <hui.wang@canonical.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IFtQQVRDSF0gaW5wdXQ6?=
 =?UTF-8?Q?_alps-fix_the_issue_the_special_alps_trackpoint_do_not_work=2e?=
Date: Sat, 25 May 2019 09:33:46 +0800
Message-ID: <721b91b0-f231-5f7d-a438-09dd85f63513@canonical.com>
References: <OSBPR01MB48550B43F78BBFBDC20D414DDA000@OSBPR01MB4855.jpnprd01.prod.outlook.com>
 <20190522074030.64sy7xt3wnomtxjb@pali> <20190523060154.GA10526@jelly>
 <38ec4a40-d51a-aeb1-a5e8-dbaed1142298@canonical.com>
 <20190524053648.GA16379@jelly>
 <d1fd207d-68e1-0b57-f0dc-c254bfc9352c@canonical.com>
 <20190524072648.6zqgz7rpwpcv22pb@pali>
 <d0b659bf-e6ed-bbbb-a3ab-17daf525a577@canonical.com>
 <20190524093729.GB1119@jelly>
 <f0c2dff9-519e-d54d-4cd0-2be666656dc2@canonical.com>
 <20190524105822.GA3358@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190524105822.GA3358@jelly>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Xiaoxiao Liu <xiaoxiao.liu-1@cn.alps.com>, dmitry.torokhov@gmail.com, XiaoXiao Liu <sliuuxiaonxiao@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Xiaojian Cao <xiaojian.cao@cn.alps.com>, "zhangfp1@lenovo.com" <zhangfp1@lenovo.com>
List-Id: linux-input@vger.kernel.org


On 2019/5/24 下午6:58, Peter Hutterer wrote:
> On Fri, May 24, 2019 at 06:43:58PM +0800, Hui Wang wrote:
>> On 2019/5/24 下午5:37, Peter Hutterer wrote:
>>> On Fri, May 24, 2019 at 03:37:57PM +0800, Hui Wang wrote:
>>>>
>> OK, that is sth we need to do.  But anyway it is a bit risky to backport
>> that much code and the whole folder of quirks to libinput 1.10.4,  we need
>> to do lots of test to make sure there is no regression on other machines.
>>
>> Probably we only need to keep the quirks/30-vendor-alps.quirks to 1.10.4 and
>> drop other quirks, that will be better for our testing effort.
> might be worth looking at what is in 1.10.7, e.g.  a3b3e85c0e looks like it
> may be of interest. That one suggests the range on some ALPS devices is over
> 100, so testing with 5-25 may really not have had any effect.

Oh, looks exactly the same as our issue, will have a try with it.

Thanks,

Hui.


>
> Cheers,
>     Peter
>
