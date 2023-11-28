Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Q9Vg2469"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B249F18E
	for <linux-input@vger.kernel.org>; Mon, 27 Nov 2023 18:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1701138236; x=1701397436;
	bh=D/TnT0FA5XFPtDytlvmLmeU4AoycfTLzjg+wlor6Xcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q9Vg2469X8QV8wh87XH49/pbV3tcx6nYU2yJhQWc2/xe/EW5N45yFor2keHzJUXaK
	 1VWjuJHelgi6uhderkxl820zcZC2bLmXboyYNrtJc3aK7PdIvCGV3Y6s10Be6ctSnG
	 BYLZ9xEeV24n+Nyx19EThjXQB2KfYIQIAyeBAjVCrajhcF3oK2G6Etxe89Tf6y5nRU
	 RlCUBAxkj2gNgy9s9uLmk+sGIoCcGHchjtBrFWhHtOatiA4hE46tDEx41s1lunPrsm
	 ioOz0WQk2dLvruJ7hqLARywj1573sm/9BPUAUjm1bRX/MwBNcn5A1MiwrOexlQLwhR
	 jDcfJKPJVDBcA==
Date: Tue, 28 Nov 2023 02:23:52 +0000
To: Alexander Koskovich <AKoskovich@protonmail.com>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Roderick Colenbrander <thunderbird2k@gmail.com>, "Colenbrander, Roelof" <roderick.colenbrander@sony.com>, linux-input <linux-input@vger.kernel.org>
Subject: Re: Wrong inputs on DualSense Edge Wireless Controller
Message-ID: <877cm2ehu3.fsf@protonmail.com>
In-Reply-To: <P8jVfYBAwiM_8MIgshN0osVVfshfBH2-oZCQuqoqh0Hy76_031zuZvYXWl0edtfTUwDOSNlc5priSRXI3G5dboVh5VPbcdxzAcEF7EvUVgo=@protonmail.com>
References: <o-hu9PCGr9R5LPS2ZnqssxnR22SBfwuDa0xuSsPwr3op3vBs1lbSsyH7RZMxkw7Ro2EuEzXbekDPrbiFoJ_R2_TzDlQ1g5zDaCogEU2w0sI=@protonmail.com> <CAEc3jaBpdY0J8hwJ6FMBOi5JH3Z-pEPxP38RYD0Y74+9=cfUOw@mail.gmail.com> <ivOCP7WJIYExbRiOtMQq1_X5Lrm691_Jzu2MB_EoHi94WQwoWQtn0YUt2Bf20BQ6BSNuIOZBrrJ5rYTzag5mWGlrn2Yfis9TziSb6VfPxbY=@protonmail.com> <CAEc3jaCSUWXPZo=nvYkWhvOuJYT7xmh4QcBajmrs4GWY6u5OVw@mail.gmail.com> <P8jVfYBAwiM_8MIgshN0osVVfshfBH2-oZCQuqoqh0Hy76_031zuZvYXWl0edtfTUwDOSNlc5priSRXI3G5dboVh5VPbcdxzAcEF7EvUVgo=@protonmail.com>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Nov, 2023 01:50:37 +0000 "Alexander Koskovich" <AKoskovich@proto=
nmail.com> wrote:
> I tested in evtest, and it's reporting sane results (cross south, square =
west, etc). So this seems to be an issue outside of the playstation driver =
itself?
>

Right, I believe the problem stems from Proton -> Windows userspace
Xinput drivers or game/Steam controller test specific code though I am
not 100% sure.

  https://github.com/ValveSoftware/Proton/blob/proton_8.0/docs/CONTROLLERS.=
md

A easy way to confirm would be to run the Steam controller test from
Windows (if you have access) and see if it is weird. You will see from
the diagram that the driver is bypassed by hidraw on the linux side. If
hidraw is not usable on the system, a fallback occurs SDL2's js backend
is used to map the device into a "generic" Xbox controller on the
wine/Windows land.

>
> On Monday, November 27th, 2023 at 2:40 PM, Roderick Colenbrander <thunder=
bird2k@gmail.com> wrote:
>
>
>> This seems a little weird to me. Would you be able to test in using evte=
st? It would rule out some of the other middle layers which can do their ow=
n remapping.
>> Thanks,
>> Roderick
>>
>> On Mon, Nov 27, 2023, 6:42=E2=80=AFAM Alexander Koskovich <AKoskovich@pr=
otonmail.com> wrote:
>>
>> > I was testing this in the Steam controller test, Cyberpunk 2077 (throu=
gh GOG, not through Steam), and SuperTuxKart. All of these have wrong mappi=
ngs for the Edge controller exclusively.
>> > For additional context I have a PS5 controller (non Edge) and it works=
 out of the box. This just seems to be an issue with the Edge variant.
>> >
>> >
>> > On Monday, November 27th, 2023 at 9:37 AM, Roderick Colenbrander <thun=
derbird2k@gmail.com> wrote:
>> >
>> >
>> > >
>> > >
>> > > Hi Alexander,
>> > >
>> > > Sorry for the late reply, but I have been out for a few days. I'm no=
t
>> > > aware of any button/axis mapping change between Edge and regular
>> > > DualSense. The HID reports stayed the same.
>> > >
>> > > I just did a quick check on my laptop also on Fedora 38 / kernel 6.5
>> > > and the mapping seems to be fine. In evtest, triangle reports
>> > > BTN_NORTH, square BTN_WEST, etcetera.
>> > >
>> > > The sticks, triggers and buttons seem to be fine as well. How are yo=
u
>> > > testing this?
>> > >
>> > > Thanks,
>> > > Roderick
>> > >
>> > > On Wed, Nov 22, 2023 at 4:18=E2=80=AFPM Alexander Koskovich
>> > > AKoskovich@protonmail.com wrote:
>> > >
>> > > > [Resending email due to lack HTML message rejected]
>> > > >
>> > > > Hello,
>> > > >
>> > > > I am currently on Fedora 39 (6.5.12-300.fc39.x86_64) and I am noti=
cing that the inputs for this controller are wrong primarily on the right s=
ide of the controller.
>> > > >
>> > > > playstation 0005:054C:0DF2.000C: hidraw11: BLUETOOTH HID v1.00 Gam=
epad [DualSense Edge Wireless Controller] on 10:3d:1c:fd:30:bc
>> > > > playstation 0005:054C:0DF2.000C: Registered DualSense controller h=
w_version=3D0x01000208 fw_version=3D0x01000036
>> > > >
>> > > > This is the current mapping that I'm seeing with the hid_playstati=
on module loaded:
>> > > > "X" is actually "Square"
>> > > > "Square" is "Triangle"
>> > > > "Triangle" is "Circle"
>> > > > "Circle" is "X"
>> > > >
>> > > > Also the right joystick seems to be controlling "R2" instead of th=
e right joystick. "L2" and "R2" triggers control the joystick instead. It's=
 overall very weird. Has there been any similar reports to this?


