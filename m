From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
Date: Sun, 1 Jul 2018 16:44:19 -0700
Message-ID: <20180701234419.GA250349@dtor-ws>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws>
 <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
 <20180622001632.GI79890@dtor-ws>
 <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kt.liao@emc.com.tw, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, ulrik.debie-os@e2big.org, phoenix@emc.com.tw, aaron.ma@canonical.com, josh.chen@emc.com.tw
List-Id: linux-input@vger.kernel.org

On Sun, Jul 01, 2018 at 04:30:44PM -0700, Linus Torvalds wrote:
> On Thu, Jun 21, 2018 at 5:16 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > OK, thank you for the info. Applied.
> 
> Ugh. Dmitry, please be more careful with author names.
> 
> Apparently you aren't in a proper utf-8 locale, and you messed up the
> name in the git repository. So yoiu apparently tried to take KT Liao's
> Chinese name: 廖崇榮, but did so in some wrong locale, and it ended up
> being just '???' in the git repo.
> 
> And I only noticed when I did my shortlog for doing my 4.18-rc3 release notes.
> 
> I don't know what locale or tools you have, but please try to make
> sure everything is utf-8 aware so that these kinds of name corruptions
> don't happen..

Yeah, I noticed that when preparing pull request, but did not want to
rebase the branch that I always keep stable, sorry.

The reason it got messed up is I switched to pulling patches from
patchwork.kernel.org as it collects Acked-by and Reviewed-by tags so I
do not have to add them manually, but unfortunately it does not do
proper UTF-8:

https://patchwork.kernel.org/patch/10431971/

I have since reworked by scripts to only take changelog from patchwork,
and take author name/email from the mail message and using "git
mailinfo" which worked well before. Should not happen again.

Thanks.

-- 
Dmitry
