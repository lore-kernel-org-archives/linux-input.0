From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not work
	anymore
Date: Thu, 15 Oct 2009 12:51:37 -0700
Message-ID: <20091015195136.GD8544@core.coreip.homeip.net>
References: <928C125D-D36B-47C9-A549-3EE502C9EC73@gmail.com> <4AD75AC0.6020705@tremplin-utc.net> <20091015181336.GB8544@core.coreip.homeip.net> <4AD778C7.4070707@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:61357 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758635AbZJOTw3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2009 15:52:29 -0400
Content-Disposition: inline
In-Reply-To: <4AD778C7.4070707@tremplin-utc.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <Eric.Piel@tremplin-utc.net>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Oct 15, 2009 at 09:32:23PM +0200, =C9ric Piel wrote:
> Op 15-10-09 20:13, Dmitry Torokhov schreef:
>> It lokks like the keyboard controller switched from translated to
>> non-translated mode: '1c' is make code and 'f0 1c' is break (aka
>> release) code.
>>
>> Could you tell me how the keyboard indentified (in dmesg) after fres=
h
>> boot and after you do the bind/unbind trick on the older kernel?
>>
> What do you mean by "how the keyboard indentified"? Are you asking fo=
r =20
> the debug trace in dmesg? I have the beginning of a boot with the deb=
ug =20
> trace to see after a fresh boot. I don't have dmesg history with =20
> i8042.debug of the bind/unbind trick, so I'll reboot in an old kernel=
 =20
> and do it again (but I cannot do this before tuesday, when i have =20
> physical access to the machine).

No, not the debug.. Just the lines looking like this:

input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/i=
nput/input3


You should have at leat 2 - one uping initial boot and one after
rebinding i8042 upon resume.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
