From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Input: Support for a less exclusive grab.
Date: Wed, 4 Jul 2007 00:15:18 +0200
Message-ID: <20070703221518.GA5013@suse.cz>
References: <20070609084800.GR6362@aehallh.com> <200706120120.00494.dtor@insightbb.com> <20070612052316.GX6362@aehallh.com> <200706120135.06428.dtor@insightbb.com> <20070612054031.GY6362@aehallh.com> <20070702152044.GA24665@suse.cz> <20070703164555.GA20370@aehallh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070703164555.GA20370@aehallh.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Zephaniah E. Hull" <warp@aehallh.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jul 03, 2007 at 12:45:55PM -0400, Zephaniah E. Hull wrote:

> Not really, what happens when the user presses alt-F1?

Well, if the console is switched to medium raw or raw mode, nothing
happens.

> A way to tell the kernel that events from a given input device should
> not go to the console has been needed since the very first time an X
> driver allowed keyboard events from /dev/input/event<n>, and that
> still has not changed.

And the ages old method that X has been using before the existence of
the input layer still works fine, as far as I know.

> We just want a more flexible approach then what we are already using[0].

I'm fine with that, I just wonder whether attacking it on the input
layer side is the right way to do it: If you want to disable the
console, tell the console.

That way, we don't have to figure out which exact kernel input handlers
are console and which are not.

> I'll see about writing something up when I get back to my computers[1]
> and have things set back up[2].

Enjoy whatever computerless period you're planning!

-- 
Vojtech Pavlik
Director SuSE Labs
