From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 2/2] drivers: input: mouse: alps: drop unneeded likely()
 call around IS_ERR()
Date: Wed, 21 Aug 2019 13:37:09 +0200
Message-ID: <2cd7178e-9713-7678-a02d-dde91e990c1e@metux.net>
References: <1566298572-12409-1-git-send-email-info@metux.net>
 <1566298572-12409-2-git-send-email-info@metux.net>
 <20190820111719.7blyk5jstgwde2ae@pali>
 <02f5b546-5c30-4998-19b2-76b816a35371@metux.net>
 <20190820142204.x352bftlvnb7s57n@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820142204.x352bftlvnb7s57n@pali>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

On 20.08.19 16:22, Pali Rohár wrote:

Hi,

>> In that case, wouldn't a comment be more suitable for that ?
> 
> And why to add comment if current state of code is more-readable and
> does not need it?

Readability is probably a bit subjective :p

With ongoing efforts of automatically identifying redundant code pathes,
the current situation causes the same discussion coming up over and over
again. Sooner or later somebody might get the idea to add a comment on
that line, that it's exactly as intented :o

OTOH, I'm unsure whether it's important to document that is particular
error path is unlikely, while we don't do it in thousands of other
places. IMHO, error pathes are supposed to be unlikely by nature,
otherwise we wouldn't call it an error situation ;-)

> People normally add comments to code which is problematic to understand
> or is somehow tricky, no so obvious or document how should code behave.

Yes, but isn't this case so obvious that it doesn't need any
documentation at all ? Is it so important to never ever forget that this
particular path is a rare situation ?

I might be wrong, but IMHO the likely()/unlikely() macros have been
introduced for optimization (better pipeline optimization for the
frequent cases).

> People first need to understand that static code analysis cannot work
> 100% reliably and always is needed to properly review changes.

Yes, but we see that this particular case is coming up again and again,
from different people, who can't know the background of this (nobody
can read the whole lkml and remember everything). This could be
prevented by adding a comment on that line, but then the macro call
just for documentation wouldn't be necessary anymore.

> And if the only reason for this change is to satisfy some static code
> analysis program,

Actually, it's more for people who're using the tools for the purpose
of tidying up the code and find potential problems. They need some
information to act on properly, which is currently missing ...

> would not it better to teach this program to no
> generate such false-positive results?

Okay, but how to do that practically ? There's no information in the
code which neither some tool nor any human could recognize this false
alarm. That information is just in your brain, now also in mine, and
the other folks who previously proposed the same change (assuming they
still recall it after years).

Blacklisting doesn't seem to be a good idea in the long run. Once going
that route, such blacklists grow quickly and get hard to maintain (we
now have two entirely separately maintained data sources that need to
be synced manually, when something changes).

I believe the code should be kinda self-documenting, so the reader
shouldn't need any detailed special knowledge to understand it. IMHO,
when such discussions on actual implementation details come up, the
code isn't expressive enough.

How can we improve the situation ?

Shall we consider introducing yet another macro (explicitly different
name) for stating/documenting such cases ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
