From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 01/24] input: Add ff-memless-next module
Date: Wed, 14 May 2014 10:58:25 -0700
Message-ID: <20140514175825.GA30089@core.coreip.homeip.net>
References: <1398524543-15012-1-git-send-email-madcatxster@devoid-pointer.net>
 <1398524543-15012-2-git-send-email-madcatxster@devoid-pointer.net>
 <20140514063806.GC13621@core.coreip.homeip.net>
 <1818063.tFLKhAd1oy@sigyn>
 <ceda9d065796952132cc6ff971c0537b.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ceda9d065796952132cc6ff971c0537b.squirrel@mungewell.org>
Sender: linux-kernel-owner@vger.kernel.org
To: simon@mungewell.org
Cc: =?iso-8859-1?Q?=22Michal_Mal=FD=22?= <madcatxster@devoid-pointer.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi
List-Id: linux-input@vger.kernel.org

On Wed, May 14, 2014 at 11:11:40AM -0400, simon@mungewell.org wrote:
> 
> > If we ever come across a really memoryless device it should not be
> > particularly difficult to add another callback to ff-memless-next which
> > would emulate conditional effects with constant force.
> 
> It should be noted that some (/many?) applications/games already use the
> CF with position feedback to emulate behaviour such as springs. The feed
> back loop is simply not fast enough to do emulation of friction/inertia.
> 
> I don't believe that the FF layer in the kernel should be 'tricked out'
> with lots of emulation features.
> 
> As a game designer (ok... tinkerer) it's a bit of a pain that devices lie
> about what they can really do - ie. gamepads claiming periodic ability
> when all they are doing is faking it with rumble.

Would it help if kernel would indicate which effects are native and
which are emulated?

Thanks.

-- 
Dmitry
