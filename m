From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [KJ][RFC][PATCH] BIT macro cleanup
Date: Sat, 24 Feb 2007 22:37:32 -0500
Message-ID: <200702242237.33182.dtor@insightbb.com>
References: <3b44d3fb0702230215o2fbd5a3y25729e481a447149@mail.gmail.com> <45DF6E20.9060604@student.ltu.se> <20070224111124.GB3609@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070224111124.GB3609@suse.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-joystick@atrey.karlin.mff.cuni.cz
Cc: Vojtech Pavlik <vojtech@suse.cz>, Richard Knutsson <ricknu-0@student.ltu.se>, Milind Choudhary <milindchoudhary@gmail.com>, kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Saturday 24 February 2007 06:11, Vojtech Pavlik wrote:
> > The reason I don't like it with modulo is simply because it hides 
> > potential bugs (when x is to big). 
> 
> That would be my only concern - losing compiler warnings.
> 

I think most dangerous scenario is when both shift operands are not constant
but compiler will not help us in this case...
 
-- 
Dmitry
