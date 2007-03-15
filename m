From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCH 0/2] wistron_btns: More keymaps
Date: Thu, 15 Mar 2007 11:26:59 +0100
Message-ID: <45F91F73.8040200@tremplin-utc.net>
References: <45ECA23A.5010503@tremplin-utc.net> <d120d5000703060536k7743ece9hb20fa4d1f7ad7ad7@mail.gmail.com> <45ED8809.70309@tremplin-utc.net> <45F72D37.6090004@tremplin-utc.net> <d120d5000703140654y4d8cb0a3oafd49c48a045bd77@mail.gmail.com> <20070314182559.GC5264@suse.cz> <d120d5000703141158t4d02b8b7pc4ab967722dac@mail.gmail.com> <20070314190254.GA5843@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070314190254.GA5843@suse.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, mitr@volny.cz, otauber@web.de, linux-kernel@vger.kernel.org, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

03/14/2007 08:02 PM, Vojtech Pavlik wrote/a =C3=A9crit:
> On Wed, Mar 14, 2007 at 02:58:49PM -0400, Dmitry Torokhov wrote:
>=20
>>>> 2. I also have a concern about using KEY_SCREEN to signal toggling
>>>> display on and off. I am CCing Vojtech - he must know what the
>>>> original intent of this key code was. BTW, when user presses
>>>> corresponding button - does the display actually goes off? Maybe we
>>>> need another switch.
>>> Sorry, Dmitry, I probably should have documented it back then, I don'=
t
>>> have the slightest idea anymore.
>>>
>> That's what I was afraid of ;) Well, maybe we should just use it to
>> indicate display switch and add a comment to that effect to input.h...
>=20
> Digging somewhat deeper into my memory, I think it just so happened tha=
t
> there was a keyboard with a key with a pictogram of a computer screen o=
n
> it with no really defined purpose. Since at that time there was only a
> limited number of different extended keyboard types, it was added.
>=20
> I think it'd make sense to use it eg. for the key that switches between
> internal and external output on laptops, if the laptop generates a
> keycode for the key at all. But maybe that function is already taken by
> KEY_SWITCHVIDEOMODE ...

Ok, so let me summarize:

There are two kinds of keys on those laptops (for which we are not sure=20
about the keycode that it should generate):
* Laptop screen on/off
* Display output selection (for instance: laptop/external/both)

The possible keycodes that we could assign to them:
KEY_SCREEN
KEY_MEDIA
KEY_MODE
KEY_VIDEO
KEY_SWITCHVIDEOMODE
KEY_COMPUTER
KEY_PC

 From the discussion, I had the feeling this association would be the=20
less incorrect:
Screen on/off : KEY_SCREEN
Display selection : KEY_SWITCHVIDEOMODE

Is that ok with everyone? If not, please suggest something better ;-)

See you,
Eric

PS: So far, I believe that for all laptops, those keys are just normal=20
keys (as opposed to a key which would also do by itself its intended=20
action).  At least on a 3020, pressing "screen on/off" doesn't=20
automatically switch on/off the screen.
