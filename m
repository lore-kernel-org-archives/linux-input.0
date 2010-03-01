From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] Input: scancode in get/set_keycodes should be unsigned
Date: Mon, 1 Mar 2010 14:52:51 +0000
Message-ID: <20100301145251.GB14808@srcf.ucam.org>
References: <20100228061310.GA765@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100228061310.GA765@core.coreip.homeip.net>
Sender: linux-media-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Linux Input <linux-input@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Platform Driver x86 <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Feb 27, 2010 at 10:13:11PM -0800, Dmitry Torokhov wrote:
> The HID layer has some scan codes of the form 0xffbc0000 for logitech
> devices which do not work if scancode is typed as signed int, so we need
> to switch to unsigned int instead. While at it keycode being signed does
> not make much sense either.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
Acked-by: Matthew Garrett <mjg@redhat.com>
-- 
Matthew Garrett | mjg59@srcf.ucam.org
