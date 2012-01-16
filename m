From: Leon Romanovsky <leon-2ukJVAZIZ/Y@public.gmane.org>
Subject: Re: [PATCH v2] [INCREMENTAL] Input: tegra-kbc - add device tree support
Date: Mon, 16 Jan 2012 13:31:50 +0200
Message-ID: <CALq1K=LShfkwyfx+G3rqp9OdHzRoZzXremr2tH7guJTLZaqbRw@mail.gmail.com>
References: <1325639956-27502-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1325639956-27502-1-git-send-email-olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 4, 2012 at 03:19, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> wrote:
>
> This is an incremental patch updating to the revised bindings for mat=
rix keyboards.
>
> This includes an optional "linux,fn-keymap" binding that is not yet i=
mplemented,
> that will be used to specify the Fn-key modifier layout if needed.
>
> New for v2:
> * Removed references to "matrix-keyboard-controller" compatible value=
s
> * Rebased to be incremental on top of previous patch.
>
> Signed-off-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> ---
>
> Dmitry,
>
> Here's an incremental patch to go on top of your next branch.
>
> Regards,
>
> -Olof
> ---
> =C2=A0.../devicetree/bindings/input/tegra-kbc.txt =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 17 ++++++++++-----
> =C2=A0drivers/input/keyboard/tegra-kbc.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 21 +++++++++++++++----
> =C2=A02 files changed, 27 insertions(+), 11 deletions(-)

=46or any reasons this patch is missing from for-next branch and the
absence of the lines below prevents from linux-next-20120116 build
(and previous too).
> + =C2=A0 =C2=A0 =C2=A0 u32 prop;
> + =C2=A0 =C2=A0 =C2=A0 int i;

http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=3Dblo=
b;f=3Ddrivers/input/keyboard/tegra-kbc.c;h=3Da136e2e832beff1e740c8c9a79=
ad850b01fe14c2;hb=3Drefs/heads/stable#l589

--
Leon Romanovsky | Independent Linux Consultant
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0www.leon.nu=C2=A0| leon-2ukJVAZIZ/Y@public.gmane.org
