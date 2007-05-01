From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] playing ff effect with code greater then FF_EFFECTS can
 cause buffer overflow
Date: Wed, 2 May 2007 01:20:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705020117270.9221@jikos.suse.cz>
References: <Pine.LNX.4.64.0705020101460.9489@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0705020101460.9489@twin.jikos.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Kratochvil <krata@matfyz.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anssi Hannula <anssi.hannula@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Wed, 2 May 2007, Jan Kratochvil wrote:

>   i found a bug in ff-memless.c so i fixed it. As you can see I am doing 
> check if effect_id is less then 0, but I am aware that it is useless 
> because effect_id is actually input_event.code which is __u16, but on 
> the other side as long as the effect_id is int I feel it is correct to 
> check whether it is > 0.

Dmitry,

actually, looking at the code - is there any particular reason for the 
inconsistency between the types used in struct input_event ( __u16 type; 
__u16 code) and in the rest of the code (basically unsigned int 
everywhere)?

Thanks,

-- 
Jiri Kosina
SUSE Labs
