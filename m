From: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: input devices handling
Date: Wed, 14 Jan 2009 16:32:43 +0300
Message-ID: <496DE97B.9010901@msgid.tls.msk.ru>
References: <496BA5C8.5090506@msgid.tls.msk.ru> <20090112214424.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hobbit.corpit.ru ([81.13.33.150]:21099 "EHLO hobbit.corpit.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761053AbZANNcp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2009 08:32:45 -0500
In-Reply-To: <20090112214424.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Dmitry Torokhov wrote:
[power/sleep buttons]
>> Before, there was /proc/acpi/event and /etc/acpid/* stuff,
>> and it was easy (but somewhat clumsy) to act to system power
>> down button.  But the "proper way" now is to handle
>> /dev/input/event* interface, because such "Power" button can
>> be on a keyboard, on a remote control, and so on.  I understand
>> the idea, and I like it.
>>
>> But now the question.  How one supposed to find all the devices
>> which generate such events?  I mean not about scanning the /dev
>> directory, which can be done once at startup, but about REscanning
>> it to find which NEW keyboards and the like appeared since last
>> (re)scan and which were removed.
> 
> You can either listen to hotplug events or poll (select)
> /proc/bus/input/devices - waiters are woken up every time we
> add or remove a new input device or a new input handler.

Hmm.  Seems to be too much for a simple "power down when i press
`power' button' stuff.  Where the only thing needed is to run a
script when this button is pressed, but the code to watch for the
input device changes becomes larger and more complex than the
actual thing it should do.  (Maybe I stop somewhere at the middle:
scan all devices at startup and rescan when receiving a HUP signal,
or require a restart.  But the whole select-loop looks ugly too,
for such a simple task ;)

So this basically turns into another question being discussed in a
parallel thread: /dev/input/mice, /dev/input/keyboard, and maybe
/dev/input/event meta-devices...

Thanks!

/mjt
