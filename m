From: Daniel Drake <dsd@laptop.org>
Subject: Re: Communicating tablet mode status to userspace
Date: Wed, 3 Oct 2012 10:04:11 -0600
Message-ID: <CAMLZHHTnhCjYA8x-=Q9+R3zbjV5ABnQ7D1hYX9qWfQ4Hck9f-Q@mail.gmail.com>
References: <CAMLZHHS80_zdmgVtJ87w+fuQGC05yj+EoJt3C_zBC7hkyhnaoQ@mail.gmail.com>
	<20121002233640.GB8542@core.coreip.homeip.net>
	<CAMLZHHQfGuiK6s_d8ya8FUNiDiGDpgh35VFbHcu-mgCH-=TXVw@mail.gmail.com>
	<20121003150542.GA8460@kroah.com>
	<CAPXgP10+ZzLC98VdaQz19413guR-sKLT47iFLbN-mF_isF0n9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-hotplug-owner@vger.kernel.org>
In-Reply-To: <CAPXgP10+ZzLC98VdaQz19413guR-sKLT47iFLbN-mF_isF0n9A@mail.gmail.com>
Sender: linux-hotplug-owner@vger.kernel.org
To: Kay Sievers <kay@vrfy.org>
Cc: Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-hotplug@vger.kernel.org, hadess@hadess.net, Carlos Garnacho <carlosg@gnome.org>
List-Id: linux-input@vger.kernel.org

On Wed, Oct 3, 2012 at 9:23 AM, Kay Sievers <kay@vrfy.org> wrote:
> The usual model is not uid/gid, it's ACLs dynamically applied for
> logged-in users with active sessions:
>   http://www.freedesktop.org/software/systemd/man/systemd-logind.service.html
>   http://cgit.freedesktop.org/systemd/systemd/tree/src/login/70-uaccess.rules

Thanks, those were the pointers I needed.
I'll work with this approach.

Thanks
Daniel
