From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: tegra-kbc - Add tegra keyboard driver
Date: Thu, 6 Jan 2011 22:06:19 -0800
Message-ID: <20110107060618.GB29038@core.coreip.homeip.net>
References: <1294351512-17035-1-git-send-email-riyer@nvidia.com>
 <alpine.LNX.2.00.1101062311340.13988@swampdragon.chaosbits.net>
 <20110106142714.f823dea8.rdunlap@xenotime.net>
 <1FC56210173BB445BD77F608D6FB8D03165A008053@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1FC56210173BB445BD77F608D6FB8D03165A008053@HQMAIL03.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rakesh Iyer <riyer@nvidia.com>
Cc: 'Randy Dunlap' <rdunlap@xenotime.net>, Jesper Juhl <jj@chaosbits.net>, "tsoni@codeaurora.org" <tsoni@codeaurora.org>, "shubhrajyoti@ti.com" <shubhrajyoti@ti.com>, "ccross@android.com" <ccross@android.com>, "konkers@android.com" <konkers@android.com>, "olof@lixom.net" <olof@lixom.net>, Andrew Chew <AChew@nvidia.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 06, 2011 at 06:49:45PM -0800, Rakesh Iyer wrote:
> 
> Is having this check really an issue?  Can't input_free_device change
> in the future so that NULL as a parameter does cause undesirable
> side-effects?

No, it won't because changing it to crash on NULL pointers would be
really stupid.

Thanks.

-- 
Dmitry
