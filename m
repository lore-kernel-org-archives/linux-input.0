From: Xiangfu Liu <xiangfu.z@gmail.com>
Subject: want add numpad  to matrix_keypad driver. need help.
Date: Sun, 17 Jan 2010 21:40:36 +0800
Message-ID: <4B531354.3080709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:35534 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab0AQNkp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jan 2010 08:40:45 -0500
Received: by pwj9 with SMTP id 9so1214848pwj.21
        for <linux-input@vger.kernel.org>; Sun, 17 Jan 2010 05:40:45 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi

in this[1] picture. there is blue [Fn] and blue Numbers.
I want make the [Fn] as KEY_NUMLOCK. (just like IBM keyboard)

I use the matrix_keypad driver in our device. I try to modify the 
matrix_keypad.c but not work.

I also try to modify the keyboard.c there is function[2], I want map the 
[U] [I] [O] to 7 8 9, but not work.

please give me some advice. 
thanks.

[1]http://downloads.qi-hardware.com/hardware/Photos/2009_09_30_keyboard.jpg
[2]static void k_pad(struct vc_data *vc, unsigned char value, char up_flag)

Best Regards
Xiangfu.
