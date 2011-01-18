From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: Pegatron Lucid accelerometer
Date: Mon, 17 Jan 2011 21:59:28 -0800
Message-ID: <20110118055928.GF23851@core.coreip.homeip.net>
References: <1295287011-12849-1-git-send-email-andy.ross@windriver.com>
 <1295287011-12849-2-git-send-email-andy.ross@windriver.com>
 <4D3529A1.1030804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D3529A1.1030804@ti.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: Andy Ross <andy.ross@windriver.com>, Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 18, 2011 at 11:18:17AM +0530, Shubhrajyoti wrote:
> On Monday 17 January 2011 11:26 PM, Andy Ross wrote:
> >+
> >+static int __devexit platform_remove(struct platform_device *pd)
> >+{
> >+	input_unregister_polled_device(ipdev);
> >+	input_free_polled_device(ipdev);
> This may not be needed.

Yes this is needed (for polled input devices only).

-- 
Dmitry
