From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 0/4] Pegatron Lucid tablet acceleromter/ALS
Date: Tue, 25 Jan 2011 17:05:05 +0000
Message-ID: <AANLkTi=tQpQ0wjfx-Cp13FuCSQNFitN7XAg-V2AcSHz2@mail.gmail.com>
References: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>
	<20110124230557.GA18135@core.coreip.homeip.net>
	<AANLkTinfDR4TnVC-NPLsCqXsc9nP+UWXKO6n8jXuT7ne@mail.gmail.com>
	<4D3EFDCF.7090308@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D3EFDCF.7090308@windriver.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 25, 2011 at 4:43 PM, Andy Ross <andy.ross@windriver.com> wr=
ote:
> On 01/24/2011 11:30 PM, Corentin Chary wrote:
>> Dmitry Torokhov wrote:
>> > I am happy with the input part but I wonder if it really needs to =
be
>> > separate? If you roll it up into asus-laptop you would not need a =
new
>> > platform device and then it would be what - 20 lines of code?
>> >
>> > Corentin, what do you think?
>>
>> I think that it should be consistent, if there is already some code
>> for pegatron tablet in asus-laptop, then why a new platform device
>> only for the accelerometer ?
>
> No strong feelings here. =C2=A0I made it a separate file because
> asus-laptop.c is already very large and this was something that could
> be fairly easily split out, but obviously it's a really trivial
> device.
>
>> Andy, what is shared with asus-laptop exactly ? What sysfs files are
>> working and enabled ? =C2=A0Are backlight and led classes working ?
>
> Just the key device, which exports the single touch area in the corne=
r
> of the tablet as KEY_MEDIA. =C2=A0Some of the other sysfs devices
> (bluetooth, display, leds) appear because the methods exist, but
> they're stubbed out in the ASL and thus noops.
>
> Andy

If everybody is ok with that, I think you should move the code back
into asus-laptop.c. But if you do so, don't forget to modify the help
text of ASUS_LAPTOP section in KConfig.

Should we also change the description to
"Asus/Medion/JVC/Lenovo/Pegatron Extra" ? That seems really ugly
but....

--=20
Corentin Chary
http://xf.iksaif.net
