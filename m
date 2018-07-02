From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
Date: Sun, 1 Jul 2018 17:00:03 -0700
Message-ID: <CA+55aFwCdAuw+GuKTCzACWpQBDFAx_DsMM0uTCx2fZKBBU7X0w@mail.gmail.com>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws> <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
 <20180622001632.GI79890@dtor-ws> <CA+55aFzLMkyAGdfaeDLUXeRE0MJUckRDsrbVy2yonT6R=wf-Og@mail.gmail.com>
 <20180701234419.GA250349@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180701234419.GA250349@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, ulrik.debie-os@e2big.org, phoenix@emc.com.tw, aaron.ma@canonical.com, josh.chen@emc.com.tw
List-Id: linux-input@vger.kernel.org

On Sun, Jul 1, 2018 at 4:44 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> The reason it got messed up is I switched to pulling patches from
> patchwork.kernel.org as it collects Acked-by and Reviewed-by tags so I
> do not have to add them manually, but unfortunately it does not do
> proper UTF-8:

Ugh.

I made an 'issue' of it for patchwork:

  https://github.com/getpatchwork/patchwork/issues/194

and hopefully that can be fixed. It's sad when we corrupt names like this.

              Linus
