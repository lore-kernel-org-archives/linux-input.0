From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/2] wistron_btns: More keymaps
Date: Wed, 14 Mar 2007 15:02:49 -0400
Message-ID: <d120d5000703141202g3987d5beob3a0551d48003840@mail.gmail.com>
References: <45ECA23A.5010503@tremplin-utc.net>
	 <d120d5000703060536k7743ece9hb20fa4d1f7ad7ad7@mail.gmail.com>
	 <45ED8809.70309@tremplin-utc.net> <45F72D37.6090004@tremplin-utc.net>
	 <d120d5000703140654y4d8cb0a3oafd49c48a045bd77@mail.gmail.com>
	 <20070314182559.GC5264@suse.cz>
	 <d120d5000703141158t4d02b8b7pc4ab967722dac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703141158t4d02b8b7pc4ab967722dac@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>, mitr@volny.cz, otauber@web.de, linux-kernel@vger.kernel.org, linux-input <linux-input@atrey.karlin.mff.cuni.cz>
List-Id: linux-input@vger.kernel.org

On 3/14/07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 3/14/07, Vojtech Pavlik <vojtech@suse.cz> wrote:
> > On Wed, Mar 14, 2007 at 09:54:27AM -0400, Dmitry Torokhov wrote:
> > > Hi Eric,
> > >
> > > On 3/13/07, Eric Piel <Eric.Piel@tremplin-utc.net> wrote:
> > > >Hello,
> > > >
> > > >As a sequel to my patch "Wistron button support for TravelMate 610" of
> > > >last week, here is a bigger addition of keymaps for the wistron_btns.
> > > >
> > > >Patch 1 adds all the database of acerhk which fits this driver (about 25
> > > >more laptops).
> > > >Patch 2 adds a generic map that should fit most users but has the
> > > >disadvantage of not being automatic.
> > > >
> > > >Dmitry, I've tried to make them against your tree. Still, if they don't
> > > >apply cleanly, just tell me and I'll try harder!
> > > >
> > >
> > > I have couple of comments/requests:
> > >
> > > 1. KEY_OPEN and KEY_CLOSE should not be used to signal state of the
> > > lid, they correspond to Accpication Control Open and Close keys from
> > > USB HID HUT spec:
> > >
> > >     http://www.usb.org/developers/devclass_docs/Hut1_12.pdf
> > >
> > > SW_LID shoudl be used to signal lid state instead.
> > >
> > > 2. I also have a concern about using KEY_SCREEN to signal toggling
> > > display on and off. I am CCing Vojtech - he must know what the
> > > original intent of this key code was. BTW, when user presses
> > > corresponding button - does the display actually goes off? Maybe we
> > > need another switch.
> >
> > Sorry, Dmitry, I probably should have documented it back then, I don't
> > have the slightest idea anymore.
> >
>
> That's what I was afraid of ;) Well, maybe we should just use it to
> indicate display switch and add a comment to that effect to input.h...
>

Oh, wait, DVB uses this code to request switchin full screen mode, we
better not touch it.

-- 
Dmitry
