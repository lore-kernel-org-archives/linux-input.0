From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] mfd: twl4030: add twl4030-pwrbutton as our child
Date: Wed, 22 Jul 2009 15:25:53 -0700
Message-ID: <200907221525.53890.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <20090227154220.7099f339.akpm@linux-foundation.org> <5d5443650907221227w72768b3cna145cea00f1baa05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:41548 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752988AbZGVWZz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2009 18:25:55 -0400
In-Reply-To: <5d5443650907221227w72768b3cna145cea00f1baa05@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, Samuel Ortiz <sameo@linux.intel.com>

On Wednesday 22 July 2009, Trilok Soni wrote:
> > That doesn't address the problem at all. =A0A function called
> > "add_children" just shouldn't exist. =A0The general kernel design i=
s for
> > client drivers to register themselves with the core, so the core do=
es
> > not have any hard-wired knowledge of any client drivers.

The general kernel design also involves bus drivers
(consider PCI or USB) enumerating their child devices
and then *adding* those children ... that's what is
done here.  The devices supported by that system get
added, and then the driver model code can bind each
device to its driver.


> > IOW, twl4030_pwrbutton_probe() should call into twl4030-core,
> > registering the powerbutton driver.

It calls to the driver model to register that driver,
which then sees that the device is registered.

- Dave


>=20
> Reviving this very old thread.
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
