From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: cleanup of hiddev
Date: Tue, 04 Nov 2008 16:17:49 +0100
Message-ID: <4910679D.4010406@gmail.com>
References: <Pine.LNX.4.44L0.0811040959040.2642-100000@iolanthe.rowland.org> <200811041612.22282.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:32319 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbYKDPSC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2008 10:18:02 -0500
In-Reply-To: <200811041612.22282.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Jiri Kosina <jikos@jikos.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Oliver Neukum napsal(a):
> Am Dienstag, 4. November 2008 16:00:06 schrieb Alan Stern:
>> On Tue, 4 Nov 2008, Oliver Neukum wrote:
>>
>>> Am Montag, 3. November 2008 20:58:11 schrieb Jiri Slaby:
>>>> Hi.
>>>>
>>>>> this is the cleanup of hiddev against current vanilla. What do you think?
>>>> See my comments below.
>>> Hi,
>>>
>>> there still is a race of disconnect() with ioctl(). It seems like that
>>> code still operates under the assumption that both methods take
>>> BKL. Do you prefer a conservative fix with selective application of BKL
>>> or introduction of a new mutex?
>> It's none of my business... but IMO we should try to move away from the 
>> BKL as much as possible.
> 
> This is true but hiddev is in a sense legacy code which should be replaced
> with hidraw, so I tend to fix it conservatively.

Jiri K. is off for few days, I'm not responsible for the HID layer, he is, I
would let him to decide ;).
