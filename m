From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] wistron_btns: More keymaps
Date: Mon, 19 Mar 2007 17:28:06 -0400
Message-ID: <d120d5000703191428t11f2df22w5f28d49d2ecfcd52@mail.gmail.com>
References: <45ECA23A.5010503@tremplin-utc.net>
	 <d120d5000703060536k7743ece9hb20fa4d1f7ad7ad7@mail.gmail.com>
	 <45ED8809.70309@tremplin-utc.net> <45F72D37.6090004@tremplin-utc.net>
	 <d120d5000703140654y4d8cb0a3oafd49c48a045bd77@mail.gmail.com>
	 <20070314182559.GC5264@suse.cz>
	 <d120d5000703141158t4d02b8b7pc4ab967722dac@mail.gmail.com>
	 <20070314190254.GA5843@suse.cz> <45F91F73.8040200@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45F91F73.8040200@tremplin-utc.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Cc: Vojtech Pavlik <vojtech@suse.cz>, mitr@volny.cz, otauber@web.de, linux-kernel@vger.kernel.org, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On 3/15/07, =C9ric Piel <Eric.Piel@tremplin-utc.net> wrote:
> 03/14/2007 08:02 PM, Vojtech Pavlik wrote/a =E9crit:
> > On Wed, Mar 14, 2007 at 02:58:49PM -0400, Dmitry Torokhov wrote:
> >
> >>>> 2. I also have a concern about using KEY_SCREEN to signal toggling
> >>>> display on and off. I am CCing Vojtech - he must know what the
> >>>> original intent of this key code was. BTW, when user presses
> >>>> corresponding button - does the display actually goes off? Maybe we
> >>>> need another switch.
> >>> Sorry, Dmitry, I probably should have documented it back then, I don'=
t
> >>> have the slightest idea anymore.
> >>>
> >> That's what I was afraid of ;) Well, maybe we should just use it to
> >> indicate display switch and add a comment to that effect to input.h...
> >
> > Digging somewhat deeper into my memory, I think it just so happened tha=
t
> > there was a keyboard with a key with a pictogram of a computer screen o=
n
> > it with no really defined purpose. Since at that time there was only a
> > limited number of different extended keyboard types, it was added.
> >
> > I think it'd make sense to use it eg. for the key that switches between
> > internal and external output on laptops, if the laptop generates a
> > keycode for the key at all. But maybe that function is already taken by
> > KEY_SWITCHVIDEOMODE ...
>
> Ok, so let me summarize:
>
> There are two kinds of keys on those laptops (for which we are not sure
> about the keycode that it should generate):
> * Laptop screen on/off
> * Display output selection (for instance: laptop/external/both)
>
> The possible keycodes that we could assign to them:
> KEY_SCREEN
> KEY_MEDIA
> KEY_MODE
> KEY_VIDEO
> KEY_SWITCHVIDEOMODE
> KEY_COMPUTER
> KEY_PC
>
>  From the discussion, I had the feeling this association would be the
> less incorrect:
> Screen on/off : KEY_SCREEN

It looks like DVB folks chose to ise KEY_SCREEN and KEY_WINDOW to
switch applications between full screen and windowed modes so we'll
have to invent our own keycode. KEY_DISPLAYTOGGLE anyone?

> Display selection : KEY_SWITCHVIDEOMODE
>

I agree here.

--=20
Dmitry
