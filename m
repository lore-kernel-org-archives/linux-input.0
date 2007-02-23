From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [KJ][RFC][PATCH] BIT macro cleanup
Date: Fri, 23 Feb 2007 12:05:33 -0500
Message-ID: <d120d5000702230905r6b50a1bbm3b71551f855cdf01@mail.gmail.com>
References: <3b44d3fb0702222056k1d2a9b57q69a3555a09a9058e@mail.gmail.com>
	 <3b44d3fb0702230014x4ee4a1dewdc624c54b3635e15@mail.gmail.com>
	 <45DEAC45.7090105@student.ltu.se>
	 <3b44d3fb0702230215o2fbd5a3y25729e481a447149@mail.gmail.com>
	 <45DEF5EE.4030002@student.ltu.se>
	 <d120d5000702230657s1860efb3o6986277901f13d03@mail.gmail.com>
	 <45DF1165.2080003@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45DF1165.2080003@student.ltu.se>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Milind Choudhary <milindchoudhary@gmail.com>, kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 2/23/07, Richard Knutsson <ricknu-0@student.ltu.se> wrote:
> Dmitry Torokhov wrote:
> > On 2/23/07, Richard Knutsson <ricknu-0@student.ltu.se> wrote:
> >> Milind Choudhary wrote:
> >> > On 2/23/07, Richard Knutsson <ricknu-0@student.ltu.se> wrote:
> >> >> > +#define BITWRAP(nr)    (1UL << ((nr) % BITS_PER_LONG))
> >> >> >
> >> >> > & make the whole input subsystem use it
> >> >> > The change is huge, more than 125 files using input.h
> >> >> > & almost all use the BIT macro.
> >> >> It is as a big of change, but have you dismissed the "BIT(nr %
> >> >> BITS_PER_LONG)" approach?
> >> >
> >> > no..
> >> > but just looking at the number of places it is being used,
> >> > it seems that adding a new  macro would be good
> >> > which makes it look short n sweet
> >> You have a point there but I still don't think it should be in bitops.h.
> >> Why should we favor long-wrap before byte-wrap, so what do you think
> >> about doing:
> >>
> >> #define BITWRAP(x)      BIT((x) % BITS_PER_LONG)
> >>
> >> in input.h? Otherwise I think it should be call LBITWRAP (or something)
> >> to both show what kind it is and enable us to add others later.
> >
> > Why would you not want to have what you call bitwrap as a standard
> > behavior? Most placed to not use modulus because they know the kind of
> > data they are working with but should still be fine if generic
> > implementation did that.
> >
> Both because I find the name not as expressive as simple "BIT(x %
> something)",

I was not talking about name (I hate BITWRAP) but behavior.

> but mainly since it only enables wrapping of the long-type.

I'd provde BIT and separate LLBIT for ones who really need long long.
People who intereseted in smaller than BITS_PER_LONG bitmaps shoud use
your proposal - BIT(x % DESIRED_WITH) and BIT should do modulo
BITS_PER_LONG internally.

-- 
Dmitry
