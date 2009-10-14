From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not work anymore
Date: Tue, 13 Oct 2009 19:05:05 -0700
Message-ID: <928C125D-D36B-47C9-A549-3EE502C9EC73@gmail.com>
Mime-Version: 1.0 (iPhone Mail 7C144)
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:55966 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759333AbZJNCHC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2009 22:07:02 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?=C3=89ric_Piel?= <eric.piel@tremplin-utc.net>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Oct 13, 2009 at 11:52:19AM +0200, =C3=89ric Piel wrote:
> Op 12-10-09 17:48, Dmitry Torokhov schreef:
>> On Mon, Oct 12, 2009 at 01:46:17PM +0200, =C3=89ric Piel wrote:
>>>> Eric, do you still need to fiddle with i8042 to get your keyboard =
=20
>>>> working with
>>>> 2.6.32-rc3? We need to make sure that resube works without users =20
>>>> needing to
>>>> mess with bind/unbind.
>>> Yes, the keyboard doesn't work after the first resume from ram (the
>>> later resumes do work). I haven't tried any special option to the =20
>>> i8042
>>> driver. This is on a HP 2510, in 64 bits.
>>
>> Could you please try and let me know if unloading at suspend and
>> reloading after resume atkbd and/or psmouse drivers and leaving i804=
2
>> alone "fixes" the issue?
>>
> Unloading the modules before suspend and reloading them after works
> around the issue, indeed.
>

Do both of them need to be reloaded? Or only one (my guess psmouse) is
enough. Hmm, this is HP laptop so it most likely has Synaptics touchpad=
=2E
I wonder what happens if you force it to bare PS/2 protocol (or maybe
Intellimouse)... Try adding "option psmouse proto=3Dimps" and
"option psmouse proto=3Dbare" and suspend/resume.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
