From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 2/3] Support enable Acer Launch Manager mode
Date: Tue, 19 Oct 2010 15:07:39 +0200
Message-ID: <AANLkTi==eQcUCm50tSXZj95nZ3FNyaXPLOSxREDtmozK@mail.gmail.com>
References: <4CBE187902000023000224C9@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34030 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933331Ab0JSNHl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Oct 2010 09:07:41 -0400
In-Reply-To: <4CBE187902000023000224C9@novprvlin0050.provo.novell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org

On Tue, Oct 19, 2010 at 1:15 PM, Joey Lee <jlee@novell.com> wrote:
> Hi Corentin,
>
> =E6=96=BC =E4=BA=8C=EF=BC=8C2010-10-19 =E6=96=BC 12:51 +0200=EF=BC=8C=
Corentin Chary =E6=8F=90=E5=88=B0=EF=BC=9A
>> >> Most of users will want the key to just toggle wlan/bluetooth. Bu=
t some of them
>> >> will be happy if they can configure the behavior of the key (cycl=
e, only toggle
>> >> WLAN, etc...)
>> >>
>> >
>> > I thought just direct disable the default EC behavior then leave a
>> > userland daemon to control the behavior, it will grab the wifi key=
 event
>> > then control rfkill state by follow user's customization rules.
>>
>> What I'm saying is: I don't really care what's the default behavior =
is,
>> but if the EC provide a somewhat reliable way to make the key work
>> without any userspace daemon involved, I think we should allow
>> the user to use this mode (even if it's with an obscure module
>> parameter or sysfs file).
>>
>> But .. maybe if someone want this default "raw" behavior,
>> he should just not load this module.
>>
>
> Fully understood, now.
>
> Like you siad, we need define a policy for:
>
> =C2=A0- If user want the default "raw" behavior, what do they need to=
 do?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0I thought if the wmi driver doesn't load b=
y default, then user
> =C2=A0 =C2=A0 =C2=A0 will get a "raw" behavior.
>
> =C2=A0- If any distro want provide userland solution, how can they di=
sable
> =C2=A0 the default "raw" behavior?
> =C2=A0 =C2=A0 =C2=A0 =C2=A0If anybody want to disable the "raw" behav=
ior, just load the wmi
> =C2=A0 =C2=A0 =C2=A0 driver.
>
> Does it right?

Yeah, seems to be ok...
--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
