From: =?ISO-8859-1?Q?Fabien_Andr=E9?= <fabien.andre@enac.fr>
Subject: Re: Can I limit the scope of an input device to specific processes ?
Date: Wed, 29 Jan 2014 13:35:18 +0100
Message-ID: <CAM18vYopPv_NP43k4M=Wdf6NeGC-vxZc+xdqJesfu8g-R35hsw@mail.gmail.com>
References: <S1754733AbaA1IxR/20140128085317Z+41@vger.kernel.org>
	<52E78481.6040606@UKE.Uni-Hamburg.de>
	<CANq1E4ReNtJgC7zArLo=Bo87YZXOukFTTuxjYf_nupfmUkCL+A@mail.gmail.com>
	<52E7A24E.20601@UKE.Uni-Hamburg.de>
	<CANq1E4TUjuB9yfu5U0NJx97ysmNOo+7aeFSFYQgxi+eTu_PYQA@mail.gmail.com>
	<52E8CD67.4010705@UKE.Uni-Hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:57070 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbaA2MfT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jan 2014 07:35:19 -0500
Received: by mail-ob0-f176.google.com with SMTP id gq1so1849428obb.7
        for <linux-input@vger.kernel.org>; Wed, 29 Jan 2014 04:35:18 -0800 (PST)
In-Reply-To: <52E8CD67.4010705@UKE.Uni-Hamburg.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: R.Zimmermann@uke.uni-hamburg.de
Cc: David Herrmann <dh.herrmann@gmail.com>, linux-input@vger.kernel.org

Hi,


On Wed, Jan 29, 2014 at 10:44 AM, Dr. Zimmermann
<R.Zimmermann@uke.uni-hamburg.de> wrote:
> Am 28.01.2014 13:49, schrieb David Herrmann:
>>
>> Hi
>>
> Hi David,
>
>> On Tue, Jan 28, 2014 at 1:27 PM, Dr. Zimmermann
>> <R.Zimmermann@uke.uni-hamburg.de> wrote:
>>
>> You can mark devices as floating via:
>> Section "InputClass"
>>      Identifier "Custom Input Blacklist"
>>      MatchProduct "<Product-Name-of-Your-Device>"
>>      MatchDevicePath "/dev/input/event*"
>>      Option "Floating" "on"
>> EndSection
>>
>> Also see "man xorg.conf" and search for "Floating".

An alternative to X config file is the xinput command line tool

$> xinput list
to get the name and id of your device
$>xinput float NAME_OR_ID
to "detach" the device from the virtual core keyboard
(the name will be stable while id can change after unplug or restart,
thus name is a better candidate for scripting)


Regards,
Fabien
