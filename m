From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] drivers: input: mouse: alps: drop unneeded likely()
 call around IS_ERR()
Date: Wed, 21 Aug 2019 10:48:57 -0700
Message-ID: <20190821174857.GD76194@dtor-ws>
References: <1566298572-12409-1-git-send-email-info@metux.net>
 <1566298572-12409-2-git-send-email-info@metux.net>
 <20190820111719.7blyk5jstgwde2ae@pali>
 <02f5b546-5c30-4998-19b2-76b816a35371@metux.net>
 <20190820142204.x352bftlvnb7s57n@pali>
 <2cd7178e-9713-7678-a02d-dde91e990c1e@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2cd7178e-9713-7678-a02d-dde91e990c1e@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

Hi,

On Wed, Aug 21, 2019 at 01:37:09PM +0200, Enrico Weigelt, metux IT consult wrote:
> On 20.08.19 16:22, Pali Rohár wrote:
> 
> Hi,
> 
> > > In that case, wouldn't a comment be more suitable for that ?
> > 
> > And why to add comment if current state of code is more-readable and
> > does not need it?
> 
> Readability is probably a bit subjective :p
> 
> With ongoing efforts of automatically identifying redundant code pathes,
> the current situation causes the same discussion coming up over and over
> again. Sooner or later somebody might get the idea to add a comment on
> that line, that it's exactly as intented :o
> 
> OTOH, I'm unsure whether it's important to document that is particular
> error path is unlikely, while we don't do it in thousands of other
> places. IMHO, error pathes are supposed to be unlikely by nature,
> otherwise we wouldn't call it an error situation ;-)
> 
> > People normally add comments to code which is problematic to understand
> > or is somehow tricky, no so obvious or document how should code behave.
> 
> Yes, but isn't this case so obvious that it doesn't need any
> documentation at all ? Is it so important to never ever forget that this
> particular path is a rare situation ?

Because if I see "if (IS_ERR(...))" in an interrupt path I will try to
see if it can be optimized out, but in this particular case we document
it with explicit "unlikely" and I know that I do not need to bother.

The fact that there is unlikely in IS_ERR is an implementation detail.
It may be gone tomorrow. I do not want to have to remember all
implementation details of all kernel APIs and readjust the code all the
time as they are change underneath me.

Thanks.

-- 
Dmitry
