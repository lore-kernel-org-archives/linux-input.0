From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Revert "HID: uhid: use strlcpy() instead of strncpy()"
Date: Thu, 15 Nov 2018 12:55:44 +0100
Message-ID: <CANq1E4T6rKjVPwGd-4CDWZzFYz1ohzPSpKGd2kK+O4BNSe--Hg@mail.gmail.com>
References: <20181114131642.21425-1-dh.herrmann@gmail.com> <ea944fb3-0cd9-e6e6-5449-faab7c9603c1@redhat.com>
 <CAGXu5jJJGg5_crJ3v+AG5JZWVGLpDvZGr0UVyurzFxcv9Fwa5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jJJGg5_crJ3v+AG5JZWVGLpDvZGr0UVyurzFxcv9Fwa5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: labbott@redhat.com, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, xiongfeng.wang@linaro.org
List-Id: linux-input@vger.kernel.org

Hi

On Thu, Nov 15, 2018 at 12:09 AM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Nov 14, 2018 at 9:40 AM, Laura Abbott <labbott@redhat.com> wrote:
[...]
> > Can we switch to strscpy instead? This will quiet gcc and avoid the
> > issues with strlcpy.
>
> Yes please: it looks like these strings are expected to be NUL
> terminated, so strscpy() without the "- 1" and min() logic would be
> the correct solution here.

"the correct solution"? To my knowledge the original code was correct
as well. Am I missing something?

>                            If @hid is already zero, then this would
> just be:
>
>        strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
>        strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
>        strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
>
> If they are NOT NUL terminated, then keep using strncpy() but mark the
> fields in the struct with the __nonstring attribute.

They are supposed to be NUL terminated, but for compatibility reasons
we allow them to be not. So I don't think your proposal is safe.

Thanks
David
