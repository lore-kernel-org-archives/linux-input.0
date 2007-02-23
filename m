From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [KJ][RFC][PATCH] BIT macro cleanup
Date: Fri, 23 Feb 2007 16:58:26 -0500
Message-ID: <d120d5000702231358j55cd6665x2add335ceb904c22@mail.gmail.com>
References: <3b44d3fb0702222056k1d2a9b57q69a3555a09a9058e@mail.gmail.com>
	 <45DEAC45.7090105@student.ltu.se>
	 <3b44d3fb0702230215o2fbd5a3y25729e481a447149@mail.gmail.com>
	 <45DEF5EE.4030002@student.ltu.se>
	 <d120d5000702230657s1860efb3o6986277901f13d03@mail.gmail.com>
	 <45DF1165.2080003@student.ltu.se>
	 <d120d5000702230905r6b50a1bbm3b71551f855cdf01@mail.gmail.com>
	 <45DF2F57.2080309@student.ltu.se>
	 <d120d5000702231037q511f8073n47beed320f097458@mail.gmail.com>
	 <45DF3C53.4030100@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45DF3C53.4030100@student.ltu.se>
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
> >
> > Hm, I thought as was clear, but apparently I messed up explaining my
> > position:
> >
> > 1. I don't like BITWRAP name at all and I don't want anything like
> > that near input code. I think BIT is just fine.
> Oh, I think I understand now. So the (in input.h):
> #undef BIT
> #define BIT(...
> business is what you want to do? Well, that I will not object to.

No, #undefs may be barely tolerable in .c files but they are not
acceptable in core subsystem interfaces. If you do that you will never
know what version of BIT patricular module is using.

>  Your
> patch with:
> +#define BIT(nr)        (1UL << (nr))
> +#define LLBIT(nr) (1ULL << (nr))
> +#define BITWRAP(nr)    (1UL << ((nr) % BITS_PER_LONG))
> in bitops.h made me believe the #undef in input.h was just a temporarily
> thing.

No. There is no "my patch". You are confusing me with Milind
Choudhary. I am saying that IMO input's BIT definition should be
adequate for 99% of potential users and that I would be OK with moving
said BIT definition from input.h to bitops.h and maybe supplementing
it with LLBIT. I am also saying that I do not want BITWRAP, BITSWAP
(what swap btw?) nor BIT(x % BITS_PER_LONG) in input drivers.

-- 
Dmitry
