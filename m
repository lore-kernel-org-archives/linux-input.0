From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Haptic class support (v2)
Date: Mon, 12 Oct 2009 17:20:20 +0100
Message-ID: <20091012162020.GF22233@sirena.org.uk>
References: <20091006074533.GA28889@july> <ac3eb2510910120842m3129b76fyaa11b509e7f97038@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932799AbZJLQVA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ac3eb2510910120842m3129b76fyaa11b509e7f97038@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Kyungmin Park <kmpark@infradead.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, soni.trilok@gmail.com
List-Id: linux-input@vger.kernel.org

On Mon, Oct 12, 2009 at 05:42:08PM +0200, Kay Sievers wrote:
> On Tue, Oct 6, 2009 at 09:45, Kyungmin Park <kmpark@infradead.org> wrote:

> > To enable the haptic, echo 1 > /sys/class/haptic/${name}/enable
> > You can adjust the level by echo ${level} > /sys/class/haptic/${name}/enable
> > or
> > With oneshot feature, echo ${msec time} > /sys/class/haptic/${name}/oneshot

> Please never add any custom files to the top-level of a class
> directory. This place is reserved for devices, and not for custom
> files. It's a serious bug in the layout and API of sysfs that this
> allowed at all.

I'm assuming that ${name} is the device name in the above in which case
it should be fine from that point of view?
