From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
Date: Sun, 1 Jul 2018 16:30:44 -0700
Message-ID: <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws> <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
 <20180622001632.GI79890@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180622001632.GI79890@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, ulrik.debie-os@e2big.org, phoenix@emc.com.tw, aaron.ma@canonical.com, josh.chen@emc.com.tw
List-Id: linux-input@vger.kernel.org

On Thu, Jun 21, 2018 at 5:16 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> OK, thank you for the info. Applied.

Ugh. Dmitry, please be more careful with author names.

Apparently you aren't in a proper utf-8 locale, and you messed up the
name in the git repository. So yoiu apparently tried to take KT Liao's
Chinese name: =E5=BB=96=E5=B4=87=E6=A6=AE, but did so in some wrong locale,=
 and it ended up
being just '???' in the git repo.

And I only noticed when I did my shortlog for doing my 4.18-rc3 release not=
es.

I don't know what locale or tools you have, but please try to make
sure everything is utf-8 aware so that these kinds of name corruptions
don't happen..

                 Linus
