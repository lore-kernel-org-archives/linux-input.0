From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: suspend: Rename pm_suspend_via_s2idle()
Date: Wed, 19 Jun 2019 10:29:37 +0200
Message-ID: <CAJZ5v0jANxDYpvukieee1jwjw93fg_Q=t5t=5fqKtDWqL35EoQ@mail.gmail.com>
References: <7812857.KkDK7346ep@kreacher> <20190619001905.GA62571@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190619001905.GA62571@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jun 19, 2019 at 2:19 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Rafael,
>
> On Tue, Jun 18, 2019 at 10:18:28AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The name of pm_suspend_via_s2idle() is confusing, as it doesn't
> > reflect the purpose of the function precisely enough and it is
> > very similar to pm_suspend_via_firmware(), which has a different
> > purpose, so rename it as pm_suspend_default_s2idle() and update
> > its only caller, i8042_register_ports(), accordingly.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I assume you'll take it through your tree...

I will.

> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks!
