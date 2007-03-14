From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Subject: Re: [PATCH 0/2] wistron_btns: More keymaps
Date: Wed, 14 Mar 2007 16:20:01 +0100
Message-ID: <45F812A1.3060108@tremplin-utc.net>
References: <45ECA23A.5010503@tremplin-utc.net>	 <d120d5000703060536k7743ece9hb20fa4d1f7ad7ad7@mail.gmail.com>	 <45ED8809.70309@tremplin-utc.net> <45F72D37.6090004@tremplin-utc.net> <d120d5000703140654y4d8cb0a3oafd49c48a045bd77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703140654y4d8cb0a3oafd49c48a045bd77@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: mitr@volny.cz, otauber@web.de, linux-kernel@vger.kernel.org, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-input@vger.kernel.org

03/14/2007 02:54 PM, Dmitry Torokhov wrote/a =C3=A9crit:
> Hi Eric,
>=20
:
> I have couple of comments/requests:
>=20
> 1. KEY_OPEN and KEY_CLOSE should not be used to signal state of the
> lid, they correspond to Accpication Control Open and Close keys from
> USB HID HUT spec:
>=20
>     http://www.usb.org/developers/devclass_docs/Hut1_12.pdf
>=20
> SW_LID shoudl be used to signal lid state instead.
The keycodes put in the keymap are simply the same as in acerhk, just=20
because I couldn't think of better. Indeed, KEY_OPEN and KEY_CLOSE seem=20
to badly fit if they might be interpreted by userland as opening or=20
closing a document! That would be better to generate a SW_LID event, but=20
I'm not sure how to do that, is it just about using=20
input_report_switch(x, SW_LID, 0 or 1) instead of using=20
input_report_key()? Probably I need to update input_dev->swbit as well.=20
Do I have to anything else to generate switch events?

Sincerely, I don't think anyone is using this info (especially because=20
probably the info is also passed though ACPI) so that would be fine with=20
me to just not generate any event :-P Tell me if you think it worths it.


> 2. I also have a concern about using KEY_SCREEN to signal toggling
> display on and off. I am CCing Vojtech - he must know what the
> original intent of this key code was. BTW, when user presses
> corresponding button - does the display actually goes off? Maybe we
> need another switch.
Only few laptops generate an event for this key (most of the laptop=20
simply switch the screen). I don't have access to any of those, so I've=20
no idea if it's the userland which has to control the display or if it's=20
just information for the userland. Maybe Olaf knows? I don't think it's=20
possible to convert it to a switch event because it doesn't report the=20
information about if screen is on or off.

On the same topic, there are some "KEY_MEDIA" generated when key to=20
change display output is pressed. Is it fine for you or do have a more=20
suiting keycode in mind?


> 3. The number of keymap tables grew considerably ;) Do you think it
> woudl make sense to allocate memory for keymap at device creation time
> and copy selected keymap and them mark all original keymaps as
> __initdata so they are discarded one module completed initialization?
In the patch, I've reduced the keymap structure to only take 32bits per=20
key. So, in the absolute, it's not that terrible with each keymap taking=20
about 40 bytes. Still, it wouldn't hurt to save space knowing that it's=20
likely that the list keeps growing up. It shouldn't be hard to do as you=20
propose with the __initdata.

I had thought about a different way: as the generic keymap should fit=20
most of the laptop, we could save only the difference of a given laptop=20
to this keymap (then behaving more like a "quirk"). This would have the=20
advantage of saving space even in the source file ;-)

I'll try to tinker a bit with both approaches and see what fit best.=20
Anyway, is it ok for you to merge those patches first and later I'll=20
come up with a space-saver patch?

See you,
Eric
