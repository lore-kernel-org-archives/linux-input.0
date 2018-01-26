From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] HID: asus: only support backlight when it's not driven by WMI
Date: Fri, 26 Jan 2018 11:47:07 +0200
Message-ID: <CAHp75VeFXx91TkNqPJSGwqFOcj-c7etAxxvFhDUqfS3Ws7F-cQ@mail.gmail.com>
References: <20180109012042.13947-1-drake@endlessm.com> <CAHp75Veyrzh+gV_8ff7TRqWpVx4h+2Qg05j9OpNXCH+E1+hsQg@mail.gmail.com>
 <CAD8Lp46gbny3mV2CgWnrJnEpZpNo-P-GgKA5-DypykbmGoUhQg@mail.gmail.com>
 <CAHp75Vc962G3rufA_D1GY=Giy7u0vri4_vQnFPYCxZ_w6N_2GQ@mail.gmail.com>
 <CAMz_NCr-3taeHeZ3NF2LYXrMGf25gWgL+dzdO=Ca=Bxug2EbCw@mail.gmail.com> <CAD8Lp476c1stJOScWBuX2ZsNrORKVYnUJL1UnwCp6hQOzXASvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAD8Lp476c1stJOScWBuX2ZsNrORKVYnUJL1UnwCp6hQOzXASvw@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Mustafa Kuscu <mustafakuscu@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Carlo Caione <carlo@endlessm.com>, Corentin Chary <corentin.chary@gmail.com>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 15, 2018 at 10:33 PM, Daniel Drake <drake@endlessm.com> wrote:
> On Fri, Jan 12, 2018 at 1:33 PM, Mustafa Kuscu <mustafakuscu@gmail.com> wrote:

> Andy, still waiting for any more feedback on the issue detailed in
> this thread once you have a chance.

As I said before I don't like code duplication and even more I don't
like functionality duplication.
So, check what can we re-use from asus-wmi.c and adopt it accordingly.

-- 
With Best Regards,
Andy Shevchenko
