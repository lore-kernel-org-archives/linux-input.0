From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCH 0/2] wistron_btns: More keymaps
Date: Tue, 20 Mar 2007 01:06:35 +0100
Message-ID: <45FF258B.5090007@tremplin-utc.net>
References: <45ECA23A.5010503@tremplin-utc.net>	 <d120d5000703060536k7743ece9hb20fa4d1f7ad7ad7@mail.gmail.com>	 <45ED8809.70309@tremplin-utc.net> <45F72D37.6090004@tremplin-utc.net>	 <d120d5000703140654y4d8cb0a3oafd49c48a045bd77@mail.gmail.com>	 <20070314182559.GC5264@suse.cz>	 <d120d5000703141158t4d02b8b7pc4ab967722dac@mail.gmail.com>	 <20070314190254.GA5843@suse.cz> <45F91F73.8040200@tremplin-utc.net> <d120d5000703191428t11f2df22w5f28d49d2ecfcd52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703191428t11f2df22w5f28d49d2ecfcd52@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, mitr@volny.cz, otauber@web.de, linux-kernel@vger.kernel.org, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

19.03.2007 22:28, Dmitry Torokhov wrote/a =E9crit:
> On 3/15/07, =C9ric Piel <Eric.Piel@tremplin-utc.net> wrote:
>>
>> Ok, so let me summarize:
>>
>> There are two kinds of keys on those laptops (for which we are not sur=
e
>> about the keycode that it should generate):
>> * Laptop screen on/off
>> * Display output selection (for instance: laptop/external/both)
>>
>> The possible keycodes that we could assign to them:
>> KEY_SCREEN
>> KEY_MEDIA
>> KEY_MODE
>> KEY_VIDEO
>> KEY_SWITCHVIDEOMODE
>> KEY_COMPUTER
>> KEY_PC
>>
>>  From the discussion, I had the feeling this association would be the
>> less incorrect:
>> Screen on/off : KEY_SCREEN
>=20
> It looks like DVB folks chose to ise KEY_SCREEN and KEY_WINDOW to
> switch applications between full screen and windowed modes
Just for info, I couldn't find any reference to KEY_WINDOW. Anyway,=20
indeed, KEY_SCREEN is already used for "full screen" (although sometimes=20
it's KEY_ZOOM :-/) so better not using it if something else is possible.

> so we'll
> have to invent our own keycode. KEY_DISPLAYTOGGLE anyone?
What about KEY_DISPLAYONOFF ? :-)
What should be its value? Would 239 be fine?

>> Display selection : KEY_SWITCHVIDEOMODE
> I agree here.=20

BTW, I'm thinking of implementing led support. However, there are two=20
mechanisms for leds in the kernel: the "input layer" leds and the "full=20
feature" leds. The laptops may have up to three leds: mail, wifi,=20
bluetooth. The input layer has LED_MAIL but no wifi nor bluetooth. The=20
led subsystem has the advantage of the very extensible "trigger"=20
mechanism. Which of the subsystems would you recommend me to use?

See you,
Eric
