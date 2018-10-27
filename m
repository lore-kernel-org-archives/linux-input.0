From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Oops in current tree in i2c
Date: Sat, 27 Oct 2018 18:20:19 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810271813120.23511@cbobk.fhfr.pm>
References: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wiVH6SdC2YutcDJ8kiAYUkO-ei3Wdjp2TXcbWas7LJrSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Julian Sax <jsbc@gmx.de>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, 27 Oct 2018, Linus Torvalds wrote:

> I *think* the problem is that the i2c_hid_dmi_desc_override_table[]
> isn't terminated by a NULL entry, and I will test that next.

Hm, that almost certainly is indeed the issue, thanks a lot for reporting 
it.

> What makes me *very* unhappy about this is that if I'm right, I think it 
> means that code was literally not tested at all by anybody who didn't 
> have one of the entries in that list.

Honestly, my autotesting of HID tree is running on HW that doesn't have 
i2c transport at all, only USB a Bluetooth. Something to improve I guess; 
will fix that next week.

Benjamin, do you have something for that in place already?

Thanks,

-- 
Jiri Kosina
SUSE Labs
