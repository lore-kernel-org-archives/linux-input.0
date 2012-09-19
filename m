From: David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org>
Subject: Re: [PATCH v2] HID: Add support for Sony PS3 BD Remote Control
Date: Wed, 19 Sep 2012 12:59:46 -0400
Message-ID: <1348073986.10827.21.camel@frustration.ornl.gov>
References: <1346378760.7976.2.camel@obelisk.thedillows.org>
	 <CABBYNZ+5E+BC-+9fj0e7iUpEDFJrJBQo8aoMZj8ZEkmiuB=QLA@mail.gmail.com>
	 <1347284864.3532.1.camel@sirocco.hadess.net>
	 <CABBYNZJpHkt8CGDsfVwirZ=vecb-fhbpPbrVFKt1UR_rA25mSw@mail.gmail.com>
	 <CABBYNZ+n9obON7iNcv66x2ZVQCeTs_JoJUDXZFwxJJ6C4cb4YQ@mail.gmail.com>
	 <CABBYNZKggzJ7bzQWVmWi30kxOUR8bVCyMLL=SM1=Oe74YPwvKg@mail.gmail.com>
	 <1347394656.1606.10.camel@sirocco.hadess.net>
	 <CABBYNZ+gpheC9sNeTp2uvDFBV-yPs+cY4PUR2omPt_kLTCafKw@mail.gmail.com>
	 <1347456657.23874.29.camel@sirocco.hadess.net>
	 <CABBYNZLwXhF0gixPGKUTJY4sZ7EHynTYmHzGtiZsoRGXgeEFaw@mail.gmail.com>
	 <CANq1E4SDXVHcumBbEA-4xpeuOQ0SjDxxtL_RqAiNYRPj6ccagQ@mail.gmail.com>
	 <20120913003628.ce5babb2a66d09fe17fa15de@studenti.unina.it>
	 <1347591892.6145.14.camel@obelisk.thedillows.org>
	 <20120917120441.a164d2e10bb02aa9a1e8d523@studenti.unina.it>
	 <1347929527.29391.9.camel@obelisk.thedillows.org>
	 <1347932038.29391.17.camel@obelisk.thedillows.org>
	 <20120919184834.8093076c520dba2dc91c2f5d@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120919184834.8093076c520dba2dc91c2f5d-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Herrmann <dh.herrmann-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Luiz Augusto von Dentz <luiz.dentz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, 2012-09-19 at 18:48 +0200, Antonio Ospite wrote:
> On Mon, 17 Sep 2012 21:33:58 -0400
> David Dillow <dave-i1Mk8JYDVaaSihdK6806/g@public.gmane.org> wrote:

> While on the remote I see:
> 
> I press '1' and keep it pressed:
> Event: time 1348069656.505528, type 1 (EV_KEY), code 2 (KEY_1), value 1
> 1111111111...
> 
> I press '2' and release it ('1' is sent):
> Event: time 1348069666.025543, type 1 (EV_KEY), code 2 (KEY_1), value 0
> Event: time 1348069668.395531, type 1 (EV_KEY), code 2 (KEY_1), value 1
> 1111111111...
> 
> I release '1':
> Event: time 1348069671.625541, type 1 (EV_KEY), code 2 (KEY_1), value 0
> 
> I don't know at what level this behavior is enforced.
> 
> I will test later with the old raw_event callback and the fix to the
> descriptor you suggested in the other mail.

Please capture the raw reports
from /sys/kernel/debug/hid/0005:*:0306:*/events when pressing multiple
keys -- and tell me which ones they were. You may need to mount debugfs
to get to this path.

It looks like this simple approach isn't going to work when you press
multiple keys, so I'll need more information to see if I can do
something else -- my Harmony can only do one key press at a time, as it
is converting IR to an emulated BD remote.

> > +config HID_PS3REMOTE
> > +	tristate "Sony PS3 BD Remote"
> 
> If you are going for a v3, consider using "Sony PS3 BD Remote Control"
> here too, not a big deal but that's the name on the user manual.

Will do, thanks.

> For the note about the association procedure I had in mind something
> like this:
> 
> /* NOTE: in order to associate the Sony PS3 BD Remote with a Bluetooth host
>  * the key combination Start+Enter has to be kept pressed for about 7 seconds,
>  * with the host BT Controller in discovering mode.
>  *
>  * Also the pin request should be ignored by the BT Controller (NULL pin).
>  */
> 
> Could someone more into BT please check the terminology here? Thanks.

Will add something along these lines, though I think you mean there is
no authentication step rather than a NULL pin, which implies we still
need to do auth. Or maybe that's just how the Harmony needed it...

Thanks,
Dave
