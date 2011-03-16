From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: The way for disabling input device?
Date: Wed, 16 Mar 2011 16:12:35 +0900
Message-ID: <4D8062E3.30305@samsung.com>
References: <4D7F2C12.5020509@samsung.com>
 <20110316045551.GB2582@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:9515 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab1CPHZU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:25:20 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LI5009902P0ED40@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Wed, 16 Mar 2011 16:12:36 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LI500GKI2P06A@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 16 Mar 2011 16:12:36 +0900 (KST)
In-reply-to: <20110316045551.GB2582@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On 2011-03-16 =EC=98=A4=ED=9B=84 1:55, Dmitry Torokhov wrote:
> On Tue, Mar 15, 2011 at 06:06:26PM +0900, Joonyoung Shim wrote:
>> Hi, all.
>>
>> The many smartphones and embedded devices have LCD panel with
>> touchscreen. The LCD panel is turned off for power saving and
>> touchscreen also is disabled if there isn't user input for a while o=
r if
>> user presses power key briefly. This state is such idle, not suspend=
=2E
>>
>> The framebuffer device driver of kernel supplies sysfs interface to
>> control blanking level of framebuffer and  we can turn off LCD panel
>> using this sysfs at the above case.
>>
>> Currently i know there isn't the generic way for disabling input dev=
ice
>> via user interface, so i am looking for the way for disabling
>> input device on kernel side for above case.
>>
>> The above case has a condition which the touchscreen is disabled if =
LCD
>> panel is turned off. The framebuffer framework of kernel has notifie=
r
>> block to callback on events like hardware display blank change occur=
ed,
>> so the callback function disabling and enabling input device can be
>> called using notifier block of framebuffer. The callback function is
>> implemented in each touchscreen driver or can be implemented though
>> input core if this can be generic way for input device.
>>
>> Actually i wonder whether this approach makes sense. I know this is =
a
>> specific case but certainly necessary function in the smartphone and
>> embedded devices.
>
> I do not believe that we should tie the 2 together. I can come up wit=
h
> scenarios where you woudl want to put the keeboard/touchcsreen to sle=
ep
> before turning off the display and vice versa.

Right, as you say, various scenarios can come up, so i think generic wa=
y=20
for disabling input device needs more and more.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
