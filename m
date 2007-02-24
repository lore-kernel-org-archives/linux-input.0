From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [KJ][RFC][PATCH] BIT macro cleanup
Date: Sat, 24 Feb 2007 12:11:24 +0100
Message-ID: <20070224111124.GB3609@suse.cz>
References: <3b44d3fb0702230215o2fbd5a3y25729e481a447149@mail.gmail.com> <45DEF5EE.4030002@student.ltu.se> <d120d5000702230657s1860efb3o6986277901f13d03@mail.gmail.com> <45DF1165.2080003@student.ltu.se> <d120d5000702230905r6b50a1bbm3b71551f855cdf01@mail.gmail.com> <45DF2F57.2080309@student.ltu.se> <d120d5000702231037q511f8073n47beed320f097458@mail.gmail.com> <45DF3C53.4030100@student.ltu.se> <d120d5000702231358j55cd6665x2add335ceb904c22@mail.gmail.com> <45DF6E20.9060604@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <45DF6E20.9060604@student.ltu.se>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Milind Choudhary <milindchoudhary@gmail.com>, kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Fri, Feb 23, 2007 at 11:43:44PM +0100, Richard Knutsson wrote:

> >I am saying that IMO input's BIT definition should be
> >adequate for 99% of potential users and that I would be OK with moving
> >said BIT definition from input.h to bitops.h and maybe supplementing
> >it with LLBIT. I am also saying that I do not want BITWRAP, BITSWAP
> >(what swap btw?) nor BIT(x % BITS_PER_LONG) in input drivers.

And I totally agree with Dmitry. The "% BITS_PER_LONG" doesn't hurt
other users, and it's needed for larger-than-single-long bit arrays.

> Is the reason for the modulo to put a bitmask larger then the variable 
> into an array?

The complementary LONG() macro will tell you the index of an array of
longs where the bit should be set.

> I did just a quick 'grep' for "BIT(" in drivers/input/ 
> and from what I saw, most (or all?) of the values are defined constants 
> and those in input.h were noway near the limits of a 'long'.

Well, many do not need it, but for example BIT(BTN_LEFT) does, and
that's used in a lot of places.

> The reason I don't like it with modulo is simply because it hides 
> potential bugs (when x is to big). 

That would be my only concern - losing compiler warnings.

> And what about the "1%"?

The 1% will need either LLBIT or an extra % 8.

> IMHO BIT should be as simple as possible.

-- 
Vojtech Pavlik
Director SuSE Labs
