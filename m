From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [HP Jornada 6XX] - Onboard Keyboard support
Date: Tue, 11 Sep 2007 01:22:34 -0700
Message-ID: <20070911012234.5257be24.Kristoffer.Ericson@Gmail.com>
References: <20070721181549.9d118414.Kristoffer.Ericson@Gmail.com>
	<200707220145.10563.dtor@insightbb.com>
	<20070726223452.e6d8f7c3.Kristoffer.Ericson@Gmail.com>
	<d120d5000707300539haa26ae8sdfee043ae9e64688@mail.gmail.com>
	<20070910145836.bc268d5d.Kristoffer.Ericson@Gmail.com>
	<d120d5000709100601u1a5a0208g903c4463119c3702@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000709100601u1a5a0208g903c4463119c3702@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Mon, 10 Sep 2007 09:01:51 -0400
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> On 9/10/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:
> > Greetings,
> >
> > I've sent this patch a couple of times now without receiving any response, so here goes again.
> 
> Argh, that's what I needed to do over the weekend... Sorry...
No worries,

> 
> OK, I looked over the patch and it is in a pretty decent shape, here
> is the only thing that bothers me:
> > +
> > +static void jornadakbd680_poll(struct input_polled_dev *dev)
> > +{
> > +    struct jornadakbd *jornadakbd = dev->private;
> > +    scan_jiffies++;
> > +
> > +       if (scan_jiffies & 1) {
> > +               if (!jornada_scan_keyb(jornadakbd->s0))
> > +                       jornada_check_kbd(jornadakbd, jornadakbd->s0, jornadakbd->s1);
> > +               else
> > +                       memcpy(jornadakbd->s0, jornadakbd->s1, jornadakbd->length);
> 
> jornada_scan_keyb appears to always return 0 so this copy never takes
> place. Overall I find this poll routine a bit complicated.

Couldnt agree with you more, I came to the same conclusion but after the driver started working it slipped my mind.
Generally the driver was too complicated than it needed too, I've sorted out some of its 'lets see how I can make a simple check complicated' routines, but not all.

> I am
> attaching a patch that has it impoemented a bit differently, could you
> tell me if it is still works for you?

It works, but the keys it returns are wrong. For instance enter returns 'z'. Somehow the *table must be off. I havent looked at it more closely, but will tommorow.

> 
> Thanks!
> 
> -- 
> Dmitry
> 


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
