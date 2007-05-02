From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] playing ff effect with code greater then FF_EFFECTS can cause buffer overflow
Date: Tue, 1 May 2007 22:56:50 -0400
Message-ID: <200705012256.51512.dtor@insightbb.com>
References: <Pine.LNX.4.64.0705020101460.9489@twin.jikos.cz> <Pine.LNX.4.64.0705020117270.9221@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0705020117270.9221@jikos.suse.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jan Kratochvil <krata@matfyz.cz>, Anssi Hannula <anssi.hannula@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tuesday 01 May 2007 19:20, Jiri Kosina wrote:
> On Wed, 2 May 2007, Jan Kratochvil wrote:
> 
> >   i found a bug in ff-memless.c so i fixed it. As you can see I am doing 
> > check if effect_id is less then 0, but I am aware that it is useless 
> > because effect_id is actually input_event.code which is __u16, but on 
> > the other side as long as the effect_id is int I feel it is correct to 
> > check whether it is > 0.
> 
> Dmitry,
> 
> actually, looking at the code - is there any particular reason for the 
> inconsistency between the types used in struct input_event ( __u16 type; 
> __u16 code) and in the rest of the code (basically unsigned int 
> everywhere)?
>

input_event is part of ABI and I guess Vojtech tried to pack it to minimize
memory copying. However it is just easier to use unisgned int elsewhere in
the kernel - you either pass values in registers on on stack using native
word size.
  
-- 
Dmitry
