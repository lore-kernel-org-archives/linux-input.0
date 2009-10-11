From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Haptic class support (v2)
Date: Sun, 11 Oct 2009 11:05:49 +0200
Message-ID: <20091011090549.GE1414@ucw.cz>
References: <20091006074533.GA28889@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756069AbZJKJGh@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091006074533.GA28889@july>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, soni.trilok@gmail.com, Greg KH <greg@kroah.com>
List-Id: linux-input@vger.kernel.org

On Tue 2009-10-06 16:45:33, Kyungmin Park wrote:
> This patch includes two haptic devices, isa1000 and isa1200
> ISA1000 is gpio based haptic, but isa1200 is based on I2C
> Both are working on Samsung SoCs and tested.
> 
> To enable the haptic, echo 1 > /sys/class/haptic/${name}/enable
> You can adjust the level by echo ${level} > /sys/class/haptic/${name}/enable
> or
> With oneshot feature, echo ${msec time} > /sys/class/haptic/${name}/oneshot

New device classes should certainly be documented in Documentation/.

For example... is level 0-100? Is it valid to change level while
'oneshot' is running? Does oneshot use last level set?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
