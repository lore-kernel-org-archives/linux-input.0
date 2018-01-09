From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] HID: asus: only support backlight when it's not driven by WMI
Date: Tue, 9 Jan 2018 13:41:31 -0600
Message-ID: <CAD8Lp46gbny3mV2CgWnrJnEpZpNo-P-GgKA5-DypykbmGoUhQg@mail.gmail.com>
References: <20180109012042.13947-1-drake@endlessm.com> <CAHp75Veyrzh+gV_8ff7TRqWpVx4h+2Qg05j9OpNXCH+E1+hsQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAHp75Veyrzh+gV_8ff7TRqWpVx4h+2Qg05j9OpNXCH+E1+hsQg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Carlo Caione <carlo@endlessm.com>, Corentin Chary <corentin.chary@gmail.com>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 9, 2018 at 1:32 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> Imagine someone who on possession of laptop where it's not needed
> having old kernel configuration.
> Building new kernel with old configuration will bring a regression.
>
> Selection is also not a solution since we don't need all crap in
> kernel because of some particular case.
>
> So, NO.

If I can't use depends nor select, then what options are left? What
alternative solutions do you have in mind?

Thanks
Daniel
