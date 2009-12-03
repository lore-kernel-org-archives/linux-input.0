From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 32/33] input: add KEY_WIRELESS_CYCLE
Date: Thu, 3 Dec 2009 09:12:52 +0100
Message-ID: <71cd59b00912030012r2f45f474u37c494ad281230cb@mail.gmail.com>
References: <1259826317-18809-24-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-26-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-27-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-28-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-29-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-30-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-31-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-32-git-send-email-corentincj@iksaif.net>
	 <1259826317-18809-33-git-send-email-corentincj@iksaif.net>
	 <20091203075404.GK9121@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f197.google.com ([209.85.212.197]:42562 "EHLO
	mail-vw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbZLCIMq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Dec 2009 03:12:46 -0500
In-Reply-To: <20091203075404.GK9121@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Dec 3, 2009 at 8:54 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Dec 03, 2009 at 08:45:16AM +0100, Corentin Chary wrote:
>> This keycode could be used in a lot of platform specific drivers.
>> For example, on Asus laptops, Fn+F2 allow to cycle trought wireless
>> drivers (bt/wl: off/off, on/off, off/on, on/on).
>>
>> Currently, these key are mapped to KEY_WLAN, and KEY_BLUETOOTH/KEY_WIMAX
>> are rarely used.
>>
>
> Is there any application support for such cycling? IOW does anyone cares
> to do such cycling?

On Asus laptops (both asus and eeepc) the Fn+F2 key cycle
(bluetooth/wlan: on/on, on/off, off/on, off/off) on windows.
On Linux, it only produces a KEY_WLAN keycode.

-- 
Corentin Chary
http://xf.iksaif.net
