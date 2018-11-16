From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] Revert "HID: uhid: use strlcpy() instead of strncpy()"
Date: Thu, 15 Nov 2018 19:10:53 -0600
Message-ID: <CAGXu5jK35O-fGVwG4HbU-WP_YETgbTAQJpiYK8AD4mweo1WrcA@mail.gmail.com>
References: <20181114131642.21425-1-dh.herrmann@gmail.com> <ea944fb3-0cd9-e6e6-5449-faab7c9603c1@redhat.com>
 <CAGXu5jJJGg5_crJ3v+AG5JZWVGLpDvZGr0UVyurzFxcv9Fwa5A@mail.gmail.com> <CANq1E4T6rKjVPwGd-4CDWZzFYz1ohzPSpKGd2kK+O4BNSe--Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANq1E4T6rKjVPwGd-4CDWZzFYz1ohzPSpKGd2kK+O4BNSe--Hg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Laura Abbott <labbott@redhat.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Xiongfeng Wang <xiongfeng.wang@linaro.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 15, 2018 at 5:55 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Thu, Nov 15, 2018 at 12:09 AM Kees Cook <keescook@chromium.org> wrote:
>> On Wed, Nov 14, 2018 at 9:40 AM, Laura Abbott <labbott@redhat.com> wrote:
> [...]
>> > Can we switch to strscpy instead? This will quiet gcc and avoid the
>> > issues with strlcpy.
>>
>> Yes please: it looks like these strings are expected to be NUL
>> terminated, so strscpy() without the "- 1" and min() logic would be
>> the correct solution here.
>
> "the correct solution"? To my knowledge the original code was correct
> as well. Am I missing something?

So, yes, no one should use strlcpy():
https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

And while I think nothing was technically wrong with the strncpy()
usage in the original version, I think strncpy() should only be used
for __nonstring cases:
https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

>
>>                            If @hid is already zero, then this would
>> just be:
>>
>>        strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
>>        strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
>>        strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));
>>
>> If they are NOT NUL terminated, then keep using strncpy() but mark the
>> fields in the struct with the __nonstring attribute.
>
> They are supposed to be NUL terminated, but for compatibility reasons
> we allow them to be not. So I don't think your proposal is safe.

I was originally thinking only about the the hid->* strings, so I was
confused by this answer (they appear to always be NUL-terminated).
Then I thought you meant that ev->u.create2.* strings may not be
terminated, but I stayed confused. :)

The original code was:

        len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
        strncpy(hid->name, ev->u.create2.name, len);

If sizeof(hid->name) is smaller than sizeof(ev->u.create2.name), it
made sure than hid->name kept a trailing NUL.

If sizeof(ev->u.create2.name) is smaller than sizeof(hid->name), it
made sure than the last byte of ev->u.create2.name was ignored, and by
definition, hid->name would be NUL-terminated.

So you're converting from a potentially unterminated string into a
terminated string... (ev->u.create2.name maybe needs to be marked
__nonstring?)

The most you can write is sizeof(dest) - 1 but you must not read more
than sizeof(source). So I see that if the destination is smaller than
the source, you cannot represent these conditions correctly to
strscpy(). (And, I would argue, you can't with strncpy() either.)

However, they're all exactly the same size, so none of this matters,
and I think strscpy() would be the most sensible. And maybe you could
enforce the size checking:

        BUILD_BUG_ON(sizeof(hid->name) != sizeof(ev->u.create2.name));
        strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));

etc...

-- 
Kees Cook
