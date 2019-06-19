From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] PM: suspend: Rename pm_suspend_via_s2idle()
Date: Tue, 18 Jun 2019 17:19:05 -0700
Message-ID: <20190619001905.GA62571@dtor-ws>
References: <7812857.KkDK7346ep@kreacher>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7812857.KkDK7346ep@kreacher>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Rafael,

On Tue, Jun 18, 2019 at 10:18:28AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The name of pm_suspend_via_s2idle() is confusing, as it doesn't
> reflect the purpose of the function precisely enough and it is
> very similar to pm_suspend_via_firmware(), which has a different
> purpose, so rename it as pm_suspend_default_s2idle() and update
> its only caller, i8042_register_ports(), accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I assume you'll take it through your tree...

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

-- 
Dmitry
