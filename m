From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH]input: Change timer function to workqueue for gpio_keys
	driver
Date: Thu, 25 Jun 2009 09:42:42 -0700
Message-ID: <d120d5000906250942j1d25f4d6rccc12034758f8815@mail.gmail.com>
References: <20090608152420.0e76c302@dxy.sh.intel.com>
	 <1245936693.20530.107.camel@jani-desktop>
	 <20090625220826.1fa7413e@dxy.sh.intel.com>
	 <1245941565.20530.134.camel@jani-desktop>
	 <1245942355.20530.141.camel@jani-desktop>
	 <20090625230949.53beda65@dxy.sh.intel.com>
	 <1245944528.20530.145.camel@jani-desktop>
	 <20090625234846.1b987069@dxy.sh.intel.com>
	 <1245946154.9103.742.camel@pcarmody-desktop>
	 <20090626002345.07928230@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f193.google.com ([209.85.221.193]:59899 "EHLO
	mail-qy0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbZFYQm4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2009 12:42:56 -0400
In-Reply-To: <20090626002345.07928230@dxy.sh.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alek Du <alek.du@intel.com>
Cc: "ext-phil.2.carmody@nokia.com" <ext-phil.2.carmody@nokia.com>, "Nikula Jani.1 (EXT-Nixu/Helsinki)" <ext-jani.1.nikula@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Trilok Soni <soni.trilok@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>

On Thu, Jun 25, 2009 at 9:23 AM, Alek Du<alek.du@intel.com> wrote:
> On Fri, 26 Jun 2009 00:09:14 +0800
> Phil Carmody <ext-phil.2.carmody@nokia.com> wrote:
>
>> If you stopped calling the delay after the first transition "debounc=
ing
>> time" and simply called it a "delay" you might more easily see that =
it
>> does *no* debouncing at all. Imagine putting noise on the line
>> constantly - the original code's timer would never expire. Your time=
r
>> will expire after a delay, and while the line is still toggling
>> frantically - you've not debounced.
>
> I don't know if it is really meaningful if you want to handle such po=
ol signal...
> Ok, if you want to handle this ultimate case, will this patch work?
>
> =A0 =A0 =A0 =A0BUG_ON(irq !=3D gpio_to_irq(button->gpio));
>
> + =A0 =A0 =A0 cancel_delayed_work_sync(&bdata->work);

Can't do *_sync in interrupt context.

> =A0 =A0 =A0 =A0delay =3D button->debounce_interval ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msecs_to_jiffies(butto=
n->debounce_interval) : 0;
> =A0 =A0 =A0 =A0schedule_delayed_work(&bdata->work, delay);
>

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
