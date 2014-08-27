From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH] HID: add support for PenMount HID TouchScreen Driver
Date: Wed, 27 Aug 2014 10:23:19 +0200
Message-ID: <CAH9NwWeT5tQbdexKE-N7R6SbFSQupJUPx4f_eQ6p=6+6gfq7iw@mail.gmail.com>
References: <1408978083-569-1-git-send-email-christian.gmeiner@gmail.com>
 <CAN+gG=Gpze-CA_LRa-69+M_rL3HzSiM_DwMAW1TW8xkA_Kc82w@mail.gmail.com>
 <CAH9NwWe7FSmvVx+BNf7gsjOm9oWLEO7CunHrZjPUwkxiKWLb9w@mail.gmail.com> <CAN+gG=E=k7JCeh=V4O6nzkzoogRj=q+C8Np_h5SHNhLympH1GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:54055 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbaH0IXk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Aug 2014 04:23:40 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so10923wib.10
        for <linux-input@vger.kernel.org>; Wed, 27 Aug 2014 01:23:39 -0700 (PDT)
In-Reply-To: <CAN+gG=E=k7JCeh=V4O6nzkzoogRj=q+C8Np_h5SHNhLympH1GA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Benjamin.


2014-08-26 20:47 GMT+02:00 Benjamin Tissoires <benjamin.tissoires@gmail.com>:
> On Tue, Aug 26, 2014 at 3:29 AM, Christian Gmeiner
> <christian.gmeiner@gmail.com> wrote:
>> Hi Benjamin.
>>
>> 2014-08-25 17:43 GMT+02:00 Benjamin Tissoires <benjamin.tissoires@gmail.com>:
>>> On Mon, Aug 25, 2014 at 10:48 AM, Christian Gmeiner
>>> <christian.gmeiner@gmail.com> wrote:
>>>> This driver is a cleaned up version of
>>>> http://git.android-x86.org/?p=kernel/cdv.git;a=blob_plain;f=drivers/hid/hid-penmount.c;hb=HEAD
>>>
>>> This is definitively weird. According to your driver, it should go by
>>> default through hid-multitouch and behave correctly (at least the
>>> multi-touch versions, and I would say yours too).
>>>
>>
>> I thought I have tried it with hid-multitouch, but I it never gets used.
>>
>> [   94.342542] usb 2-1.7: USB disconnect, device number 6
>> [   96.312636] usb 2-1.7: new full-speed USB device number 7 using ehci-pci
>> [   96.399606] usb 2-1.7: New USB device found, idVendor=14e1, idProduct=6000
>> [   96.399611] usb 2-1.7: New USB device strings: Mfr=1, Product=2,
>> SerialNumber=0
>> [   96.399614] usb 2-1.7: Product: PenMount USB
>> [   96.399617] usb 2-1.7: Manufacturer: DIALOGUE INC
>> [   96.402777] input: DIALOGUE INC PenMount USB as
>> /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.7/2-1.7:1.0/0003:14E1:6000.0004/input/input12
>> [   96.403533] hid-generic 0003:14E1:6000.0004: input,hidraw2: USB HID
>> v1.01 Mouse [DIALOGUE INC PenMount USB] on usb-0000:00:1d.0-1.7/input0
>
> Yep, it will never go through hid-multitouch because the report
> descriptor does not contain the ContactID usage. So hid-generic is
> fine for now.
>

ok

>>
>>
>>> Can you send me some touch recordings of your device with
>>> hid-recorder[1] please? No need to remove your driver, it will capture
>>> raw input events, so you should be just fine.
>>
>> [christian@chgm-pc hid]$ sudo hid-recorder
>> Available devices:
>> /dev/hidraw0:   Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)
>> /dev/hidraw1:   LITE-ON Technology USB NetVista Full Width Keyboard.
>> /dev/hidraw2:   DIALOGUE INC PenMount USB
>> Select the device event number [0-2]: 2
>> R: 76 05 01 09 02 a1 01 09 01 a1 00 09 00 15 00 25 01 95 06 75 01 81
>> 01 05 09 19 01 29 03 15 00 25 01 95 02 75 01 81 02 05 01 09 30 09 31
>> 15 00 26 ff 03 36 80 00 46 ff 7f 75 10 95 02 81 02 09 00 15 00 26 ff
>> 00 75 08 95 05 b1 02 c0 c0
>> N: DIALOGUE INC PenMount USB
>> P: usb-0000:00:1d.0-1.7/input0
>> I: 3 14e1 6000
>> E: 0.000000 5 30 d0 00 d1 01
>> E: 0.000945 5 70 d0 00 d1 01
>> E: 0.006984 5 70 d0 00 d1 01
>> E: 0.012961 5 70 d0 00 d1 01
>> E: 0.019001 5 70 d0 00 d1 01
>> E: 0.025965 5 70 d0 00 d1 01
>> E: 0.031960 5 70 d0 00 d1 01
>> E: 0.037964 5 70 d0 00 d1 01
>> E: 0.043964 5 70 d0 00 d1 01
>> E: 0.050988 5 70 d0 00 d1 01
>> E: 0.056945 5 70 d0 00 d1 01
>> E: 0.062985 5 70 d0 00 d1 01
>> E: 0.068965 5 70 d0 00 d1 01
>> E: 0.075974 5 70 d0 00 d1 01
>> E: 0.081961 5 70 d0 00 d1 01
>> E: 0.112985 5 70 d0 00 d1 01
>> E: 0.118978 5 70 d0 00 d0 01
>> E: 0.124978 5 70 d1 00 d0 01
>> E: 0.131973 5 70 d3 00 d0 01
>> E: 0.137971 5 70 d4 00 d0 01
>> E: 0.143919 5 70 d5 00 cf 01
>> E: 0.149938 5 70 d7 00 cf 01
>> E: 0.155971 5 70 d9 00 cf 01
>> E: 0.163011 5 70 db 00 ce 01
>> E: 0.168984 5 70 dc 00 ce 01
>> E: 0.174996 5 70 de 00 cd 01
>> E: 0.180957 5 70 e0 00 cd 01
>> E: 0.187985 5 70 e1 00 cc 01
>> E: 0.193991 5 70 e3 00 cc 01
>> E: 0.199984 5 70 e5 00 cb 01
>> E: 0.206006 5 70 e7 00 cb 01
>> E: 0.212986 5 70 e9 00 ca 01
>> E: 0.218988 5 70 eb 00 ca 01
>> E: 0.224955 5 70 ed 00 c9 01
>> E: 0.230943 5 70 f0 00 c9 01
>> E: 0.237986 5 70 f2 00 c8 01
>> E: 0.243951 5 70 f5 00 c7 01
>> E: 0.262959 5 70 f8 00 c6 01
>> E: 0.269008 5 70 fc 00 c5 01
>> E: 0.274963 5 70 ff 00 c3 01
>> E: 0.280913 5 70 03 01 c1 01
>> E: 0.287962 5 70 07 01 c0 01
>> E: 0.293989 5 70 0a 01 bf 01
>> E: 0.299971 5 70 0e 01 be 01
>> E: 0.305973 5 70 12 01 bd 01
>> E: 0.313004 5 70 15 01 bc 01
>> E: 0.318966 5 70 18 01 bb 01
>> E: 0.324979 5 70 1b 01 ba 01
>> E: 0.330975 5 70 1f 01 b9 01
>> E: 0.337957 5 70 22 01 b8 01
>> E: 0.343986 5 70 25 01 b7 01
>> E: 0.349924 5 70 28 01 b5 01
>> E: 0.355963 5 70 2c 01 b4 01
>> E: 0.362928 5 70 2f 01 b3 01
>> E: 0.368975 5 70 33 01 b1 01
>> E: 0.374911 5 70 36 01 b0 01
>> E: 0.380961 5 70 39 01 af 01
>> E: 0.387969 5 70 3d 01 af 01
>> E: 0.393916 5 70 40 01 ae 01
>> E: 0.399961 5 70 43 01 ad 01
>> E: 0.405957 5 70 47 01 ad 01
>> E: 0.412947 5 70 4a 01 ac 01
>> E: 0.418982 5 70 4d 01 ab 01
>> E: 0.424983 5 70 50 01 aa 01
>> E: 0.430989 5 70 54 01 a9 01
>> E: 0.437946 5 70 57 01 a8 01
>> E: 0.443999 5 70 5a 01 a7 01
>> E: 0.449980 5 70 5d 01 a6 01
>> E: 0.455972 5 70 61 01 a5 01
>> E: 0.462986 5 70 64 01 a4 01
>> E: 0.468994 5 70 67 01 a3 01
>> E: 0.474981 5 70 6a 01 a3 01
>> E: 0.480990 5 70 6c 01 a2 01
>> E: 0.487974 5 70 6f 01 a1 01
>> E: 0.493988 5 70 72 01 a1 01
>> E: 0.500009 5 70 75 01 a0 01
>> E: 0.505973 5 70 77 01 9f 01
>> E: 0.512990 5 70 7a 01 9f 01
>> E: 0.518971 5 70 7d 01 9e 01
>> E: 0.524988 5 70 7f 01 9e 01
>> E: 0.530969 5 70 81 01 9e 01
>> E: 0.537991 5 70 83 01 9d 01
>> E: 0.543979 5 70 86 01 9d 01
>> E: 0.549988 5 70 88 01 9c 01
>> E: 0.555973 5 70 8a 01 9c 01
>> E: 0.562958 5 70 8c 01 9c 01
>> E: 0.568917 5 70 8d 01 9b 01
>> E: 0.574984 5 70 8f 01 9b 01
>> E: 0.580986 5 70 92 01 9b 01
>> E: 0.587984 5 70 94 01 9a 01
>> E: 0.593990 5 70 95 01 9a 01
>> E: 0.599959 5 70 97 01 99 01
>> E: 0.605980 5 70 97 01 99 01
>> E: 0.612983 5 70 98 01 99 01
>> E: 0.618990 5 70 9a 01 98 01
>> E: 0.624972 5 70 9b 01 98 01
>> E: 0.630983 5 70 9c 01 97 01
>> E: 0.638007 5 70 9e 01 97 01
>> E: 0.643953 5 70 9f 01 97 01
>> E: 0.649986 5 70 a1 01 96 01
>> E: 0.655975 5 70 a1 01 96 01
>> E: 0.662980 5 70 a3 01 96 01
>> E: 0.668993 5 70 a4 01 95 01
>>
>
> Weird, this trace is missing the release from the finger (it should
> start with 5 30 ...)
>

here it is:

E: 0.387936 5 70 59 02 cd 01
E: 0.394915 5 70 59 02 cd 01
E: 0.400929 5 70 59 02 cd 01
E: 0.437981 5 30 59 02 cd 01


> As I understand, the only problem which your driver is trying to solve
> is to map the button 0 emitted by your touchscreen to BTN_TOUCH (I
> have the feeling that you already said that, but I can not find it in
> the thread :/ -> found your other thread).
>

Yeah that is what I want. userspace should see a touch event. In the end
the browser will react to this touch events. And this work enabled this
for the penmount 6000.

> You have 2 possibilities:
> 1. fix the report descriptor and rely on the generic implementations
> 2. just handle the button mapping in this penmount driver and leave
> the rest to the generic code.
>

I am not sure what you would prefer but as I have never played with
report descriptors I went with possibility #2.

> The choice 2. might be easier if you never played with report
> descriptors. You will just have to heavily remove stuffs from your
> current version:
> - struct penmount_priv is not required anymore
> - in penmount_input_mapping() just map HID_UP_BUTTON to BTN_TOUCH, and
> return 0 for everything else
> - remove penmount_process() and penmount_event()
> - no need to have a probe or a remove function anymore
> - use the macro module_hid_driver(penmount_driver) instead of having
> your own penmount_init() and penmount_exit()
>
> You might also want to say that you are the author of the module and
> also just say that you based your work on a hid-penmount copyrighted
> by PenMount Touch Solution <...>.
> The code should be very different by now, so there is no need IMO to
> keep the author when you completely have rewritten the code.
>

I have send a v2.

Greets
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
