From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] hid: add force feedback support for SmartJoy PLUS PS2/USB
 adapter
Date: Mon, 25 May 2009 12:16:43 +0200
Message-ID: <4A1A700B.8020805@gmail.com>
References: <20090508074636.16912.55839.stgit@fate.lan> <alpine.LNX.2.00.0905111712410.22712@wotan.suse.de> <4A0848E7.9080301@suse.cz> <alpine.LNX.2.00.0905111749530.22712@wotan.suse.de> <4A084A0C.3070500@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:62097 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbZEYKQm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2009 06:16:42 -0400
In-Reply-To: <4A084A0C.3070500@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On 05/11/2009 05:53 PM, Jiri Slaby wrote:
> On 05/11/2009 05:51 PM, Jiri Kosina wrote:
>>> So I think, in this particular case, it is OK to have the conditional 
>>> line in there.
>>
>> Actually this should be the case at least for
>>
>> - all drivers which implement only force feedback features
>> - all drivers which only add additional key mappings
> 
> Yeah, this is correct point and it looks very scary. Let me think about it.

Hmm, if we could do something like plugins, which would just add some
functionality without unbinding a device form a generic driver, it would
be good.

Plugins would be the same as drivers, except ll_driver won't be stopped
and generic would still drive the device. It means plugins can't have
report_fixup defined.

We would need to introduce hid_disconnect, call it on register_driver,
do the additional mapping, mask out FF connect bit or whatever other
operation the plugin needs. This would be performed the same way as it
is currently, except plugin probe won't call parse and hw_start, but
only connect with proper flags.

This will cover most of current drivers and hence we might eliminate
almost all blacklisted entries (except the ones for drivers with
report_fixup).

Caveats:
* events come even when stopped: drop (or hold) events until inputs are
connected again
* complexity: added complexity, slowdown in initialization and handling
* "start-stop-start" on bootup: each bootup will start with generic,
disconnect inputs (a plugin came), connect inputs by a plugin
* plugins removal: we need to go through stop-start again
* anything I don't see?

Ideas, comments, improvements?
