From: "Anssi Hannula" <anssi@mandriva.org>
Subject: Re: Force Feedback: Thrustmaster FGT Wheel quick-and-dirty in
     hid-lgff.c or hid-tmff.c
Date: Mon, 16 Jul 2007 20:21:40 +0300 (EEST)
Message-ID: <57857.84.250.84.4.1184606500.squirrel@mail.onse.fi>
References: <469B7721.9070705@free.fr>
    <d120d5000707160905l214a6ec3yaefc73be5644e1b1@mail.gmail.com>
    <469BA787.8080700@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <469BA787.8080700@free.fr>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Gerald Folcher <geraldf2@free.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Gerald Folcher wrote:
> Dmitry Torokhov wrote:
>
>> I wonder if the attached is all that is needed for your wheel to
>> work...
>
> No, but I think I understand where is the confusion:
> It won't work because my wheel is the "Force Feedback" model, not the
> "Rumble Force" model which is cheaper but looks exactly the same. With
> your patch applied as is, my wheel will neither do rumble effects nor
> constant force effects, the force feedback test utilities 'ffcfstress' =
and
> 'ffmvforce' will spit an error message on startup and exit. And
> 'fftest' will think my wheel can do Rumble but trying such effects will
> effectively trigger hazardous constant forces on my wheel.
>
> But your patch would maybe work for the actual Rumble wheel if you
> change the id to 0x651, which is the id of the Rumble version according=
 to
> the MS-Windows registry on a machine where I installed the Thrustmaster
> drivers (the registry is full of id's of the wheels supported by the
> driver).
>
> While the id of my wheel (Force Feedback) is: 0x654 (and according to
> the aforementioned MS-Windows registry there is also an id 0x652 for a
> Thrustmaster wheel with the same name).

Could you perhaps provide the kernel log output when you plug your device
in with CONFIG_HID_DEBUG enabled in kernel configuration?

Thanks,
--=20
Anssi Hannula
