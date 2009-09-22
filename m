From: Raphael Derosso Pereira <raphaelpereira@gmail.com>
Subject: Re: [PATCH] Atmel AT42QT2160 sensor chip input driver
Date: Tue, 22 Sep 2009 11:11:43 -0300
Message-ID: <f20381800909220711g6e845feree34c15085a8b1c0@mail.gmail.com>
References: <f20381800908201315s7cd4cfc1g57c8799218415b8d@mail.gmail.com>
	 <20090915042612.GB1132@core.coreip.homeip.net>
	 <f20381800909210835h66d695f2i10d95c3ed040efe7@mail.gmail.com>
	 <20090922055252.GA9658@core.coreip.homeip.net>
	 <f20381800909220441l57e7b636qdb96f6528505c7c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:15277 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913AbZIVOSw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 10:18:52 -0400
Received: by an-out-0708.google.com with SMTP id d40so5079945and.1
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2009 07:18:56 -0700 (PDT)
In-Reply-To: <f20381800909220441l57e7b636qdb96f6528505c7c2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hello Dmitry,

I managed to get a working copy of your 'for-linus' branch.

I compiled and tested it and it is working fine! I would just remove
the first #include <autoconf.h> as it was only added for the
CONFIG_QT2160_DEBUG you removed.

Also, this chip is capable of performing some ajustments, like adding
keys to groups to avoid double detection, setting up sensibility,
detection thresholds, etc... I was wondering how to put that to
userspace, through sysfs, evdev ioctl or a /dev entry. What do you
suggest???

--
=46rom: Raphael Derosso Pereira <raphaelpereira@gmail.com>

Inclusion cleanup

Signed-off-by: Raphael Derosso Pereira <raphaelpereira@gmail.com>
--
diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/q=
t2160.c
index 0d57c17..191cc51 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -18,8 +18,6 @@
  *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */

-#include <linux/autoconf.h>
-
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>


2009/9/22 Raphael Derosso Pereira <raphaelpereira@gmail.com>:
> Hello,
>
> 2009/9/22 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>> Hi Raphael,
>>
>>
>> I don't think we need a Kconfig entry for debugging. A person who wa=
nts
>> to debug such driver can easily turn on debugging manually.
>
> Ok.
>
>>
>> We normally try to allocate all necessary resources in probe() so th=
at
>> if device is bound to a driver it should work unless it is broken. S=
ince
>> there is no way to shut off IRQs while IRQ handler is registered it =
does
>> not make sense to have open and close if we allocate IRQ in probe().
>
> Agreed.
>
>>
>> Please take a look at the latest version that I have in 'for-linus'
>> branch in my tree on kernel.org and shout if you see something wrong=
=2E
>
> How am I supposed to do that?
>
>>
>> Thanks.
>>
>> --
>> Dmitry
>>
>
>
>
> --
> Raphael Derosso Pereira
> Engenheiro de Computa=E7=E3o
> msn: rderossopereira@hotmail.com
> Skype: rderossopereira
>



--=20
Raphael Derosso Pereira
Engenheiro de Computa=E7=E3o
msn: rderossopereira@hotmail.com
Skype: rderossopereira
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
