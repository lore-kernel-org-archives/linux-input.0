From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Oops in current tree in i2c
Date: Sat, 27 Oct 2018 09:19:56 -0700
Message-ID: <CAHk-=wgOan5tQR_vxpq2qX6Nus8NZoFcHBL7KJ4QAxetDXHX-g@mail.gmail.com>
References: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Julian Sax <jsbc@gmx.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Oct 27, 2018 at 9:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I *think* the problem is that the i2c_hid_dmi_desc_override_table[]
> isn't terminated by a NULL entry, and I will test that next.

Confirmed.  That makes my laptop boot cleanly.

See commit b59dfdaef173 ("i2c-hid: properly terminate
i2c_hid_dmi_desc_override_table[] array")

                       Linus
