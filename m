From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH v5] Input: i8042 add i8042_is_mr_coffee() helper to avoid
 refconut leak
Date: Fri, 21 Dec 2018 22:45:33 +0800
Message-ID: <CAEExFWu7EY=OLLzHnzNjRFJ9J7TB+NwPy6=A+6NvBsbprd_z0Q@mail.gmail.com>
References: <20181215090846.28009-1-tiny.windzz@gmail.com> <20181221084212.GG211587@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221084212.GG211587@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Dec 21, 2018 at 4:42 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sat, Dec 15, 2018 at 04:08:46AM -0500, Yangtao Li wrote:
> > of_find_node_by_path() acquires a reference to the node returned by
> > it and that reference needs to be dropped by its caller. Add
> > i8042_is_mr_coffee() helper to avoid refconut leak.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > changes in v5:
> > -fix typo
>
> Has this at least been actually compiled by you?
Sure!!!
On ubuntu 18 machine.

MBR,
Yangtao
