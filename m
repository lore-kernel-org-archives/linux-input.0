From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Mon, 25 May 2009 09:06:00 +0530
Message-ID: <5d5443650905242036k384950cbv5110e6a0df987d3f@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <5d5443650905070141k2d6e3cb8r9e923c71c5474e43@mail.gmail.com>
	 <f17812d70905070148s47045998mfcbbe65b0d8d07b0@mail.gmail.com>
	 <5d5443650905070151s2cba17ecm1f829e2fdfb0d0c9@mail.gmail.com>
	 <f17812d70905071829j758ee376gbf5564881f186937@mail.gmail.com>
	 <d6200be20905072252p494eec8fmda993ad08fb2c9a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:60401 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbZEYDf7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 May 2009 23:35:59 -0400
Received: by pzk7 with SMTP id 7so2299426pzk.33
        for <linux-input@vger.kernel.org>; Sun, 24 May 2009 20:36:00 -0700 (PDT)
In-Reply-To: <d6200be20905072252p494eec8fmda993ad08fb2c9a7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

Hi Eric/Arve,

2009/5/8 Arve Hj=F8nnev=E5g <arve@android.com>:
> On Thu, May 7, 2009 at 6:29 PM, Eric Miao <eric.y.miao@gmail.com> wro=
te:
>> On Thu, May 7, 2009 at 4:51 PM, Trilok Soni <soni.trilok@gmail.com> =
wrote:
>>> Hi Eric,
>>>
>>> On Thu, May 7, 2009 at 2:18 PM, Eric Miao <eric.y.miao@gmail.com> w=
rote:
>>>> On Thu, May 7, 2009 at 4:41 PM, Trilok Soni <soni.trilok@gmail.com=
> wrote:
>>>>> Hi Eric,
>>>>>
>>>>> On Thu, May 7, 2009 at 1:30 PM, Eric Miao <eric.y.miao@gmail.com>=
 wrote:
>>>>>> Original patch by Marek Vasut, modified by Eric in:
>>>>>>
>>>>>> 1. use delayed work to simplify the debouncing
>>>>>> 2. build keycode array for fast lookup
>>>>>> 3. combine col_polarity/row_polarity into a single active_low fi=
eld
>>>>>> (are there some cases where the GPIOs are externally connected
>>>>>> with an inverter and thus causing two different polarity require=
ment??)
>>>>>> 4. use a generic bit array based XOR algorithm to detect key pre=
ss/release,
>>>>>> which should make the column assertion time shorter and code a b=
it
>>>>>> cleaner
>>>>>> 5. remove the ALT_FN handling, which is no way generic, the ALT_=
=46N
>>>>>> key should be treated as no different from other keys, and trans=
lation
>>>>>> will be done by user space by commands like 'loadkeys'.
>>>>>>
>>>>>> Patch tested on Littleton/PXA310 (though PXA310 has a dedicate k=
eypad
>>>>>> controller, I have to configure those pins as generic GPIO to us=
e this
>>>>>> driver, works quite well, though ;-)
>>>>>
>>>>> Any support about removing/clearing ghost/phantom keys? Also we a=
ssume
>>>>> that all gpios in the matrix should be able to generate interrupt=
s so
>>>>> no polldev support required.
>>>>>
>>>>
>>>> Is there some info about such ghost/phantom keys? Otherwise I'll
>>>> assume these are something like sticky control keys?
>>>>
>>>> I'm not sure if there're any such support in console tools and in
>>>> input subsystem. Hard to say...
>>>>
>>>> And the comments below are of great value, I'll incorporate these
>>>> suggestions in later submission. Thanks very much.
>>>>
>>>
>>> Could you please have look at following gpio_matrix driver?
>>>
>>> gpio_matrix.c:
>>> http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dblob;f=3Ddriv=
ers/input/misc/gpio_matrix.c;h=3Dc1f47651a4937d5c976a9625ca5da389dd7e4a=
7c;hb=3DHEAD
>>>
>>> gpio_input.c:
>>> http://android.git.kernel.org/?p=3Dkernel/msm.git;a=3Dblob;f=3Ddriv=
ers/input/misc/gpio_input.c;h=3D7e307f267a2a059b64a3fb9c8a379b149016b2f=
8;hb=3DHEAD
>>>
>>
>> Mmm... looks not so generic, though. And I still have no idea
>> about how its phantom key works unless I see its hw.
>>
>
> There should be no hardware specific code in those drivers, and you
> are free to use them. If you remove the early suspend and wakelock
> code and replace disable_irq with disable_irq_nosync it may cover you=
r
> needs. We used to have a separate gpio_matrix (and gpio_keys) like yo=
u
> are proposing to add, but it proved to be too limited since the
> hardware vendors like to mix direct gpio keys and and matrix keys in
> the same logical keypad.
>
> For the phantom key problem, this occurs with most matrix based
> keypads/keyboards. For instance, you press two keys in the same row
> then a third key in another row, but in the same column as one of the
> first two keys. The driver cannot tell which of the two column you
> pressed since the current will flow through the first two keys to or
> from the other column. If you do not have any code to detect this you
> will report four keys down.

I would suggest that we better move ahead with current gpio_matrix
driver submitted by Eric and let's get reviewed by Dmitry. Other
features can be added as an when some one needs them. Is that sounds
good?

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
