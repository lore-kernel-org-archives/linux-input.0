From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with middle key
Date: Sun, 01 Jul 2018 17:12:37 -0700
Message-ID: <A5DA555C-6131-4F7B-82F2-A06C12E23CAF@gmail.com>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw> <20180529180506.GB167092@dtor-ws> <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw> <20180622001632.GI79890@dtor-ws> <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com> <20180701234419.GA250349@dtor-ws> <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kt.liao@emc.com.tw, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, ulrik.debie-os@e2big.org, phoenix@emc.com.tw, aaron.ma@canonical.com, josh.chen@emc.com.tw
List-Id: linux-input@vger.kernel.org

On July 1, 2018 5:00:03 PM PDT, Linus Torvalds <torvalds@linux-foundation=
=2Eorg> wrote:
>On Sun, Jul 1, 2018 at 4:44 PM Dmitry Torokhov
><dmitry=2Etorokhov@gmail=2Ecom> wrote:
>>
>> The reason it got messed up is I switched to pulling patches from
>> patchwork=2Ekernel=2Eorg as it collects Acked-by and Reviewed-by tags s=
o
>I
>> do not have to add them manually, but unfortunately it does not do
>> proper UTF-8:
>
>Ugh=2E
>
>I made an 'issue' of it for patchwork:
>
>  https://github=2Ecom/getpatchwork/patchwork/issues/194
>
>and hopefully that can be fixed=2E It's sad when we corrupt names like
>this=2E

Might not even be an issue with recent patchwork, but unfortunately the ve=
rsion that is running on kernel=2Eorg is ancient as far as I know=2E


Thanks=2E

--=20
Dmitry
