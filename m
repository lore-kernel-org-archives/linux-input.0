From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: Re: matrix_keypad driver, Combination keys
Date: Wed, 09 Sep 2009 00:48:01 +0800
Message-ID: <4AA68AC1.2000705@gmail.com>
References: <4A819D39.2040006@qi-hardware.com> <20090812024620.E4E10526EC9@mailhub.coreip.homeip.net> <4A9AA392.4060301@gmail.com> <20090901021034.6117F526EA5@mailhub.coreip.homeip.net> <4AA474DC.9010509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751779AbZIHQsO@vger.kernel.org>
In-Reply-To: <4AA474DC.9010509@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Xiangfu Liu wrote:
> Hi Dmitry
> Dmitry Torokhov wrote:
>> Hi,
>> Historically our KEY_* definitions did not include defines for symbols
>> like '@' because they do not have a dedicated key but rather being
>> produced as a combination of a primary key + modifier; the mapping is
>> done either in console driver or in X.
>>
>> Looking at the picture of the device that you provided it appears that
>> your device does not have a dedicated '@' key so it should work in the
>> same fashion as above.
>>
> 
> since we don't have X now. I google about this. I don't know how to 
> modify the console driver. can you tell me which file I need look 
> into? thanks.
> 
> I found an another method. we use busybox in rootfs. the busybox have 
> command [dumpkmap] [loadkmap] [showkey],
> 
> -----------
> in host system run :
> /usr/bin/dumpkeys > normal_keymap
> /usr/bin/loadkeys funky_mini_keyboard_keymap
> /usr/bin/busybox dumpkmap > funky_mini_keyboard_keymap.bin
> /usr/bin/loadkeys normal_keymap
> 
> then in target system run
> "loadkmap funky_mini_keyboard_keymap.bin"
> -----------
> 
> in our device have a two special keys
> [RED UP POINT] keycode is 94
> [QI] keycode is 93
> 

can I modify this function matrix_keyboard.c:103
static void matrix_keypad_scan(struct work_struct *work)
to detect the combination keys?
like:
1. if press the compose keys [RED UP POINT] just record
2. if next press the 'w'. will report '@' to OS.

if it's possible. how to report '@' to OS. 
I saw the source code is always report the keycode.

thanks for help
-- 
Xiangfu Liu
Email: xiangfu at qi-hardware dot com
Web: http://www.qi-hardware.com
