From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: Fn + [KEYS] question
Date: Thu, 17 Sep 2009 01:24:25 +0800
Message-ID: <4AB11F49.6060308@gmail.com>
References: <4AB0929D.4030007@gmail.com> <20090916073207.GI2756@core.coreip.homeip.net> <4AB09717.6040704@gmail.com> <20090916080607.GJ2756@core.coreip.homeip.net> <4AB0AEF6.7020103@gmail.com> <4AB0F9B1.90606@gmail.com> <20090916163305.GB4970@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57307 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053AbZIPRYa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 13:24:30 -0400
Received: by bwz19 with SMTP id 19so3656640bwz.37
        for <linux-input@vger.kernel.org>; Wed, 16 Sep 2009 10:24:32 -0700 (PDT)
In-Reply-To: <20090916163305.GB4970@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Wed, Sep 16, 2009 at 10:44:01PM +0800, Xiangfu Liu wrote:
>> Xiangfu Liu wrote:
>>> Hi Dmitry
>>>
>>>>>  thanks for the reply.
>>>>> see [1], I change the [Red arrow] key to [ALTGR] then I can easy change the 
>>>>> defkeymap.map. make all the red keys work.
>>>>>
>>>>> but for the [Blue Fn] key. I don't know how to make it work in keymap?
>>>>> there is [SHIFT] [CONTROL] [SHIFT] [ALTGR] four modifier keys.
>>>>> all used. so I can not may the [Fn] to those four modifier keys.
>>>>>
>>>>> can I make the leftAlt and rightAlt generate different keys?
>>>>> like:
>>>>>  LeftAlt + 'U' = Alt + 'U'
>>>>>  RightAlt + 'U' = '7'
>>>>>
>>>> Keyboard driver supports 9 modifiers total, you should be able use one
>>>> of these for your numeric buttons.
>>>>
>>> oh. can you give me some tips on the other modifiers.
>>> how to define them? 
>>> can I just change the defkeymap.map file?
>>> or I must change the source code?
>>>
>> Hi Dmitry I found this[1] in the 'man keymaps', three are 9 modifiers.
>> but the in defkaymap.map, there is alwasy like:
>>
>> control keycode  53 = Delete
>>
>> there is no ctrll in the defkeymap.map.
>> how to implement this?
>>
>> ShiftL + u = U
>> ShiflR + u = 7
>>
> 
> The same as with AltGr you need to do
> 
> keycode XX = CtrlR
> 
> and then
> 
> keycode YY = u
> shift keycode YY = U
> ctrlr keycode YY = seven
Hi Dmitry
thanks for the reply. I test this, it's not work. 
----------
$ loadkeys -m defkeymap.map > defkeymap.c && rm defkeymap.o
loadkeys: defkeymap.map:71: adding map 64 violates explicit keymaps line


I look into the keyboard.c,  in the kbd_keycode function
seems this "keysym = key_map[keycode];" make the CtrlL and CtrlR 
map to the Ctrl. so I change the keyboard.c[1] code like:

1. when press CtrlR pass, change back the Ctrl to CtrlR. 
2. in the k_shift function set a sign [shift_right] to 1
3. change the CtrlR to Ctrl in k_shift funtion. other code 
   will only know the Ctrl. not the CtrlR. 
4. when press "u" and [shift_right] is true change the keysym to "1"
   others are same.

_I think the code is not good. so if someone have any idea._
_just let me know._

thanks.


[1]
-----------------------
@@ -800,7 +805,15 @@ static void k_shift(struct vc_data *vc, unsigned char value, char up_flag)
                        clr_vc_kbd_led(kbd, VC_CAPSLOCK);
        }
 
+       if (value == KVAL(K_CTRLR)) {
+               shift_right = 1;
+               value = KVAL(K_CTRL);
+       }
+
        if (up_flag) {
+               shift_right = 0;
                /*
                 * handle the case that two shift or control
                 * keys are depressed simultaneously
@@ -1284,6 +1297,20 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
        if (raw_mode && type != KT_SPEC && type != KT_SHIFT)
                return;
 
+       if (keysym == 61461 && shift_right == 1)//61461 is CtrlR + U
+               keysym = 61489;  		//61489 is "1"
+       if (keysym == 61449 && shift_right == 1)
+               keysym = 61490;
+       if (keysym == 64367 && shift_right == 1)
+               keysym = 61491;
+
+       if (keycode == KEY_RIGHTCTRL) 
+               keysym += 5;

//KEY_CTRL = 2
//KEY_RIGHTCTRL = 7 form the keyboard.h file

        (*k_handler[type])(vc, keysym & 0xff, !down);
 
        param.ledstate = kbd->ledflagstate;


> 
> Let me know if this works.
> 


-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
