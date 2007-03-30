From: "Milind Arun Choudhary" <milindchoudhary@gmail.com>
Subject: Re: [KJ][PATCH] BIT macro cleanup
Date: Fri, 30 Mar 2007 18:01:03 +0530
Message-ID: <3b44d3fb0703300531l6293e792y94d4f16e43652fb5@mail.gmail.com>
References: <20070328033309.GA9597@arun.site>
	 <20070328190925.GC5306@martell.zuzino.mipt.ru>
	 <460B3244.9060405@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <460B3244.9060405@student.ltu.se>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Knutsson <ricknu-0@student.ltu.se>, Alexey Dobriyan <adobriyan@gmail.com>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 3/29/07, Richard Knutsson <ricknu-0@student.ltu.se> wrote:
> Alexey Dobriyan wrote:
> > On Wed, Mar 28, 2007 at 09:03:09AM +0530, Milind Arun Choudhary wrote:
> >
> >> +#define BIT(nr)	(1UL << ((nr) % BITS_PER_LONG))
> >>
> >
> > I think this would be a disaster because something like
> >
> > 	BIT(123)
> >
> > would not even generate a warning.
> >
> There were a discussion on this, at KJ, when BIT was first used with a
> modular operation. I said the same thing as you do now, but a big user
> of BIT is the input-subsystem who defined their BIT as above. Also it
> was mentioned that the compiler can only find the statical errors, a
> variable input can break it in runtime.
> + if we _really_ want to check the tree for such warnings, it is easy to
> remove the modular operation temporarily (and keep away of input/)
>
> I don't say I like this, just that it is a choose between possible errors.
as discussed in earlier thread there are two kinds of users of BIT
1. input sybsystem which needs the "% BITS_PER_LONG"
2. & all other who don't, so that they are warned when the bit no overflows
I think a simple macro cant serve both the purposes

so IMHO there should be two macros
 +#define BIT(nr)	(1UL << (nr))
which server the first case

&
 +#define XXXBITXXX(nr)	(1UL << ((nr) % BITS_PER_LONG))
for input users
earlier i suggested a name BITWRAP
but some people hate it i think
'm fine with any other name as well
inputs....suggest a name

so that we can still keep these two macros (along with LLBIT) in
bitops.h & use apporpriately

only hassle is the whole input tree is to be searched & replaced for BIT
is this OK

-- 
Milind Arun Choudhary
