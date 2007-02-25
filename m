From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [KJ][RFC][PATCH] BIT macro cleanup
Date: Sat, 24 Feb 2007 22:39:32 -0500
Message-ID: <200702242239.33314.dtor@insightbb.com>
References: <3b44d3fb0702230215o2fbd5a3y25729e481a447149@mail.gmail.com> <20070224111124.GB3609@suse.cz> <45E036AB.9050303@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45E036AB.9050303@student.ltu.se>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-joystick@atrey.karlin.mff.cuni.cz
Cc: Richard Knutsson <ricknu-0@student.ltu.se>, Vojtech Pavlik <vojtech@suse.cz>, Milind Choudhary <milindchoudhary@gmail.com>, kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Saturday 24 February 2007 07:59, Richard Knutsson wrote:
> Vojtech Pavlik wrote:
> > On Fri, Feb 23, 2007 at 11:43:44PM +0100, Richard Knutsson wrote:
> >
> >   
> >> Is the reason for the modulo to put a bitmask larger then the variable 
> >> into an array?
> >>     
> >
> > The complementary LONG() macro will tell you the index of an array of
> > longs where the bit should be set.
> >   
> This may be a little OT, but how come it is not done as an function? 
> Maybe something like "(set/get)_long_mask(...)".

We have it. Is is called set_bit (or __set_bit) and works wery well for
single bit operations, but sometimes it is nice to be able to write

	a = BIT(b) | BIT(c); 

-- 
Dmitry
