From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: HID regression: Quanta touchscreen, device ID: 0408:3008
Date: Mon, 23 Apr 2012 08:59:07 -0700
Message-ID: <4F957C4B.2020408@canonical.com>
References: <alpine.LNX.2.00.1204231542030.1856@pobox.suse.cz> <4f95669e.a0e7d80a.2ef7.6710SMTPIN_ADDED@mx.google.com> <CAN+gG=EYXHegM+BTEuDvAT_cmvZCT5u38hY+Woe_No3V0rDfWA@mail.gmail.com> <4F957856.1070107@canonical.com> <CAN+gG=HJVynUaLciTkKqMSvciU1RN9NssQOBGeH2Wkg=9b6kOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41587 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287Ab2DWP7E (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 11:59:04 -0400
In-Reply-To: <CAN+gG=HJVynUaLciTkKqMSvciU1RN9NssQOBGeH2Wkg=9b6kOQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Ming Lei <tom.leiming@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 04/23/2012 08:48 AM, Benjamin Tissoires wrote:
> On Mon, Apr 23, 2012 at 17:42, Chase Douglas
> <chase.douglas@canonical.com> wrote:
>> On 04/23/2012 08:34 AM, Benjamin Tissoires wrote:
>>> The problem relies in the upper layers and not in the kernel: nobody
>>> took the time to code a X.org driver that handles true multitouch
>>> direct devices. You can eventually use the synaptics one, but you will
>>> have to deal with absolute/relative coordinates, and the last time I
>>> played with it, it was not convenient as I was not able to make GDM
>>> use the absolute coordinate system (I kow I should have patched the
>>> synaptics X.org driver).
>>
>> X now supports direct multitouch devices using the X evdev driver. This
>> may be a bug in the X server.
> 
> Yes it does, but does it also emulates right-clicks with double tap?
> (It's not an attack ;-), it's just a question as I did not followed
> the development of XInput 2.2 since a long time...)

No offense taken :). I merely wanted to point out that it could be a bug
in the X server, too.

In XI 2.2, there is only button 1 emulation. If you double tap it should
double click. If you press and hold, it should press and hold button 1.
There's no "gestural" interpretation in the X server that interprets
touchscreen input and causes a button 2 event.

-- Chase
