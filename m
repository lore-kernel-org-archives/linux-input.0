From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
Date: Mon, 2 Jul 2018 09:31:10 -0700
Message-ID: <CA+55aFxU853g1dgsQ682R+EeZcm7=tTEmPsmuZ0z=apr24eyEA@mail.gmail.com>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws> <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
 <20180622001632.GI79890@dtor-ws> <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
 <20180701234419.GA250349@dtor-ws> <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
 <A5DA555C-6131-4F7B-82F2-A06C12E23CAF@gmail.com> <87sh5196pk.fsf@purkki.adurom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87sh5196pk.fsf@purkki.adurom.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kt.liao@emc.com.tw, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, ulrik.debie-os@e2big.org, phoenix@emc.com.tw, aaron.ma@canonical.com, josh.chen@emc.com.tw
List-Id: linux-input@vger.kernel.org

On Mon, Jul 2, 2018 at 5:13 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> FWIW I use patchwork.kernel.org and I don't have any issues with UTF-8
> characters in the From header. For example, here's one patch which I
> recently applied:
>
> https://git.kernel.org/linus/88001968245c

Well, that one actually has at least two reasons why it might work well:

 - Rafa=C5=82 sends his patches with an explicit "From:" line in the body
of the email itself (probably because he has had problems with email
headers in the past).  So his body itself has

    From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

 - Also, even ignoring that, he actually uses utf-8 in the headers
too, so his "From" header line looks like

    From:   =3D?UTF-8?q?Rafa=3DC5=3D82=3D20Mi=3DC5=3D82ecki?=3D <zajec5@gma=
il.com>

so it is already in UTF-8, it just is rfc2047-encoded.

I suspect it's that first reason that patchwork.kernel.org gets it
right, but it *migth* be the fact that the problematic email is using
the old 'big5'  encoding:

    From:   =3D?big5?B?ufmxUrph?=3D <kt.liao@emc.com.tw>

anyway, it does look like a newer version of patchwork will fix this.

           Linus
