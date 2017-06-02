From: Damjan Georgievski <gdamjan@gmail.com>
Subject: Re: Trackpoint on Thinkpad X1 Carbon (5th gen)
Date: Fri, 2 Jun 2017 12:46:49 +0200
Message-ID: <CAEk1YH54DWWonBcMKaz17+O_UOaWFSm-FWZchUpkT+czVwS93Q@mail.gmail.com>
References: <CAEk1YH5dPPQfMEq650cUX1p4QrOUzR0oSSBombtFQLKV--ix2A@mail.gmail.com>
 <CAEk1YH7589yXnMJkmn+NMr45KZruGdW58xXVm-r47uy_W=ynwg@mail.gmail.com> <CAKdAkRTcgg2g2mmN3PTKf1ZhKHJ5nsE4z_LDjZ=tOqcoUoZ8Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37317 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdFBKqv (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Jun 2017 06:46:51 -0400
Received: by mail-wm0-f41.google.com with SMTP id d127so22061522wmf.0
        for <linux-input@vger.kernel.org>; Fri, 02 Jun 2017 03:46:51 -0700 (PDT)
In-Reply-To: <CAKdAkRTcgg2g2mmN3PTKf1ZhKHJ5nsE4z_LDjZ=tOqcoUoZ8Mg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Masaki Ota <masaki.ota@jp.alps.com>

On 30 May 2017 at 19:24, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Tue, May 23, 2017 at 11:12 AM, Damjan Georgievski <gdamjan@gmail.com> =
wrote:
>> On 19 May 2017 at 22:12, Damjan Georgievski <gdamjan@gmail.com> wrote:
>>> Hi all,
>>> the trackpoint on the  Thinkpad X1 Carbon (5th gen) (model 20HQ) is
>>> recognised as:
>>> "ImPS/2 Generic Wheel Mouse" while typically it should be "TPPS/2 IBM
>>> TrackPoint".
>>
>> the following patch[1] adds the X1 Carbon gen 5 to work with the
>> rmi4_smbus support, there are some issues though:
>> - the touchpad _seems_ to be working a bit better (at least that's
>> what I feel like)
>> - the trackpoint moves too fast
>> - middle click scrolling is not enabled and can't be set with xinput
>>
>> Can I do someting to improve/test the trackpoint issues, before
>> submiting this for merging?
>>
>> ps.
>> also, when this is aplied the touchpad and trackpoint are recognized as
>>> =E2=8E=9C   =E2=86=B3 AlpsPS/2 ALPS DualPoint Stick             id=3D12=
   [slave  pointer  (2)]
>>> =E2=8E=9C   =E2=86=B3 AlpsPS/2 ALPS DualPoint TouchPad          id=3D14=
   [slave  pointer  (2)]
>
> This is surprising that device on F03 pass-through port managed to
> respond to ALPS queries...


actually the touchpad seems to be recognized as
=E2=8E=9C   =E2=86=B3 Synaptics TM3289-002                      id=3D12   [=
slave  pointer  (2)]

and the other two ALPS devices are the trackpoint and its buttons
(which I beleive are connected to the touchpad)


> Masaki, is there a chance to make ALPS detection more robust here as I
> do not believe we are dealing with ALPS device here.


Is there anything else I can test?



--=20
damjan
