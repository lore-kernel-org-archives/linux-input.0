From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] input: atmel_tsadcc: touchscreen rework setting
	capabilities
Date: Wed, 18 Nov 2009 09:30:33 -0800
Message-ID: <20091118173033.GA4385@core.coreip.homeip.net>
References: <693b9933de6fe9eb7e4401ca56a8f9ab6a966666.1258553002.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758025AbZKRRae@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <693b9933de6fe9eb7e4401ca56a8f9ab6a966666.1258553002.git.nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, avictor.za@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Nicolas,

On Wed, Nov 18, 2009 at 03:12:12PM +0100, Nicolas Ferre wrote:
> Tiny patch for setting capabilities using input API function.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

All looks good. Since the series span platform and input subtrees how do
you want to merge it?

-- 
Dmitry
