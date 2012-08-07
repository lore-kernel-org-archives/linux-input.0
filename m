From: Yann Cantin <yann.cantin@laposte.net>
Subject: Re: [RFC ebeam PATCH v3 0/2]
Date: Tue, 07 Aug 2012 03:45:59 +0200
Message-ID: <50207357.5080208@laposte.net>
References: <1344288104-20731-1-git-send-email-yann.cantin@laposte.net> <20120806214423.GC30355@kroah.com> <1743577.8bRY3CPqxH@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1743577.8bRY3CPqxH@dtor-d630.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Le 07/08/2012 00:09, Dmitry Torokhov a =E9crit :
> On Monday, August 06, 2012 02:44:23 PM Greg KH wrote:
>> On Mon, Aug 06, 2012 at 11:21:42PM +0200, Yann Cantin wrote:
>>> Hi,
>>>
>>> New USB input driver for eBeam devices.
>>>
>>> Currently, only the Luidia eBeam classic projection model is suppor=
ted.
>>> Edge model and a NEC interactive video-projector support planned fo=
r the
>>> end of the mounth.
>>>
>>> Patch 1 to blacklist the device for hid generic-usb.
>>>
>>> Patch 2 is the actual driver.
>>>
>>> Changes from previous :
>>> - switch to div64_s64 for portable 64/64-bits divisions
>=20
> Do you really need this much precision? It will be slower on 32 bits.=
=2E

Yes. I can give the details if you want (homography computation without
floating point maths).

>>> - some cosmetics in device name
>>> - unused include and def removed
>>> - variables name changes for readability
>>>
>>> Pending issues :
>>>
>>> - sysfs custom files : need to pass 13 parameters for calibration :
>>>   choice is between lots of simply-handled, or few with a big sscan=
f.
>>
>> sysfs is "one value per file", so use lots of different files please=
=2E
>=20
> This is kind of a "one value" though - it is a transformation matrix.
> Maybe switch it to binary - 9 s32?

Right, but this somehow obfuscate the api. In the other hand, i doubt
there will be lots of calibration tools other that mine.

Is there any drawback for numerous sysfs custom files ?

--=20
Yann Cantin
A4FEB47F
--
