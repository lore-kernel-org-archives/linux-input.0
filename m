From: Louai Al-Khanji <louai.khanji@gmail.com>
Subject: Re: Support for Logitech Dinovo Edge special keys
Date: Tue, 17 Mar 2009 02:27:14 +0200
Message-ID: <f4a2642e0903161727o1e6d00a6xb0458b05952ff627@mail.gmail.com>
References: <f4a2642e0903161453v447f5fe8idf1e3c58fd800548@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f175.google.com ([209.85.218.175]:34747 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229AbZCQA1R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2009 20:27:17 -0400
Received: by bwz23 with SMTP id 23so1184192bwz.37
        for <linux-input@vger.kernel.org>; Mon, 16 Mar 2009 17:27:14 -0700 (PDT)
In-Reply-To: <f4a2642e0903161453v447f5fe8idf1e3c58fd800548@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Mon, Mar 16, 2009 at 11:53 PM, Louai Al-Khanji
<louai.khanji@gmail.com> wrote:
> Hi,
>
> I recently bought a Logitech Dinovo Edge keyboard. However, it seems
> that not all keys are supported by the current HID layer as of
> 2.6.28.7 - at least, in X I get no reports of keypresses, and for the
> special keys that do generate key presses no keycode info is
> available. I wonder if anyone can point me in the right direction on
> how to fix this, and indeed confirm that this needs to be fixed in the
> HID layer rather than in X somewhere.
>
> I did look in hid-input.c, where in the hidinput_configure_usage
> function there is a case HID_UP_LOGIVENDOR which is ignored. hid-lg.c
> seems to contain some fixes for Logitech keyboards, but I don't quite
> see how it all fits together.
>
> I have not worked extensively in kernel space before, so please bear with me. :)

Sorry to reply to myself, but I'm not certain my first mail went
through as I wasn't signed up on the list.

I've also gathered some information on the keyboard and the missing
keys. Attached are two files, with some dmesg info as output when the
hid driver is loaded with the option debug=2.

logitech-dinovo-edge-keys-log contains dmesg output when pressing the
keys that do not work. I've entered a key description followed by the
info from dmesg. Some keys do not generate any output, those are
followed by a blank line.

logitech-dinovo-edge-plug-log contains the dmesg output when the
keyboard's receiver is plugged in.

If anyone can give me any pointers on where and how to specify these
keys, and why some keys are completely dead, I would be very grateful.

-- 
- Louai Al-Khanji
