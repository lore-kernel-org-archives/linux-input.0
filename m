From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/6] Input: elantech - use firmware provided x, y ranges
Date: Thu, 18 Aug 2011 00:47:56 -0700
Message-ID: <20110818074756.GE10093@core.coreip.homeip.net>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw>
 <1313632629-23603-3-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1313632629-23603-3-git-send-email-jj_ding@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Eric Piel <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 18, 2011 at 09:57:05AM +0800, JJ Ding wrote:
> +
> +		i = (etd->fw_version > 0x020800 &&
> +		     etd->fw_version < 0x020900) ? 1 : 2;
> +		*x_max = (etd->capabilities[1] - i) * 64;
> +		*y_max = (etd->capabilities[2] - i) * 64;
> +		*y_2ft_max = (*y_max - i) * 64 / 4;

Hmm, we should have the same range for ST and MT data and scale MT data
if it has lower resolution to match ST.

Thanks.

-- 
Dmitry
